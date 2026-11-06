# WORKFLOW: REA Feasibility Check

**Workflow ID:** `rea-feasibility-check`  
**Trigger:** Explicit user command (e.g. `/rea-feasibility-check` or "Check target feasibility")  
**Target Phases:** Phase 0 (Provisional) or Phase 11 (Final Reconciliation)  
**Governing Document:** `PART-01-PREFLIGHT.md`, `PART-06-COMPLETENESS-AND-MASTER-REPORT.md`, `REA-SCHEMAS.md` §8

---

## Prerequisites Verification
1. Phase 0 baseline load has been performed, OR Phases 1–10 investigation data is available.
2. Evidence Ledger (`evidence-ledger.md`) is accessible.

---

## Execution Steps

### Mode A: Provisional Feasibility Check (Phase 0)
1. Evaluate the 10 feasibility dimensions:
   - Initial HTML vs Post-JS DOM
   - Hydration indicators
   - Markup origin (client vs server)
   - Script bundles and complexity
   - API dependencies
   - Route rendering modes
   - Feature dependencies
   - Tooling coverage
   - Potential reconstruction blockers
2. Assign canonical classification to entry Route and visible features: `FEASIBLE`, `PARTIALLY FEASIBLE`, `NOT FEASIBLE`, `UNKNOWN`.
3. Assign qualitative difficulty: `Low`, `Medium`, `High`, or `Unknown` (marked `[INFERRED]`).
4. Save `feasibility-assessment.md`.

### Mode B: Final Feasibility Reconciliation (Phase 11)
1. Read `feasibility-assessment.md` and accumulated page records, technology stack, and API maps.
2. Reconcile route-by-route and feature-by-feature feasibility decisions using append-only records.
3. Document any shifts in classification with supporting E-IDs.
4. Flag any `NOT FEASIBLE` finding as an explicit reconstruction blocker.
5. Save `final-feasibility-reconciliation.md`.

---

## Gate & Mandatory Stop
1. If any primary route or essential feature is `NOT FEASIBLE`:
   - Halt progression.
   - Present specific technical blockers to the user.
   - Present feasible alternatives (e.g. documentation-only audit, partial shell).
   - Await user guidance.
2. **STOP.** Report feasibility findings clearly to the user.
