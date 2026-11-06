# WORKFLOW: REA Approve Frontend Reconstruction

**Workflow ID:** `rea-approve-reconstruction`  
**Trigger:** Explicit written user instruction authorizing reconstruction (e.g. `/rea-approve-reconstruction` or "I approve frontend reconstruction")  
**Target Part:** PART 07 (Phase 13: Frontend-Only Reconstruction)  
**Governing Document:** `PART-00-MASTER-CONTROL.md` & `PART-07-FRONTEND-RECONSTRUCTION.md`

---

## Prerequisites Verification (Strict Gating)
Before any reconstruction file or directory is created, verify:
1. `PART-06` is complete and delivered.
2. Phase 11 Completeness Gate evaluated to `PASS`.
3. `application-graph.json` and `ir.json` are frozen in `{{AUDIT_DIR}}`.
4. `final-feasibility-reconciliation.md` exists and confirms route feasibility.
5. `STACK-DECISION` in `technology-stack.md` is `READY` (or user explicitly resolved stack choice).
6. User's explicit written approval specifically authorizing frontend reconstruction is recorded in `progress-log.md`.

If any prerequisite is missing: **HALT IMMEDIATELY**. Do not create `{{RECON_DIR}}` or generate any code.

---

## Execution Steps

### Step 1: Input Contract Verification
- Read `ir.json`, `ir-summary.md`, and `asset-register.md`.
- Verify that only `Authorized` assets will be reused; unapproved assets mapped to placeholders.
- Ensure that any route marked `NOT FEASIBLE` is isolated and marked as a placeholder.

### Step 2: Workspace Setup & Technology Selection
- Create `{{RECON_DIR}}`. Keep `{{AUDIT_DIR}}` completely untouched.
- Initialize the frontend project using the verified original technology stack (from Phase 6 evidence).
- Verify zero backend dependencies (no database, no server API).

### Step 3: Component & Route Reconstruction
- Reconstruct shared layouts, navigation, and page hierarchies.
- Implement reusable components matching observed design tokens and component origin (`server` vs `client`).
- Reimplement observed client-side interactions and state machines.

### Step 4: Synthetic Mock API Implementation
- Generate local mock data fixtures adhering strictly to observed API schemas in `ir.json::mockContracts`.
- Simulate authentication UI locally without external backend connection.

### Step 5: Quality Assurance & Eight-Dimension Acceptance
- Run local frontend build (`npm run build`). Fix any compilation errors.
- Evaluate the 8 acceptance dimensions:
  1. Visual Fidelity (using `render.local` if Supported; else limitation).
  2. Route Coverage.
  3. Components and Layout.
  4. Interactions.
  5. Client-Side State.
  6. Responsive Behavior (including 390px mobile).
  7. Assets (Authorized only).
  8. Functional Consistency.
- Produce `ir-traceability.md` and `acceptance-matrix.md`.
- Deliver `reconstruction-report.md` in `{{RECON_DIR}}`.

---

## Gate & Mandatory Stop
1. Final acceptance check:
   - Frontend build succeeds.
   - All 8 dimensions evaluated.
   - Every IR node traced.
   - Zero backend code present.
   - Audit directory intact.
2. Present final reconstruction report and run instructions to the user.
3. **STOP.**
