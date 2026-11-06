# Capability Preservation Matrix

Maps every rule, phase, deliverable, gate, and safety condition of the original REA Prompt (PART 00–07 as supplied in `healthbook-antigravity-partitions.7z`) to its location in the unified Prompt.

**Status legend**

| Code | Meaning |
|---|---|
| **P** | Preserved verbatim, in original order. Verified automatically (Appendix A). |
| **P\*** | Preserved verbatim except approved parameterization tokens (`{{TARGET_URL}}`, `{{AUDIT_DIR}}`, `{{RECON_DIR}}`, `{{PROJECT_NAME}}`) per decision D7. |
| **P+** | Preserved verbatim and unchanged; new additive content sits next to it (a new block, a new bullet, a new table row). The original text is not edited. |
| **M** | Original text changed. Every M row is listed in full in Appendix A. |

Nothing is marked removed, weakened, or reordered. Original Part names, Phase numbers, gate wording, and stop points are unchanged.

---

## 1. PART 00 — Master Control

| ID | Original rule or content | Status | Location in unified |
|---|---|---|---|
| 00-01 | File is the permanent contract; read before every partition; execute only the supplied partition | P | PART 00, opening paragraph |
| 00-02 | Mission: target, allowed scope, output language (English), audit directory, reconstruction directory, depth | P\* | PART 00 › Mission. Parameters defined in "Project parameters" |
| 00-03 | Authorization statement treated as sufficient; no repeated proof; does not authorize bypass or leaving scope | P | PART 00 › Mission |
| 00-04 | REA is the only authorized tool for inspection and browser interaction | P+ | PART 00 › Absolute tool restriction; clarification in "REA definition and interpretation" (D1) |
| 00-05 | Allowed operations through REA (open, click, type, scroll, screenshot, supported inspections, public resources) | P | PART 00 › Absolute tool restriction |
| 00-06 | Forbidden: Playwright, Puppeteer, Selenium, external CDP scripts, curl/wget/direct HTTP, Python/Node scripts for inspection, external agents/extensions/MCP, silent substitution | P+ | Same section. Interpretation rule added beside it; the list itself is untouched |
| 00-07 | If REA cannot perform an operation: mark `[LIMITATION]`, state what, affected phase/deliverable, continue, never switch silently or claim unsupported inspection | P | Same section |
| 00-08 | Local workspace operations are not inspection; Node.js only as local frontend dev runtime in PART 07 | P | Same section |
| 00-09 | Observe, navigate, read only; no exploitation, payloads, brute force, fuzzing, scanning, load testing, privilege escalation, auth/MFA/OTP/WAF/rate-limit bypass | P | PART 00 › Safety and non-destructive rules |
| 00-10 | Stay in scope; no out-of-scope systems, accounts, domains, data | P | Safety rules |
| 00-11 | Test credentials only if explicitly supplied; otherwise public pages and stop at authentication boundary | P+ | Safety rules; new "Manual login handoff" bullet follows (D6) |
| 00-12 | No real patient records; no transmitting sensitive information | P+ | Safety rules; new bullet extends to all real personal/sensitive data |
| 00-13 | No real data submission; no account creation/alteration, messages, payments, deletion, deployment, irreversible actions | P | Safety rules |
| 00-14 | Destructive/financial/irreversible flows: stop at last safe step, document untested | P | Safety rules |
| 00-15 | Keep request volume low; slow on throttling/errors | P | Safety rules |
| 00-16 | Never use secrets found; record only location and type; redact (max first/last three characters) | P | Safety rules |
| 00-17 | Do not overwrite original files or previous evidence | P | Safety rules |
| 00-18 | Ask before installing dependencies or destructive workspace operations | P | Safety rules |
| 00-19 | Every factual claim cites evidence IDs; otherwise `[UNKNOWN]` | P | PART 00 › Evidence and finding contract |
| 00-20 | Exactly one label per statement: OBSERVED / INFERRED / UNKNOWN / LIMITATION, with definitions | P | Same section |
| 00-21 | Confidence High/Medium/Low for technology, architecture, vulnerability claims, with definitions | P | Same section |
| 00-22 | Never invent versions, endpoints, headers, metrics, selectors, paths, libraries, measurements; versions only if exposed | P | Same section |
| 00-23 | Evidence record fields (ID, Where, What, How, When) | P+ | Same section; optional rows `Session` and `Skill` added after `When` |
| 00-24 | Finding record fields (ID, Title, Category, Label, Confidence, Severity, Evidence, URL(s), Impact, Recommendation) | P | Same section |
| 00-25 | Avoid vague claims; use observable or measurable statements | P | Same section |
| 00-26 | Tracking files: progress-log, url-queue, evidence-ledger, findings, capability-matrix, phase deliverables/page records, checkpoint | P+ | PART 00 › Persistence and checkpointing; `skill-registry.md` and `graph/` bullet added |
| 00-27 | Progress log format | P | Same section |
| 00-28 | Checkpoint rules: after every phase and about every 10 pages; contents; never mark incomplete work complete; resume from latest verified checkpoint; never fabricate or skip | P+ | Same section; one bullet adds Registry and Graph ranges |
| 00-29 | Partition execution protocol, steps 1–10 (one partition at a time; read checkpoint; gates; preserve artifacts; wait for the user; PART 07 forbidden until PART 06 complete and written approval) | P | PART 00 › Partition execution protocol |
| 00-30 | Required end-of-partition response | P+ | PART 00 › Required end-of-partition response; two bullets added (Graph fragments, Skills) |
| 00-31 | Scope of project: Stage 1 Phases 0–11, Stage 2 Phase 12, Stage 3 Phase 13 after approval; no backend; only verified original frontend technology; stop and ask if stack not confident | P | PART 00 › Scope of the overall project |

