# WORKFLOW: REA Feasibility Check (Archived Reference Runbook)

> [!WARNING]
> **DEPRECATION & MIGRATION NOTICE:**  
> Standalone workflow files (`.agents/workflows/*.md`) are deprecated in Google Antigravity. Live slash command `/rea-feasibility-assessment` is powered directly by [`skills/rea-feasibility-assessment/SKILL.md`](../skills/rea-feasibility-assessment/SKILL.md). This file is preserved as an offline procedural reference runbook. See [`WORKFLOW-MIGRATION-GUIDE.md`](../antigravity/WORKFLOW-MIGRATION-GUIDE.md).

**Workflow ID:** `rea-feasibility-check` (Reference Runbook)  
**Governing Skill:** `rea-feasibility-assessment` (`/rea-feasibility-assessment`)  
**Target Master Phases:** `MASTER-PHASE-04` (Provisional) or `MASTER-PHASE-13` (Final Reconciliation)  
**Governing Documents:** `PART-01-PREFLIGHT.md`, `PART-06-COMPLETENESS-AND-MASTER-REPORT.md`, `REA-SCHEMAS.md` §8, `REA-PHASE-REGISTRY.md`

---

## Prerequisites Verification
1. Phase 0 baseline load has been performed, OR Phases 1–10 investigation data is available.
2. Evidence Ledger (`evidence-ledger.md`) is accessible.

---

## Execution Steps

### Mode A: Provisional Feasibility Check (`MASTER-PHASE-04` / `PART-01-LOCAL-PHASE-00.4`)
1. Evaluate the 10 technical feasibility dimensions:
   - (1) Authentication & Session complexity
   - (2) Dynamic & Anti-Bot challenges
   - (3) Network & Protocol dependencies
   - (4) Client Architecture & Hydration markers
   - (5) Route Complexity & depth
   - (6) Responsive & Viewport requirements
   - (7) Design System & Asset accessibility
   - (8) Storage & State models
   - (9) API Surface & dependency contracts
   - (10) Build & Reconstruction blockers
2. Assign canonical classification to entry Route and visible features: `FEASIBLE`, `PARTIALLY_FEASIBLE`, `NOT_FEASIBLE`, `UNKNOWN`.
3. Assign qualitative difficulty: `LOW`, `MEDIUM`, `HIGH`, or `UNKNOWN` (marked `[INFERRED]`).
4. Save `feasibility-assessment.md` and optional `feasibility-assessment.json`.

### Mode B: Final Feasibility Reconciliation (`MASTER-PHASE-13` / `PART-06-LOCAL-PHASE-11` DO 12)
1. Read `feasibility-assessment.md` and accumulated page records, technology stack, and API maps.
2. Reconcile route-by-route and feature-by-feature feasibility decisions using append-only records.
3. Document any shifts in classification with supporting E-IDs.
4. Flag any `NOT_FEASIBLE` finding as an explicit reconstruction blocker.
5. Save `final-feasibility-reconciliation.md`.

---

## Gate & Blocker Policy
1. If any primary route or essential feature is `NOT_FEASIBLE`:
   - **Do NOT cancel audit progression.** Audit phases (`MASTER-PHASE-05` through `MASTER-PHASE-14`) continue to capture all allowable evidence.
   - **`NOT_FEASIBLE` blocks ONLY `MASTER-PHASE-16` (`PART-07-LOCAL-PHASE-13` Frontend Reconstruction).**
   - Present specific technical blockers to the user.
   - Present feasible alternatives (e.g. documentation-only audit, partial shell).
   - Await user guidance before considering reconstruction.
2. **STOP.** Report feasibility findings clearly to the user.
