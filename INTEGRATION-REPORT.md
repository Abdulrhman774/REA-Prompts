# REA Unified Prompt — Integration Report

**Scope of this report:** documents how the original REA Prompt (PART 00–07) and the Web Application Reverse Engineering specification were merged, under the approved decisions D1–D13 and the seven architectural conditions.
**Nothing was executed against any target, no tool was installed in your project, and no project file was changed.** All output is documentation and prompt text in this folder. (For transparency: a Python package was installed inside my own sandbox only to open the `.7z` you supplied.)

---

## 1. Package contents

| File | Role |
|---|---|
| `PART-00-MASTER-CONTROL.md` … `PART-07-FRONTEND-RECONSTRUCTION.md` | The unified Prompt. Same eight files and names as the original. Run them one partition at a time, exactly as before |
| `REA-SCHEMAS.md` | Shared reference: Skill descriptor and catalog, Graph schema, evidence-label mapping, IR schema |
| `CAPABILITY-PRESERVATION-MATRIX.md` | Every original rule, phase, deliverable, gate, and safety condition mapped to its place in the unified Prompt, with an automated verbatim-preservation check |
| `SUBSTITUTE-CHECKLIST.md` | Clearly labeled substitute for the missing Appendix E / final checklist (D10) |
| `INTEGRATION-REPORT.md` | This file |

**How to start a project:** supply the required parameters defined in PART 00 › Project parameters (`PROJECT_NAME`, `TARGET_URL`, `PROJECT_SLUG`; optionally the directories and `SESSION_ALIASES`), then run PART 00 + PART 01, and continue partition by partition. The stop points and the written-approval gate before PART 07 are unchanged.

**To reproduce the original Healthbook run:** `PROJECT_NAME` = Healthbook, `TARGET_URL` = `https://healthbook.hclhealthcare.in/`, `PROJECT_SLUG` = healthbook. The default directories then resolve to `./audit-healthbook/` and `./reconstructed-healthbook/`, the original paths.

---

## 2. Verification result

| Check | Result |
|---|---|
| Original non-blank lines compared in order | 610 |
| Preserved verbatim, same order (after approved parameter tokens) | **600** |
| Lines whose text changed | **10**, all listed in Appendix A of the matrix |
| Breakdown of the 10 | 2 technology-assumption removals (D7); 2 schema lines extended with extra columns, original text kept as prefix; 6 sentences extended in place, original sentence kept first |
| Removed lines | **0** |
| Reordered lines | **0** |
| Residual project-specific strings (`Healthbook`, `hclhealthcare`, `ASP.NET`, `Entity Framework`) in the unified files | **0** (checked by the build) |

Scope of the check: it proves the original text survives and is unreordered. It does not prove that the new text behaves well when executed by an agent. Only a trial run can show that.

---

## 3. Architecture added

```
                 ┌────────────────────────── Agent (REA) ──────────────────────────┐
                 │ plans, selects Skills from the Registry, runs phases, enforces   │
                 │ gates, safety rules, evidence contract (PART 00, unchanged)      │
                 └───────────────┬────────────────────────────────┬─────────────────┘
                                 │ uses                           │ writes
                        ┌────────▼─────────┐              ┌───────▼────────────────┐
                        │  Skill Registry  │              │ Evidence + Findings    │
                        │ (Phase 0, from   │              │ (E-IDs, F-IDs)         │
                        │  REA docs only)  │              └───────┬────────────────┘
                        └────────┬─────────┘                      │ cited by
                                 │ provider-neutral Skills         │
                        ┌────────▼─────────┐              ┌───────▼────────────────┐
                        │     Adapters     │              │ Graph fragments (JSONL)│
                        │ (per provider /  │              │ Phases 0–10, append-   │
                        │  framework)      │              │ only, evidence-linked  │
                        └────────┬─────────┘              └───────┬────────────────┘
                                 │ expose                          │ Phase 11 verify, Phase 12 freeze
                        ┌────────▼─────────┐              ┌───────▼────────────────┐
                        │  Tools / engines │              │ application-graph.json │
                        │ (internal to REA)│              │ ir.json (derived)      │
                        └──────────────────┘              └───────┬────────────────┘
                                                                  │ read after written approval
                                                          ┌───────▼────────────────┐
                                                          │ PART 07 reconstruction │
                                                          └────────────────────────┘
```

Key properties:
- **Markdown stays the source of truth.** Graph and IR are derived. On conflict, markdown wins.
- **Framework-agnostic from the base.** Components, interactions, and states are discovered from DOM, styles, interactions, screenshots, and the network log. React inspection is one optional Tier 2 adapter. If it is absent, nothing else changes.
- **Provider-independent.** Parts reference Skills by capability. Adding a new tool means adding an Adapter and descriptors to the Registry, not editing a phase.
- **Fallback is always inside REA.** A lower-fidelity Skill or `[LIMITATION]`. Never an external tool, another agent, or a silent switch.

---

## 4. Phase integration map

