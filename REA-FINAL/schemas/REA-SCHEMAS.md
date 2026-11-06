# REA-SCHEMAS — Skills, Application Intelligence Graph, and Intermediate Representation

Companion to `PART-00-MASTER-CONTROL.md`. It adds no behavior that overrides PART 00–07. Where this file and a Part disagree, the Part wins. Read it at the start of PART 01 and of every Part that writes Graph fragments (PART 02–06) and PART 07.

All names such as `{{AUDIT_DIR}}` are the project parameters defined in PART 00.

---

## 1. Tiers

| Tier | Meaning |
|---|---|
| **MVP** | Needed to preserve the original REA outputs, or to produce the Graph and IR handoff. Required by the unified workflow. |
| **Tier 2** | Valuable but optional. Never required by any gate. If unsupported, it is recorded in the Registry and the work continues with the documented Fallback. |

---

## 2. Skill descriptor, Registry format, and core catalog

### 2.1 Descriptor (one block per Skill in `{{AUDIT_DIR}}skill-registry.md`)

```
ID:               dotted, provider-neutral (e.g. inspect.dom)
Name:
Purpose:
Category:         navigate | capture | inspect | session | discover | assets | render | adapter
Tier:             MVP | Tier 2
Requires:         capability-matrix rows (and adapter, if any)
Inputs:
Outputs:
Limits:           what this Skill cannot expose
Safety:           constraints (e.g. read-only, no value capture)
Evidence emitted: what the evidence record "How" field cites
Fallback:         lower-fidelity REA Skill, or [LIMITATION]. Never an external tool.
Status:           SUPPORTED | NOT_SUPPORTED | NOT_VERIFIED
Status evidence:  E-ID or documentation reference
```

### 2.2 Core catalog (populate in Phase 0; add any extra Skill REA documents)

| ID | Capability | Requires (capability-matrix row) | Tier | Typical use | Fallback |
|---|---|---|---|---|---|
| `nav.open-url` | Open and navigate a URL | Navigate/open URL | MVP | Phases 0–2 | `[LIMITATION]`; nothing else can be done |
| `nav.click` | Click visible UI | Click | MVP | Phases 1–3 | Record the element as untested with reason |
| `input.type` | Type into fields | Type | MVP | Phase 3 | As above |
| `input.keyboard` | Keyboard operation | Keyboard input | MVP | Phases 3, 8 | Record as untested |
| `nav.scroll` | Scroll | Scroll | MVP | Phases 2–3 | Observe only the initially visible area; `[LIMITATION]` |
| `capture.screenshot` | Screenshots | Screenshot | MVP | Every phase | Textual DOM description labeled lower fidelity |
| `viewport.resize` | Set and read viewport size | Viewport resize | MVP | Phase 5 | `[LIMITATION]` for missing viewports |
| `inspect.dom` | Read rendered DOM | DOM read/inspect | MVP | Phases 2–4, 6–7 | Visible-text description labeled lower fidelity |
| `inspect.styles` | Read authored and computed styles, custom properties | DOM read/inspect, source/resource view | MVP | Phase 4 | Values marked `[UNKNOWN]` |
| `inspect.network-log` | Request log | Network request log | MVP | Phases 2, 6–8 | `[UNKNOWN]` for APIs |
| `inspect.headers-status` | Response headers and status | Response headers/status | MVP | Phases 6, 9 | `[UNKNOWN]` |
| `inspect.console` | Console log | Console log | MVP | Phase 8 | `[UNKNOWN]` |
| `inspect.cookies` | Cookie metadata (flags, scope), never values | Cookies | MVP | Phases 6, 9 | `[UNKNOWN]` |
| `inspect.storage` | Local/session storage keys and types, never values | Local/session storage | MVP | Phases 7, 9 | `[UNKNOWN]` |
| `inspect.resources` | Source and resource view of delivered files | Source/resource view | MVP | Phases 1, 6, 9 | `[UNKNOWN]` |
| `discover.metadata-files` | robots.txt, sitemap.xml, manifest, source maps | Inspect robots/sitemap/manifest/source maps | MVP | Phases 1, 6, 9 | Navigation-only discovery |
| `assets.inspect` | Inspect publicly delivered assets | Download or inspect publicly delivered assets | MVP | Phase 2 | Record URL and type only |
| `inspect.response-shape` | Field names and types of API responses, never values | Network log, response view | MVP | Phase 7 | `[UNKNOWN]` |
| `session.tabs` | Multiple tabs | Multiple tabs | MVP | Phase 1–3 | Single-tab sequential |
| `session.manual-login` | User completes login in an authorized session | Manual login handoff | MVP | Phase 2 | Stop at the authentication boundary (original rule) |
| `render.local` | Open a local project (localhost or file) and capture screenshots | Open local URL, Screenshot | MVP | PART 07 QA | `[LIMITATION]`; no visual comparison may be claimed |
| `fingerprint.tech` | Composite: technology fingerprint from the Skills above | (derived) | MVP | Phase 6 | `[UNKNOWN]` / class Unknown |
| `inspect.initial-html` | Inspect server-delivered initial HTML markup before JS execution | Initial HTML inspection / Network response view | MVP | Phases 0, 1, 6 | `[UNKNOWN]`; rendering mode remains unverified |
| `analyze.rendering-mode` | Analyze rendering mode (CSR/SSR/SSG/Hybrid) & component origins | (derived from initial-html, dom, resources) | MVP | Phases 0, 6 | Classify as `UNKNOWN` |
| `session.isolated-contexts` | Several isolated sessions per role alias | Multiple contexts | Tier 2 | Phases 2–3 | Sequential single session, logout between aliases |
| `inspect.dom-shadow` | Read Shadow DOM | DOM read | Tier 2 | Phases 2, 4 | Not claimed |
| `inspect.dom-mutations` | Observe DOM mutations | DOM mutation observation | Tier 2 | Phases 2–3 | Before/after snapshots |
| `inspect.network-initiator` | Request initiator or request-to-interaction association | Network log with initiator | Tier 2 | Phases 3, 7 | Mark association `[UNKNOWN]` or INFERRED |
| `adapter.react-runtime` | React runtime adapter (component tree, props shape, hooks, context, store shapes) | Framework runtime inspection | Tier 2 | Phase 10 | Not activated; structure-based components remain |