---

## 2. PART 01 — Preflight (Phase 0)

| ID | Original rule or content | Status | Location in unified |
|---|---|---|---|
| 01-01 | Read PART 00 first; execute Phase 0 only; do not start Phase 1 | P+ | PART 01, opening; extra "Also read" line added before Phase 0 |
| 01-02 | START: record objective, timestamp, scope, intended REA operations; confirm authorization without repeated proof | P | Phase 0 › START |
| 01-03 | Read REA's own documentation; do not invent commands or capabilities | P | Phase 0 › DO 1 |
| 01-04 | Capability matrix: 17 items with Supported / Not supported / Not verified, evidence, affected phases | P+ | Phase 0 › DO 2. Extended discovery in DO 8 |
| 01-05 | No inferring support from another tool; docs not establishing support → Not verified | P | Phase 0 › DO 3 |
| 01-06 | Create audit directory and initialize six tracking files | P+ | Phase 0 › DO 4; `skill-registry.md` and `graph/fragments/` added to the list |
| 01-07 | Load the target exactly once; record initial URL, final URL, title, status if exposed, timestamp, screenshot | P | Phase 0 › DO 5 |
| 01-08 | Record baseline observations with sequential evidence IDs | P | Phase 0 › DO 6 |
| 01-09 | Investigation plan mapping Phases 1–11 to verified capabilities | P+ | Phase 0 › DO 7; DO 12 extends it with a Skill-to-Phase map |
| 01-10 | RECORD rules: evidence record per PART 00; mandatory labels; no unexposed status/header/title/redirect | P | Phase 0 › RECORD |
| 01-11 | DELIVER: capability-matrix, investigation-plan, progress-log, url-queue, evidence-ledger, checkpoint | P+ | Phase 0 › DELIVER; `skill-registry.md` and `phase-00.jsonl` added |
| 01-12 | GATE: capabilities documented or Not verified; no reliance on unverified capability; baseline recorded; tracking files exist; unsupported → `[LIMITATION]` and continue without switching tools | P+ | Phase 0 › GATE; Registry and Graph conditions added |
| 01-13 | STOP after Phase 0; report gate; wait for instruction to run PART 02 | P | Phase 0 › STOP |

---

## 3. PART 02 — Discovery (Phase 1) and Page-by-Page (Phase 2)

