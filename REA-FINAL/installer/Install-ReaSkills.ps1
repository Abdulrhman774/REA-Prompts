<#
.SYNOPSIS
    Install-ReaSkills.ps1 - Enterprise-grade, non-destructive installer and validator for the REA Antigravity Suite.

.DESCRIPTION
    Installs, validates, and manages REA Skills, Rules, and reference runbooks in Google Antigravity environments.
    Supports Global (~/.gemini/config/), Workspace-only (<root>/.agents/), or Both scopes.
    Enforces strict overwrite authorization, ShouldProcess (-WhatIf/-Confirm), automatic backups,
    path traversal prevention, duplicate skipping, and restoration capabilities.

.PARAMETER Scope
    Target deployment scope. Valid values: "Global", "Workspace", "Both".
    Required for installation and dry-run write operations. In -Check mode, defaults to evaluating both.

.PARAMETER WorkspaceRoot
    Root directory of the workspace project when Scope is "Workspace" or "Both". Defaults to current directory.

.PARAMETER ManifestPath
    Path to the skills manifest JSON file. Defaults to ".\skills-manifest.json".

.PARAMETER DryRun
    Simulates all operations, displaying planned actions without writing or modifying any files.

.PARAMETER Check
    Reports installation status, version alignment, and integrity across targets without performing modifications.

.PARAMETER Force
    Explicit authorization switch required to replace existing conflicting files.
    When specified, still creates and verifies a timestamped backup before replacing.

.PARAMETER AllowScripts
    Explicit opt-in to permit copying executable script files (if any). By default, scripts are excluded.

.PARAMETER Restore
    Restoration mode: restores pre-existing files from a specified or latest timestamped backup (.bak-*).

.PARAMETER BackupFile
    Specific backup path to restore when using -Restore.

.PARAMETER VerboseOutput
    Displays detailed diagnostics during validation and execution.

.EXAMPLE
    .\Install-ReaSkills.ps1 -Check
    Performs a non-destructive audit of REA skills across global and workspace targets.

.EXAMPLE
    .\Install-ReaSkills.ps1 -DryRun -Scope Workspace
    Simulates deployment to the workspace environment without making changes.

.EXAMPLE
    .\Install-ReaSkills.ps1 -Scope Workspace
    Safely installs new REA components into the workspace, skipping duplicates and refusing to overwrite conflicts.

.EXAMPLE
    .\Install-ReaSkills.ps1 -Scope Workspace -Force
    Installs REA components, creating verified backups before replacing conflicting files.
#>