| Part / Phase | What was added (additive only) | New deliverables |
|---|---|---|
| PART 00 | Project parameters; REA definition and interpretation rule; Skill architecture; manual login handoff; sensitive-data rule extension; optional evidence fields `Session`, `Skill`; Graph & IR contract | none |
| PART 01 / Phase 0 | Extended capability discovery; Skill Registry; Graph workspace and APPLICATION node; session plan; Skill-to-Phase map | `skill-registry.md`, `graph/fragments/phase-00.jsonl` |
| PART 02 / Phase 1 | Queue reason codes and session column; unsafe-action recording; Route nodes | `phase-01.jsonl` |
| PART 02 / Phase 2 | Framework-agnostic component-instance and runtime-UI capture; asset register with authorization; Page Record columns | `asset-register.md`, `phase-02.jsonl` |
| PART 03 / Phase 3 | Before/after states; network linkage where exposed; state model; User Flows | `state-model.md`, `phase-03.jsonl` |
| PART 03 / Phase 4 | Authored vs computed distinction; token and variant nodes | `phase-04.jsonl` |
| PART 03 / Phase 5 | 390 px reference width; viewport variants on nodes | `phase-05.jsonl` |
| PART 04 / Phase 6 | Framework-agnostic detection; `Reconstruction stack decision` and STACK-DECISION flag; Technology nodes | `phase-06.jsonl` |
| PART 04 / Phase 7 | API dependency map; component definitions; layout and API nodes and edges | `api-dependency-map.md`, `phase-07.jsonl` |
| PART 05 / Phases 8–9 | Findings linked to graph nodes | `phase-08-09.jsonl` |
| PART 05 / Phase 10 | Optional framework adapters (React adapter A-R as Tier 2) | none |
| PART 06 / Phase 11 | Graph integrity, graph coverage, Registry limitation review; substitute checklist step | `graph-integrity-report.md`, `graph-coverage-matrix.md`, `completion-checklist-substitute.md` (if needed) |
| PART 06 / Phase 12 | IR freeze; report section 21; extra items in the Final Audit Review | `application-graph.json`, `ir.json`, `ir-summary.md`, `ir-derivation-log.md` |
| PART 07 / Phase 13 | IR input contract; asset authorization rule; IR-derived fixtures and tests; local-render rule; traceability | `ir-traceability.md` |

---

## 5. MVP vs future

**In the MVP (written into the Prompt as required behavior):** parameterization; REA clarification; Skill architecture and Registry; manual login handoff; queue reason codes; framework-agnostic component and runtime capture; asset register; state model; stack decision; API dependency map; Graph fragments and integrity/coverage checks; IR freeze; PART 07 input contract, mock derivation, and traceability.

**Tier 2 (defined, optional, never gating):** Shadow DOM, DOM-mutation observation, request-initiator association, isolated multi-session contexts, the React adapter. Their absence reduces detail, not validity.

**Not defined (deferred by your decisions):** SQLite, offline parsers (Acorn, Babel, PostCSS), image-diff tools, any new dependency, a second validation partition that re-inspects the original, session replay, alternative output generators.

---

## 6. Gaps, assumptions, and points that need your attention

| # | Item | How it was handled |
|---|---|---|
| 1 | **Appendix E and "final checklist in PART 00" are missing** from the supplied files (PART 06 refers to both) | Phase 11 step 7 is preserved verbatim. Step 7a adds a rule for the unavailable originals. `SUBSTITUTE-CHECKLIST.md` is labeled as a substitute, built only from requirements present in the Parts, each with its source. Please send the originals if they exist |
| 2 | `ALLOWED_SCOPE` was used in PART 02 but never defined | Defined in PART 00 › Project parameters as the existing "Allowed scope" statement of the Mission. No new scope was invented |
| 3 | The original forbids Playwright/CDP outright, while D1 lets REA use internal engines | Resolved by the interpretation rule in PART 00. Nothing is assumed available. Availability must be proven from REA's documentation in Phase 0, and doubt means treat as not part of REA and ask you. I cannot verify from here what REA's documentation says, so this stays open until Phase 0 runs |
| 4 | **PART 07 QA needs local rendering and screenshots**, which the original never says how to obtain | Per D5, only through REA and only if the `render.local` Skill is Supported. If not, `[LIMITATION]`, and the Prompt forbids claiming any visual comparison. Your original acceptance items on responsive checks and screenshot comparison may therefore end as documented limitations. That outcome is correct under your rule, but you should expect it |
| 5 | Wording "patient" in the original safety rules and PART 07 | Kept unchanged (it is a safety rule). A new bullet extends the protection to all real personal or sensitive data |
| 6 | The specification's Stagehand, Playwright, pixelmatch, Sharp, parse5/Cheerio, SQLite, TypeScript stack | Not adopted as named tools. The specification's capabilities were recast as provider-neutral Skills. Anything REA cannot do through its own documented operations is a `[LIMITATION]` |
| 7 | The specification's eight queue statuses | Mapped onto the original four states plus reason codes, to avoid altering Phase 1 |
| 8 | The specification's confidence terms | Mapped onto the original labels and confidence scale (`REA-SCHEMAS.md` §4). No second taxonomy exists |
| 9 | The specification's "vanilla HTML/CSS/JS first" | Not adopted. PART 07 follows Phase 6 evidence and the STACK-DECISION flag (D3) |
| 10 | The original Healthbook-specific ASP.NET and Entity Framework lines | The only two removals (D7). If the analysis of a specific target proves such a stack, it belongs in that project's evidence, not in the general rules |
| 11 | Model-behavior risk | The additive blocks add steps and files per phase. A first trial on a small target is the right way to test whether an agent follows them without drifting. I recommend that trial before any large target |

---

## 7. Decisions D1–D13 and conditions: where each is satisfied

See `CAPABILITY-PRESERVATION-MATRIX.md`, section 10, for the complete cross-reference.

---

## 8. Suggested next step

Run a dry trial on a small, public, low-risk site with PART 00 + PART 01 only. It will confirm what REA's documentation really supports (the Registry), which settles items 3 and 4 above before any large investigation.