| ID | Original rule or content | Status | Location in unified |
|---|---|---|---|
| 02-01 | Read PART 00, checkpoint, capability matrix, plan; execute Phases 1 and 2 only | P+ | PART 02, opening; extra "Also read" line added |
| 02-02 | Phase 1 START | P | Phase 1 › START |
| 02-03 | Non-intrusive discovery methods (robots/sitemap, navigation areas, pagination, links in DOM/scripts/manifests/API responses if exposed, search results, redirects, one safe 404) | P | Phase 1 › DO |
| 02-04 | Queue record fields; four states Discovered / Visited / Analyzed / Blocked | P+ | Phase 1 › DO; additive block adds `session` and `reason` columns and reason codes without changing the four states |
| 02-05 | Classification of each URL by type | P | Phase 1 › DO |
| 02-06 | Inspect all navigation areas including mobile menus; keep external links separate; never leave ALLOWED_SCOPE | P+ | Phase 1 › DO; `ALLOWED_SCOPE` now defined in PART 00 "Project parameters" |
| 02-07 | No brute force, wordlist path guessing, ID enumeration, or probing hidden routes | P | Phase 1 › DO |
| 02-08 | RECORD orphan pages, link depth, dead links, redirect chains, inaccessible routes only if observed; else `[UNKNOWN]` | P | Phase 1 › RECORD |
| 02-09 | DELIVER: sitemap, url-queue, link-graph-summary, evidence/findings updates | P+ | Phase 1 › DELIVER; `phase-01.jsonl` bullet added |
| 02-10 | GATE: queue empty or all Blocked with reasons; all navigation enumerated; do not begin Phase 2 if gate fails | P+ | Phase 1 › GATE; additional conditions sentence follows |
| 02-11 | Phase 2: visit every queued in-scope page individually; at least five instances for dynamic route families; do not guess identifiers | P | Phase 2 › DO |
| 02-12 | One Page Record per URL with the listed observations (layout order, components, headings, resources, states, auth variants, interactions, responsive, tech, findings, limitations) | P | Phase 2 › DO |
| 02-13 | Auth pages: only supplied credentials; else stop at boundary and mark Blocked; never bypass or inspect other users' data | P | Phase 2 › DO |
| 02-14 | Do not assume pages identical until inspected; checkpoint per phase and about every ten pages | P | Phase 2 › DO |
| 02-15 | Page Record schema (15 fields) | M | Phase 2 › DELIVER. Original schema kept as prefix; `Session` and `Graph refs` added. See Appendix A |
| 02-16 | Save records under `page-records/`; update sitemap, queue, ledger, findings, checkpoint | P\* | Phase 2 › DELIVER |
| 02-17 | GATE: every Visited page has a record; every Blocked page has a reason; no silent skipping | P+ | Phase 2 › GATE; additional conditions sentence follows |
| 02-18 | STOP after Phase 2; report coverage; wait for PART 03 | P | Phase 2 › STOP |

---

## 4. PART 03 — Interactions (Phase 3), Design System (Phase 4), Responsive (Phase 5)

| ID | Original rule or content | Status | Location in unified |
|---|---|---|---|
| 03-01 | Read PART 00, checkpoint, sitemap, page records, capability matrix; execute Phases 3–5 only | P+ | PART 03, opening; "Also read" line added |
| 03-02 | Interaction matrix per page (8 columns) | M | Phase 3 › DO. Original columns kept as prefix; four columns added. See Appendix A |
| 03-03 | Test safe actions only (navigation, tabs, accordions, dropdowns, modals, hover/focus, harmless search, filters, sorting, pagination, carousels, toggles, keyboard) | P | Phase 3 › DO |
| 03-04 | Forms: inspect fields, labels, constraints, validation, errors; submit only with test account or explicit authorization; never submit patient/real personal/payment/deletion/irreversible data | P | Phase 3 › DO |
| 03-05 | Map user journeys from observed flows; Mermaid only if supported | P | Phase 3 › DO |
| 03-06 | DELIVER: interaction-matrix, functionality-map, user-journeys | M | Phase 3 › DELIVER. Original sentence kept first; `state-model.md` and fragment added |
| 03-07 | GATE: every interactive element tested or listed untested with reason | P+ | Phase 3 › GATE; additional condition follows |
| 03-08 | Phase 4: extract only exposed values (colors, typography, spacing, radii, shadows, variants, animations, custom properties) | P | Phase 4 › DO |
| 03-09 | Audit consistency; do not invent hex, pixel, computed styles, tokens; `[UNKNOWN]` for unmeasurable | P | Phase 4 › DO |
| 03-10 | DELIVER: design-system, component-inventory with per-token and per-component fields | M | Phase 4 › DELIVER. Sentence extended with graph fragment |
| 03-11 | GATE: every value has evidence; unmeasurable marked `[UNKNOWN]` | P | Phase 4 › GATE |
| 03-12 | Phase 5: list verified viewports; inspect desktop/tablet/mobile; suggested widths 1920, 1440, 1024, 768, 480, 360 | P+ | Phase 5 › DO; additive block adds a 390 reference width |
| 03-13 | Record navigation, grid, typography, images, repositioning, overflow, clipping, touch targets, orientation | P | Phase 5 › DO |
| 03-14 | Breakpoints only when observed between two tested widths; no fabricated exact breakpoint | P | Phase 5 › DO (restated in additive block, unchanged meaning) |
| 03-15 | DELIVER responsive-matrix and findings; GATE every page type at desktop/tablet/mobile or `[LIMITATION]`; STOP after Phase 5 | P | Phase 5 |

