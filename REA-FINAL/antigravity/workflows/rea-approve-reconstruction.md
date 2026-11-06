# WORKFLOW: REA Approve Frontend Reconstruction (Archived Reference Runbook)

> [!WARNING]
> **DEPRECATION & MIGRATION NOTICE:**  
> Standalone workflow files (`.agents/workflows/*.md`) are deprecated in Google Antigravity. Live slash command `/rea-frontend-reconstruction` is powered directly by [`skills/rea-frontend-reconstruction/SKILL.md`](../skills/rea-frontend-reconstruction/SKILL.md). This file is preserved as an offline procedural reference runbook. See [`WORKFLOW-MIGRATION-GUIDE.md`](../antigravity/WORKFLOW-MIGRATION-GUIDE.md).

**Workflow ID:** `rea-approve-reconstruction` (Reference Runbook)  
**Governing Skill:** `rea-frontend-reconstruction` (`/rea-frontend-reconstruction`)  
**Target Part:** `PART-07` (`MASTER-PHASE-16` / `PART-07-LOCAL-PHASE-13`: Frontend-Only Reconstruction)  
**Governing Documents:** `PART-00-MASTER-CONTROL.md`, `PART-06-COMPLETENESS-AND-MASTER-REPORT.md`, `PART-07-FRONTEND-RECONSTRUCTION.md`, `REA-PHASE-REGISTRY.md`

---

## Prerequisites Verification (Strict Reconstruction Gate)
Before any reconstruction file or directory is created, verify:
1. `PART-06` is complete and delivered.
2. `MASTER-PHASE-13` (Phase 11 Completeness Gate) evaluated to `PASS`.
3. `application-graph.json` and `ir.json` are frozen in `{{AUDIT_DIR}}`.
4. `final-feasibility-reconciliation.md` exists; any `NOT_FEASIBLE` finding is isolated or resolved.
5. `STACK-DECISION` in `technology-stack.md` is `READY` (or user explicitly resolved stack choice).
6. User's **explicit, separate, written approval** specifically authorizing frontend reconstruction is recorded in `progress-log.md`.

If any prerequisite is missing: **HALT IMMEDIATELY**. Do not create `{{RECON_DIR}}` or generate any code.

---

## Execution Steps

### Step 1: Input Contract Verification
- Read `ir.json`, `ir-summary.md`, and `asset-register.md`.
- Verify that only `Authorized` assets will be reused; unapproved assets mapped to placeholders.
- Ensure that any route marked `NOT_FEASIBLE` is isolated and marked as a placeholder.

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

### Step 5: Quality Assurance & Canonical Eight-Dimension Acceptance (`MASTER-PHASE-17`)
- Run local frontend build (`npm run build`). Fix any compilation errors.
- Evaluate the Canonical Eight Acceptance Dimensions:
  1. Visual fidelity (`VERIFIED` / `NOT_VERIFIED` with `LIMITATION`)
  2. Route coverage (`VERIFIED` / `NOT_VERIFIED` with `LIMITATION`)
  3. Components and layout (`VERIFIED` / `NOT_VERIFIED` with `LIMITATION`)
  4. Interactions (`VERIFIED` / `NOT_VERIFIED` with `LIMITATION`)
  5. Client-side state (`VERIFIED` / `NOT_VERIFIED` with `LIMITATION`)
  6. Responsive behavior (`VERIFIED` / `NOT_VERIFIED` with `LIMITATION`)
  7. Assets (`VERIFIED` / `NOT_VERIFIED` with `LIMITATION`)
  8. Functional consistency (`VERIFIED` / `NOT_VERIFIED` with `LIMITATION`)
- Save `acceptance-matrix.md` and `reconstruction-report.md`.
- Present final deliverable package and run instructions.