Adapters for other frameworks or optional external tools (e.g. `adapter.browser-toolkit`) are added to the Registry in the same format. None is predefined as mandatory.

---

## 3. Application Intelligence Graph

### 3.1 Storage
- Append-only JSONL fragments: `{{AUDIT_DIR}}graph/fragments/phase-NN.jsonl`, one record per line.
- Record envelope: `{"op":"add" | "supersede","kind":"node" | "edge","reason":"(supersede only)","record":{...}}`.
- `supersede` replaces an earlier record with the same `id`. Earlier lines are never edited.
- Phase 11 compiles fragments into `{{AUDIT_DIR}}application-graph.json` (Phase 12 freeze).

### 3.2 Node types and IDs

| Type | ID | Written in |
|---|---|---|
| Application | `APP-001` | Phase 0 |
| Route | `R-001` | Phases 1–2 |
| Layout / Template | `L-001` | Phase 7 |
| Component (definition) | `C-001` | Phases 4, 7 (and adapters) |
| Component instance | `CI-001` | Phase 2 |
| State | `S-001` | Phase 3 |
| Interaction | `I-001` | Phase 3 |
| User Flow | `UF-001` | Phase 3 |
| ApiEndpoint | `A-001` | Phase 7 |
| Asset | `AS-001` | Phase 2 (matches `asset-register.md`) |
| DesignToken | `T-001` | Phase 4 |
| Technology | `TECH-001` | Phase 6 |

IDs are sequential per type and never reused.

### 3.3 Common node fields

| Field | Rule |
|---|---|
| `id`, `type`, `name` | Required |
| `label` | Required: `OBSERVED` / `INFERRED` / `UNKNOWN` / `LIMITATION` / `IMPORTED` |
| `confidence` | Required for Technology, API, Component definition, and any INFERRED node: `High` / `Medium` / `Low`. Optional otherwise |
| `evidence` | Required: one or more E-IDs. An `UNKNOWN` placeholder cites the E-ID or progress-log step that exposed the gap |
| `reasoning` | Required when `label` is `INFERRED` |
| `phase` | The Phase that wrote it |
| `urls` | URLs where observed |
| `session` | Role alias, if applicable |
| `skill` | Skill ID used |
| `findings` | Optional F-IDs (annotation only) |
| `attrs` | Type-specific attributes (below). Framework-specific data only under `attrs.runtime.<adapter>` |

### 3.4 Type-specific `attrs` (essential fields)

