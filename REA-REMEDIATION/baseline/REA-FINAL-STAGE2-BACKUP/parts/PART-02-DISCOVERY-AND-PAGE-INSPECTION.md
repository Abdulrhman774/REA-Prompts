# PART 02 — WEBSITE DISCOVERY & PAGE-BY-PAGE INSPECTION
Read PART 00 and the latest checkpoint, capability matrix, and investigation plan. Execute Phases 1 and 2 only.

Also read `REA-SCHEMAS.md`, `{{AUDIT_DIR}}skill-registry.md`, `{{AUDIT_DIR}}feasibility-assessment.md`, and the latest graph fragments in `{{AUDIT_DIR}}graph/fragments/`. Resolve all `{{VARIABLES}}` per PART 00 (Project parameters).

## Phase 1 — Complete Discovery & Sitemap

### START
Record the Phase 1 objective and only the verified REA operations that will be used.

### DO
Discover URLs only through supported, non-intrusive REA methods:
- robots.txt, sitemap.xml, nested sitemaps, if REA supports direct navigation/resource inspection
- header, footer, navigation, dropdowns, sidebars, breadcrumbs
- pagination, in-content links, visible buttons that navigate
- links exposed in rendered DOM, inline scripts, JS bundles, route tables, manifest files, or API responses loaded by the page, only if REA officially exposes them
- search result pages and redirects observed through normal UI navigation
- one clearly non-existent path to observe a 404 page, only if safe and REA can observe it

Do not brute-force, guess paths with wordlists, enumerate IDs, or probe hidden routes.

For every discovered URL, add a queue record with:
`URL | title | type | discovered-via | status code (if exposed) | state | evidence ID | notes`

States: Discovered / Visited / Analyzed / Blocked.

Classify each URL where evidence permits:
home, listing, detail, dynamic route (record pattern only if observed), static, auth, account, dashboard, checkout, form, search, error, file/media, external, API.

Inspect all navigation areas, including mobile menus if REA supports viewport changes. Keep external links separate and do not leave ALLOWED_SCOPE.

### RECORD
Record orphan pages, link depth, dead links, redirect chains, and inaccessible routes only when directly observed. Otherwise use `[UNKNOWN]`.

### DO (additive — exploration queue discipline, feasibility tracking, and graph write)
- The URL queue is the exploration queue. The four states stay Discovered / Visited / Analyzed / Blocked. Add two queue columns: `session` (role alias) and `reason`. Every Blocked record carries one reason code: AUTH_REQUIRED, MANUAL_INTERVENTION, UNSAFE_ACTION, OUT_OF_SCOPE, LIMITATION (naming the missing Skill), or ERROR (an observed failure). A page that was opened but not fully exercised is Visited with its untested parts listed. It is not Analyzed.
- Unsafe or irreversible actions found through navigation (payment, deletion, sending, publishing, security-setting changes) are recorded as Blocked with reason UNSAFE_ACTION and the last safe step. They are never executed.
- Use only Skills that are Supported in the Registry. Where a Skill is unavailable use its documented Fallback, otherwise record `[LIMITATION]`.
- Links inside Shadow DOM are discovered only if the Tier 2 Skill is Supported. Otherwise do not claim they were examined.
- Graph write: for each in-scope URL write a Route node (OBSERVED only for a URL actually seen; route patterns only if observed) and `navigatesTo` edges from the page where the link was observed. External links are recorded as external references, not Routes.
- Additive Route attributes: include initial route classification for `renderingMode` (`CSR`, `SSR`, `SSG`, `Hybrid`, or `UNKNOWN`) and route-level `feasibility` (`FEASIBLE`, `PARTIALLY FEASIBLE`, `NOT FEASIBLE`, or `UNKNOWN`) based on evidence observed during discovery.

### DELIVER
Save:
- `sitemap.md`
- updated `url-queue.md`
- `link-graph-summary.md`
- evidence and findings updates
- graph fragment `phase-01.jsonl` (Route nodes with rendering and feasibility attributes, `navigatesTo` edges)

