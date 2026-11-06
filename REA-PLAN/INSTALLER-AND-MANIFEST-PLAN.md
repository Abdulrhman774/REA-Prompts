# REA PLAN — INSTALLER AND MANIFEST PLAN
**Stage One | Generated:** 2026-11-06  
**Status:** PLAN — Installer does not exist; must be created from scratch in Stage Two.

---

## 1. Current State

**Installer found:** NO  
**Manifest found:** NO  
**Search locations checked:**
- `C:\Users\abd alrhman\Downloads\Prompts` — no .ps1, no .json manifest
- `C:\Users\abd alrhman\Downloads` — no REA installer found
- `C:\Users\abd alrhman\.gemini\config` — no REA installer found
- `C:\Users\abd alrhman\.agents` — no REA installer found (`.skill-lock.json` exists but is an Antigravity internal file)

---

## 2. Installer Requirements (from Work Order §19)

### 2.1 Installer Modes

| Mode | Flag | Behavior |
|---|---|---|
| Global install | `--global` or default | Install to `~/.gemini/config/` |
| Workspace install | `--workspace <path>` | Install to specified project's `.agents/` |
| Dry run | `--dry-run` | Show what would happen without doing it |
| Check only | `--check` | Report versions and status; no changes |
| Force with backup | `--force` | Overwrite with automatic backup |

### 2.2 Safety Requirements

| Requirement | Implementation |
|---|---|
| No silent overwrite | Always check existing; backup before replace |
| No automatic script execution | Scripts excluded from automatic install by default |
| Explicit opt-in for scripts | `--allow-scripts` flag required |
| Duplicate detection | Hash comparison of existing vs. incoming |
| Version detection | Read metadata from existing SKILL.md |
| Disabled entries remain disabled | Read current state; preserve it |
| Backup before replacement | Copy to `<path>.bak-<timestamp>` |
| Clear status reporting | Per-item success/fail/skip/backup |
| Failure reporting | Non-zero exit on any failure; list all failures |

---

## 3. Manifest Requirements

### 3.1 Manifest Format (skills-manifest.json)

```json
{
  "schema": "1.0",
  "package": "rea-skills",
  "version": "1.0.0",
  "description": "REA Reverse Engineering Agent — Skills package",
  "entries": [
    {
      "id": "rea-orchestrator",
      "type": "skill",
      "source": "local",
      "sourcePath": "./skills/rea-orchestrator",
      "destination": "global",
      "enabled": true,
      "version": "1.0.0",
      "validation": ["SKILL.md"]
    },
    ...
  ]
}
```

### 3.2 Source Types

| Type | Description | Safety Requirements |
|---|---|---|
| `local` | Local filesystem path relative to manifest | Validate path exists; no symlink traversal |
| `github` | GitHub repository (if implemented) | Requires explicit user authorization; pinned version; no auto-update |
| `zip` | ZIP archive | Validate hash before extract; no auto-execute |

> [!CAUTION]
> GitHub and ZIP sources must NOT be enabled in the manifest by default. They require explicit user authorization before use.

### 3.3 Destination Values

| Value | Meaning | Path |
|---|---|---|
| `global` | Global Antigravity config | `~/.gemini/config/` |
| `workspace` | Current workspace | `{{WORKSPACE_PATH}}/.agents/` |

### 3.4 Entry Types

| Type | Meaning |
|---|---|
| `skill` | A SKILL.md folder |
| `rule` | A rules markdown file |
| `workflow` | A workflow markdown file |

---

## 4. Installer Design (Install-ReaSkills.ps1)

### 4.1 Parameter Block

```powershell
param(
    [string]$ManifestPath = ".\skills-manifest.json",
    [string]$WorkspacePath = "",
    [switch]$Global,
    [switch]$DryRun,
    [switch]$Check,
    [switch]$Force,
    [switch]$AllowScripts,
    [switch]$Verbose
)
```

### 4.2 Execution Flow

```
1. Load and validate manifest (schema check)
2. Determine installation targets (global / workspace)
3. Verify target directories exist and are writable
4. For each enabled entry:
   a. Validate source exists
   b. Validate source has required files (e.g., SKILL.md)
   c. Check if entry already exists at destination
   d. If exists: compare versions; plan skip/backup/overwrite
   e. If --dry-run: print plan; do not write
   f. If --check: report status; do not write
   g. Otherwise: backup if exists, copy, verify copy
5. Report summary: installed / skipped / backed up / failed
6. Exit 0 on full success; non-zero on any failure
```

### 4.3 Validation Checks

```
Manifest validation:
  - Valid JSON syntax
  - Required fields present (schema, entries)
  - Each entry has: id, type, source, sourcePath, destination, enabled
  - sourcePath exists (for local sources)
  - destination is "global" or "workspace"
  - Disabled entries: log as "skipped (disabled)"; do not install

Skill validation:
  - SKILL.md exists in sourcePath
  - SKILL.md has valid YAML frontmatter (name:, description:)
  - name in frontmatter matches entry id

Script safety:
  - By default, do not install entries with executable scripts unless --allow-scripts is set
  - Log any excluded scripts clearly
```

---

## 5. PowerShell Version Compatibility

| Feature | Min PS Version |
|---|---|
| `param()` block | PS 2.0 |
| `Get-FileHash` | PS 4.0 |
| `Test-Json` | PS 6.1+ (use alternative for PS 5.1) |
| `ConvertFrom-Json` | PS 3.0 |

**Target compatibility:** PowerShell 5.1+ (Windows built-in) with graceful degradation for PS 7+.

---

## 6. Test Environment

The installer must be tested in a temporary copy of the target directories before any actual installation. Stage Two testing plan:

```powershell
# Test in temp directory
$testRoot = Join-Path $env:TEMP "rea-install-test-$(Get-Date -Format 'yyyyMMddHHmmss')"
New-Item -ItemType Directory -Path $testRoot -Force

# Run installer with --dry-run first
.\Install-ReaSkills.ps1 -DryRun -ManifestPath .\skills-manifest.json

# Then run against test directory
.\Install-ReaSkills.ps1 --WorkspacePath $testRoot
```

**No actual installation to `~/.gemini/config/` until installer is verified in test.**
