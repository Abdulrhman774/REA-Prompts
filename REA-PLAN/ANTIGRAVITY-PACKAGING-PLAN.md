# REA PLAN — ANTIGRAVITY PACKAGING PLAN
**Stage One | Generated:** 2026-11-06  
**Status:** PLAN — Based on verified Antigravity conventions from agy-customizations SKILL.md

---

## 1. Verified Antigravity Conventions

| Item | Verified Value |
|---|---|
| Global config root | `~/.gemini/config/` = `C:\Users\abd alrhman\.gemini\config\` |
| Global Skills directory | `~/.gemini/config/skills/<name>/SKILL.md` |
| Global Rules directory | `~/.gemini/config/rules/*.md` |
| Workspace Skills | `.agents/skills/<name>/SKILL.md` in project root |
| Workspace Rules | `.agents/rules/*.md` or `GEMINI.md`, `AGENTS.md` |
| Plugins | `~/.gemini/config/plugins/<name>/plugin.json` |
| Hooks | `~/.gemini/config/hooks.json` |
| MCP servers | `~/.gemini/config/mcp_config.json` |
| Skill format | YAML frontmatter with `name:` and `description:` fields; `---` delimiters |
| Skill activation | Progressive disclosure — names/descriptions injected; full content on explicit activation |
| Rules activation | `always_on` rules loaded unconditionally; `trigger: model_decision` rules on demand |
| Existing REA MCP | Registered in `~/.gemini/config/mcp_config.json` ✓ |
| Existing rules | `browser.md` and `persistent-memory.md` in `~/.gemini/config/rules/` |

---

## 2. Packaging Strategy

### 2.1 Global vs. Workspace

The REA package will support two deployment scopes:

| Scope | Target Path | Use Case |
|---|---|---|
| **Global** | `~/.gemini/config/skills/rea-*/` | Available in all projects on this machine |
| **Workspace** | `{{PROJECT_ROOT}}/.agents/skills/rea-*/` | Available only within the specific REA project |

The installer will support both. The default will be global for the REA Skills (since REA sessions can be run against any target) and workspace for project-specific configuration.

### 2.2 REA Rules

**Location:** `~/.gemini/config/rules/rea-identity.md` (global) or `.agents/rules/rea-identity.md` (workspace)

**Content strategy:** Keep concise. The Rules file defines:
- REA's identity and primary orchestrator role
- Safety restriction summary (observe-only, no bypass, no PART-07 without approval)
- Source-of-truth declaration (markdown wins over Graph/IR)
- Evidence integrity requirements (E-IDs mandatory, labels mandatory)
- Phase sequencing declaration (partition-by-partition only)
- Approval gate declaration (PART-07 requires written approval)
- Prohibition on replacing REA with external tools

**What it does NOT contain:** Detailed specifications — those remain in the Part documents.

### 2.3 REA Workflows

**Location:** `~/.gemini/config/workflows/` or workspace equivalent

**Planned workflows:**
1. `rea-start-session.md` — Load documentation, discover skills, initialize workspace
2. `rea-feasibility-check.md` — Run feasibility assessment against a target
3. `rea-run-phase.md` — Execute a specific phase with gate verification
4. `rea-generate-report.md` — Compile and present Phase 12 report
5. `rea-approve-reconstruction.md` — Explicit PART-07 approval workflow

**Constraint:** Workflows must not bypass approval gates. Each workflow reinforces the gate it covers.

### 2.4 REA-Specific Skills Packaging

Each REA Skill will be a folder under `~/.gemini/config/skills/`:

```
~/.gemini/config/skills/
├── rea-orchestrator/
│   └── SKILL.md
├── rea-evidence-ledger/
│   └── SKILL.md
├── rea-application-graph/
│   └── SKILL.md
├── rea-schemas-ir/
│   └── SKILL.md
├── rea-feasibility-assessment/
│   └── SKILL.md
├── rea-rendering-analysis/
│   └── SKILL.md
├── rea-browser-toolkit-adapter/
│   └── SKILL.md
├── rea-frontend-reconstruction/
│   └── SKILL.md
└── rea-validation/
    └── SKILL.md
```

Each SKILL.md will have YAML frontmatter:
```yaml
---
name: rea-<component>
description: <one-sentence description suitable for progressive disclosure>
---
```

### 2.5 Relationship Between REA Skills and reverse-engineer-anything

The existing `reverse-engineer-anything` skill (v49, 229 tools) describes the REA MCP server's native capabilities. The new REA-specific Skills describe how to USE those capabilities within the REA reverse engineering workflow. They are complementary:

| Skill | Role |
|---|---|
| `reverse-engineer-anything` | "Here are all the tools available" |
| `rea-orchestrator` | "Here is how to orchestrate a REA session" |
| `rea-evidence-ledger` | "Here is how to maintain evidence" |
| etc. | — |

The REA-specific Skills do NOT replace or override `reverse-engineer-anything`. They reference its capabilities by tool name.

---

## 3. Source Package Location

The REA package source lives in:
```
C:\Users\abd alrhman\Downloads\Prompts\REA-FINAL\
```

The installer deploys from this source to the installation targets above.

---

## 4. What Is Not Included in the Antigravity Package

| Item | Reason |
|---|---|
| REA MCP server configuration | Already installed; installer must check and NOT overwrite existing config |
| `reverse-engineer-anything` skill | Already installed; must not be replaced without version comparison |
| Project-specific audit files | Generated per-project at runtime; not packaged |
| Actual target data | Never packaged |
| Credentials | Never stored |

---

## 5. Installation Safety Rules

1. Check if target path already has a skill of the same name
2. If it does, compare versions before overwriting
3. Never silently overwrite — always backup first
4. Disabled entries remain disabled after install
5. Script execution requires explicit opt-in (`--allow-scripts` flag)
6. Dry-run mode must accurately predict all file operations

---

## 6. What Cannot Be Verified Until Stage Two

| Item | Why Deferred |
|---|---|
| Exact workflows directory path | The agy-customizations skill documents skills and rules clearly; workflows path needs verification from docs |
| Whether plugins.json is needed | No plugins are planned; can verify if a skills.json declaration is needed |
| Skill content quality | Skills must be authored; content cannot be verified until written |
| Installer behavior | Installer must be written and tested in a safe temp environment |
