# SUBSTITUTE CHECKLIST — NOT THE ORIGINAL APPENDIX E

**Status of this document:** substitute, not original.

PART 06 (Phase 11, step 7) refers to "the final checklist in PART 00 and the original Appendix E requirements". Neither exists in the supplied partitions (`PART-00` to `PART-07`). PART 00 contains no explicit final checklist, and no Appendix E was supplied.

This list was built **only** from requirements that actually appear in the supplied Parts. Each item cites its source. It does not contain any requirement from the missing originals, and no item here may be described as an Appendix E requirement. Items marked **(additive)** come from the additive blocks of the unified Prompt, not from the original.

If the original Appendix E or final checklist is later supplied, use it in addition to this list and record any difference in `contradictions-and-resolution.md`.

---

## A. Contract (PART 00)
- [ ] Every statement carries exactly one label: OBSERVED / INFERRED / UNKNOWN / LIMITATION. — PART 00, Evidence and finding contract
- [ ] Every factual claim cites evidence IDs; otherwise it is `[UNKNOWN]`. — PART 00
- [ ] Every technology, architecture, and vulnerability claim has a confidence (High / Medium / Low). — PART 00; PART 06 Phase 11 step 6
- [ ] No invented version, endpoint, header, metric, selector, path, library name, or measurement. — PART 00
- [ ] Every finding has ID, title, category, label, confidence, severity, evidence, URLs, impact, recommendation. — PART 00
- [ ] No vague claims remain ("modern", "clean", "fast", "secure"…). — PART 00
- [ ] Every operation REA could not perform is marked `[LIMITATION]` with the affected phase and deliverable; no silent tool substitution; no unsupported inspection claimed. — PART 00, Absolute tool restriction
- [ ] Safety rules were respected: observe-only, in-scope, test credentials only, no real or sensitive data, destructive flows stopped at the last safe step, low request volume. — PART 00, Safety rules
- [ ] Secrets found are recorded by location and type only, with values redacted. — PART 00
- [ ] `progress-log.md`, `url-queue`, `evidence-ledger.md`, `findings.md`, `capability-matrix.md`, `checkpoint.md` exist and are current. — PART 00, Persistence
- [ ] A checkpoint was saved after every phase and about every ten pages; no incomplete work is marked complete. — PART 00
- [ ] Prior evidence and original artifacts were not overwritten. — PART 00
- [ ] No partition ran without being explicitly supplied; no reconstruction file exists without written approval. — PART 00, Partition protocol

## B. Phase 0 gate (PART 01)
- [ ] Relevant REA capabilities are documented with evidence or marked Not verified. — PART 01 Gate
- [ ] No later operation relies on an unverified capability. — PART 01 Gate
- [ ] The target baseline was recorded to the extent REA exposes it. — PART 01 Gate
- [ ] Workspace tracking files exist. — PART 01 Gate

## C. Phases 1–2 gates (PART 02)
- [ ] The queue is empty or every remaining URL is Blocked with a specific reason. — Phase 1 Gate
- [ ] All discoverable navigation areas were enumerated, including mobile navigation where supported. — Phase 1 Gate
- [ ] Every Visited page has a Page Record. — Phase 2 Gate
- [ ] Every Blocked page has a reason. — Phase 2 Gate
- [ ] No discovered in-scope page was silently skipped. — Phase 2 Gate

## D. Phases 3–5 gates (PART 03)
- [ ] Every interactive element is tested or listed as untested with a specific reason. — Phase 3 Gate
- [ ] Every asserted design value has evidence; unmeasurable values are `[UNKNOWN]`. — Phase 4 Gate
- [ ] Every page type was checked at desktop, tablet, and mobile, or the missing viewport is recorded as `[LIMITATION]`. — Phase 5 Gate

