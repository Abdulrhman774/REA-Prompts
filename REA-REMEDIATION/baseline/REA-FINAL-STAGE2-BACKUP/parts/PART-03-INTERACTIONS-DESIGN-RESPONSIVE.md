# PART 03 — INTERACTIONS, DESIGN SYSTEM & RESPONSIVE ANALYSIS
Read PART 00 and the latest checkpoint, sitemap, page records, and capability matrix. Execute Phases 3–5 only.

Also read `REA-SCHEMAS.md`, `{{AUDIT_DIR}}skill-registry.md`, and the latest graph fragments in `{{AUDIT_DIR}}graph/fragments/`. Resolve all `{{VARIABLES}}` per PART 00 (Project parameters).

## Phase 3 — Interaction & Functionality Analysis

### START
Record the objective and verified REA operations.

### DO
For every page, build an interaction matrix:
`Page | Element | Action | Expected behavior (label as inferred if not directly specified) | Actual behavior | State | Evidence | Untested reason | Before state | After state | Network triggered | Session`

Test safe actions only:
- Navigation
- Tabs and accordions
- Dropdowns and modals open/close
- Hover/focus states where supported
- Search with harmless terms
- Filters, sorting, pagination, carousels
- Language/theme toggles
- Keyboard operation

For forms:
- Inspect fields, labels, required indicators, constraints, client-side validation, and error messages.
- Submit only if the user explicitly provided a test account or explicitly authorized test submissions.
- Otherwise do not submit; stop before the final action and document the untested behavior.
- Never submit patient data, real personal data, payment, deletion, or irreversible actions.

Map relevant user journeys with entry point, steps, visible feedback, outcome, and observable failures. Use Mermaid only if the local report format supports it; diagrams must be based on observed flows.

### DO (additive — safe state discovery, state model, interaction effects, graph write)
- **Safe UI State Discovery Rule:** Loading, empty, error, and success states must be documented only when naturally observed or safely triggered through normal authorized interaction, or supported by reliable existing evidence. Never use fuzzing, brute force, destructive payloads, unauthorized endpoints, real payments, or production data alteration. Unknown states must remain `[UNKNOWN]`. Never invent a state because it is common in other web applications.
- For each interaction record also: the Before state and After state (observable differences in visible UI, DOM, URL, or storage, each OBSERVED); the network requests triggered, only when REA exposes initiator or timing (otherwise `[UNKNOWN]`; causation inferred from timing alone is INFERRED with reasoning); and the session alias.
- State model: name every observable frontend state (for example menu open or closed, loading, modal visible, validation error, logged out or in as observed) with entry condition, exit condition, and evidence. Do not invent states. States reachable only through unsafe actions are listed as untested with the reason.
- User Flows are assembled only from observed steps.
- Graph write: Interaction (`I-`), State (`S-`), and User Flow (`UF-`) nodes; edges `respondsTo`, `changes`, `triggers` (only with evidence), and `partOf`.
- None of this requires any framework to be detected.

### DELIVER
Save `interaction-matrix.md`, `functionality-map.md`, and `user-journeys.md`. Also save `state-model.md` and graph fragment `phase-03.jsonl`.

### GATE
Every interactive element in the page records is tested or listed as untested with a specific reason.

Additional condition: every Interaction node with an observed effect has a Before and After state, or `[UNKNOWN]` with the reason.

## Phase 4 — Design System Reverse Engineering

### START
Record the objective and verified REA capabilities for style/DOM/resource inspection.

### DO
Extract only values that REA actually exposes:
- Colors: primary, secondary, backgrounds, text, borders, accents, gradients, hover/focus/active
- Typography: font families, weights, sizes, line heights, letter spacing, heading scale, font loading
- Spacing scale, container/max widths, grids, gaps
- Border radii, shadows, borders
- Button/card/input/icon variants
- Animations/transitions: duration, easing, reduced-motion behavior
- CSS custom properties and design tokens, if exposed

Audit consistency: repeated components, one-off styles, page-to-page differences, duplicated patterns.

Do not invent exact hex values, pixel sizes, computed styles, or CSS tokens. Mark unmeasurable items `[UNKNOWN]`.

### DO (additive — component origin & graph write)
- Distinguish authored values (stylesheet or custom property) from computed values and label which is which. Values not exposed remain `[UNKNOWN]`.
- Component definitions: correlate component instances across pages to produce canonical Component (`C-`) nodes with observed `origin` (`server`, `client`, or `unknown`).
- Graph write: DesignToken (`T-`) nodes and Component definition and variant records, with `uses` edges from Components to Tokens where observed.

### DELIVER
Save `design-system.md` and `component-inventory.md`. For each token, include value, pages/components, evidence IDs, and confidence. For each component include variants, states, usage count only if actually counted, and page references. Also write graph fragment `phase-04.jsonl`.

### GATE
Every asserted value has evidence. Unmeasurable values are marked `[UNKNOWN]`.

## Phase 5 — Responsive Design Analysis

### START
List viewport sizes that REA has verified support for. Do not claim unsupported resizing capability.

### DO
For every key page template and distinct page type, inspect desktop, tablet, and mobile sizes where supported. Suggested widths only if REA can set them: approximately 1920, 1440, 1024, 768, 480, and 360 CSS pixels; include portrait/landscape where supported.

Record:
- navigation transformations
- grid/column changes
- typography scaling
- image behavior
- component repositioning
- horizontal overflow
- clipped/overlapping content
- touch target sizes only if measurable
- orientation behavior

Report breakpoints only when observed between two tested widths. State the observed range, not a fabricated exact breakpoint.

### DO (additive)
- In addition to the suggested widths, record a 390 CSS pixel mobile reference width where REA can set it. Never claim unsupported resizing.
- Attach observed viewport variants to Route and Component nodes in graph fragment `phase-05.jsonl`. The rule on breakpoints is unchanged: report only an observed range between two tested widths.

### DELIVER
Save `responsive-matrix.md` and responsive findings.

### GATE
Every page type is checked at desktop, tablet, and mobile, or the missing viewport is recorded as `[LIMITATION]`.

### STOP
Stop after Phase 5 and wait for PART 04.
