# WORKFLOW: REA Run Phase / Partition

**Workflow ID:** `rea-run-phase`  
**Trigger:** Explicit user command specifying a partition (e.g. `/rea-run-phase 2`, or "Run PART 02")  
**Target Part:** PART 01 through PART 06 (PART 07 requires `rea-approve-reconstruction`)  
**Governing Document:** `PART-00-MASTER-CONTROL.md` (Partition Execution Protocol)

---

## Prerequisites Verification
1. Verify that the previous partition's gate evaluated to `PASS`.
2. Verify that the latest checkpoint (`checkpoint.md`) has been read.
3. Verify that the user has explicitly requested the current partition.

---

## Execution Steps

### Step 1: Read Context & Checkpoints
- Read `PART-00-MASTER-CONTROL.md`.
- Read the latest `checkpoint.md`, `progress-log.md`, and capability matrix.
- Verify that no prerequisite capability is marked `NOT_SUPPORTED` without a documented fallback.

### Step 2: Execute Requested Partition Only
- If PART 02 requested: Execute Phases 1 and 2 only (URL Discovery, Page-by-Page Analysis).
- If PART 03 requested: Execute Phases 3, 4, and 5 only (Interactions, Design System, Responsive).
- If PART 04 requested: Execute Phases 6 and 7 only (Technology Fingerprint, Architecture).
- If PART 05 requested: Execute Phases 8, 9, and 10 only (Quality, Passive Security, Conditional Modules).
- If PART 06 requested: Execute Phases 11 and 12 only (Completeness Gate, Final Report, IR Freeze).

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
