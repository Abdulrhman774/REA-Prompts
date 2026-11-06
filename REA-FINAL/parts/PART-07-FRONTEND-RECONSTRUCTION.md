# PART 07 — FRONTEND-ONLY RECONSTRUCTION
Read PART 00 and all final audit deliverables. This partition is permitted ONLY after PART 06 is complete, Phase 11 passed, and the user explicitly approved frontend reconstruction in writing. If any prerequisite is missing, STOP and request the missing approval or evidence. Do not infer approval.

## Input contract (additive — IR handoff)
Besides the final audit deliverables, read `{{AUDIT_DIR}}ir.json`, `ir-summary.md`, `ir-derivation-log.md`, `asset-register.md`, `final-feasibility-reconciliation.md`, and `skill-registry.md`. The prerequisites above are unchanged.
- The audit markdown deliverables remain the source of truth. If the IR and markdown disagree, follow markdown and record the discrepancy in `reconstruction-report.md`.
- The IR is framework-neutral and never selects the technology. Selection follows Phase 13 §1 using Phase 6 evidence and the STACK-DECISION flag.
- IR labels are binding. OBSERVED items are implemented. INFERRED items are implemented only as documented assumptions and listed under "Assumptions" in `reconstruction-report.md`. UNKNOWN and LIMITATION items become documented placeholders or blockers and are never filled by invention.
- Feasibility boundaries are strictly respected: any route or feature classified as `NOT FEASIBLE` in `final-feasibility-reconciliation.md` must NOT be reconstructed without explicit written user approval of the specific blocker resolution; it is implemented as a documented placeholder.
- No credentials, cookies, tokens, session identifiers, or real personal data are placed in any generated file.
- If no IR exists (graph-less mode), proceed from the markdown deliverables exactly as originally defined and record that no IR was available.

## Phase 13 — Frontend-Only Reconstruction

### Primary objective
Reconstruct the observable frontend in `{{RECON_DIR}}` as accurately and comprehensively as the evidence permits. This is frontend-only. Do not implement, generate, configure, or operate a backend.

### 1. Technology selection
Review Phase 6 evidence:
- original frontend framework
- version only if directly evidenced
- styling system and UI libraries
- routing and state management
- rendering approach: CSR / SSR / SSG / hybrid / UNKNOWN

Use the original stack by default. Do not switch frameworks for convenience. If the original technology cannot be determined confidently, stop and ask the user before choosing an alternative. Evidence comes from Phase 6 and the STACK-DECISION flag. Do not choose any framework (including vanilla HTML/CSS/JavaScript or React) because it is easier to implement.

### 2. Workspace safety and project setup
- Keep `{{AUDIT_DIR}}` and all original inspection artifacts untouched.
- Create the reconstructed app only in `{{RECON_DIR}}`.
- Inspect the local workspace for already supplied assets before sourcing or creating replacements.
- Do not overwrite original project files.
- Ask approval before installing additional dependencies or performing destructive workspace operations.
- Node.js may be used strictly as a local frontend development runtime/build tool when required. It must not be used for website inspection or to implement a backend.
- Do not create a server, API, database, or authentication service.

### 3. Frontend project requirements
- Use detected framework and compatible tooling.
- Reproduce observed routing and shared/nested layouts.
- Implement reusable components and observed design tokens, respecting component origin (`server` vs `client`) as observed.
- JavaScript behavior: reimplement observed behavior based on evidence (interactions, state transitions, API mock responses). Never copy original minified bundles as the reconstruction code; do not assume original source code is available.
- Reuse only assets the user is authorized to reproduce and that are available in the workspace or otherwise explicitly authorized.
- Authorization status comes from `asset-register.md`. Use only assets with status Authorized. Unknown or Unauthorized assets are replaced by clearly labeled placeholders and listed in the asset inventory.
- Reproduce responsive layouts and observed states: loading, empty, error, success, disabled.
- Implement client-side interactions and validation as documented.
- Recreate observable authentication-related UI without connecting to the original authentication system.

### 4. Page reconstruction
Rebuild every page with sufficient evidence:
- match layout and section order
- reproduce typography, colors, spacing, borders, shadows, dimensions
- recreate buttons, forms, tables, cards, navigation, modals, dropdowns
- reproduce observed transitions and interaction behavior
- match desktop/tablet/mobile behavior
- reproduce role-dependent UI only where evidence supports it