---

## 5. PART 04 — Technology (Phase 6) and Architecture (Phase 7)

| ID | Original rule or content | Status | Location in unified |
|---|---|---|---|
| 04-01 | Read PART 00, checkpoint, page records, design system, capability matrix; execute Phases 6–7 only | P+ | PART 04, opening; "Also read" line added |
| 04-02 | Fingerprint only from direct evidence (metadata, script/style URLs, globals if exposed, headers, cookies, service worker, manifest, source maps, network calls, errors, assets, CDN hints) | P | Phase 6 › DO |
| 04-03 | Coverage: frontend framework and rendering mode, libraries, CSS tooling, backend/API style, hosting/CDN, third parties | P | Phase 6 › DO |
| 04-04 | No claim of source code or internal infrastructure access; minified bundles not proof; versions only if exposed | P | Phase 6 › DO |
| 04-05 | DELIVER `technology-stack.md` (Name, Category, Purpose, Evidence IDs, Confidence, Class); also list technologies investigated but not confirmed | P+ | Phase 6 › DELIVER; additive block adds the `Reconstruction stack decision` section |
| 04-06 | GATE: no Confirmed without High-confidence direct evidence; no unsupported versions | P+ | Phase 6 › GATE; additional condition follows |
| 04-07 | Phase 7: reconstruct only the observable (layouts, components, navigation, API inventory, data dependencies, auth/session behavior, client storage, caching, build characteristics) | P | Phase 7 › DO |
| 04-08 | Separate directly observed facts from architectural hypotheses with reasoning, confidence, supporting evidence, confirm/refute path | P | Phase 7 › DO |
| 04-09 | Never claim access to source code, databases, server internals, or private systems | P | Phase 7 › DO |
| 04-10 | DELIVER architecture-report, component-map, data-flow (Mermaid where supported) | M | Phase 7 › DELIVER. Sentence extended with `api-dependency-map.md` and fragment |
| 04-11 | GATE: every hypothesis has observations and a confirmation/refutation path; every endpoint or contract evidenced or `[UNKNOWN]`; STOP after Phase 7 | P+ | Phase 7 › GATE; additional condition follows |

---

## 6. PART 05 — Quality (Phase 8), Passive Security (Phase 9), Conditional Modules (Phase 10)

| ID | Original rule or content | Status | Location in unified |
|---|---|---|---|
| 05-01 | Read PART 00 and listed deliverables; execute Phases 8–10 only | P+ | PART 05, opening; "Also read" line added |
| 05-02 | Performance: measure or report only what REA exposes; no estimated metrics | P | Phase 8 › Performance |
| 05-03 | SEO checks (titles, meta, headings, canonical, robots, Open Graph, structured data, alt text, hreflang, URL structure, status/redirects, no-JS content if establishable) | P | Phase 8 › SEO |
| 05-04 | Accessibility vs WCAG 2.2 AA as a reference (landmarks, forms, keyboard, focus, modals, ARIA, alternatives, contrast, motion, resize, touch targets) | P | Phase 8 › Accessibility |
| 05-05 | DELIVER three prioritized tables; findings follow PART 00 schema | M | Phase 8 › DELIVER. Sentence extended with graph linkage |
| 05-06 | GATE: every page type covered; unperformed checks marked | P | Phase 8 › GATE |
| 05-07 | Phase 9 scope: observation only; OWASP Top 10/ASVS mapping | P | Phase 9 › Scope |
| 05-08 | Phase 9 checks list (HTTPS, mixed content, TLS, security headers, CORS, cookie flags, client storage, SRI, third-party scripts, source maps, secrets redaction, API exposure signals, session flow, injection-prone patterns, cache-control, vulnerable libraries only if exposed) | P | Phase 9 › Checks |
| 05-09 | Forbidden: exploitation, payload injection, credential guessing, user enumeration, bypass, load testing, scanning, probing | P | Phase 9 › Forbidden |
| 05-10 | DELIVER `security-observations.md` and `not-tested-passive-only.md`; each check Checked / Not observable / Not applicable | M | Phase 9 › DELIVER. Sentence extended with graph linkage |
| 05-11 | GATE: every check has a status; findings have evidence, severity, confidence, OWASP mapping, remediation | P | Phase 9 › GATE |
| 05-12 | Phase 10: modules activate only if Phase 6 confirms technology with High/Medium confidence; otherwise `Not activated: no evidence` | P | Phase 10 |
| 05-13 | Module A framework audit with scorecard; source-dependent checks Not Verifiable | P+ | Phase 10 › Module A; optional "Framework adapters" block added after the module list |
| 05-14 | Modules B (Canvas/WebGL/media), C (E-commerce/payments, never submit payment data), D (PWA/offline), E (third-party integrations, exposed keys redacted and never used) | P | Phase 10 › Modules B–E |
| 05-15 | Use official documentation only if the user permits; no other tool to inspect the target; do not invent best-practice findings | P | Phase 10 |
| 05-16 | DELIVER `conditional-modules.md`; GATE explicit activation decision and evidence; STOP after Phase 10 | P+ | Phase 10; additional condition follows the gate |

