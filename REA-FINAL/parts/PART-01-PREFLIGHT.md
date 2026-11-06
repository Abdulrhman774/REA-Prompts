# PART 01 — PREFLIGHT & REA CAPABILITY DISCOVERY
Read `PART-00-MASTER-CONTROL.md` first. Execute Phase 0 only. Do not start Phase 1.

Also read `REA-SCHEMAS.md`, `{{AUDIT_DIR}}skill-registry.md`, and the latest graph fragments in `{{AUDIT_DIR}}graph/fragments/`. Resolve all `{{VARIABLES}}` per PART 00 (Project parameters).

## Phase 0 — Preflight & Capability Discovery

### START
Record the objective, current timestamp/step, scope, and the exact REA operations intended. Confirm the user's authorization statement and allowed scope as stated in PART 00. Do not request repeated proof.

### DO
1. Read REA's own documentation/help through REA's officially available documentation surface. Do not invent commands or capabilities.
2. Build a capability matrix. For each item use Supported / Not supported / Not verified, plus evidence and affected phases:
   - Navigate/open URL
   - Click
   - Type
   - Scroll
   - Screenshot
   - DOM read/inspect
   - Network request log
   - Console log
   - Response headers/status
   - Cookies
   - Local/session storage
   - Viewport resize and viewport dimensions
   - Keyboard input
   - Source/resource view
   - Multiple tabs
   - Download or inspect publicly delivered assets
   - Inspect robots.txt/sitemap.xml/manifest/source maps, if REA supports it
3. Do not infer support from another tool or from assumptions. If docs do not establish support, mark Not verified.
4. Create `{{AUDIT_DIR}}` and initialize:
   - `progress-log.md`
   - `url-queue.md`
   - `evidence-ledger.md`
   - `findings.md`
   - `capability-matrix.md`
   - `checkpoint.md`
   - `skill-registry.md`
   - `graph/fragments/` (with `phase-00.jsonl`)
5. Load the target exactly once through REA, unless doing so would violate a documented limitation. Record:
   - Initial URL
   - Final URL after redirects, if visible
   - Page title
   - Visible status/response status only if REA exposes it
   - Timestamp/step
   - Screenshot reference
6. Record baseline observations with sequential evidence IDs.
7. Prepare an investigation plan mapping Phases 1–11 to verified REA capabilities. Mark unsupported or unverified operations as potential limitations.

### DO (additive — Skill Registry, Graph workspace, Web RE capability discovery)
These steps are in addition to steps 1–7 above.
8. Extend capability discovery to the Skill catalog in `REA-SCHEMAS.md` §2. For each Skill record Supported / Not supported / Not verified from REA's own documentation only. In particular establish, with evidence: whether REA documents an internal engine (for example a browser automation engine or a protocol bridge); computed-style read; Shadow DOM access; DOM-mutation observation; network initiator or request-to-interaction association; response-shape inspection; multiple isolated sessions; manual login handoff; opening a local project (localhost or file) and capturing screenshots (required by PART 07 QA); asset inspection; framework runtime inspection (Tier 2); initial HTML inspection (`inspect.initial-html`); rendering mode analysis (`analyze.rendering-mode`). Do not infer support from any tool outside REA.
9. Build `skill-registry.md`: one descriptor per catalog Skill plus any extra Skill REA documents. Fill Status and Status evidence. Document the Fallback of every Skill. Mark Tier 2 Skills.
10. Initialize `{{AUDIT_DIR}}graph/fragments/` and write the APPLICATION node (`APP-001`) in `phase-00.jsonl`, citing the baseline evidence IDs.
11. Record the session plan: `{{SESSION_ALIASES}}`, which aliases need manual login handoff, and whether test accounts were supplied. Never request or record credentials.
12. Extend `investigation-plan.md` with a Skill-to-Phase map: which Skills each of Phases 1–11 will use, their Fallbacks, and which deliverables are exposed to a potential `[LIMITATION]` by each Skill that is Not supported or Not verified.

