# REA WORKFLOW MIGRATION & COMPATIBILITY GUIDE
**Document ID:** REA-DOC-WF-MIG-001  
**Authority:** Antigravity Customization Standards  
**Status:** OFFICIAL MIGRATION SPECIFICATION

---

## 1. Antigravity Workflow Deprecation Context

In Google Antigravity, legacy standalone workflow files (`.agents/workflows/*.md` or `~/.gemini/config/workflows/*.md`) are officially **deprecated** in favor of the **Antigravity Skills architecture** (`skills/<name>/SKILL.md`).

As documented in official Antigravity customization references:
- Legacy workflow `.md` files **do not** register interactive slash commands.
- Skills provide:
  1. First-class slash command support: Any skill folder `skills/<name>/SKILL.md` with valid YAML frontmatter is automatically mounted as `/<name>` in the chat UI.
  2. Progressive disclosure: Only names and descriptions are initially loaded, preserving context token budget.
  3. Semantic discovery: The agent can invoke the skill on demand based on conversation context.
  4. Multi-file modularity: Supports `scripts/`, `references/`, and `examples/`.

---

## 2. Legacy Workflow to Skill Migration Map

The procedural routines originally drafted as legacy workflow files map directly to dedicated REA Skills:

| Legacy Workflow File | Original File Path | Active Replacement Skill | Live Slash Command | Functional Scope |
|---|---|---|---|---|
| `rea-start-session.md` | `antigravity/workflows/rea-start-session.md` | `skills/rea-orchestrator/SKILL.md` | `/rea-orchestrator` | Session bootstrap, preflight checks, workspace initialization, and tool verification (`MASTER-PHASE-01` to `03`). |
| `rea-feasibility-check.md` | `antigravity/workflows/rea-feasibility-check.md` | `skills/rea-feasibility-assessment/SKILL.md` | `/rea-feasibility-assessment` | 10-dimension preflight technical feasibility evaluation (`MASTER-PHASE-04`). |
| `rea-run-phase.md` | `antigravity/workflows/rea-run-phase.md` | `skills/rea-orchestrator/SKILL.md` | `/rea-orchestrator` | Controlled execution of any single phase with strict input/output verification. |
| `rea-approve-reconstruction.md` | `antigravity/workflows/rea-approve-reconstruction.md` | `skills/rea-frontend-reconstruction/SKILL.md` | `/rea-frontend-reconstruction` | Formal reconstruction readiness checklist and gate verification (`MASTER-PHASE-15`). |

---

## 3. Operational Policy for Legacy Workflow Files

1. **Preservation:** The four legacy workflow files in `REA-FINAL/antigravity/workflows/` are preserved as **reference runbooks** so that human users and agents can read their step-by-step checklists.
2. **Deprecation Notice:** Each legacy workflow file carries a standard deprecation header explaining that slash commands are powered by the corresponding Skills.
3. **No Automatic Slash Claims:** Neither the installer nor the documentation advertises legacy workflow filenames as slash commands.
4. **Approval Protection:** No migrated Skill or legacy Workflow can manufacture user approval or automatically enter Phase 16 (`PART-07-LOCAL-PHASE-13` Reconstruction). Written human authorization remains strictly required.
