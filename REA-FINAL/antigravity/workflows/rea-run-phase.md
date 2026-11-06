# WORKFLOW: REA Run Phase / Partition (Archived Reference Runbook)

> [!WARNING]
> **DEPRECATION & MIGRATION NOTICE:**  
> Standalone workflow files (`.agents/workflows/*.md`) are deprecated in Google Antigravity. Live slash command `/rea-orchestrator` is powered directly by [`skills/rea-orchestrator/SKILL.md`](../skills/rea-orchestrator/SKILL.md). This file is preserved as an offline procedural reference runbook. See [`WORKFLOW-MIGRATION-GUIDE.md`](../antigravity/WORKFLOW-MIGRATION-GUIDE.md).

**Workflow ID:** `rea-run-phase` (Reference Runbook)  
**Governing Skill:** `rea-orchestrator` (`/rea-orchestrator`)  
**Target Parts:** `PART-01` through `PART-06` (`PART-07` requires explicit written approval)  
**Governing Documents:** `PART-00-MASTER-CONTROL.md`, `REA-PHASE-REGISTRY.md`

---

## Prerequisites Verification
1. Verify that the previous partition's gate evaluated to `PASS`.
2. Verify that the latest checkpoint (`checkpoint.md`) has been read.
3. Verify that the user has explicitly requested the current partition.

---

## Execution Steps

### Step 1: Read Context & Checkpoints
- Read `PART-00-MASTER-CONTROL.md` and `REA-PHASE-REGISTRY.md`.
- Read the latest `checkpoint.md`, `progress-log.md`, and capability matrix.
- Verify that no prerequisite capability is marked `NOT_SUPPORTED` without a documented fallback.

### Step 2: Execute Requested Partition Only
- If PART 02 requested: Execute `MASTER-PHASE-05` and `06` only (`PART-02-LOCAL-PHASES-01-02` URL Discovery, Page Analysis).
- If PART 03 requested: Execute `MASTER-PHASE-07`, `08`, and `09` only (`PART-03-LOCAL-PHASES-03-05` Interactions, Design Tokens, Responsive).
- If PART 04 requested: Execute `MASTER-PHASE-10` and `11` only (`PART-04-LOCAL-PHASES-06-07` Tech Fingerprint, Architecture).
- If PART 05 requested: Execute `MASTER-PHASE-12` only (`PART-05-LOCAL-PHASES-08-10` Quality, Passive Security, Conditional Modules).
- If PART 06 requested: Execute `MASTER-PHASE-13`, `14`, and `15` only (`PART-06-LOCAL-PHASES-11-12` Completeness Gate, Final Report, IR Freeze).

### Step 3: Evidentiary Recording & Graph Fragment Emission
- Append all new observations to `evidence-ledger.md` using sequential E-IDs.
- Write incremental graph fragments to `graph/fragments/phase-NN.jsonl`.
- Update findings in `findings.md`.

### Step 4: Checkpoint Preservation
- Save updated `checkpoint.md` recording visited URLs, evidence ID range, findings range, and graph node counts.

---

## Gate & Mandatory Stop
1. Evaluate the partition gate criteria.
2. Produce the standardized end-of-partition response:
   - Partition and phases attempted/completed.
   - Gate result: `PASS`, `FAIL`, or `PARTIAL`.
   - Deliverables saved and paths.
   - Evidence IDs and findings generated.
   - Limitations and blocked items.
   - Exact next partition name.
3. **MANDATORY STOP:** Halt execution immediately. Never automatically begin the next partition. Wait for explicit user instruction.