### DO (additive — Provisional Feasibility & Rendering Assessment Gate)
These steps execute before completing Phase 0 to ensure that unfeasible targets or features are flagged early.
13. Perform a **Provisional Feasibility Assessment** using only evidence from the single initial page load and REA's verified capabilities. Evaluate the 10 feasibility dimensions:
    - (1) Initial HTML delivered by the server (via `inspect.initial-html` if Supported; else `[UNKNOWN]`).
    - (2) Rendered DOM after JavaScript execution (via `inspect.dom`).
    - (3) Hydration indicators (e.g. `data-reactroot`, `__NEXT_DATA__`, `ng-version`, `data-v-`, Nuxt payload, Svelte markers).
    - (4) Client-generated vs server-generated markup comparison.
    - (5) JavaScript bundles and script resources exposed in the initial load.
    - (6) Initial API calls or data fetching observed in the network log.
    - (7) Initial route rendering behavior (CSR, SSR, SSG, Hybrid, or UNKNOWN).
    - (8) Feature-specific dependencies visible on the initial surface.
    - (9) Available inspection capabilities vs required investigation depth.
    - (10) Potential frontend reconstruction blockers (e.g. WebGL canvas games, proprietary streaming protocols, non-reconstructible third-party embeds).
14. Record provisional feasibility for the entry Route and any immediately identifiable major Features using the four canonical classifications: `FEASIBLE`, `PARTIALLY FEASIBLE`, `NOT FEASIBLE`, or `UNKNOWN` (mapped in JSON to `FEASIBLE`, `PARTIALLY_FEASIBLE`, `NOT_FEASIBLE`, `UNKNOWN`).
    - Every classification must include: reason, E-IDs, relevant F-IDs, required capabilities, known limitations, reconstruction implications, and qualitative provisional difficulty (`LOW`, `MEDIUM`, `HIGH`, or `UNKNOWN`).
    - Never invent difficulty percentages or precise metrics. All difficulty estimates are qualitative, marked `[INFERRED]`, and justified by written criteria.
    - Do not infer that an entire multi-page application is `FEASIBLE` solely from a successful homepage load.
15. If the entry Route or any primary Feature is provisionally evaluated as `NOT FEASIBLE` (`NOT_FEASIBLE`):
    - Document the specific blocker and affected deliverable in `feasibility-assessment.md`.
    - Present feasible alternatives (e.g. static shell with mock data, partial route coverage, documentation-only audit).
    - Note that Parts 01–06 (`MASTER-PHASE-05` through `MASTER-PHASE-14`) remain fully actionable for security, quality, and architectural auditing even when reconstruction is not feasible. `NOT_FEASIBLE` blocks ONLY Part 07 (`MASTER-PHASE-16` Reconstruction).

### RECORD
Every observation must follow the evidence record in PART 00. Every claim must have one mandatory label (`[OBSERVED]`, `[INFERRED]`, `[UNKNOWN]`, `[LIMITATION]`). Do not record a status code, header, title, or redirect unless actually exposed.

### DELIVER
Save:
- `capability-matrix.md`
- `investigation-plan.md`
- `feasibility-assessment.md` (provisional assessment across 10 dimensions, per-route/feature classifications)
- initial `progress-log.md`
- initial `url-queue.md`
- initial `evidence-ledger.md`
- initial `checkpoint.md`
- `skill-registry.md`
- initial `graph/fragments/phase-00.jsonl` (APPLICATION node with initial rendering and feasibility attributes)

### GATE
PASS only if:
- The actual REA capabilities relevant to the planned work are documented with evidence or marked Not verified.
- No later operation relies on an unverified capability.
- The target baseline was recorded to the extent REA exposes it.
- Workspace tracking files exist.
- `skill-registry.md` exists; every Skill has a descriptor, a status with evidence, and a Fallback; no Skill is Supported without evidence.
- The Graph workspace is initialized with the APPLICATION node.
- Provisional feasibility assessment is recorded in `feasibility-assessment.md` with every entry Route/Feature classified; no item is marked `FEASIBLE` without supporting evidence; any `NOT FEASIBLE` finding is explicitly disclosed.
- Tier 2 Skills do not affect this gate.

If a capability is not supported, mark `[LIMITATION]`, name the affected phases/deliverables, and continue planning around the limitation. Do not switch tools.

### STOP
Stop after Phase 0. Report the gate result and wait for the user's instruction to run PART 02.
