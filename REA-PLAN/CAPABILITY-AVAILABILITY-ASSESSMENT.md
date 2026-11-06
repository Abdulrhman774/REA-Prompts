# REA PLAN — CAPABILITY AVAILABILITY ASSESSMENT
**Stage One | Generated:** 2026-11-06  
**Status:** Based on verified inspection of installed MCP config and reverse-engineer-anything SKILL.md (v49, 229 tools)

---

## 1. REA Execution Provider — Verified

| Item | Value |
|---|---|
| Provider | REA MCP Server via `rea-agents` npm package |
| Registration | `C:\Users\abd alrhman\.gemini\config\mcp_config.json` |
| Command | `npx -y rea-agents@6.8.0 mcp` |
| Skill guidance | `reverse-engineer-anything` v49 (229 tools) |
| Verification status | REGISTERED (not runtime-tested in Stage One — requires Phase 0 of an actual session) |

> [!IMPORTANT]
> The MCP server is registered. Whether it is reachable and which tools are actually available requires a live Phase 0 capability test. All statuses below reflect what the installed skill documents + what the registration implies, NOT runtime-verified results.

---

## 2. Capability Status Table

For each capability required by REA's Skill catalog plus new capabilities from the work order:

| Capability ID | Capability Name | REA MCP Evidence | Status | Affects Feasibility |
|---|---|---|---|---|
| nav.open-url | Open and navigate a URL | `capture_browser_scenario` with navigation actions; `list_browser_targets` | LIKELY SUPPORTED | Yes — if NOT SUPPORTED, nothing else can be done |
| nav.click | Click visible UI | `capture_browser_scenario` actions | LIKELY SUPPORTED | Affects interaction coverage |
| input.type | Type into fields | `capture_browser_scenario` actions | LIKELY SUPPORTED | Affects form testing |
| input.keyboard | Keyboard operation | `capture_browser_scenario` actions | LIKELY SUPPORTED | Affects accessibility testing |
| nav.scroll | Scroll | `capture_browser_scenario` actions | LIKELY SUPPORTED | Affects below-fold content |
| capture.screenshot | Screenshots | `capture_browser_scenario`, `capture_web_screenshot` | LIKELY SUPPORTED | Required for QA visual comparison |
| viewport.resize | Set and read viewport size | `capture_browser_scenario` viewport | LIKELY SUPPORTED | Affects responsive testing |
| inspect.dom | Read rendered DOM | `inspect_web_page` | LIKELY SUPPORTED | Core capability |
| inspect.styles | Read authored and computed styles | `inspect_web_page` (style data) | LIKELY SUPPORTED (partial) | Affects design system fidelity |
| inspect.network-log | Request log | `inspect_web_network_capture`, `observe_web_session` | LIKELY SUPPORTED | Critical for API mapping |
| inspect.headers-status | Response headers and status | `inspect_web_network_capture` | LIKELY SUPPORTED | Affects security analysis |
| inspect.console | Console log | `observe_web_execution`, `observe_javascript_runtime` | LIKELY SUPPORTED | Affects error detection |
| inspect.cookies | Cookie metadata | `inspect_web_page` | LIKELY SUPPORTED | Affects security analysis |
| inspect.storage | Local/session storage keys | `inspect_web_page` | LIKELY SUPPORTED | Affects architecture analysis |
| inspect.resources | Source and resource view | `inspect_web_page`, `export_web_scripts` | LIKELY SUPPORTED | Affects fingerprinting |
| discover.metadata-files | robots.txt, sitemap, manifest, source maps | Navigation + `inspect_web_page` | LIKELY SUPPORTED | Affects discovery |
| assets.inspect | Inspect publicly delivered assets | `inspect_web_page`, `open_bundle_resources` | LIKELY SUPPORTED | Affects asset register |
| inspect.response-shape | Field names and types of API responses | `inspect_web_network_capture` | LIKELY SUPPORTED (partial) | Affects API mapping |
| session.tabs | Multiple tabs | `list_browser_targets` (multiple) | LIKELY SUPPORTED | Affects multi-session testing |
| session.manual-login | User completes login in authorized session | `capture_browser_scenario` with user handoff | LIKELY SUPPORTED | Affects authenticated coverage |
| render.local | Open local project and capture screenshots | `list_browser_targets` with localhost | LIKELY SUPPORTED | Required for PART-07 QA |
| fingerprint.tech | Composite technology fingerprint | Derived from other capabilities | DERIVED | Depends on above |
| session.isolated-contexts | Multiple isolated sessions (Tier 2) | Multiple browser contexts | NOT VERIFIED | Tier 2 — not gating |
| inspect.dom-shadow | Read Shadow DOM (Tier 2) | `inspect_web_page` (possible) | NOT VERIFIED | Tier 2 — not gating |
| inspect.dom-mutations | Observe DOM mutations (Tier 2) | `observe_web_execution` | NOT VERIFIED | Tier 2 — not gating |
| inspect.network-initiator | Request initiator (Tier 2) | `inspect_web_network_capture` with initiator fields | NOT VERIFIED | Tier 2 — not gating |
| adapter.react-runtime | React runtime adapter (Tier 2) | `observe_javascript_runtime`, `reconcile_javascript_runtime` | NOT VERIFIED | Tier 2 — not gating |
| **inspect.initial-html** | Collect initial HTML (NEW) | `capture_browser_scenario` before JS execution; `inspect_web_page` | NOT VERIFIED | High — required for feasibility assessment |
| **analyze.rendering-mode** | Analyze rendering mode from evidence (NEW) | Analysis step, not a tool call | NOT VERIFIED (analysis task) | High — required for classification |

