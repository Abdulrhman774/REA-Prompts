---
name: rea-feasibility-assessment
description: Feasibility assessment engine for REA. Evaluates 10 feasibility dimensions, assigns canonical route and feature classifications, enforces the provisional Phase 0 gate, and executes append-only final reconciliation in Phase 11.
---

# REA Feasibility Assessment

## 1. Overview & Purpose
`rea-feasibility-assessment` evaluates whether a target web application, its individual routes, and its core features can be reverse-engineered and reconstructed within the frontend-only, evidence-based constraints of REA. It establishes an early **Provisional Feasibility Gate** in Phase 0 to catch blockers before substantial effort is expended, and executes an **Append-Only Final Reconciliation** in Phase 11.

## 2. Activation Guidance
Activate this skill in Phase 0 during preflight setup, and again in Phase 11 prior to compiling the final audit report and freezing the IR.

## 3. Preconditions
- Initial target load completed in Phase 0 (for provisional assessment).
- Complete page records and technology audit available in Phase 11 (for final reconciliation).
- Evidence Ledger active to record E-IDs for feasibility claims.

## 4. Inputs
- Initial HTML, rendered DOM, hydration markers, and script bundle references.
- Capability Matrix status from the Skill Registry (`skill-registry.md`).
- Observed API contracts, third-party dependencies, and rendering modes.

## 5. Expected Outputs
- `{{AUDIT_DIR}}feasibility-assessment.md`: Phase 0 provisional assessment across 10 dimensions.
- `{{AUDIT_DIR}}final-feasibility-reconciliation.md`: Phase 11 final reconciliation table detailing shifts in feasibility, reasons, and remaining blockers.
- Route-level and feature-level feasibility properties attached to Application Graph nodes.

## 6. Relevant REA Phases
- **Phase 0:** Provisional 10-dimension assessment and Phase 0 gate evaluation.
- **Phase 11:** Final reconciliation, blocker disclosure, and stop-gate preparation.

## 7. Required Capabilities
- `inspect.initial-html` (or fallback to network response view)
- `inspect.dom`
- Filesystem write access in the audit directory.

## 8. Dependencies
- Works in close coordination with `rea-rendering-analysis`.
- Cites evidence from `rea-evidence-ledger`.
- Governed by `rea-orchestrator`.

## 9. The 10 Feasibility Dimensions
1. **Initial Server HTML:** Volume, structure, and readability of server-delivered markup before JavaScript runs.
2. **Post-JS DOM Complexity:** Scale, dynamic mounting nodes, and mutation intensity.
3. **Hydration Indicators:** Presence of framework hydration tags (`data-reactroot`, `__NEXT_DATA__`, `ng-version`, Nuxt/Svelte payloads).
4. **Markup Origin Breakdown:** Proportion of client-rendered versus server-rendered elements.
5. **Script Bundles & Complexity:** Script obfuscation, WebAssembly modules, dynamic chunk splitting.
6. **API Dependencies:** Volume, authentication requirements, and observable response schemas of backend calls.
7. **Route Rendering Modes:** Consistency of CSR/SSR/SSG across discovered routes.
8. **Feature Dependencies:** Reliance on browser-specific APIs (WebRTC, WebGL, Bluetooth, Push Notifications).
9. **Inspection Tooling Coverage:** Alignment between required inspections and verified REA capabilities.
10. **Reconstruction Blockers:** Complex binary protocols, canvas games, non-reconstructible proprietary widgets.

## 10. Canonical Classifications & Rules
Each Route and significant Feature is classified independently:
- `FEASIBLE` (`FEASIBLE`): Observable through available REA capabilities, sufficient evidence achievable, cleanly reconstructible within frontend-only boundaries.
- `PARTIALLY FEASIBLE` (`PARTIALLY_FEASIBLE`): Portions observable and reconstructible; specific sub-features are blocked and must be documented as placeholders/limitations.
- `NOT FEASIBLE` (`NOT_FEASIBLE`): Essential functionality cannot be inspected or reconstructed under current capabilities, access limits, or safety rules.
- `UNKNOWN` (`UNKNOWN`): Insufficient evidence to establish feasibility at the current phase.

### Qualitative Difficulty Estimates:
- Must use `LOW`, `MEDIUM`, `HIGH`, or `UNKNOWN`.
- All estimates must be marked `[INFERRED]` and justified by written technical rationale.
- **Strict Rule:** Never invent numerical percentages (e.g. "87% feasible").

## 11. NOT FEASIBLE Blocker Policy
If any primary route or essential application feature is evaluated as `NOT FEASIBLE` (`NOT_FEASIBLE`):
1. **Audit Progression Continues:** Do NOT cancel or abandon audit phases. Phases 01–06 (`MASTER-PHASE-05` through `MASTER-PHASE-14`) continue to capture all allowable evidence and deliver the full security, SEO, accessibility, and architectural audit.
2. **Reconstruction Gated:** `NOT_FEASIBLE` blocks ONLY `MASTER-PHASE-16` (`PART-07-LOCAL-PHASE-13` Frontend Reconstruction).
3. **Detail the Blocker:** Identify the exact technical cause (e.g. proprietary encrypted WebSocket, missing auth credential, opaque WebGL shader).
4. **Present Feasible Alternatives:** Formulate alternative paths (e.g. partial reconstruction, mock UI shell, documentation-only deliverable).
5. **Preserve Prior Work:** Emphasize that all audit deliverables remain fully valid.

## 12. Final Reconciliation Discipline (Phase 11)
- Reconcile provisional Phase 0 findings against all evidence accumulated through Phase 10.
- Append-only records: never overwrite or erase Phase 0 evaluations.
- Every change in classification (e.g. `UNKNOWN` → `FEASIBLE`, or `FEASIBLE` → `PARTIALLY FEASIBLE`) must cite supporting E-IDs and document the exact technical reason for the shift.

## 13. Explicit Limitations
- Feasibility assessment evaluates technical feasibility under the stated REA scope; it does not guarantee visual perfection or replace empirical Phase 13 build/test validation.