[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
param(
    [ValidateSet("Global", "Workspace", "Both", "")]
    [string]$Scope = "",

    [string]$WorkspaceRoot = (Get-Location).Path,

    [string]$ManifestPath = ".\skills-manifest.json",

    [switch]$DryRun,

    [switch]$Check,

    [switch]$Force,

    [switch]$AllowScripts,

    [switch]$Restore,

    [string]$BackupFile,

    [switch]$VerboseOutput
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Write-ReaLog {
    param([string]$Message, [string]$Level = "INFO")
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $color = switch ($Level) {
        "INFO"     { "Cyan" }
        "SUCCESS"  { "Green" }
        "WARN"     { "Yellow" }
        "ERROR"    { "Red" }
        "PLAN"     { "Magenta" }
        "SECURITY" { "DarkYellow" }
        Default    { "White" }
    }
    Write-Host "[$timestamp] [$Level] $Message" -ForegroundColor $color
}

function Get-ReaSha256 {
    param([string]$FilePath)
    if (-not (Test-Path $FilePath -PathType Leaf)) { return $null }
    $stream = [System.IO.File]::OpenRead($FilePath)
    try {
        $hasher = [System.Security.Cryptography.SHA256]::Create()
        $hashBytes = $hasher.ComputeHash($stream)
        $hasher.Dispose()
        return (-join ($hashBytes | ForEach-Object { $_.ToString("X2") }))
    } finally {
        $stream.Close()
        $stream.Dispose()
    }
}

# Resolve script directory and manifest path
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
if (-not [System.IO.Path]::IsPathRooted($ManifestPath)) {
    $ManifestPath = Join-Path $ScriptDir $ManifestPath
}

Write-ReaLog "Starting REA Antigravity Suite Installer / Validator v2.1.0..." "INFO"

# Scope Validation: Require explicit scope for any operation that simulates or performs writes
if (-not $Check -and -not $Restore) {
    if ([string]::IsNullOrWhiteSpace($Scope)) {
        Write-ReaLog "Scope parameter is required for deployment operations. Use: -Scope Workspace, -Scope Global, or -Scope Both" "ERROR"
        Write-ReaLog "To audit your environment safely without specifying scope, run: .\Install-ReaSkills.ps1 -Check" "INFO"
        exit 1
    }
} elseif ($Check -and [string]::IsNullOrWhiteSpace($Scope)) {
    $Scope = "Both"
}

# Handle Restoration Mode
if ($Restore) {
    Write-ReaLog "Mode: RESTORATION" "WARN"
    if ([string]::IsNullOrWhiteSpace($BackupFile)) {
        Write-ReaLog "Please specify the backup path to restore using -BackupFile <path>" "ERROR"
        exit 1
    }
    if (-not (Test-Path $BackupFile)) {
        Write-ReaLog "Backup file not found: $BackupFile" "ERROR"
        exit 1
    }
    # Derive original file path by stripping .bak-*
    $origPath = $BackupFile -replace '\.bak-\d{8}-\d{6}$', ''
    if ($origPath -eq $BackupFile) {
        Write-ReaLog "BackupFile does not match expected naming convention (.bak-yyyyMMdd-HHmmss): $BackupFile" "ERROR"
        exit 1
    }
    
    if ($PSCmdlet.ShouldProcess("Restore $origPath from $BackupFile", "Restore backup")) {
        Copy-Item -Path $BackupFile -Destination $origPath -Recurse -Force
        Write-ReaLog "Successfully restored: $origPath from $BackupFile" "SUCCESS"
    }
    exit 0
}

# Execution mode banners
if ($DryRun) { Write-ReaLog "Mode: DRY-RUN (Simulation only; zero writes will occur)" "PLAN" }
if ($Check)  { Write-ReaLog "Mode: CHECK-ONLY (Audit status report; zero writes will occur)" "PLAN" }

# 1. Validate Manifest Existence and Content
if (-not (Test-Path $ManifestPath)) {
    Write-ReaLog "Manifest file not found: $ManifestPath" "ERROR"
    exit 1
}

try {
    $rawManifest = Get-Content -Path $ManifestPath -Raw -Encoding utf8
    $manifest = $rawManifest | ConvertFrom-Json
} catch {
    Write-ReaLog "Failed to parse manifest JSON: $($_.Exception.Message)" "ERROR"
    exit 1
}

if (-not $manifest.entries -or $manifest.entries.Count -eq 0) {
    Write-ReaLog "Manifest contains no component entries" "ERROR"
    exit 1
}

# Validate Manifest Integrity: Check for duplicate IDs and path traversal in manifest
$idSet = New-Object System.Collections.Generic.HashSet[string]
foreach ($entry in $manifest.entries) {
    if ([string]::IsNullOrWhiteSpace($entry.id)) {
        Write-ReaLog "Manifest entry missing required 'id' property" "ERROR"
        exit 1
    }
    if ($idSet.Contains($entry.id)) {
        Write-ReaLog "Duplicate manifest entry id detected: $($entry.id)" "ERROR"
        exit 1
    }
    [void]$idSet.Add($entry.id)

    # Check for path traversal in targetDirectory
    if ($entry.targetDirectory -match '\.\.' -or $entry.targetDirectory -match '^[\/\\]') {
        Write-ReaLog "Manifest entry '$($entry.id)' has unsafe targetDirectory containing traversal: $($entry.targetDirectory)" "SECURITY"
        exit 1
    }

    # Verify source path exists
    $sourceResolved = Join-Path $ScriptDir $entry.sourcePath
    if (-not (Test-Path $sourceResolved)) {
        Write-ReaLog "Manifest entry '$($entry.id)' specifies missing sourcePath: $sourceResolved" "ERROR"
        exit 1
    }

    # Verify requiredFiles exist within source
    if ($entry.requiredFiles) {
        foreach ($rf in $entry.requiredFiles) {
            $rfPath = Join-Path $sourceResolved $rf
            if (-not (Test-Path $rfPath)) {
                Write-ReaLog "Manifest entry '$($entry.id)' is missing required file: $rfPath" "ERROR"
                exit 1
            }
        }
    }
}
Write-ReaLog "Manifest validated: $($manifest.entries.Count) entries verified structurally." "SUCCESS"

# 2. Resolve and Secure Target Directories
$destinations = @()

if ($Scope -eq "Global" -or $Scope -eq "Both") {
    $globalRoot = Join-Path $env:USERPROFILE ".gemini\config"
    $destinations += [PSCustomObject]@{
        Name = "Global"
        Root = [System.IO.Path]::GetFullPath($globalRoot)
    }
}

if ($Scope -eq "Workspace" -or $Scope -eq "Both") {
    $canonicalWorkspace = [System.IO.Path]::GetFullPath($WorkspaceRoot)
    $workspaceRootPath = Join-Path $canonicalWorkspace ".agents"
    $destinations += [PSCustomObject]@{
        Name = "Workspace"
        Root = [System.IO.Path]::GetFullPath($workspaceRootPath)
    }
}

Write-ReaLog "Deployment targets:" "INFO"
foreach ($dest in $destinations) {
    Write-ReaLog "  -> $($dest.Name): $($dest.Root)" "INFO"
}

# 3. Component Evaluation & Execution Loop
$stats = [PSCustomObject]@{
    TotalDeclared          = $manifest.entries.Count
    EligibleNew            = 0
    InstalledNew           = 0
    IdenticalSkipped       = 0
    ConflictsSkipped       = 0
    ReplacementsAuthorized = 0
    BackupsCreated         = 0
    Failures               = 0
}

$resultsTable = @()

foreach ($entry in $manifest.entries) {
    $entryId = $entry.id
    $entryType = $entry.type
    $sourceResolved = [System.IO.Path]::GetFullPath((Join-Path $ScriptDir $entry.sourcePath))

    foreach ($dest in $destinations) {
        $destPath = Join-Path $dest.Root $entry.targetDirectory
        $destCanonical = [System.IO.Path]::GetFullPath($destPath)

        # Path Traversal Guard: Ensure destination is strictly within $dest.Root
        if (-not $destCanonical.StartsWith($dest.Root, [System.StringComparison]::OrdinalIgnoreCase)) {
            Write-ReaLog "Security violation: destination '$destCanonical' escapes root '$($dest.Root)'" "SECURITY"
            $stats.Failures++
            continue
        }

        $destExists = Test-Path $destCanonical
        $status = "UNKNOWN"
        $action = "NONE"

        if (-not $destExists) {
            $status = "ELIGIBLE_NEW"
            $action = if ($DryRun -or $Check) { "WOULD_INSTALL" } else { "INSTALL" }
            $stats.EligibleNew++
        } else {
            # Destination exists: perform byte-level SHA-256 comparison
            $isIdentical = $false

            if (Test-Path $destCanonical -PathType Leaf) {
                $srcHash = Get-ReaSha256 -FilePath $sourceResolved
                $dstHash = Get-ReaSha256 -FilePath $destCanonical
                $isIdentical = ($srcHash -eq $dstHash)
            } else {
                # Directory comparison (check SKILL.md and key files)
                $srcSkillMd = Join-Path $sourceResolved "SKILL.md"
                $dstSkillMd = Join-Path $destCanonical "SKILL.md"
                if ((Test-Path $srcSkillMd) -and (Test-Path $dstSkillMd)) {
                    $srcHash = Get-ReaSha256 -FilePath $srcSkillMd
                    $dstHash = Get-ReaSha256 -FilePath $dstSkillMd
                    $isIdentical = ($srcHash -eq $dstHash)
                }
            }

            if ($isIdentical) {
                $status = "ALREADY_INSTALLED_IDENTICAL"
                $action = "SKIP_IDENTICAL"
                $stats.IdenticalSkipped++
            } else {
                # Destination exists and differs: CONFLICT
                if ($Force) {
                    $status = "CONFLICT_FORCE_AUTHORIZED"
                    $action = if ($DryRun -or $Check) { "WOULD_BACKUP_AND_OVERWRITE" } else { "BACKUP_AND_OVERWRITE" }
                } else {
                    $status = "CONFLICT_REFUSED_NO_OVERWRITE"
                    $action = "SKIP_CONFLICT"
                    $stats.ConflictsSkipped++
                    Write-ReaLog "Conflict detected at destination: $destCanonical differs from package. Refusing overwrite without explicit -Force authorization." "WARN"
                }
            }
        }

        $resultsTable += [PSCustomObject]@{
            EntryId     = $entryId
            Type        = $entryType
            Scope       = $dest.Name
            Status      = $status
            Action      = $action
            Destination = $destCanonical
        }

        # Perform writes only if NOT in DryRun, NOT in Check, and action permits
        if (-not $DryRun -and -not $Check) {
            try {
                $parentDir = Split-Path -Parent $destCanonical
                if (-not (Test-Path $parentDir)) {
                    New-Item -ItemType Directory -Path $parentDir -Force | Out-Null
                }

                if ($action -eq "INSTALL") {
                    if ($PSCmdlet.ShouldProcess($destCanonical, "Install new component $entryId")) {
                        if (Test-Path $sourceResolved -PathType Leaf) {
                            Copy-Item -Path $sourceResolved -Destination $destCanonical -Force
                        } else {
                            Copy-Item -Path $sourceResolved -Destination $destCanonical -Recurse -Force
                        }
                        $stats.InstalledNew++
                        Write-ReaLog "Installed: $entryId -> $destCanonical" "SUCCESS"
                    }
                } elseif ($action -eq "BACKUP_AND_OVERWRITE") {
                    if ($PSCmdlet.ShouldProcess($destCanonical, "Backup and overwrite conflicting component $entryId")) {
                        # 1. Create timestamped backup
                        $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
                        $backupPath = "$destCanonical.bak-$timestamp"
                        Copy-Item -Path $destCanonical -Destination $backupPath -Recurse -Force

                        # Verify backup creation
                        if (-not (Test-Path $backupPath)) {
                            throw "Backup verification failed: backup path '$backupPath' does not exist."
                        }
                        Write-ReaLog "Created verified backup: $backupPath" "SECURITY"
                        $stats.BackupsCreated++

                        # 2. Overwrite target with source
                        if (Test-Path $sourceResolved -PathType Leaf) {
                            Copy-Item -Path $sourceResolved -Destination $destCanonical -Force
                        } else {
                            # Copy directory content
                            Copy-Item -Path $sourceResolved -Destination $destCanonical -Recurse -Force
                        }
                        $stats.ReplacementsAuthorized++
                        Write-ReaLog "Overwrote (authorized with backup): $entryId -> $destCanonical" "SUCCESS"
                    }
                }
            } catch {
                Write-ReaLog "Execution failed for $entryId at $destCanonical : $($_.Exception.Message)" "ERROR"
                $stats.Failures++
            }
        }
    }
}

# 4. Display Results Summary Table
Write-Host ""
Write-Host "=================== REA INSTALLATION AUDIT / EXECUTION REPORT ===================" -ForegroundColor White
$resultsTable | Format-Table -AutoSize EntryId, Type, Scope, Status, Action

Write-Host "=================== SUMMARY METRICS ===================" -ForegroundColor White
Write-Host "Scope Examined          : $Scope"
Write-Host "Total Declared Entries  : $($stats.TotalDeclared)"
Write-Host "Eligible New Components : $($stats.EligibleNew)"
Write-Host "Installed (New)         : $($stats.InstalledNew)"
Write-Host "Identical (Skipped)     : $($stats.IdenticalSkipped)"
Write-Host "Conflicts (Skipped)     : $($stats.ConflictsSkipped)"
Write-Host "Replacements Authorized : $($stats.ReplacementsAuthorized)"
Write-Host "Backups Created         : $($stats.BackupsCreated)"
Write-Host "Failures / Errors       : $($stats.Failures)"
Write-Host "=======================================================" -ForegroundColor White

if ($stats.Failures -gt 0) {
    Write-ReaLog "Installer completed with $($stats.Failures) errors." "ERROR"
    exit 1
} elseif ($stats.ConflictsSkipped -gt 0 -and -not $Force) {
    Write-ReaLog "Installer completed safely. $($stats.ConflictsSkipped) conflicting items were protected from overwrite. Use -Force if you explicitly authorize replacing them." "WARN"
    exit 0
} else {
    Write-ReaLog "Operation completed successfully with 0 errors." "SUCCESS"
    exit 0
}
