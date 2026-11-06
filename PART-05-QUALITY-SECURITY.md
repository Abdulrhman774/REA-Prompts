# PART 05 — QUALITY, SEO, ACCESSIBILITY, PASSIVE SECURITY & CONDITIONAL MODULES
Read PART 00 and the latest checkpoint, technology report, architecture report, page records, and capability matrix. Execute Phases 8–10 only.

Also read `REA-SCHEMAS.md`, `{{AUDIT_DIR}}skill-registry.md`, and the latest graph fragments in `{{AUDIT_DIR}}graph/fragments/`. Resolve all `{{VARIABLES}}` per PART 00 (Project parameters).

## Phase 8 — Quality: Performance, SEO, Accessibility

### Performance
Measure or report only what REA can actually expose:
- load behavior
- resource count and sizes
- render-blocking resources
- image formats/dimensions/lazy loading
- compression and caching headers
- JS/CSS weight
- broken resources
- console/network errors
- visible layout shift or flashing
- Core Web Vitals only if REA actually measures them

Do not estimate metrics.

### SEO
Inspect, where supported:
- title and meta description per page (length and uniqueness)
- heading hierarchy
- canonical, robots meta, robots.txt and sitemap interaction
- Open Graph/Twitter cards
- structured data
- image alt text
- hreflang
- URL structure and internal linking
- status codes and redirects
- content visible without JavaScript, only if REA can establish it

### Accessibility
Use WCAG 2.2 AA as a reference, not as an automatic certification. Inspect:
- semantic landmarks and heading order
- form labels and errors
- keyboard reachability/order and visible focus
- modal focus behavior
- ARIA usage only where assessable
- image/media alternatives
- color contrast only if exact colors can be obtained
- motion and reduced-motion behavior
- text resizing and touch targets only where measurable
- accessible alternatives for canvas/WebGL/video

### DELIVER
Save three prioritized tables: `performance-audit.md`, `seo-audit.md`, `accessibility-audit.md`. Each finding follows PART 00's finding schema and cites evidence. Link each F-ID to the graph node IDs it affects in `graph/fragments/phase-08-09.jsonl`. Findings annotate nodes; they are not structural nodes.

### GATE
Every page type is covered. Unperformed checks are explicitly `[LIMITATION]`, `[UNKNOWN]`, or Not applicable with reasons.

## Phase 9 — Passive Security Review

### Scope
Observation only. Map relevant findings to OWASP Top 10 / ASVS categories where applicable.

### Checks
Use only normal page navigation and REA-exposed information:
- HTTPS enforcement and HTTP-to-HTTPS redirect, if safely observable
- mixed content
- TLS details only if REA exposes them
- security headers: CSP, HSTS, X-Content-Type-Options, X-Frame-Options/frame-ancestors, Referrer-Policy, Permissions-Policy, COOP/COEP/CORP
- CORS behavior only as observed on the site's own normal requests
- cookie flags: Secure, HttpOnly, SameSite, scope, expiry, only if REA exposes them
- client-side storage containing tokens/personal data, if visible; do not use discovered values
- SRI on third-party scripts
- third-party script inventory
- exposed source maps, debug endpoints, directory listings, version banners, verbose errors, comments
- secrets/keys in HTML/JS/network responses: redact; never use
- public API exposure and unauthenticated access signals from normal application traffic only; do not probe
- authentication/session flow issues visible without attacking
- client-side injection-prone patterns only if visible in delivered code
- cache-control conflicts on sensitive pages
- known-vulnerable library versions only when explicitly exposed; map to public advisories only if source research is permitted by the user's tool constraint. Do not use another tool to inspect the target.

### Forbidden
No exploitation, payload injection, credential guessing, user enumeration, bypass, load testing, scanning, or probing.

### DELIVER
Save `security-observations.md` and a `not-tested-passive-only.md` list. Each check must be Checked / Not observable / Not applicable, with evidence or reason. Link Phase 9 findings to graph nodes in the same way.

### GATE
Every listed check has a status. Findings include evidence, severity, confidence, OWASP mapping where applicable, and remediation.

## Phase 10 — Conditional Modules

Activate only if Phase 6 confirms the relevant technology with High or Medium confidence. Otherwise mark `Not activated: no evidence`.

- Module A — Framework best-practices audit (Angular, React, Vue, Svelte, Next.js, Nuxt, etc.): version evidence; architecture; routing/code splitting; component structure; state/data fetching; rendering strategy; forms/validation; framework security; testing/TypeScript only if source is accessible. If source is unavailable, mark source-dependent checks Not Verifiable. Scorecard: Category | Evidence | Best practice | Status | Priority.
- Module B — Canvas/WebGL/game/media-heavy app: engine, scene/state transitions, asset pipeline, loading, input, audio/autoplay, DOM alternatives, reduced motion, memory-heavy assets.
- Module C — E-commerce/payments: catalog, cart, checkout only to last safe step, provider integration, price/stock display, order API observations. Never submit payment data.
- Module D — PWA/service worker/offline: manifest, scope, caching, cache versioning/invalidation, update flow, cache directive conflicts.
- Module E — Third-party integrations: each external API, endpoint and purpose only if observed, error/fallback, rate-limit signals, exposed keys (redact and never use).

### Framework adapters (additive, optional, Tier 2)
Universal runtime inspection (Phases 2–4 and 6–7) is complete without any adapter. Adapters only add framework-specific attributes to existing graph nodes.
- Activation: only if (a) Phase 6 classed the framework Confirmed or Strong indication with High or Medium confidence, and (b) the Registry shows the matching adapter Skill as Supported. Otherwise record `Not activated` with the reason. A skipped or unavailable adapter is not a gate failure.
- Adapter A-R (React runtime adapter), if activated, may record only what REA exposes at runtime: component tree and display names (minified names recorded as minified), props shape, hook usage, context presence, and the presence and shape of Redux, Zustand, or TanStack Query stores. An item is OBSERVED only if read directly from the running application through the adapter; reasoning on top of it is INFERRED. Values that may contain personal or sensitive data are never recorded, only shape and type. Versions only if explicitly exposed. Never claim recovery of original source code, props not seen, or state not observed.
- Results are stored as `runtime.react` attributes on Component nodes and in the Module A section of `conditional-modules.md`. Components found only through the adapter are added with source `adapter` and the label the evidence supports.
- Adapters for other frameworks may be registered later through the Skill Registry with the same contract. None is defined here.

Use official documentation only for the detected framework/version if the user permits external documentation research. Do not use another tool to inspect the target. Do not invent best-practice findings.

### DELIVER
Save `conditional-modules.md`, with each module completed or marked Not activated.

### GATE
Every module has an explicit activation decision and evidence.

Additional condition: adapter activation decisions are recorded in `conditional-modules.md`.

### STOP
Stop after Phase 10 and wait for PART 06.
