# PART 04 — TECHNOLOGY FINGERPRINT & ARCHITECTURE
Read PART 00 and the latest checkpoint, page records, design system, and capability matrix. Execute Phases 6–7 only.

Also read `REA-SCHEMAS.md`, `{{AUDIT_DIR}}skill-registry.md`, `{{AUDIT_DIR}}feasibility-assessment.md`, and the latest graph fragments in `{{AUDIT_DIR}}graph/fragments/`. Resolve all `{{VARIABLES}}` per PART 00 (Project parameters).

## Phase 6 — Technology & Infrastructure Identification

### START
List the verified REA features available for inspecting markup, resources, headers, cookies, storage, and network activity. Do not use any alternative inspection tool.

### DO
Fingerprint only from direct evidence:
- HTML metadata, root elements, data attributes
- script/style URLs and file naming
- global JS objects, if REA exposes them
- response headers, cookies, service worker, manifest, source maps, if exposed
- network calls initiated by the application, if exposed
- error messages, favicon and asset paths
- CDN/hosting hints only if directly visible through REA

Cover, where evidence exists:
- frontend framework and rendering mode (CSR / SSR / SSG / hybrid / UNKNOWN)
- libraries, CSS tooling, UI kits, animation, routing, state, forms
- backend/API style (REST, GraphQL, RPC, WebSocket), auth mechanism
- hosting, CDN, caching, asset delivery
- analytics, tracking, tag managers, monitoring, chat, payments, maps, fonts, third-party APIs

Do not claim access to original source code or internal infrastructure. Minified bundles are not proof of original source architecture. Never infer a version unless explicitly exposed.

### DO (additive — framework-agnostic detection, rendering analysis, stack decision, graph write)
- Detection is framework-agnostic. "No recognized framework" is a valid recorded result (class Unknown). No later Phase depends on a framework being detected.
- **Rendering Mode & Component Origin Analysis:**
  - Classify each discovered route into `CSR`, `SSR`, `SSG`, `Hybrid`, or `UNKNOWN`.
  - Reconcile initial server HTML (from `inspect.initial-html`) against final client DOM (from `inspect.dom`), identifying hydration markers and dynamic mounting points.
  - Classify component origins as `server`, `client`, or `unknown`.
  - Do not guess rendering mode from framework name alone (e.g. Next.js can mix SSR, SSG, and CSR across routes).
  - Propagate observed rendering constraints into route-level feasibility updates.
- Write Technology (`TECH-`) nodes with Class and Confidence.
- Add to `technology-stack.md` a section `Reconstruction stack decision`: the original frontend stack as evidenced (only Confirmed or Strong indication items), rendering mode, styling, routing, and state, with evidence IDs, and a flag `STACK-DECISION: READY` or `STACK-DECISION: NEEDS-USER-INPUT`. Use NEEDS-USER-INPUT when the original stack is not identified confidently; Phase 13 §1 then stops and asks. Never choose an alternative stack here for convenience and never default to any particular framework.
- Record which optional framework adapters are relevant, as input to Phase 10 only.

### DELIVER
Save `technology-stack.md` using:
`Name | Category | Purpose | Evidence IDs | Confidence | Class`
Class must be Confirmed / Strong indication / Unknown. Confirmed requires High-confidence direct evidence.
Also list technologies investigated but not confirmed, and provide the route-by-route rendering mode breakdown.

### GATE
No item is Confirmed without High-confidence direct evidence. No unsupported version claims.

Additional condition: the `Reconstruction stack decision` section exists and its flag is justified by evidence. Graph fragment `phase-06.jsonl` is written with Technology nodes and Route rendering attributes.

## Phase 7 — Architecture & Data-Flow Reconstruction

### START
Identify the evidence set used for architecture analysis.

### DO
Reconstruct, only to the extent observable:
- shared layouts and page templates
- reusable components
- navigation architecture
- API inventory: endpoint, method, purpose, auth requirement, request/response shape, only if exposed by REA
- data dependencies
- authentication/session behavior visible in normal UI
- client-side storage use
- caching/offline behavior (service worker/cache headers if exposed)
- build output characteristics (bundle splitting, chunk naming, hashing)

Separate:
1. Directly observed facts.
2. Architectural hypotheses, each with reasoning, confidence, supporting evidence, and what would confirm/refute it.

Never claim access to source code, databases, server internals, or private systems that were not inspected.

### DO (additive — API dependency map, component definitions, feasibility propagation, graph write)
- API dependency map: for each endpoint observed through REA record method, URL pattern (only as observed), status (if exposed), resource type, initiating page, associated interaction (I-ID, only with evidence, otherwise `[UNKNOWN]`), authentication requirement (observed behavior only), and response structure as field names and types only when exposed and safe. Never record values, tokens, or personal data.
- Component map: reusable component definitions with their instance lists and `origin` (`server`, `client`, or `unknown`), derived from the framework-agnostic evidence of Phases 2 and 4. Statements about framework internals are INFERRED with reasoning unless a Phase 10 adapter later observes them.
- Feasibility updates: for each component and API dependency, record any identified reconstruction blockers or limitations affecting route feasibility.
- Optional adapter architecture: where an optional adapter (e.g. Browser Toolkit adapter) is configured, document its provenance bridge and ensure external data is labeled `IMPORTED`/`INFERRED`.
- Graph write: ApiEndpoint (`A-`) nodes, Layout/Template and Component definition nodes (with `origin` and `feasibilityNotes`), `dependsOn` edges from Routes and Components to APIs, `triggers` edges from Interactions to APIs only where evidenced, and storage use as node attributes.

### DELIVER
Save `architecture-report.md`, `component-map.md`, and `data-flow.md` (Mermaid where supported). Also save `api-dependency-map.md` and graph fragment `phase-07.jsonl`.

### GATE
Every hypothesis lists supporting observations and a confirmation/refutation path. Every endpoint or contract is directly evidenced or marked `[UNKNOWN]`. Component definitions include origin classification.

### STOP
Stop after Phase 7 and wait for PART 05.
