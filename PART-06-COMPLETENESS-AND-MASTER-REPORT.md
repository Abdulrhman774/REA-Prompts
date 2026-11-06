# PART 06 — COMPLETENESS VERIFICATION & FINAL MASTER REPORT
Read PART 00 and the latest checkpoint plus all previous deliverables. Execute Phases 11 and 12 only. Do not reconstruct.

Also read `REA-SCHEMAS.md`, `{{AUDIT_DIR}}skill-registry.md`, and the latest graph fragments in `{{AUDIT_DIR}}graph/fragments/`. Resolve all `{{VARIABLES}}` per PART 00 (Project parameters).

## Phase 11 — Completeness Verification (Mandatory)

### START
List the current phase status, URL queue totals, evidence/finding ID ranges, and known limitations.

### DO
1. Build a Coverage Matrix: every URL x [Discovered, Visited, Analyzed, Interactions tested, Responsive checked, Technical evidence collected, Quality checked, Security observed]. Each cell: Yes / No / N-A / Blocked.
2. For every No: revisit and complete using REA, or convert to `[LIMITATION]` with exact reason.
3. Re-scan navigation, footer, sitemap, scripts and API responses for undiscovered in-scope URLs only where REA exposes them. Drain the queue again.
4. Re-verify at least 20% of findings, including all Critical and High findings. Fix or remove unsupported claims.
5. Check contradictions across phases and reconcile them.
6. Check labels: no unlabeled statement; no technology without confidence; no finding without evidence IDs.
7. Complete the final checklist in PART 00 and the original Appendix E requirements.
7a. If the original Appendix E or a final checklist in PART 00 is not available in the workspace, do not invent it and do not attribute any requirement to the original. Generate `completion-checklist-substitute.md` headed `SUBSTITUTE CHECKLIST — NOT THE ORIGINAL APPENDIX E`, starting from `SUBSTITUTE-CHECKLIST.md` if supplied, built only from requirements present in the supplied Parts, each item citing its Part/Phase source. Record the missing-original gap in `contradictions-and-resolution.md` and in report section 19.
8. Graph integrity: no node or edge without an E-ID; no orphan node except UNKNOWN placeholders; every Route node matches a queue record; every Interaction node matches an interaction-matrix row; every API node matches an `api-dependency-map.md` entry; labels and confidences conform to PART 00; no secret or personal data in any fragment. Save `graph-integrity-report.md`.
9. Graph coverage matrix: every Route, Component, State, Interaction, API, and Asset × [Observed, Evidence cited, Tested, Responsive checked, Authorization status known] with Yes / No / N-A / Blocked, plus coverage by session alias. Each No is revisited with REA or converted to `[LIMITATION]` with the exact reason. Save `graph-coverage-matrix.md`.
10. Reconcile markdown against the Graph. Markdown wins. Correct the Graph through superseding records and log each correction.
11. Skill Registry review: every Skill that was Not supported or Not verified and affected a deliverable is recorded as `[LIMITATION]` with the affected phase and deliverable.

### DELIVER
Save:
- `coverage-matrix.md`
- `claim-verification.md`
- `contradictions-and-resolution.md`
- `completion-checklist.md`
- updated evidence ledger, findings, progress log, checkpoint
- `completion-checklist-substitute.md` (only if the originals are unavailable)
- `graph-integrity-report.md`
- `graph-coverage-matrix.md`

### GATE
Investigation is complete only if:
- every discovered URL is Analyzed or Blocked with a reason
- every interactive element is tested or explained
- design system, stack, architecture, and audits are delivered
- all limitations are documented
- claim audit leaves no unsupported claims
- graph integrity checks pass and the graph coverage matrix has no unexplained `No`
- every Skill gap that affected a deliverable is recorded as `[LIMITATION]`

If any condition fails, state what remains and continue safe investigation where possible. Do not claim completion.

## Phase 12 — Final Master Report

Only after Phase 11 passes, create a consolidated report in `{{AUDIT_DIR}}` containing:

1. Executive Summary: scope, method, top 10 findings by severity, overall risk picture, coverage percentage (only if calculated from actual matrix)
2. Sitemap
3. Page-by-Page Analysis
4. UI Component Inventory
5. Design System
6. Responsive Documentation
7. Technology Stack
8. Frontend Architecture
9. Backend & API Observations
10. Functionality Map & User Journeys
11. Performance Observations
12. SEO Audit
13. Accessibility Audit
14. Security Observations
15. Conditional Module Results
16. Architecture Reconstruction (facts vs hypotheses)
17. Issues & Weaknesses (all findings sorted by severity)
18. Prioritized Remediation Roadmap (Now / Next / Later, effort and impact; effort must be labeled as estimate)
19. Investigation Coverage & Limitations, including what source-code or authenticated review would add
20. Appendices: capability matrix, evidence ledger, coverage matrix, progress log, page records
21. Application Graph & IR Summary (additive): counts by label and confidence, STACK-DECISION flag, asset authorization summary, Skill Registry status with limitations, graph integrity and coverage results

Use tables where useful. Every factual row traces to evidence IDs. Preserve original artifacts and appendices.

### IR freeze (additive — only after the Phase 11 gate passes)
1. Compile `application-graph.json` from the fragments, resolving superseded records.
2. Derive `ir.json` per `REA-SCHEMAS.md` §5 and write `ir-summary.md` (counts by label and confidence, UNKNOWN and LIMITATION lists, STACK-DECISION flag, asset authorization summary).
3. Write `ir-derivation-log.md`: for each IR section, the markdown deliverables it was derived from, plus the consistency check result. On a discrepancy, markdown wins and the IR is corrected.
4. Re-run the graph integrity checks on the frozen Graph. If any check fails, do not freeze; report the failure.
5. Frozen files are read-only for later Parts. Any change after approval requires a new checkpoint and notice to the user.
If the Phase 11 gate did not pass, do not produce `ir.json`.

### FINAL AUDIT REVIEW — STOP GATE
After saving the report, STOP. Do not begin Phase 13 or create `{{RECON_DIR}}`.

Present:
- Investigation completion status
- Discovered frontend technology and confidence
- Route coverage
- Major findings
- Outstanding limitations
- Recommended reconstruction architecture
- Exact paths to all reports and evidence
- Whether the Phase 11 gate passed
- IR freeze status and exact paths (`application-graph.json`, `ir.json`, `ir-summary.md`, `ir-derivation-log.md`)
- The STACK-DECISION flag and the evidence behind it
- Skill Registry limitations that affect reconstruction or QA, including whether the Skill for opening a local project and capturing screenshots is Supported
- Asset authorization summary, listing the assets that need the user's written approval before reuse
- Whether a substitute checklist was used because the original Appendix E was unavailable

Wait for the user's explicit written approval before PART 07. Approval must clearly authorize frontend reconstruction. Do not interpret general praise or an ambiguous response as approval.

### STOP
No reconstruction in this partition.