Do not replace complex pages with generic placeholders. For inaccessible pages or unevidenced features, create a clearly labeled placeholder only if necessary, and document the unknown requirements.

### 5. Backend independence and mock behavior
Do NOT implement:
- any backend framework
- Node.js backend services
- database servers or ORM/data-access layers
- server-side authentication
- original backend APIs
- payment processing
- real patient-data operations

Where the original frontend depends on APIs:
- create local mock data, static JSON fixtures, or frontend-only mock services
- reproduce observable loading/success/empty/error states
- simulate authentication and role selection locally for demonstration
- isolate API boundaries so a real backend could be connected later
- derive mock fixtures only from the observed shapes in the IR `apiDependencies` (field names and types). Invent no endpoints or fields. Fixture values are synthetic and marked as synthetic.
- clearly label all simulated behavior; never claim it is connected to the original system

Never use real patient records or sensitive data.

### 6. Authentication UI
Recreate only observed screens and states:
- login/logout
- registration/password recovery, if observed
- authenticated layouts
- role-dependent navigation
- access-denied pages
- policy-dependent controls
- session-expiration UI

Use local mock authentication only. Do not bypass the original app's authentication.

### 7. Quality Assurance & Eight-Dimension Acceptance Framework
Every reconstructed frontend must be evaluated against the Eight Acceptance Dimensions. Each dimension must receive an explicit status:
- `Verified`: Tested and confirmed to match evidence.
- `Not verified`: Not tested or test incomplete.
- `Not verified due to limitation`: Blocked by an explicit tooling, platform, or environment constraint.

The Eight Dimensions:
1. **Visual Fidelity:** Typography, spacing, layout hierarchy, color palettes, borders, shadows, and iconography compared against evidence screenshots.
   - Note: Visual comparison requires a usable local rendering and screenshot capability (`render.local`). If unavailable, record `Not verified due to limitation` and do not claim visual comparison occurred.
2. **Route Coverage:** Verification of all mapped routes, dynamic route families, navigation transitions, and fallback/404 routing.
3. **Components and Layout:** Verification of shared layouts, nested viewports, component hierarchies, slots, and component origin fidelity.
4. **Interactions:** Verification of buttons, modals, dropdowns, accordions, tabs, form inputs, validation triggers, and event handlers.
5. **Client-Side State:** Verification of local/session storage simulation, UI toggles, state transition correctness, and active filters.
6. **Responsive Behavior:** Verification across breakpoints (desktop, tablet, mobile reference width 390px, and observed ranges).
7. **Assets:** Verification that authorized assets load cleanly and all unauthorized/unknown assets render as explicit placeholders.
8. **Functional Consistency:** Verification of mock API contracts, loading/empty/error states, and simulated authentication flows.

Do not describe the reconstruction as complete when one or more required dimensions remain unverified without documented limitations.

### 8. Deliverables
Produce:
1. Complete frontend source project.
2. Original-framework-based architecture.
3. Implemented routes and pages.
4. Reusable component library.
5. Design tokens and styles.
6. Local mock data and mock services.
7. Local authentication simulation where needed.
8. Asset inventory and provenance notes.
9. Build/run instructions.
10. Reconstruction coverage report.
11. Known limitations and differences from original.
12. QA/build results.
13. IR traceability matrix (`ir-traceability.md`): every IR node mapped to a generated file, a documented placeholder, or an explicit blocker.
14. Eight-Dimension Acceptance Matrix (`acceptance-matrix.md`): all 8 dimensions with verified status, evidence citations, covered routes/features, unavailable capabilities, and remaining discrepancies.
15. Skill and limitation notes that affected QA.

### Final acceptance criteria
The task is complete only when:
- frontend build succeeds
- every sufficiently documented page is implemented or has an explicit documented blocker
- implemented routes work locally
- major interactions behave as documented
- responsive behavior has been checked
- no backend implementation exists
- all mock functionality is clearly distinguished from real backend behavior
- audit artifacts remain untouched
- every IR node is traced in `ir-traceability.md`
- all eight acceptance dimensions have an explicit status and supporting evidence
- no visual comparison is claimed unless it was actually performed

### Final report
Save `reconstruction-report.md` in `{{RECON_DIR}}` and report build status, route coverage, QA results, eight-dimension acceptance table, limitations, and run instructions.
