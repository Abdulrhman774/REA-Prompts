---
name: rea-rendering-analysis
description: Rendering mode and component origin analyzer for REA. Distinguishes CSR, SSR, SSG, and Hybrid architectures, evaluates hydration markers, and classifies component origins as server, client, or unknown.
---

# REA Rendering Mode & Component Origin Analysis

## 1. Overview & Purpose
`rea-rendering-analysis` provides specialized inspection and reasoning to determine how a target web application generates, delivers, and hydrates its user interface. It establishes whether routes rely on Client-Side Rendering (`CSR`), Server-Side Rendering (`SSR`), Static Site Generation (`SSG`), or a `Hybrid` architecture, and classifies whether individual components originate on the server or in the browser client runtime.

## 2. Activation Guidance
Activate this skill in Phase 0 for provisional rendering evaluation, in Phase 2 during page-by-page component capture, and in Phase 6 during full technology architecture fingerprinting.

## 3. Preconditions
- Initial HTML capture or raw network response for the route is available.
- Post-JavaScript rendered DOM inspection has been performed through `inspect.dom`.

## 4. Inputs
- Raw initial HTML response from `inspect.initial-html` (or network response payload).
- Rendered DOM tree from `inspect.dom`.
- Network request waterfall showing runtime JavaScript chunk loading.
- Script and stylesheet resource URLs.

## 5. Expected Outputs
- Route-by-route rendering mode classification (`CSR`, `SSR`, `SSG`, `Hybrid`, `UNKNOWN`).
- Component origin classification (`server`, `client`, `unknown`) attached to Component and Component Instance graph nodes.
- Hydration discrepancy logs (comparing server-delivered text with final client DOM).
- Rendering analysis section in `technology-stack.md` and `feasibility-assessment.md`.

## 6. Relevant REA Phases
- **Phase 0:** Provisional rendering mode check from the initial page load.
- **Phase 2:** Component origin classification during page-by-page inspection.
- **Phase 6:** Full technology fingerprinting and final route rendering classification.

## 7. Required Capabilities
- `inspect.initial-html`: Captures raw server-delivered HTML before client JavaScript executes.
- `analyze.rendering-mode`: Analytic synthesis comparing initial markup, DOM mutations, and hydration tokens.
- `inspect.dom`: Captures final post-JS hydrated DOM.

## 8. Dependencies
- Supplies rendering evidence to `rea-feasibility-assessment`.
- Enriches Route and Component nodes managed by `rea-application-graph`.
- Governed by `rea-orchestrator`.

## 9. Rendering Mode Classification Taxonomy
Every route must be classified using direct empirical evidence:
- `CSR` (Client-Side Rendering): Initial HTML contains an empty root container (e.g. `<div id="root"></div>`, `<app-root></app-root>`); all visible markup, layout, and text are constructed dynamically by client JavaScript bundles.
- `SSR` (Server-Side Rendering): Server returns fully rendered HTML containing complete text, headers, and semantic structures; client scripts attach event listeners or hydrate state.
- `SSG` (Static Site Generation): Pre-built HTML pages delivered from storage or CDN; no server-side compute per request; fast initial load with static markup.
- `Hybrid`: The application mixes rendering paradigms (e.g. static landing pages, server-rendered listing pages, client-rendered interactive dashboards, or island architectures like Astro/Nuxt).
- `UNKNOWN`: Evidence is contradictory or tool limitations prevent distinguishing initial markup from rendered DOM.

### Critical Analysis Rule:
**Never infer rendering mode solely from a framework name.** Modern frameworks (Next.js, Nuxt, Remix, Angular, SvelteKit) support multiple rendering modes simultaneously within the same application. Each route must be evaluated on its own evidence.

## 10. Component Origin Classification
Every identified component instance is categorized:
- `origin: "server"`: Component markup and content exist in the initial HTTP response payload before scripts execute.
- `origin: "client"`: Component markup is absent from initial HTML and appears only after script execution, dynamic mounting, or user interaction.
- `origin: "unknown"`: Initial response payload is unavailable or tool limitations obscure delivery timing.

## 11. Hydration & Marker Detection
Examine markup for canonical framework hydration signatures:
- **React:** `data-reactroot`, `__NEXT_DATA__`, `<!--$?-->` (streaming boundaries).
- **Angular:** `ng-version`, `_ngcontent-`, `ng-server-context`.
- **Vue / Nuxt:** `data-v-`, `__NUXT__`, `__NUXT_DATA__`.
- **Svelte:** `class="svelte-"`, `<!--ssr:...-->`.

## 12. Failure Handling & Fallback
- If `inspect.initial-html` is `NOT_SUPPORTED` or `NOT_VERIFIED`: do not fabricate initial HTML. Mark rendering mode as `[UNKNOWN]`, record a limitation, and defer final classification to Phase 6 network analysis.
- If DOM inspection is blocked: record `[LIMITATION]` and rely on textual response analysis labeled with lower fidelity.

## 13. Explicit Limitations
- This skill performs passive observation of delivered markup and client DOM; it cannot inspect private server-side build pipelines, serverless functions, or edge rendering runtime environments.
