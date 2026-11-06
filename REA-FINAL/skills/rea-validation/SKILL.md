---
name: rea-validation
description: Quality assurance and Eight-Dimension Acceptance validation engine for REA. Verifies local builds, routes, interactions, responsive behavior, asset compliance, and produces the final acceptance matrix.
---

# REA Validation & Eight-Dimension Acceptance Framework

## 1. Overview & Purpose
`rea-validation` provides rigorous, evidence-backed quality assurance for the reconstructed frontend in `PART-07`. It verifies local builds, exercises client-side routes and interactions, audits asset compliance, and evaluates the final implementation against the **Eight-Dimension Acceptance Framework**. It guarantees that completion is never falsely claimed when required dimensions remain unverified.

## 2. Activation Guidance
Activate this skill during Phase 13 (§7 Quality Assurance) after `rea-frontend-reconstruction` has generated the local project, and prior to delivering the final reconstruction report.

## 3. Preconditions
- Frontend source project in `{{RECON_DIR}}` has been generated.
- Audit deliverables and `ir.json` are accessible for comparison.
- `skill-registry.md` indicates status for `render.local`.

## 4. Inputs
- Generated source code and build scripts in `{{RECON_DIR}}`.
- Baseline evidence from investigation: screenshots, route tables, interaction matrices, responsive matrices, and mock contracts.
- `{{AUDIT_DIR}}asset-register.md`.

## 5. Expected Outputs
- `{{RECON_DIR}}acceptance-matrix.md`: Standardized eight-dimension evaluation table.
- Build and QA execution logs.
- QA section in `reconstruction-report.md`.

## 6. Relevant REA Phases
- **Phase 13 (`PART-07`):** Quality Assurance and Final Acceptance.

## 7. Required Capabilities
- Local build tool execution (e.g. `npm run build`, `npm test`) within `{{RECON_DIR}}`.
- `render.local`: Opening a local URL/file and capturing screenshots (if `SUPPORTED` in Skill Registry).

## 8. Dependencies
- Validates the outputs of `rea-frontend-reconstruction`.
- Reports gate status to `rea-orchestrator`.
- Reuses inspection evidence from `rea-evidence-ledger`.

## 9. The Eight Acceptance Dimensions
Every reconstructed project must be evaluated across all eight dimensions. Each receives an explicit status:
- `Verified`: Tested and confirmed to match documented evidence.
- `Not verified`: Not tested or test incomplete.
- `Not verified due to limitation`: Blocked by a documented environment, tooling, or scope constraint.

### Dimension Specifications:
1. **Visual Fidelity:** Typography, spacing, layout structure, color contrast, borders, and shadows compared against baseline screenshots.
   - *Rule:* Visual comparison requires a verified `render.local` capability. If unsupported or unverified, record `Not verified due to limitation` and do not claim visual comparison.
2. **Route Coverage:** Verification of all mapped routes, nested routes, dynamic parameter handling, and 404 fallback routing.
3. **Components and Layout:** Verification of layout shells, navigation bars, footers, component hierarchies, and component origin fidelity (`server` vs `client`).
4. **Interactions:** Verification of buttons, dropdowns, modals, accordions, tabs, form inputs, validation feedback, and event handlers.
5. **Client-Side State:** Verification of local/session storage simulation, UI toggles, state transitions, and client-side filter behavior.
6. **Responsive Behavior:** Verification across desktop, tablet, and mobile (including 390px reference width and observed breakpoint ranges).
7. **Assets:** Verification that all authorized assets load cleanly and all unauthorized/unknown assets render as explicit, non-broken placeholders.
8. **Functional Consistency:** Verification that synthetic API mocks deliver observed data structures and client loading/empty/error states behave as documented.

## 10. Core Rules & Acceptance Criteria
1. **No False Completion:** Never describe a reconstruction as complete if one or more required dimensions remain unverified without a documented limitation.
2. **Untouched Audit Artifacts:** Verify that all original audit deliverables in `{{AUDIT_DIR}}` remain 100% byte-intact.
3. **Zero Backend Enforcement:** Verify that no backend server, database, or live external connection was introduced into the project.
4. **Original Comparison Integrity:** Never use external inspection tools to revisit the live website during QA; all comparisons must use evidence captured during Phases 0–10.

## 11. Failure Handling
- If a build fails: capture the build error log, report the failure, and return execution to `rea-frontend-reconstruction` for remediation.
- If a visual or functional discrepancy is identified: record it as a documented defect in `acceptance-matrix.md` with supporting evidence.

## 12. Explicit Limitations
- Validation operates within local test and build boundaries. When headless browser rendering or local screenshot capabilities are not supported in the host environment, visual dimensions are marked `Not verified due to limitation` with full evidentiary honesty.
