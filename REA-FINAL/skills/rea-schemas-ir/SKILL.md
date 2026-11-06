---
name: rea-schemas-ir
description: Framework-agnostic Intermediate Representation (IR) compiler and validator for REA. Derives ir.json, ir-summary.md, and ir-derivation-log.md from the frozen Application Graph, enforcing the Phase 13 handoff contract.
---

# REA Schemas & Intermediate Representation (IR)

## 1. Overview & Purpose
`rea-schemas-ir` compiles the framework-neutral Intermediate Representation (`ir.json`) from the frozen Application Intelligence Graph upon passing the Phase 11 gate. The IR serves as the definitive, structured blueprint for frontend reconstruction in `PART-07`. It guarantees that all evidenced routes, components, interactions, API mock contracts, design tokens, and assets are cleanly transferred to the reconstruction phase without framework bias or loss of evidence traceability.

## 2. Activation Guidance
Activate this skill in Phase 12 after the Phase 11 completeness gate has passed, and in Phase 13 during the pre-reconstruction input contract verification.

## 3. Preconditions
- Phase 11 completeness gate evaluation is `PASS`.
- `application-graph.json` has passed integrity checks (zero orphan nodes, zero unevidenced nodes).
- `REA-SCHEMAS.md` §5 IR Schema is loaded.

## 4. Inputs
- Frozen `application-graph.json`.
- Markdown audit deliverables: `page-records/`, `technology-stack.md`, `architecture-report.md`, `component-map.md`, `interaction-matrix.md`, `design-system.md`, `responsive-matrix.md`, `api-dependency-map.md`, `asset-register.md`, and `final-feasibility-reconciliation.md`.

## 5. Expected Outputs
- `{{AUDIT_DIR}}ir.json`: Consolidated, framework-neutral JSON blueprint.
- `{{AUDIT_DIR}}ir-summary.md`: Human-readable summary of node counts, labels, confidences, rendering modes, and feasibility decisions.
- `{{AUDIT_DIR}}ir-derivation-log.md`: Cross-reference audit proving consistency between markdown deliverables and IR sections.

## 6. Relevant REA Phases
- **MASTER-PHASE-13:** Compilation, cross-checking against markdown, and IR freeze (governed by `REA-PHASE-REGISTRY.md`).
- **MASTER-PHASE-16 (`PART-07-LOCAL-PHASE-13`):** Handoff contract verification and mock fixture derivation for frontend reconstruction.

## 7. Required Capabilities
- Local filesystem read and write access in the audit directory.

## 8. Dependencies
- Depends on `rea-application-graph` for the compiled graph.
- Consumed by `rea-frontend-reconstruction` for Phase 13 execution.
- Governed by `rea-orchestrator`.

## 9. IR Structure & Section Rules
`ir.json` contains 15 standardized sections:
1. `meta`: Schema version (`1.1`), Phase 11 gate status (`PASS`), freeze timestamp, Graph SHA-256 digest.
2. `technology`: Technology stack inventory, `stackDecision` (`READY` or `NEEDS-USER-INPUT`), rendering modes.
3. `routes`: Array of route descriptors, each carrying `pattern`, `pageType`, `layoutRef`, `componentRefs`, `renderingMode`, `feasibility`, `feasibilityReason`, `limitations`.
4. `layouts`: Shared UI shells, regions, and nesting structures.
5. `components`: Canonical component definitions with `origin` (`server`, `client`, or `unknown`), variants, states, token references.
6. `designTokens`: Measured design tokens with `valueKind` (`authored` or `computed`), unmeasurable items marked `UNKNOWN`.
7. `states`: Observable UI states (entry, exit, scope).
8. `interactions`: Interactive UI controls, before/after state transitions, safe and tested flags.
9. `userFlows`: Sequenced interaction journeys.
10. `apiDependencies`: Method, URL pattern, initiator, and observed field-name/type shape.
11. `mockContracts`: Strict contracts for synthetic mock generation derived solely from observed API shapes.
12. `assets`: Delivered media, icons, fonts with provenance and authorization status.
13. `authUi`: Observable authentication screens and role aliases (strictly zero credentials).
14. `validationBaseline`: Per-route screenshot evidence IDs and responsive breakpoint targets.
15. `feasibility`: Project-wide feasibility reconciliation summary and blocker listings.

## 10. Core Rules & Binding Constraints
1. **Framework-Neutral:** The IR never mandates a specific frontend framework (e.g. React, Vue, Angular). Framework selection is governed strictly by Phase 6 evidence and the `STACK-DECISION` flag.
2. **Binding Evidentiary Labels:**
   - `OBSERVED`: Must be implemented in reconstruction.
   - `INFERRED`: Implemented only as documented assumptions.
   - `UNKNOWN` / `LIMITATION`: Must be represented as clearly labeled placeholders; never fabricated.
3. **Markdown Precedence:** If any discrepancy exists between `ir.json` and markdown reports, the markdown deliverables prevail. `ir-derivation-log.md` must log the resolution.
4. **Data Sanitization:** The IR must contain zero credentials, session identifiers, private tokens, or real user records.

## 11. Failure Handling & Degradation
- If Phase 11 gate fails: do NOT compile `ir.json`. Report the gate failure to `rea-orchestrator`.
- If graph integrity fails during compilation: do NOT freeze. Log the unlinked nodes in `ir-derivation-log.md` and request graph reconciliation.
- Graph-less fallback: if no graph was maintained, `PART-07` executes directly from markdown audit deliverables, noting `[LIMITATION]: Graph-less mode`.

## 12. Explicit Limitations
- The IR is a structural schema; it does not generate frontend source code. Source code generation is the exclusive domain of `rea-frontend-reconstruction`.