| Type | Fields |
|---|---|
| Route | `pattern` (only if observed), `pageType`, `queueState`, `reason`, `pageRecord`, `variants` (viewport observations), `renderingMode` (`CSR` / `SSR` / `SSG` / `Hybrid` / `UNKNOWN`), `feasibility` (`FEASIBLE` / `PARTIALLY FEASIBLE` / `NOT FEASIBLE` / `UNKNOWN`), `feasibilityReason`, `limitations` |
| Layout | `regions`, `routes` (using it), `nesting` |
| Component | `role`, `origin` (`server` / `client` / `unknown`), `variants`, `states`, `instances`, `source` (`structure` or `adapter`), `runtime` (optional adapter data), `feasibilityNotes` |
| Component instance | `route`, `domLocator` (as observed), `origin` (`server` / `client` / `unknown`), `component` (C-ID, if grouped, INFERRED) |
| State | `entry`, `exit`, `scope` |
| Interaction | `target` (element description), `action`, `beforeState`, `afterState`, `safe` (true/false), `tested` (true/false) |
| User Flow | `steps` (ordered Interaction/Route IDs) |
| ApiEndpoint | `method`, `urlPattern`, `status` (if exposed), `resourceType`, `initiator` (Route/page), `auth` (observed behavior), `shape` (field names and types only) |
| Asset | `url`, `kind`, `provenance`, `authorization` (`Authorized` / `Unauthorized` / `Unknown`) |
| DesignToken | `category`, `value` (only if measured), `valueKind` (`authored` / `computed`) |
| Technology | `category`, `class` (`Confirmed` / `Strong indication` / `Unknown`), `purpose` |

### 3.5 Edges

Envelope fields: `id` (`X-001`), `type`, `from`, `to`, `label`, `evidence`, `reasoning` (if INFERRED), `confidence` (if INFERRED), `phase`.

| Type | From → To | Tier |
|---|---|---|
| `contains` | Application → Route | MVP |
| `navigatesTo` | Route → Route | MVP |
| `renders` | Route → Component instance | MVP |
| `usesLayout` | Route → Layout | MVP |
| `instanceOf` | Component instance → Component | MVP |
| `uses` | Component/Instance → Asset or DesignToken | MVP |
| `respondsTo` | Component/Instance → Interaction | MVP |
| `changes` | Interaction → State | MVP |
| `triggers` | Interaction → ApiEndpoint | MVP only with direct evidence; otherwise INFERRED. Direct evidence normally needs a Tier 2 Skill |
| `dependsOn` | Route/Component → ApiEndpoint | MVP |
| `partOf` | Interaction/Route → User Flow | MVP |
| `builtWith` | Application → Technology | MVP |

### 3.6 Example

```json
{"op":"add","kind":"node","record":{"id":"R-004","type":"Route","name":"Dashboard","label":"OBSERVED","evidence":["E-031"],"phase":"1","urls":["https://example.test/dashboard"],"session":"user","skill":"nav.open-url","attrs":{"queueState":"Visited","pageRecord":"page-records/dashboard.md","renderingMode":"CSR","feasibility":"FEASIBLE"}}}
{"op":"add","kind":"edge","record":{"id":"X-009","type":"changes","from":"I-012","to":"S-003","label":"OBSERVED","evidence":["E-077","E-078"],"phase":"3"}}
```

### 3.7 Rules
All rules in PART 00, "Application Intelligence Graph and Intermediate Representation contract", apply. In addition:
- A node that REA directly saw but could not characterize is `UNKNOWN`, never silently omitted.
- A node absent from the Graph means "not observed", not "does not exist". The IR and reports must say so.
- Nodes never contain values of cookies, tokens, personal data, or response bodies.

---

## 4. Evidence label mapping (analysis vocabulary to PART 00 contract)

PART 00 labels and confidences are the only contract. Terms used in other descriptions of web analysis map as follows and are never stored as separate labels.

| Other term | Stored as |
|---|---|
| Confirmed / directly observed | `OBSERVED` + `High` |
| Supported by multiple observations | `OBSERVED` or `INFERRED` with `High` (direct) or `Medium` (multiple indirect signals), per PART 00 definitions |
| Inferred | `INFERRED` + `Medium` or `Low`, with reasoning |
| Unknown | `UNKNOWN` |
| Unavailable | `LIMITATION` (blocked) or `UNKNOWN` (not determinable) |
| External / Adapter imported | `IMPORTED` (sub-type of INFERRED, requiring adapter provenance) |
| Reconstructed | Not an analysis label. It is a provenance field in PART 07 outputs, derived from the node's label |

