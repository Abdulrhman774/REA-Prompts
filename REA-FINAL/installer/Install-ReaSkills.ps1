<#
.SYNOPSIS
    Install-ReaSkills.ps1 - Safe, non-destructive installer and validator for the REA Antigravity Suite.

.DESCRIPTION
    Installs and validates REA Skills, Rules, and Workflows into Google Antigravity environments.
    Supports Global (~/.gemini/config/), Workspace-only (<root>/.agents/), or Both scopes.
    Features dry-run planning, status checking, duplicate detection, automatic backups, and script safety.

.PARAMETER Scope
    Target deployment scope. Valid values: "Global", "Workspace", "Both". Default is "Global".

.PARAMETER WorkspaceRoot
    Root directory of the workspace project when Scope is "Workspace" or "Both". Defaults to current directory.

.PARAMETER ManifestPath
    Path to the skills manifest JSON file. Defaults to ".\skills-manifest.json".

.PARAMETER DryRun
    Simulates all operations, displaying planned actions without writing or modifying any files.

.PARAMETER Check
    Reports installation status, version alignment, and integrity across targets without performing modifications.

.PARAMETER Force
    Forces replacement of existing files (still performs an automatic timestamped backup first).

.PARAMETER AllowScripts
    Explicit opt-in to permit copying executable script files (if any). By default, scripts are excluded.

.PARAMETER VerboseOutput
    Displays detailed diagnostics during validation and execution.

.EXAMPLE
    .\Install-ReaSkills.ps1 -Check
    Checks current status of REA skills across global and workspace targets.

.EXAMPLE
    .\Install-ReaSkills.ps1 -DryRun -Scope Both -WorkspaceRoot "C:\Projects\MyApp"
    Plans a deployment to both global and workspace environments without making changes.

.EXAMPLE
    .\Install-ReaSkills.ps1 -Scope Workspace -WorkspaceRoot "C:\Projects\MyApp"
    Installs REA skills into the specified workspace's .agents/ directory.
#>