---

## 3. Impact of NOT VERIFIED Capabilities

| Capability | Phase Impact | Deliverable Impact | Fallback |
|---|---|---|---|
| inspect.initial-html | Phase 0 provisional feasibility becomes fully UNKNOWN | Feasibility assessment is PROVISIONAL/UNKNOWN | Mark all rendering mode as NOT VERIFIED in Phase 0; defer to Phase 6 |
| analyze.rendering-mode | Phase 0 provisional only; Phase 6 uses existing evidence | Phase 0 rendering classification UNKNOWN | Phase 6 still classifies from available evidence |
| session.isolated-contexts | Multiple role coverage reduced | Tier 2 — not a gate failure | Sequential sessions |
| inspect.dom-shadow | Shadow DOM content unknown | Tier 2 — not a gate failure | Mark as LIMITATION |
| inspect.dom-mutations | Before/after state detail reduced | Tier 2 — not a gate failure | Manual before/after screenshots |
| inspect.network-initiator | Interaction-to-API causation INFERRED | Tier 2 — not a gate failure | Mark as INFERRED |
| adapter.react-runtime | No React-specific component tree | Tier 2 — not a gate failure | Structure-based components |

---

## 4. New Capability Contracts from Work Order

### inspect.initial-html
**Purpose:** Collect the initial HTML delivered by the server before JavaScript execution.  
**Provider approach:** Use `capture_browser_scenario` with no JavaScript execution (if REA supports this mode), or navigate and capture the DOM before JS hydration completes. Alternatively, use `inspect_web_network_capture` on the initial HTML response.  
**Limitation if unavailable:** Cannot distinguish SSR from CSR from initial evidence alone. Rendering mode remains UNKNOWN until Phase 6.  
**Status:** NOT VERIFIED in Stage One. Must be tested in Phase 0.

### analyze.rendering-mode
**Purpose:** Analyze available evidence (initial HTML, post-JS DOM, hydration indicators, hydration markers, bundle references) to classify rendering mode.  
**Provider approach:** This is an analysis/reasoning step, not a direct tool call. It consumes output from inspect.initial-html, inspect.dom, inspect.resources, and fingerprint.tech.  
**Limitation if unavailable:** N/A — this is an analysis task. If the evidence inputs are unavailable, the analysis output is UNKNOWN/LIMITATION.  
**Status:** NOT VERIFIED in Stage One. Activated when evidence inputs are available.

---

## 5. Summary by Risk Level

| Risk Level | Capabilities | Action |
|---|---|---|
| **HIGH RISK (blocker if unavailable)** | nav.open-url | Phase 0 must verify first; nothing else can proceed |
| **HIGH RISK (significant impact)** | capture.screenshot, inspect.dom, inspect.network-log | Must be verified in Phase 0 |
| **MEDIUM RISK** | render.local (PART-07 QA only), inspect.initial-html, session.manual-login | Phase 0 verification; fallback documented |
| **LOW RISK (Tier 2 only)** | All Tier 2 Skills | No gate impact; fallback well defined |