---

## 5. Intermediate Representation (IR)

`{{AUDIT_DIR}}ir.json` is compiled in Phase 12 from the frozen Graph. It is framework-neutral and is a derived view. It never decides the technology to use in PART 07.

### 5.1 Sections

| Section | Content | Derived from |
|---|---|---|
| `meta` | schema version, project parameters, Phase 11 gate result, freeze timestamp/step, Graph checksum | Phase 11–12 |
| `technology` | Technology nodes with class and confidence; `stackDecision` (`READY` / `NEEDS-USER-INPUT`); rendering mode; evidence | Phase 6 |
| `routes[]` | id, pattern (if observed), type, layout ref, component-instance refs, page-record path, variants, queue state, reason, session, `renderingMode`, `feasibility`, `feasibilityReason`, `limitations` | Phases 1–2, 5, 6, 11 |
| `layouts[]`, `components[]` | definitions, variants, states, token refs, instance counts only if counted, `origin` (`server` / `client` / `unknown`) | Phases 4, 7 |
| `designTokens[]` | measured values only, with `valueKind`, others `UNKNOWN` | Phase 4 |
| `states[]`, `interactions[]`, `userFlows[]` | observed transitions, before/after states, safe and tested flags, untested reasons | Phase 3 |
| `apiDependencies[]` | method, URL pattern, status if exposed, initiator, associated interaction if evidenced, auth behavior, field-name/type shape | Phase 7 |
| `mockContracts[]` | For each API with an observed shape: allowed fields and types for synthetic fixtures; loading, empty, and error states only as observed | Phase 7 |
| `assets[]` | id, URL, kind, provenance, authorization status | Phase 2 and `asset-register.md` |
| `authUi` | observed authentication screens, states, and role aliases, with no credentials or session data | Phases 2–3 |
| `validationBaseline` | per route × viewport, the E-IDs of stored screenshots; the list of interactions and states to test; breakpoints observed | Phases 2, 3, 5 |
| `feasibility` | project-wide feasibility summary, route classifications, known blockers | Phases 0, 11 |
| `findings[]` | F-IDs linked to nodes (annotation) | Phases 8–9 |
| `limitations[]` | all `LIMITATION` and `UNKNOWN` items with affected phase and deliverable | Phase 11 |
| `coverage` | counts and matrices summary from the graph coverage matrix | Phase 11 |

Every element carries `label`, `confidence` (where required), and `evidence`.

### 5.2 Skeleton

```json
{
  "meta": {"schema": "1.1", "gate11": "PASS", "graphChecksum": "…"},
  "technology": {"items": [], "stackDecision": "READY|NEEDS-USER-INPUT"},
  "routes": [], "layouts": [], "components": [], "designTokens": [],
  "states": [], "interactions": [], "userFlows": [],
  "apiDependencies": [], "mockContracts": [],
  "assets": [], "authUi": {}, "validationBaseline": {},
  "feasibility": {"overall": "FEASIBLE|PARTIALLY_FEASIBLE|NOT_FEASIBLE", "routeDecisions": {}},
  "findings": [], "limitations": [], "coverage": {}
}
```

### 5.3 Derivation and integrity rules
1. Derive only from the frozen Graph and cross-check against the markdown deliverables. Markdown wins on conflict.
2. Never include: credentials, cookies, tokens, session identifiers, response values, personal data, or values of secrets.
3. Items with label `UNKNOWN` or `LIMITATION` appear in the sections they affect and in `limitations[]`.
4. The IR contains no field that names a specific framework as a requirement. Adapter data stays inside `components[].runtime`.
5. `ir-derivation-log.md` records the source deliverables per section and the consistency result.

---

## 6. Graph-less mode and degradation

- If the Graph cannot be written (a tooling limitation), record `[LIMITATION]`, continue with the original markdown workflow, and omit `ir.json`. PART 07 then proceeds from the markdown deliverables as originally defined.
- If a Skill is Not supported or Not verified, apply its Fallback and label the lower fidelity. Never substitute an external tool.
- Missing Tier 2 Skills reduce detail, never validity.

---

## 7. Extension points

- A new tool or capability: add an Adapter and Skill descriptors to the Registry (Phase 0 or a user-approved checkpoint update). No change to any Part.
- A new framework adapter: register `adapter.<framework>-runtime` with the 2.1 descriptor. Its output goes only to `attrs.runtime.<framework>`.
- A new output generator in PART 07: consumes the same IR and is selected only by Phase 6 evidence.
- A new validation partition (for example a later PART 08 using a new REA inspection) is out of the MVP and requires explicit user authorization.

