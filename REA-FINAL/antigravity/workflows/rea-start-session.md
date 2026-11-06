# WORKFLOW: REA Start Session & Preflight

**Workflow ID:** `rea-start-session`  
**Trigger:** Explicit user command (e.g. `/rea-start-session` or "Initialize REA session")  
**Target Phase:** Phase 0 (Preflight & Capability Discovery)  
**Governing Document:** `PART-00-MASTER-CONTROL.md` & `PART-01-PREFLIGHT.md`

---

## Prerequisites Verification
Before proceeding, verify:
1. Target website URL (`{{TARGET_URL}}`) has been explicitly provided by the user.
2. User's authorization statement for the target application is recorded.
3. Project parameters are defined (`PROJECT_NAME`, `PROJECT_SLUG`, `AUDIT_DIR`).
4. REA MCP server (`rea-agents@6.8.0`) is registered and accessible.

---

## Execution Steps

### Step 1: Initialize Workspace Tracking Files
Create `{{AUDIT_DIR}}` and initialize:
- `progress-log.md`
- `url-queue.md`
- `evidence-ledger.md`
- `findings.md`
- `capability-matrix.md`
- `checkpoint.md`
- `skill-registry.md`
- `graph/fragments/` directory

### Step 2: Capability Discovery
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

### Step 3: Single Baseline Load
1. Load `{{TARGET_URL}}` exactly once through REA.
2. Record initial URL, final redirect URL, page title, and timestamp.
3. Capture baseline screenshot and assign sequential Evidence IDs (`E-001`, `E-002`, ...).

### Step 4: Provisional Feasibility Assessment
1. Run `rea-feasibility-assessment` across the 10 dimensions.
2. Classify entry route feasibility (`FEASIBLE`, `PARTIALLY FEASIBLE`, `NOT FEASIBLE`, `UNKNOWN`).
3. Save `feasibility-assessment.md`.

### Step 5: Initialize Application Graph
Write the root `Application` node (`APP-001`) to `graph/fragments/phase-00.jsonl`.

---

## Gate & Mandatory Stop
1. Verify Phase 0 Gate:
   - Capability matrix complete.
   - Skill Registry initialized.
   - Baseline evidence recorded.
   - Provisional feasibility recorded.
2. **STOP.** Report the gate status to the user.
3. **DO NOT** launch Phase 1 or PART-02 automatically. Wait for explicit user instruction.