## E. Phases 6–7 gates (PART 04)
- [ ] No technology is Confirmed without High-confidence direct evidence. — Phase 6 Gate
- [ ] No unsupported version claim. — Phase 6 Gate
- [ ] Every hypothesis lists supporting observations and a confirmation/refutation path. — Phase 7 Gate
- [ ] Every endpoint or contract is directly evidenced or marked `[UNKNOWN]`. — Phase 7 Gate

## F. Phases 8–10 gates (PART 05)
- [ ] Every page type is covered by the performance, SEO, and accessibility audits; unperformed checks are `[LIMITATION]`, `[UNKNOWN]`, or Not applicable with reasons. — Phase 8 Gate
- [ ] Every passive security check has a status (Checked / Not observable / Not applicable) with evidence or reason. — Phase 9 Gate
- [ ] Every security finding has evidence, severity, confidence, OWASP mapping where applicable, and remediation. — Phase 9 Gate
- [ ] Every conditional module has an explicit activation decision with evidence. — Phase 10 Gate

## G. Phase 11 gate (PART 06)
- [ ] Every discovered URL is Analyzed or Blocked with a reason. — Phase 11 Gate
- [ ] Every interactive element is tested or explained. — Phase 11 Gate
- [ ] Design system, stack, architecture, and audits are delivered. — Phase 11 Gate
- [ ] All limitations are documented. — Phase 11 Gate
- [ ] The claim audit leaves no unsupported claims; at least 20% of findings were re-verified, including all Critical and High. — Phase 11 Gate and step 4
- [ ] Contradictions across phases were reconciled. — Phase 11 step 5
- [ ] Completion was not claimed if any condition failed. — Phase 11 Gate

## H. Phase 12 report and stop gate (PART 06)
- [ ] The master report contains all 20 required sections; each factual row traces to evidence IDs. — Phase 12
- [ ] Coverage percentage appears only if calculated from the actual coverage matrix. — Phase 12 section 1
- [ ] Remediation effort is labeled as an estimate. — Phase 12 section 18
- [ ] The Final Audit Review was presented and the process stopped; no Phase 13 work and no reconstruction directory exists. — Phase 12 Final Audit Review
- [ ] Explicit written approval for reconstruction was received before PART 07. — Phase 12 Final Audit Review

## I. Additive conditions (unified Prompt only)
- [ ] **(additive)** `skill-registry.md` exists; each Skill has a status with evidence and a Fallback. — PART 01 Gate
- [ ] **(additive)** Every graph node and edge cites an E-ID; no secret or personal data in any fragment. — PART 00 Graph & IR contract
- [ ] **(additive)** Graph integrity and graph coverage reports exist and have no unexplained failure. — PART 06 Phase 11 steps 8–9
- [ ] **(additive)** `ir.json` was frozen only after the Phase 11 gate passed, and markdown and IR agree. — PART 06 IR freeze
- [ ] **(additive)** The STACK-DECISION flag is justified by evidence. — PART 04 Phase 6
- [ ] **(additive)** Every asset has provenance and an authorization status; unapproved assets are not used. — PART 02 Phase 2; PART 07 §3

## J. Final acceptance (PART 07) — only after approval
- [ ] The frontend build succeeds. — Phase 13 Final acceptance
- [ ] Every sufficiently documented page is implemented or has an explicit documented blocker. — Phase 13
- [ ] Implemented routes work locally. — Phase 13
- [ ] Major interactions behave as documented. — Phase 13
- [ ] Responsive behavior was checked (or recorded as a limitation if local rendering is unavailable). — Phase 13; §7
- [ ] No backend implementation exists. — Phase 13
- [ ] All mock functionality is clearly distinguished from real backend behavior. — Phase 13
- [ ] Audit artifacts remain untouched. — Phase 13
- [ ] `reconstruction-report.md` exists with build status, route coverage, QA results, limitations, and run instructions. — Phase 13 Final report
- [ ] **(additive)** Every IR node is traced in `ir-traceability.md`; no visual comparison is claimed unless actually performed. — PART 07 §8 and acceptance criteria