### GATE
The queue is empty, or every remaining URL is Blocked with a specific reason. All discoverable navigation areas have been enumerated, including mobile navigation where supported. Do not begin Phase 2 if the Phase 1 gate fails; report the gap.

Additional conditions: every Route node cites an E-ID, and every Blocked URL carries a reason code.

## Phase 2 — Page-by-Page Analysis

### START
Read the current URL queue and capability matrix. State the exact page batch being inspected.

### DO
Visit every queued in-scope page individually through REA. For dynamic route families, inspect at least five varied instances, or all if fewer, subject to the exhaustive scope and access limits. Do not guess identifiers.

Create one Page Record per URL. Record:
- URL, title, type, purpose, audience, relationships
- exact layout order from top to bottom
- header, hero, sections, sidebars, sticky/floating elements, overlays, footer
- every visible component and its appearance, purpose, and states
- headings, labels, CTAs, repeated content patterns
- images, scripts, styles, fonts, media, XHR/fetch resources only where REA exposes them
- route/query parameters only when observed
- loading, empty, success, error, disabled states when safely observable
- authentication/role variants only for explicitly supplied test accounts
- interactions already observed, responsive notes, tech evidence, findings, limitations

For auth pages:
- Use only credentials explicitly provided by the user.
- If no credentials are supplied, stop at the authentication boundary and document the protected pages as Blocked.
- Never bypass access controls or inspect another user's data.

Do not assume two pages are identical until both have been inspected. Save checkpoints after each phase and approximately every ten pages.

### DO (additive — framework-agnostic runtime capture, component origin, asset register, graph write)
Through Supported Skills only, also capture for every page:
- Component instances identified from the rendered DOM (landmarks, repeated structures, roles, naming attributes), independent of any framework. A structure seen is OBSERVED. Grouping it into a named component is INFERRED, with reasoning. Never assume a framework in order to name a component.
- Component origin indicators: observe whether component markup was delivered in the initial server response (`origin: "server"`) or constructed dynamically by JavaScript (`origin: "client"`). When evidence is indeterminate, record `origin: "unknown"`.
- Runtime-generated UI: content that appears after load, scroll, or interaction, as before/after observations. Mutation observation only if that Tier 2 Skill is Supported.
- Shadow DOM presence (Tier 2 Skill). Authored versus computed style information where the Skill exposes it, with the distinction labeled.
- Network resources per route as exposed by REA (type, method, status if exposed). Record no response values; field names and types only, only where exposed, and never personal data.
- Asset register `asset-register.md`: one row per image, SVG, icon, font, media file, stylesheet, and script observed: ID (`AS-n`), URL, type, routes where used, evidence ID, provenance (first-party same-origin / third-party / data URI / unknown), and authorization status (Authorized / Unauthorized / Unknown). The default is Unknown. Only the user can set Authorized, in writing. Inventory is not authorization: recording an asset never permits its reuse.
- The session alias used for each page. Role variants only for explicitly supplied test accounts.
- Graph write: enrich Route nodes (with observed `renderingMode`, `feasibility`, `feasibilityReason`), add Component instance nodes with `origin` and `renders` edges, add Asset nodes with `uses` edges.

### DELIVER
Save one Page Record per URL using this schema:
`URL | Title | Type | Purpose/Audience | Discovered via | Status code | Layout order | Components | Content structure | Resources loaded | Interactions tested | Responsive notes | Tech evidence | Findings (F-IDs) | Limitations | Session | Graph refs`

Save records under `{{AUDIT_DIR}}page-records/` and update sitemap, queue, evidence ledger, findings, and checkpoint.
Also save `asset-register.md` and graph fragment `phase-02.jsonl`.

### GATE
Every Visited page has a Page Record. Every Blocked page has a reason. No discovered in-scope page is silently skipped.

Additional conditions: every asset in the register has provenance and an authorization status, every Page Record lists its Graph refs, and component instances record origin indicators where observed.

### STOP
Stop after Phase 2. Report coverage and wait for PART 03.
