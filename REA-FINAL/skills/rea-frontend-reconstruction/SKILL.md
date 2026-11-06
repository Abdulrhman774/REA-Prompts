---
name: rea-frontend-reconstruction
description: Frontend-only reconstruction engine for REA. Consumes the framework-agnostic IR, implements original-framework components, builds synthetic mock APIs, enforces asset authorization, and produces the complete frontend clone.
---

# REA Frontend-Only Reconstruction

## 1. Overview & Purpose
`rea-frontend-reconstruction` executes `MASTER-PHASE-16` (`PART-07-LOCAL-PHASE-13`) of the REA lifecycle. It consumes the frozen, framework-agnostic Intermediate Representation (`ir.json`) and audit deliverables to generate a clean, modern, frontend-only implementation of the target application in `{{RECON_DIR}}`. It strictly enforces the frontend-only boundary, builds synthetic mock API services matching observed contracts, and traces every IR node to a generated code file, placeholder, or documented blocker.

> [!NOTE]
> Governed authoritatively by [`REA-PHASE-REGISTRY.md`](../../REA-PHASE-REGISTRY.md). `MASTER-PHASE-16` is Reconstruction; `MASTER-PHASE-13` is IR Freeze.

## 2. Activation Guidance & Strict Stop Gate
**CRITICAL PROTECTION:** This skill is **STRICTLY FORBIDDEN** from activating until ALL of the following prerequisites are met:
1. `PART-06` audit deliverables are fully completed.
2. `MASTER-PHASE-13` (Phase 11 Completeness Gate) has evaluated to `PASS`.
3. Final Feasibility Reconciliation is complete; any `NOT_FEASIBLE` finding is isolated or resolved.
4. The user has provided **explicit, separate, written approval** specifically authorizing frontend reconstruction.

**This skill cannot approve its own execution.** Never infer approval from general praise, ambiguous statements, or prior permission.

## 3. Preconditions
- `{{AUDIT_DIR}}ir.json`, `ir-summary.md`, and `ir-derivation-log.md` exist and are frozen.
- `{{AUDIT_DIR}}final-feasibility-reconciliation.md` is available to enforce feasibility boundaries.
- `{{AUDIT_DIR}}asset-register.md` is loaded to enforce asset reproduction authorization.
- `{{RECON_DIR}}` is clean and isolated from the audit directory.

## 4. Inputs
- Frozen `ir.json` blueprint.
- Markdown page records, component map, design system, responsive matrix, and mock contracts.
- Local workspace asset files (if authorized).

## 5. Expected Outputs
- Fully functioning frontend project in `{{RECON_DIR}}` (source code, styles, configs, tests).
- Synthetic mock data fixtures and client-side mock service abstractions.
- `{{RECON_DIR}}ir-traceability.md`: Every IR node mapped to a file, placeholder, or blocker.
- `{{RECON_DIR}}reconstruction-report.md`: Complete build report, coverage statistics, QA results, and execution instructions.

## 6. Relevant REA Phases
- **Phase 13 (`PART-07`):** Frontend-Only Reconstruction.

## 7. Required Capabilities
- Local frontend development build runtime (e.g. Node.js for Vite, Next.js, Angular CLI) used exclusively for local builds.
- Local filesystem write access in `{{RECON_DIR}}`.

## 8. Dependencies
- Consumes outputs from `rea-schemas-ir` and `rea-feasibility-assessment`.
- Tested and verified by `rea-validation`.
- Governed by `rea-orchestrator`.

## 9. Core Architectural Principles
1. **Frontend-Only Scope:** Strictly zero backend implementation. Do not configure Node.js backend servers, Express/Fastify APIs, SQL/NoSQL databases, ORM layers, server-side authentication, or live payment gateways.
2. **Technology Selection:** Follow the original framework evidenced in Phase 6 and the `STACK-DECISION` flag. Never switch frameworks for developer convenience. If the technology is unconfirmed, halt and ask the user.
3. **Clean JavaScript Reimplementation:** Reimplement observed client-side interactions, state machines, and routing from evidence. Never copy minified original production bundles into the reconstruction codebase.
4. **Synthetic Mock Contracts:** Derive mock API fixtures solely from the field names and types recorded in `ir.json` `mockContracts`. Never invent endpoints or schema fields. Populate with synthetic, clearly labeled dummy data.
5. **Asset Authorization Gate:** Only reuse assets marked `Authorized` in `asset-register.md`. Assets with status `Unknown` or `Unauthorized` must be replaced by clean, self-contained SVG or textual placeholders.
6. **Feasibility Boundaries:** Any route or feature marked `NOT FEASIBLE` in the final feasibility reconciliation must be represented as an explicit documented placeholder and excluded from code generation.
7. **Traceability:** Every single IR node must be explicitly traced in `ir-traceability.md` to a concrete source file, a placeholder, or a documented blocker.

## 10. Safety & Privacy Enforcements
- Zero real patient data, personal records (PII), live API keys, session tokens, or credentials may be written into any reconstruction source file, mock fixture, or test file.
- All simulated authentication must operate locally in-memory or via mock state; never connect to the original production authentication server.

## 11. Failure Handling
- If local compilation or build fails: diagnose syntax or module errors, apply localized fixes within `{{RECON_DIR}}`, and re-test. Never modify audit deliverables or original source files to fix a build error.
- If an interaction was insufficiently observed: do not guess implementation details. Implement a clean placeholder stating `// TODO: Interaction logic [UNKNOWN] - see E-xxx`.

## 12. Explicit Limitations
- This skill generates modern, maintainable frontend source code corresponding to observed surfaces. It does not reverse-engineer closed server-side business logic or recover private server algorithms.