---

## 7. PART 06 — Completeness (Phase 11) and Master Report (Phase 12)

| ID | Original rule or content | Status | Location in unified |
|---|---|---|---|
| 06-01 | Read PART 00, checkpoint and all previous deliverables; execute Phases 11 and 12 only; do not reconstruct | P+ | PART 06, opening; "Also read" line added |
| 06-02 | Phase 11 START: status, queue totals, ID ranges, limitations | P | Phase 11 › START |
| 06-03 | Coverage matrix: every URL × 8 dimensions with Yes / No / N-A / Blocked | P | Phase 11 › DO 1 |
| 06-04 | Every No: revisit with REA or convert to `[LIMITATION]` | P | Phase 11 › DO 2 |
| 06-05 | Re-scan navigation, footer, sitemap, scripts, API responses; drain queue again | P | Phase 11 › DO 3 |
| 06-06 | Re-verify at least 20% of findings including all Critical and High | P | Phase 11 › DO 4 |
| 06-07 | Reconcile contradictions across phases | P | Phase 11 › DO 5 |
| 06-08 | Check labels: no unlabeled statement, no technology without confidence, no finding without E-IDs | P | Phase 11 › DO 6 |
| 06-09 | Complete the final checklist in PART 00 and the original Appendix E requirements | P+ | Phase 11 › DO 7. Item 7a handles the unavailable originals with a labeled substitute (D10) |
| 06-10 | DELIVER coverage-matrix, claim-verification, contradictions-and-resolution, completion-checklist, updated tracking files | P+ | Phase 11 › DELIVER; three additive files listed |
| 06-11 | GATE: every URL Analyzed or Blocked with reason; every interactive element tested or explained; design system/stack/architecture/audits delivered; limitations documented; no unsupported claims; do not claim completion on failure | P+ | Phase 11 › GATE; two conditions added |
| 06-12 | Phase 12 only after Phase 11 passes; report sections 1–20 with traceability to evidence IDs and preserved artifacts | P+ | Phase 12; section 21 added after section 20 |
| 06-13 | FINAL AUDIT REVIEW STOP GATE: save report, stop, no Phase 13, no reconstruction directory | P+ | Phase 12 › FINAL AUDIT REVIEW. "IR freeze" subsection sits before it and runs only after Phase 11 passes |
| 06-14 | Present: completion status, technology and confidence, route coverage, major findings, limitations, recommended architecture, paths, Phase 11 gate | P+ | Phase 12 › FINAL AUDIT REVIEW; five bullets added |
| 06-15 | Wait for explicit written approval that clearly authorizes reconstruction; general praise is not approval | P | Phase 12 › FINAL AUDIT REVIEW |

---

## 8. PART 07 — Frontend-Only Reconstruction (Phase 13)