[CmdletBinding()]
param(
    [ValidateSet("Global", "Workspace", "Both")]
    [string]$Scope = "Global",

    [string]$WorkspaceRoot = (Get-Location).Path,

    [string]$ManifestPath = ".\skills-manifest.json",

    [switch]$DryRun,

    [switch]$Check,

    [switch]$Force,

    [switch]$AllowScripts,

    [switch]$VerboseOutput
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Write-ReaLog {
    param([string]$Message, [string]$Level = "INFO")
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $color = switch ($Level) {
        "INFO"    { "Cyan" }
        "SUCCESS" { "Green" }
        "WARN"    { "Yellow" }
        "ERROR"   { "Red" }
        "PLAN"    { "Magenta" }
        Default   { "White" }
    }
    Write-Host "[$timestamp] [$Level] $Message" -ForegroundColor $color
}

# Resolve paths
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
if (-not [System.IO.Path]::IsPathRooted($ManifestPath)) {
    $ManifestPath = Join-Path $ScriptDir $ManifestPath
}

Write-ReaLog "Starting REA Suite Installer / Validator..." "INFO"
Write-ReaLog "Manifest Path: $ManifestPath" "INFO"
Write-ReaLog "Requested Scope: $Scope" "INFO"
if ($DryRun) { Write-ReaLog "Mode: DRY-RUN (No filesystem modifications will occur)" "PLAN" }
if ($Check)  { Write-ReaLog "Mode: CHECK-ONLY (Audit status report)" "PLAN" }

# 1. Validate Manifest File
if (-not (Test-Path $ManifestPath)) {
    Write-ReaLog "Manifest file not found: $ManifestPath" "ERROR"
    exit 1
}

try {
    $manifestRaw = Get-Content -Path $ManifestPath -Raw -Encoding utf8
    $manifest = $manifestRaw | ConvertFrom-Json
} catch {
    Write-ReaLog "Failed to parse JSON manifest: $_" "ERROR"
    exit 1
}

if (-not $manifest.package -or -not $manifest.entries) {
    Write-ReaLog "Manifest schema invalid. 'package' and 'entries' required." "ERROR"
    exit 1
}

Write-ReaLog "Loaded package: $($manifest.package) v$($manifest.version) ($($manifest.entries.Count) entries)" "SUCCESS"

# 2. Determine Destination Roots
$destinations = @()
$globalRoot = Join-Path $env:USERPROFILE ".gemini\config"

if ($Scope -eq "Global" -or $Scope -eq "Both") {
    $destinations += @{
        Name = "Global"
        Root = $globalRoot
        SkillsDir = Join-Path $globalRoot "skills"
        RulesDir = Join-Path $globalRoot "rules"
        WorkflowsDir = Join-Path $globalRoot "workflows"
    }
}

if ($Scope -eq "Workspace" -or $Scope -eq "Both") {
    $wsAgentsRoot = Join-Path $WorkspaceRoot ".agents"
    $destinations += @{
        Name = "Workspace"
        Root = $wsAgentsRoot
        SkillsDir = Join-Path $wsAgentsRoot "skills"
        RulesDir = Join-Path $wsAgentsRoot "rules"
        WorkflowsDir = Join-Path $wsAgentsRoot "workflows"
    }
}

# 3. Processing and Validation Loop
$stats = @{
    Total = $manifest.entries.Count
    Verified = 0
    Identical = 0
    NeedsUpdate = 0
    Missing = 0
    Installed = 0
    BackedUp = 0
    Errors = 0
}

$resultsTable = @()

foreach ($entry in $manifest.entries) {
    $entryId = $entry.id
    $entryType = $entry.type
    $enabled = $entry.enabled
    
    if (-not $enabled) {
        Write-ReaLog "Skipping disabled entry: $entryId" "WARN"
        continue
    }

    # Resolve local source path relative to manifest location
    $sourceResolved = Join-Path $ScriptDir $entry.sourcePath
    if (-not (Test-Path $sourceResolved)) {
        Write-ReaLog "Source path missing for entry ${entryId}: $sourceResolved" "ERROR"
        $stats.Errors++
        continue
    }
    $sourceResolved = (Resolve-Path $sourceResolved).Path

    # Skill metadata validation (YAML frontmatter check)
    if ($entryType -eq "skill") {
        $skillMdPath = Join-Path $sourceResolved "SKILL.md"
        if (-not (Test-Path $skillMdPath)) {
            Write-ReaLog "Skill descriptor missing in ${sourceResolved}: SKILL.md required." "ERROR"
            $stats.Errors++
            continue
        }
        $skillContent = Get-Content -Path $skillMdPath -Raw -Encoding utf8
        if ($skillContent -notmatch "(?s)^---\s*\r?\n(.*?)\r?\n---\s*\r?\n") {
            Write-ReaLog "Invalid YAML frontmatter in $skillMdPath" "ERROR"
            $stats.Errors++
            continue
        }
        $frontmatter = $matches[1]
        if ($frontmatter -notmatch "name:\s*([a-zA-Z0-9_-]+)") {
            Write-ReaLog "Frontmatter missing 'name:' in $skillMdPath" "ERROR"
            $stats.Errors++
            continue
        }
        if ($frontmatter -notmatch "description:\s*(.+)") {
            Write-ReaLog "Frontmatter missing 'description:' in $skillMdPath" "ERROR"
            $stats.Errors++
            continue
        }
    }

    # Evaluate across requested destinations
    foreach ($dest in $destinations) {
        $destPath = Join-Path $dest.Root $entry.targetDirectory
        $status = "UNKNOWN"
        $action = "NONE"

        $destExists = Test-Path $destPath

        if (-not $destExists) {
            $status = "NOT_INSTALLED"
            $action = if ($DryRun -or $Check) { "WOULD_INSTALL" } else { "INSTALL" }
            $stats.Missing++
        } else {
            # File or Directory exists: perform hash / duplicate comparison
            $isIdentical = $false

            if (Test-Path $destPath -PathType Leaf) {
                # Single file comparison (rule or workflow)
                $srcHash = (Get-FileHash -Path $sourceResolved -Algorithm SHA256).Hash
                $dstHash = (Get-FileHash -Path $destPath -Algorithm SHA256).Hash
                $isIdentical = ($srcHash -eq $dstHash)
            } else {
                # Directory comparison (skill)
                $srcSkillMd = Join-Path $sourceResolved "SKILL.md"
                $dstSkillMd = Join-Path $destPath "SKILL.md"
                if (Test-Path $dstSkillMd) {
                    $srcHash = (Get-FileHash -Path $srcSkillMd -Algorithm SHA256).Hash
                    $dstHash = (Get-FileHash -Path $dstSkillMd -Algorithm SHA256).Hash
                    $isIdentical = ($srcHash -eq $dstHash)
                }
            }

            if ($isIdentical) {
                $status = "ALREADY_INSTALLED_IDENTICAL"
                $action = "SKIP"
                $stats.Identical++
            } else {
                $status = "OUTDATED_OR_MODIFIED"
                $action = if ($Force) { "BACKUP_AND_OVERWRITE" } else { "BACKUP_AND_UPDATE" }
                $stats.NeedsUpdate++
            }
        }

        $resultsTable += [PSCustomObject]@{
            EntryId     = $entryId
            Type        = $entryType
            Scope       = $dest.Name
            Status      = $status
            Action      = $action
            Destination = $destPath
        }

        # Perform actual execution if not in DryRun or Check mode
        if (-not $DryRun -and -not $Check) {
            try {
                $parentDir = Split-Path -Parent $destPath
                if (-not (Test-Path $parentDir)) {
                    New-Item -ItemType Directory -Path $parentDir -Force | Out-Null
                }

                if ($destExists -and -not $isIdentical) {
                    # Create timestamped backup
                    $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
                    $backupPath = "$destPath.bak-$timestamp"
                    Copy-Item -Path $destPath -Destination $backupPath -Recurse -Force
                    Write-ReaLog "Created backup: $backupPath" "WARN"
                    $stats.BackedUp++
                }

                if (-not $destExists -or -not $isIdentical -or $Force) {
                    if (Test-Path $sourceResolved -PathType Leaf) {
                        Copy-Item -Path $sourceResolved -Destination $destPath -Force
                    } else {
                        # Directory copy with script filtering if AllowScripts is not set
                        if (-not (Test-Path $destPath)) {
                            New-Item -ItemType Directory -Path $destPath -Force | Out-Null
                        }
                        $sourceFiles = Get-ChildItem -Path $sourceResolved -Recurse
                        foreach ($sf in $sourceFiles) {
                            $rel = $sf.FullName.Substring($sourceResolved.Length).TrimStart("\", "/")
                            $targetFile = Join-Path $destPath $rel
                            
                            # Script exclusion check
                            $isScript = $sf.Extension -match "\.(ps1|bat|cmd|sh|py)$"
                            if ($isScript -and -not $AllowScripts) {
                                Write-ReaLog "Excluding executable script (use -AllowScripts to permit): $($sf.Name)" "WARN"
                                continue
                            }

                            if ($sf.PSIsContainer) {
                                if (-not (Test-Path $targetFile)) {
                                    New-Item -ItemType Directory -Path $targetFile -Force | Out-Null
                                }
                            } else {
                                $tParent = Split-Path -Parent $targetFile
                                if (-not (Test-Path $tParent)) { New-Item -ItemType Directory -Path $tParent -Force | Out-Null }
                                Copy-Item -Path $sf.FullName -Destination $targetFile -Force
                            }
                        }
                    }
                    Write-ReaLog "Deployed [$($dest.Name)] $entryId -> $destPath" "SUCCESS"
                    $stats.Installed++
                }
            } catch {
                Write-ReaLog "Failed to deploy ${entryId} to ${destPath}: $_" "ERROR"
                $stats.Errors++
            }
        }
    }
}

# 4. Output Summary Table
Write-Host ""
Write-Host "=== REA SUITE AUDIT & DEPLOYMENT SUMMARY ===" -ForegroundColor Cyan
$resultsTable | Format-Table -Property EntryId, Type, Scope, Status, Action -AutoSize

Write-Host ""
Write-ReaLog "Execution Results: Total Entries=$($stats.Total), Missing=$($stats.Missing), Identical=$($stats.Identical), NeedsUpdate=$($stats.NeedsUpdate), Errors=$($stats.Errors)" "INFO"

if ($stats.Errors -gt 0) {
    Write-ReaLog "Completed with $($stats.Errors) error(s)." "ERROR"
    exit 2
} else {
    Write-ReaLog "Validation / Operation completed successfully with ZERO errors." "SUCCESS"
    exit 0
}
