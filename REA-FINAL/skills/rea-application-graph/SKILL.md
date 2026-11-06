---
name: rea-application-graph
description: Application Intelligence Graph construction and management for REA. Emits append-only JSONL fragments across 12 node and 12 edge types, enforces evidence linking, and compiles the final frozen graph.
---

# REA Application Intelligence Graph

## 1. Overview & Purpose
`rea-application-graph` constructs and maintains the structured, evidence-linked model of the target web application. It writes incremental, append-only JSONL fragments during Phases 0–10, enforces strict evidence traceability for every node and edge, tracks route rendering modes and component origins, and compiles the frozen `application-graph.json` during Phase 12.

## 2. Activation Guidance
Activate this skill whenever creating or updating structural models of the target application (routes, layouts, components, instances, states, interactions, APIs, design tokens, technologies).

## 3. Preconditions
- `{{AUDIT_DIR}}graph/fragments/` directory exists.
- `REA-SCHEMAS.md` §3 Graph Schema is loaded.
- Evidence Ledger (`rea-evidence-ledger`) is active to provide valid E-IDs.

## 4. Inputs
- Discovered URLs, route structures, and page layouts (Phases 1–2).
- Component instances, landmark roles, and origin indicators (Phases 2, 4).
- State transitions, interactive controls, and user journeys (Phase 3).
- Design tokens, color palettes, and typography metrics (Phase 4).
- Technology fingerprints, rendering mode classifications, and API endpoints (Phases 6–7).

## 5. Expected Outputs
- Incremental JSONL fragment files: `{{AUDIT_DIR}}graph/fragments/phase-NN.jsonl`.
- Graph integrity report: `graph-integrity-report.md` (Phase 11).
- Graph coverage matrix: `graph-coverage-matrix.md` (Phase 11).
- Compiled frozen application graph: `application-graph.json` (Phase 12).

## 6. Relevant REA Phases
- **Phases 0–10:** Incremental fragment generation.
- **Phase 11:** Graph integrity validation and coverage audit.
- **Phase 12:** Graph compilation and freeze.

## 7. Required Capabilities
- Filesystem append and write access in the audit directory.

## 8. Dependencies
- Depends on `rea-evidence-ledger` for E-ID citations.
- Feeds into `rea-schemas-ir` for IR compilation.
- Coordinated by `rea-orchestrator`.

## 9. Node and Edge Schema Rules
### 12 Canonical Node Types:
1. `Application` (`APP-001`): Target root.
2. `Route` (`R-xxx`): Discovered in-scope URLs with `renderingMode`, `feasibility`, `queueState`.
3. `Layout` (`L-xxx`): Shared UI shells and templates.
4. `Component` (`C-xxx`): Reusable component definitions with `origin` (`server`, `client`, `unknown`).
5. `Component instance` (`CI-xxx`): Concrete DOM occurrences on specific routes.
6. `State` (`S-xxx`): Observable UI states (entry, exit, scope).
7. `Interaction` (`I-xxx`): Click, type, hover, scroll actions with before/after state links.
8. `User Flow` (`UF-xxx`): Multi-step user journeys.
9. `ApiEndpoint` (`A-xxx`): Network APIs with method, URL pattern, and field-name/type shape.
10. `Asset` (`AS-xxx`): Delivered media, fonts, SVGs with provenance and authorization status.
11. `DesignToken` (`T-xxx`): Authored and computed styles (colors, spacing, typography).
12. `Technology` (`TECH-xxx`): Frameworks, libraries, and hosting infrastructure.

### 12 Canonical Edge Types:
`contains`, `navigatesTo`, `renders`, `usesLayout`, `instanceOf`, `uses`, `respondsTo`, `changes`, `triggers`, `dependsOn`, `partOf`, `builtWith`.

### Core Rules:
1. **Append-Only:** Never edit or truncate an existing fragment file. Updates are written as `{"op":"supersede", "kind":"node"|"edge", "reason":"...", "record":{...}}`.
2. **Mandatory Evidence:** Zero nodes or edges without at least one valid E-ID citation.
3. **Markdown Wins:** Markdown audit deliverables remain the ultimate source of truth. If a discrepancy arises between markdown and graph JSON, markdown prevails and the graph is superseded.
4. **No Secrets / PII:** No cookies, auth tokens, passwords, or personal data may ever enter a graph attribute.

## 10. Graph-Less Fallback
If environment constraints prevent maintaining JSONL fragments:
- Log `[LIMITATION]` in `progress-log.md`.
- Continue all investigation and auditing phases using standard markdown deliverables.
- No gate in Phases 0–11 is blocked by graph-less operation.

## 11. Explicit Limitations
- The graph represents only *observable* frontend structures and network contracts. It does not infer or model private server-side architecture, internal database schemas, or unobserved code paths.