| ID | Original rule or content | Status | Location in unified |
|---|---|---|---|
| 07-01 | Permitted only after PART 06 complete, Phase 11 passed, and written user approval; do not infer approval | P | PART 07, opening paragraph |
| 07-02 | Primary objective: reconstruct the observable frontend, frontend only, no backend | P\* | Phase 13 › Primary objective |
| 07-03 | §1 Technology selection: use original stack by default; version only if evidenced; do not switch for convenience; stop and ask if not confident | P+ | Phase 13 › §1; sentence added after the stop-and-ask rule |
| 07-04 | §2 Workspace safety: audit directory untouched; reconstruct only in reconstruction directory; inspect workspace assets first; ask before dependencies; no server/API/database/auth service | P\* | Phase 13 › §2 |
| 07-05 | §3 Requirements: framework and tooling, routing/layouts, components and tokens, authorized assets, responsive and states, client interactions, auth UI | P+ | Phase 13 › §3; one bullet added for asset authorization status |
| 07-06 | §4 Page reconstruction: match layout, typography, colors, spacing; recreate components; transitions; responsive; no generic placeholders; labeled placeholder only if necessary | P | Phase 13 › §4 |
| 07-07 | §5 Do NOT implement a backend framework, Node backend, database servers or data-access layer, server auth, original APIs, payments, real patient data | M | Phase 13 › §5. Two framework-specific names removed per D7 (see Appendix A) |
| 07-08 | §5 Mock behavior: local mock data, fixtures, mock services; loading/success/empty/error states; simulated auth; isolated API boundaries; label simulated; no real patient data | P+ | Phase 13 › §5; one bullet added for IR-derived fixtures |
| 07-09 | §6 Authentication UI: recreate only observed screens (login/logout, recovery, authenticated layouts, role navigation, access-denied, policy controls, session expiry); local mock only | P | Phase 13 › §6 |
| 07-10 | §7 QA: run local build, fix errors, verify routes, test navigation/interactions/forms/responsive, compare screenshots against collected evidence, document differences | P+ | Phase 13 › §7; local-rendering rule added (D5) |
| 07-11 | §7 Do not use another browser or tool to revisit the original; original comparisons use already collected REA evidence unless a new REA inspection is authorized | P+ | Phase 13 › §7 |
| 07-12 | §8 Deliverables 1–12 | P+ | Phase 13 › §8; items 13–14 added |
| 07-13 | Final acceptance criteria (build succeeds, pages implemented or blocked, routes work, interactions, responsive, no backend, mock distinguished, audit untouched) | P+ | Phase 13 › Final acceptance criteria; two criteria added |
| 07-14 | Final report `reconstruction-report.md` with build status, route coverage, QA, limitations, run instructions | P\* | Phase 13 › Final report |

---

## 9. New capabilities and where they were added (nothing here replaces anything above)

| ID | New capability | Type | Tier | Added at | Source |
|---|---|---|---|---|---|
| N-01 | Project parameters (name, target, slug, directories, session aliases); removal of project-specific values | Parameterization | MVP | PART 00 › Project parameters; Parts 00–07 tokens | D7 |
| N-02 | REA definition and interpretation of the REA-only restriction; no assumed engine availability | Clarification | MVP | PART 00 › REA definition | D1 |
| N-03 | Skill architecture (Tool / Adapter / Skill / Skill Registry / Agent), descriptors, Fallback rule, extensibility | Architecture | MVP | PART 00 › Skill architecture; `REA-SCHEMAS.md` §2 | Conditions 2–4 |
| N-04 | Core Skill catalog with Phase 0 verification and Registry | Capability discovery | MVP | PART 01 › DO 8–10, 12; `REA-SCHEMAS.md` §2.2 | Spec §3, D1 |
| N-05 | Manual login handoff for test accounts; role aliases; no credentials or session data stored | Safety | MVP | PART 00 › Safety rules | D6 |
| N-06 | Exploration queue reason codes; unsafe-action recording; session column | Extension | MVP | PART 02 › Phase 1 | Spec §3.2 |
| N-07 | Framework-agnostic component-instance and runtime-UI capture | Extension | MVP | PART 02 › Phase 2 | Condition 1 |
| N-08 | Asset register with provenance and authorization status; PART 07 uses only Authorized assets | New deliverable | MVP | PART 02 › Phase 2; PART 07 §3 | D8 |
| N-09 | Interaction before/after states, `state-model.md` | Extension | MVP | PART 03 › Phase 3 | Spec §4 |
| N-10 | Authored versus computed style distinction | Extension | MVP | PART 03 › Phase 4 | Spec §3.3 |
| N-11 | 390 px reference viewport | Extension | MVP | PART 03 › Phase 5 | Spec §9 |
| N-12 | Framework-agnostic technology detection and `Reconstruction stack decision` with STACK-DECISION flag | Extension | MVP | PART 04 › Phase 6 | D3 |
| N-13 | API dependency map | New deliverable | MVP | PART 04 › Phase 7 | Spec §3.5 |
| N-14 | Findings linked to graph nodes | Extension | MVP | PART 05 › Phases 8–9 | Spec §4 |
| N-15 | Optional framework adapters, including React adapter A-R | Adapter | Tier 2 | PART 05 › Phase 10 | D11 |
| N-16 | Graph integrity checks, graph coverage matrix, Registry limitation review | Extension | MVP | PART 06 › Phase 11 items 8–11 | Spec §5.3 |
| N-17 | Substitute checklist when original Appendix E is unavailable | Safeguard | MVP | PART 06 › Phase 11 item 7a; `SUBSTITUTE-CHECKLIST.md` | D10 |
| N-18 | Application Intelligence Graph (schema, fragments, evidence links) | New contract | MVP | PART 00 › Graph & IR contract; `REA-SCHEMAS.md` §3 | Spec §4, D4 |
| N-19 | IR freeze, `ir.json`, `ir-summary.md`, `ir-derivation-log.md` | New contract | MVP | PART 06 › IR freeze; `REA-SCHEMAS.md` §5 | Spec §7, D4 |
| N-20 | IR input contract for PART 07; IR-derived fixtures and tests; traceability matrix | Handoff | MVP | PART 07 › Input contract, §5, §7, §8 | Spec §8 |
| N-21 | Local rendering via REA only when the Skill is Supported; otherwise `[LIMITATION]` and no claimed comparison | Safeguard | MVP | PART 07 › §7 | D5 |
| N-22 | Evidence label mapping to PART 00 contract | Mapping | MVP | `REA-SCHEMAS.md` §4 | Spec §4.3, condition 5 |