---

## 8. Feasibility Assessment Schema (additive)

Record in `feasibility-assessment.md` (Phase 0 / `MASTER-PHASE-04`) and `final-feasibility-reconciliation.md` (Phase 11 / `MASTER-PHASE-13`):

### 8.1 Markdown Table Format
```markdown
| Target Entity | Classification | Difficulty | Reason | Evidence IDs | Blockers / Limitations | Reconstruction Impact |
|---|---|---|---|---|---|---|
| Route: / | FEASIBLE | LOW | Standard CSR React DOM observable | E-001, E-002 | None | Reconstruct as client component |
| Feature: Auth | PARTIALLY FEASIBLE | MEDIUM | Login UI observable; SSO opaque | E-015, E-018 | SSO backend redirect | Local mock auth only |
```

### 8.2 Canonical Enum Mapping Table

| Human-Readable Markdown Label | Canonical JSON Machine Value | Description |
|---|---|---|
| `FEASIBLE` | `FEASIBLE` | Observable, actionable evidence available, reconstructible within frontend boundaries. |
| `PARTIALLY FEASIBLE` | `PARTIALLY_FEASIBLE` | Core UI observable; specific dependencies blocked and requiring mock/placeholder. |
| `NOT FEASIBLE` | `NOT_FEASIBLE` | Essential UI/interactions cannot be inspected/reconstructed. Blocks Phase 16 reconstruction only. |
| `UNKNOWN` | `UNKNOWN` | Insufficient evidence to determine feasibility at the current phase. |

Qualitative Difficulty Values: `LOW`, `MEDIUM`, `HIGH`, `UNKNOWN` (marked `[INFERRED]`).

