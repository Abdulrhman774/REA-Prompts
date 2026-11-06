# WORKFLOW: REA Start Session & Preflight (Archived Reference Runbook)

> [!WARNING]
> **DEPRECATION & MIGRATION NOTICE:**  
> Standalone workflow files (`.agents/workflows/*.md`) are deprecated in Google Antigravity. Live slash command `/rea-orchestrator` is powered directly by [`skills/rea-orchestrator/SKILL.md`](../skills/rea-orchestrator/SKILL.md). This file is preserved as an offline procedural reference runbook. See [`WORKFLOW-MIGRATION-GUIDE.md`](../antigravity/WORKFLOW-MIGRATION-GUIDE.md).

**Workflow ID:** `rea-start-session` (Reference Runbook)  
**Governing Skill:** `rea-orchestrator` (`/rea-orchestrator`)  
**Target Master Phases:** `MASTER-PHASE-01` through `MASTER-PHASE-04`  
**Governing Documents:** `PART-00-MASTER-CONTROL.md`, `PART-01-PREFLIGHT.md`, `REA-PHASE-REGISTRY.md`

---

## Prerequisites Verification
Before proceeding, verify:
1. Target website URL (`{{TARGET_URL}}`) has been explicitly provided by the user.
2. User's authorization statement for the target application is recorded.
3. Project parameters are defined (`PROJECT_NAME`, `PROJECT_SLUG`, `AUDIT_DIR`).
4. REA MCP server (`rea-agents@6.8.0`) or approved tools are registered and accessible.

---

## Execution Steps

### Step 1: Initialize Workspace Tracking Files (`MASTER-PHASE-01` / `02`)
Create `{{AUDIT_DIR}}` and initialize:
- `progress-log.md`
- `url-queue.md`
- `evidence-ledger.md`
- `findings.md`
- `capability-matrix.md`
- `checkpoint.md`
- `skill-registry.md`
- `graph/fragments/` directory

### Step 2: Capability Discovery (`MASTER-PHASE-03` / `04`)
1. Probe REA's officially available documentation and execution interfaces.
2. Populate `capability-matrix.md` with:
   - `nav.open-url`
   - `capture.screenshot`
   - `inspect.dom`
   - `inspect.network-log`
   - `inspect.initial-html`
   - `analyze.rendering-mode`
   - other core capabilities.
3. Mark unverified capabilities as `NOT_VERIFIED`. Never assume availability.

### Step 3: Single Baseline Load (`MASTER-PHASE-06`)
1. Load `{{TARGET_URL}}` exactly once through REA.
2. Record initial URL, final redirect URL, page title, and timestamp.
3. Capture baseline screenshot and assign sequential Evidence IDs (`E-001`, `E-002`, ...).

### Step 4: Provisional Feasibility Assessment (`MASTER-PHASE-07` / `PART-01-LOCAL-PHASE-00.4`)
1. Run `rea-feasibility-assessment` across the 10 dimensions.
2. Assign canonical classification to entry Route and visible features: `FEASIBLE`, `PARTIALLY_FEASIBLE`, `NOT_FEASIBLE`, `UNKNOWN`.
3. If entry route is `NOT_FEASIBLE`: document specific blockers in `feasibility-assessment.md`; note that `NOT_FEASIBLE` blocks ONLY reconstruction (`MASTER-PHASE-16`), while audit phases continue.
4. Save `feasibility-assessment.md`.

---

## Gate & Mandatory Stop
1. Verify `PART-01` gate conditions:
   - All capabilities relevant to planned work verified or marked `NOT_VERIFIED` with fallback.
   - Baseline recorded.
   - Tracking files initialized.
   - Provisional feasibility recorded.
2. **STOP.** Report Phase 0 gate result to user. Await explicit instruction before proceeding to Phase 1 (`MASTER-PHASE-05`).