### Explicitly deferred (not in the MVP)

| Capability | Status |
|---|---|
| DOM mutation observation, Shadow DOM, request-to-interaction association, isolated multi-session contexts | Defined as Tier 2 Skills. Optional. No gate depends on them |
| React adapter | Defined as an optional adapter. Not required for any phase |
| Other framework adapters | Extension point only |
| SQLite storage, offline parsers (Acorn, Babel, PostCSS), image-diff tooling, new dependencies | Deferred. Not added (D4, D9) |
| Optional validation partition that re-inspects the original through REA | Not defined (D5, D12). Needs explicit user authorization |
| Session replay, vanilla/React output generators in PART 07 | Not defined. Technology follows Phase 6 evidence |

---

## 10. Traceability to your decisions and architectural conditions

| Decision / condition | Implemented as |
|---|---|
| D1 REA definition, no assumed Playwright/CDP | N-02, N-04; PART 00 › REA definition; PART 01 › DO 8 |
| D2 Part/Phase naming | Used throughout: Part 00–07 and Phase 0–13 |
| D3 Technology from original evidence, no convenience choice | N-12; PART 07 §1 sentence |
| D4 Markdown as truth, JSON derived, no SQLite | PART 00 › Graph & IR contract rules 2, 5, 9; `REA-SCHEMAS.md` §3.1, §5.3 |
| D5 Local screenshots only through REA, else `[LIMITATION]` | N-21; Skill `render.local`; PART 07 §7 |
| D6 Test accounts, manual login, role aliases, no sensitive data | N-05; PART 00 › Safety rules |
| D7 Generalize project-specific values | N-01; two lines changed in PART 07 §5 |
| D8 Asset provenance and authorization | N-08 |
| D9 Defer analyzers; no installs | Section 9 "Explicitly deferred"; no new tools referenced |
| D10 Substitute checklist, clearly labeled | N-17 |
| D11 React adapter optional | N-15; Condition 1 satisfied by N-07 and the Skill architecture rule 6 |
| D12 MVP first | Tier column; Tier 2 never gates |
| D13 English prompt | All Part files in English |
| Condition 1 Framework-agnostic | N-07, N-12, Skill architecture rule 6, IR rule 4 |
| Condition 2 Tool/Adapter/Skill/Registry/Agent separation | N-03 |
| Condition 3 Extensible, provider-independent | Skill architecture rule 5; `REA-SCHEMAS.md` §7 |
| Condition 4 Descriptor and Fallback per Skill | `REA-SCHEMAS.md` §2.1–2.2 |
| Condition 5 Observed vs inferred | PART 00 › Graph & IR contract rule 4; `REA-SCHEMAS.md` §3.3 and §4 |
| Condition 6 No gate, safety rule, checklist, or deliverable removed | Sections 1–8 above, plus Appendix A |
| Condition 7 PART 07 only after PART 06 and written approval | 00-29, 06-15, 07-01 (all P) |

---

## Appendix A — Automated verification of verbatim preservation

Method: each original partition file was compared line by line, in order (longest-common-subsequence diff), against its unified counterpart. The only normalization applied to the original before comparing was the approved parameterization (D7): the target URL, the audit and reconstruction directory paths, and the project name were replaced by `{{TARGET_URL}}`, `{{AUDIT_DIR}}`, `{{RECON_DIR}}`, and `{{PROJECT_NAME}}`.