### 8.3 Machine-Readable JSON Schema (`feasibility-assessment.json`)
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "ReaFeasibilityAssessment",
  "type": "object",
  "required": ["overall", "status", "technicalDimensions", "routeDecisions", "featureDecisions"],
  "properties": {
    "overall": {
      "type": "string",
      "enum": ["FEASIBLE", "PARTIALLY_FEASIBLE", "NOT_FEASIBLE", "UNKNOWN"]
    },
    "status": {
      "type": "string",
      "enum": ["PROVISIONAL", "FINAL"]
    },
    "technicalDimensions": {
      "type": "object",
      "properties": {
        "authentication_and_session": { "type": "string", "enum": ["FEASIBLE", "PARTIALLY_FEASIBLE", "NOT_FEASIBLE", "UNKNOWN"] },
        "dynamic_and_antibot": { "type": "string", "enum": ["FEASIBLE", "PARTIALLY_FEASIBLE", "NOT_FEASIBLE", "UNKNOWN"] },
        "network_and_protocol": { "type": "string", "enum": ["FEASIBLE", "PARTIALLY_FEASIBLE", "NOT_FEASIBLE", "UNKNOWN"] },
        "client_architecture_and_hydration": { "type": "string", "enum": ["FEASIBLE", "PARTIALLY_FEASIBLE", "NOT_FEASIBLE", "UNKNOWN"] },
        "route_complexity_and_depth": { "type": "string", "enum": ["FEASIBLE", "PARTIALLY_FEASIBLE", "NOT_FEASIBLE", "UNKNOWN"] },
        "responsive_and_viewport": { "type": "string", "enum": ["FEASIBLE", "PARTIALLY_FEASIBLE", "NOT_FEASIBLE", "UNKNOWN"] },
        "design_system_and_asset": { "type": "string", "enum": ["FEASIBLE", "PARTIALLY_FEASIBLE", "NOT_FEASIBLE", "UNKNOWN"] },
        "storage_and_state": { "type": "string", "enum": ["FEASIBLE", "PARTIALLY_FEASIBLE", "NOT_FEASIBLE", "UNKNOWN"] },
        "api_surface": { "type": "string", "enum": ["FEASIBLE", "PARTIALLY_FEASIBLE", "NOT_FEASIBLE", "UNKNOWN"] },
        "build_and_reconstruction": { "type": "string", "enum": ["FEASIBLE", "PARTIALLY_FEASIBLE", "NOT_FEASIBLE", "UNKNOWN"] }
      }
    },
    "routeDecisions": {
      "type": "object",
      "additionalProperties": {
        "type": "object",
        "required": ["decision", "reason", "evidence", "status"],
        "properties": {
          "decision": { "type": "string", "enum": ["FEASIBLE", "PARTIALLY_FEASIBLE", "NOT_FEASIBLE", "UNKNOWN"] },
          "difficulty": { "type": "string", "enum": ["LOW", "MEDIUM", "HIGH", "UNKNOWN"] },
          "reason": { "type": "string" },
          "evidence": { "type": "array", "items": { "type": "string" } },
          "status": { "type": "string", "enum": ["PROVISIONAL", "FINAL"] },
          "limitations": { "type": "array", "items": { "type": "string" } }
        }
      }
    },
    "featureDecisions": {
      "type": "object",
      "additionalProperties": {
        "type": "object",
        "required": ["decision", "reason", "evidence", "status"],
        "properties": {
          "decision": { "type": "string", "enum": ["FEASIBLE", "PARTIALLY_FEASIBLE", "NOT_FEASIBLE", "UNKNOWN"] },
          "difficulty": { "type": "string", "enum": ["LOW", "MEDIUM", "HIGH", "UNKNOWN"] },
          "reason": { "type": "string" },
          "evidence": { "type": "array", "items": { "type": "string" } },
          "status": { "type": "string", "enum": ["PROVISIONAL", "FINAL"] },
          "limitations": { "type": "array", "items": { "type": "string" } }
        }
      }
    }
  }
}
```

---

## 9. External Adapter Provenance Schema (additive — DESIGN_ONLY / NOT VERIFIED)

> [!NOTE]
> The Browser Toolkit adapter implementation status is **`DESIGN_ONLY — NOT VERIFIED`**. The schema below specifies the contract for external capture imports if an executable adapter is authorized and implemented in the future. External capture data is strictly labeled `IMPORTED` (or `INFERRED`), never `OBSERVED`.

When importing evidence via an optional external adapter:

```json
{
  "id": "E-201",
  "label": "IMPORTED",
  "where": "https://example.com/api/v1/data",
  "what": "Imported JSON response keys from external capture: id, title, created_at",
  "how": "adapter.browser-toolkit::SiteReconstructor",
  "provenance": {
    "sourceTool": "Dvurechensky/Browser.Reverse.Engineering.Toolkit",
    "captureFile": "captures/session-01.json",
    "captureFileSha256": "3a8f...b29c",
    "sanitized": true,
    "timestamp": "2026-11-06T16:00:00Z"
  }
}
```

---

## 10. Canonical Eight-Dimension Acceptance Schema (additive)

Record in `acceptance-matrix.md` and `acceptance-matrix.json` (`MASTER-PHASE-17` / `PART-07-LOCAL-PHASE-13.8`):

### 10.1 Acceptance Table Format

| Canonical Dimension | Status | Supporting Evidence | Covered Routes / Features | Gaps / Deviations | Documented Limitations |
|---|---|---|---|---|---|
| 1. Visual fidelity | VERIFIED | E-001, screenshot diffs | Primary routes: /, /about | None | render.local supported |
| 2. Route coverage | VERIFIED | E-010, route table | 100% in-scope routes | Route /admin excluded | Auth required (documented) |
| 3. Components and layout | VERIFIED | Component inventory | Layouts, Nav, Cards | None | None |
| 4. Interactions | VERIFIED | Interaction matrix | Modals, tabs, inputs | Untested checkout | Non-destructive boundary |
| 5. Client-side state | VERIFIED | State model | Cart, theme, session | None | None |
| 6. Responsive behavior | VERIFIED | Viewport records | 390px, 768px, 1440px | Minor overflow on 320px | 320px unverified (limitation) |
| 7. Assets | VERIFIED | Asset register | Icons, logos, fonts | Non-authorized replaced | Explicit placeholders used |
| 8. Functional consistency | VERIFIED | Mock test logs | Synthetic API endpoints | Real backend excluded | Mock responses only |

Allowed Status Values:
- `VERIFIED`: Measured and confirmed with direct evidence.
- `NOT_VERIFIED`: Unmeasured or blocked; MUST include a documented `LIMITATION`.

Supporting sub-aspects map cleanly beneath these canonical dimensions:
- Accessibility (WCAG AA, ARIA landmarks, keyboard nav) -> evaluated under *Visual fidelity* and *Interactions*.
- Backend mock fidelity -> evaluated under *Functional consistency*.
- Code architecture & TypeScript types -> evaluated under *Components and layout*.