| File | Original non-blank lines | Preserved verbatim, same order | Lines changed |
|---|---|---|---|
| PART-00-MASTER-CONTROL.md | 121 | 121 | 0 |
| PART-01-PREFLIGHT.md | 61 | 61 | 0 |
| PART-02-DISCOVERY-AND-PAGE-INSPECTION.md | 59 | 58 | 1 |
| PART-03-INTERACTIONS-DESIGN-RESPONSIVE.md | 67 | 64 | 3 |
| PART-04-TECHNOLOGY-ARCHITECTURE.md | 52 | 51 | 1 |
| PART-05-QUALITY-SECURITY.md | 85 | 83 | 2 |
| PART-06-COMPLETENESS-AND-MASTER-REPORT.md | 65 | 65 | 0 |
| PART-07-FRONTEND-RECONSTRUCTION.md | 100 | 97 | 3 |
| **Total** | **610** | **600** | **10** |

### Lines whose text changed (complete list)

Every other original line exists unchanged and in the original order. Changes fall into three approved categories: (D7) removal of technology assumptions, (E) additive column extension of an original schema line with the original text kept as a prefix, and (S) a sentence extended in place with the original sentence kept first.

**1. PART-02**

Original:
```text
`URL | Title | Type | Purpose/Audience | Discovered via | Status code | Layout order | Components | Content structure | Resources loaded | Interactions tested | Responsive notes | Tech evidence | Findings (F-IDs) | Limitations`
```
Unified:
```text
`URL | Title | Type | Purpose/Audience | Discovered via | Status code | Layout order | Components | Content structure | Resources loaded | Interactions tested | Responsive notes | Tech evidence | Findings (F-IDs) | Limitations | Session | Graph refs`
```

**2. PART-03**

Original:
```text
`Page | Element | Action | Expected behavior (label as inferred if not directly specified) | Actual behavior | State | Evidence | Untested reason`
```
Unified:
```text
`Page | Element | Action | Expected behavior (label as inferred if not directly specified) | Actual behavior | State | Evidence | Untested reason | Before state | After state | Network triggered | Session`
```

**3. PART-03**

Original:
```text
Save `interaction-matrix.md`, `functionality-map.md`, and `user-journeys.md`.
```
Unified:
```text
Save `interaction-matrix.md`, `functionality-map.md`, and `user-journeys.md`. Also save `state-model.md` and graph fragment `phase-03.jsonl`.
```

**4. PART-03**

Original:
```text
Save `design-system.md` and `component-inventory.md`. For each token, include value, pages/components, evidence IDs, and confidence. For each component include variants, states, usage count only if actually counted, and page references.
```
Unified:
```text
Save `design-system.md` and `component-inventory.md`. For each token, include value, pages/components, evidence IDs, and confidence. For each component include variants, states, usage count only if actually counted, and page references. Also write graph fragment `phase-04.jsonl`.
```

**5. PART-04**

Original:
```text
Save `architecture-report.md`, `component-map.md`, and `data-flow.md` (Mermaid where supported).
```
Unified:
```text
Save `architecture-report.md`, `component-map.md`, and `data-flow.md` (Mermaid where supported). Also save `api-dependency-map.md` and graph fragment `phase-07.jsonl`.
```

**6. PART-05**

Original:
```text
Save three prioritized tables: `performance-audit.md`, `seo-audit.md`, `accessibility-audit.md`. Each finding follows PART 00's finding schema and cites evidence.
```
Unified:
```text
Save three prioritized tables: `performance-audit.md`, `seo-audit.md`, `accessibility-audit.md`. Each finding follows PART 00's finding schema and cites evidence. Link each F-ID to the graph node IDs it affects in `graph/fragments/phase-08-09.jsonl`. Findings annotate nodes; they are not structural nodes.
```

**7. PART-05**

Original:
```text
Save `security-observations.md` and a `not-tested-passive-only.md` list. Each check must be Checked / Not observable / Not applicable, with evidence or reason.
```
Unified:
```text
Save `security-observations.md` and a `not-tested-passive-only.md` list. Each check must be Checked / Not observable / Not applicable, with evidence or reason. Link Phase 9 findings to graph nodes in the same way.
```

**8. PART-07**

Original:
```text
Use the original stack by default. Do not switch frameworks for convenience. If the original technology cannot be determined confidently, stop and ask the user before choosing an alternative.
```
Unified:
```text
Use the original stack by default. Do not switch frameworks for convenience. If the original technology cannot be determined confidently, stop and ask the user before choosing an alternative. Evidence comes from Phase 6 and the STACK-DECISION flag. Do not choose any framework (including vanilla HTML/CSS/JavaScript or React) because it is easier to implement.
```

**9. PART-07**

Original:
```text
- ASP.NET Core or any backend framework
```
Unified:
```text
- any backend framework
```

**10. PART-07**

Original:
```text
- database servers or Entity Framework
```
Unified:
```text
- database servers or ORM/data-access layers
```

