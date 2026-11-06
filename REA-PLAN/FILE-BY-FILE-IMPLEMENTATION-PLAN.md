# REA PLAN — FILE-BY-FILE IMPLEMENTATION PLAN
**Stage One | Generated:** 2026-11-06  
**Status:** PLAN — Awaiting user approval before any Stage Two work begins.

---

## Overview

This plan lists every file that Stage Two will create or modify, organized by directory. Files are listed in dependency order. No original source file is modified.

**Total new files:** 46  
**Modified original files:** 0  
**Additive-only new versions of original files (in REA-FINAL/):** 11

---

## Directory: REA-FINAL/

### REA-FINAL/REA-MASTER-PROMPT.md [NEW]
**Purpose:** Standalone session entry point; replaces the need to manually load all Parts  
**Content:** Self-contained REA session initialization; variable resolution; documentation loading instructions; Skill discovery; capability verification; phase coordination; approval gate enforcement  
**Dependencies:** Derives from PART-00 through PART-07 content  
**Complexity:** HIGH — most complex single file  
**Estimated size:** ~200 lines

---

### REA-FINAL/parts/ [8 files — additive versions]

Each file is a new version of the corresponding original, with the approved additive changes applied. The original files are untouched.

#### REA-FINAL/parts/PART-00-MASTER-CONTROL.md [ADDITIVE]
**Changes from original:**
- Add: Optional external provider policy (formalize what PART-00 implies)
- Add: Antigravity execution boundaries (which operations REA performs vs. which need explicit workflow)
- Add: Feasibility vocabulary definition (FEASIBLE/PARTIALLY FEASIBLE/NOT FEASIBLE/UNKNOWN)
- Add: Component origin vocabulary (server/client/unknown)
- No removal of existing text

#### REA-FINAL/parts/PART-01-PREFLIGHT.md [ADDITIVE]
**Changes from original:**
- Add: DO block for Provisional Feasibility Assessment (Phase 0 extension)
  - 10-dimension assessment checklist
  - Per-route and per-feature classification (PROVISIONAL only)
  - inspect.initial-html and analyze.rendering-mode capability check
  - Explicit UNKNOWN handling for items not determinable from Phase 0
- Add: GATE extension — provisional feasibility recorded; NOT FEASIBLE routes identified
- Add: DELIVER extension — feasibility-assessment.md (provisional)
- **Critical constraint:** All new DO steps are after existing steps 1–12; STOP after Phase 0 is unchanged

#### REA-FINAL/parts/PART-02-DISCOVERY-AND-PAGE-INSPECTION.md [ADDITIVE]
**Changes from original:**
- Add: Reference to feasibility-assessment.md in Phase 1 START
- Add: Feasibility evidence collection context in Phase 2 DO
- No structural changes

#### REA-FINAL/parts/PART-03-INTERACTIONS-DESIGN-RESPONSIVE.md [ADDITIVE]
**Changes from original:**
- Reconfirm safe state discovery rules (already present; add clarifying note about unknown states remaining UNKNOWN)
- Add: Component origin labeling guidance in Phase 4 DO (distinguish server-generated vs client-generated from evidence)
- No structural changes

#### REA-FINAL/parts/PART-04-TECHNOLOGY-ARCHITECTURE.md [ADDITIVE]
**Changes from original:**
- Add: Full rendering mode classification per-Route in Phase 6 DO (extends existing brief mention)
- Add: Component origin evidence collection in Phase 6 DO
- Add: Feasibility propagation based on rendering mode in Phase 6 (update provisional feasibility with Phase 6 evidence)
- Add: Graph write for renderingMode, feasibility fields on Route nodes
- Add: Graph write for origin field on Component nodes
- Add: Optional adapter architecture diagram in Phase 7

#### REA-FINAL/parts/PART-05-QUALITY-SECURITY.md [ADDITIVE]
**Changes from original:**
- Add: External capture security review note in Phase 9 (if adapter is in use)
- Add: Sensitive-data handling reminder for adapter-imported evidence
- Add: Adapter trust boundaries documentation requirement
- No structural changes; most security content already comprehensive

#### REA-FINAL/parts/PART-06-COMPLETENESS-AND-MASTER-REPORT.md [ADDITIVE]
**Changes from original:**
- Add: Phase 11 step — Final feasibility reconciliation (append-only; compare provisional with final evidence)
- Add: Phase 12 section 21 extension — Eight-dimensional acceptance matrix preview
- Add: Final audit review extension — feasibility reconciliation status
- Add: Skill Registry limitation review for new Skills (inspect.initial-html, analyze.rendering-mode)

#### REA-FINAL/parts/PART-07-FRONTEND-RECONSTRUCTION.md [ADDITIVE]
**Changes from original:**
- Add: §7 extension — Eight-dimensional acceptance framework
  1. Visual fidelity
  2. Route coverage
  3. Components and layout
  4. Interactions
  5. Client-side state
  6. Responsive behavior
  7. Assets
  8. Functional consistency
- Add: Feasibility-aware reconstruction section (do not reconstruct NOT FEASIBLE routes without approval)
- Add: Rendering-aware implementation notes
- Add: Unknown placeholders guidance

---

### REA-FINAL/schemas/ [3 files]

#### REA-FINAL/schemas/REA-SCHEMAS.md [EXTENDED]
**Changes from original:**
- Add: Skill catalog rows for inspect.initial-html and analyze.rendering-mode
- Add: Route attrs: renderingMode, feasibility, feasibilityReason, limitations
- Add: Component attrs: origin
- Add: Feasibility schema (new §6 or extension of existing §)
- Add: Adapter provenance schema
- Add: Acceptance dimension schema
- Add: IR sections: routes[].renderingMode, routes[].feasibility, components[].origin

#### REA-FINAL/schemas/CAPABILITY-PRESERVATION-MATRIX.md [EXTENDED]
**Changes from original:**
- Add: New capability rows (inspect.initial-html, analyze.rendering-mode)
- Add: New additive block rows for all new PART-01 through PART-07 additions
- Existing matrix rows: unchanged

#### REA-FINAL/schemas/SUBSTITUTE-CHECKLIST.md [EXTENDED]
**Changes from original:**
- Add: Section K — Feasibility gate checklist items
- Add: Section L — Eight-dimension acceptance checklist items
- Existing sections A–J: unchanged

---

### REA-FINAL/skills/ [9 skill folders]

Each folder contains one SKILL.md file. No empty placeholder files.

#### REA-FINAL/skills/rea-orchestrator/SKILL.md [NEW]
Key content: REA session lifecycle, phase coordination, Skill Registry management, approval gate enforcement, evidence authority declaration

#### REA-FINAL/skills/rea-evidence-ledger/SKILL.md [NEW]
Key content: E-ID and F-ID management, four evidence labels, confidence scale, provenance requirements, adapter evidence distinction

#### REA-FINAL/skills/rea-application-graph/SKILL.md [NEW]
Key content: Graph schema reference, JSONL fragment format, node and edge types, append-only rules, compilation process

#### REA-FINAL/skills/rea-schemas-ir/SKILL.md [NEW]
Key content: IR schema reference, derivation rules, freeze conditions, Phase 13 input contract

#### REA-FINAL/skills/rea-feasibility-assessment/SKILL.md [NEW]
Key content: Provisional assessment procedure, classification vocabulary, per-route/feature assessment, final reconciliation procedure, NOT FEASIBLE stop behavior

#### REA-FINAL/skills/rea-rendering-analysis/SKILL.md [NEW]
Key content: inspect.initial-html procedure, analyze.rendering-mode procedure, CSR/SSR/SSG/Hybrid/UNKNOWN classification, component origin classification

#### REA-FINAL/skills/rea-browser-toolkit-adapter/SKILL.md [NEW — OPTIONAL]
Key content: Activation requirements (user auth + verified install + registry SUPPORTED status), normalization procedure, IMPORTED evidence label, provenance preservation, unsupported field documentation, explicit non-activation default

#### REA-FINAL/skills/rea-frontend-reconstruction/SKILL.md [NEW]
Key content: Phase 13 activation conditions (Phase 11 gate + written approval), IR handoff contract, frontend-only scope, mock behavior derivation, eight-dimension acceptance

#### REA-FINAL/skills/rea-validation/SKILL.md [NEW]
Key content: Eight-dimension acceptance procedure, build verification, visual comparison requirements, limitation documentation, final acceptance criteria

---

### REA-FINAL/adapters/browser-reverse-engineering-toolkit/ [2 files]

#### REA-FINAL/adapters/browser-reverse-engineering-toolkit/ADAPTER-DESIGN.md [NEW]
**Condition:** Only after Browser Toolkit evaluation completes and user approves adoption  
Key content: Adapter architecture, normalization rules, provenance schema implementation, evidence import procedure, unsupported field handling, activation checklist

#### REA-FINAL/adapters/browser-reverse-engineering-toolkit/ADAPTER-SPEC.md [NEW]
**Condition:** Same as above  
Key content: Supported operations, input format, output format, evidence mapping, field-by-field normalization table

---

### REA-FINAL/antigravity/ [3–5 files]

#### REA-FINAL/antigravity/rules/rea-identity.md [NEW]
Key content: REA identity, safety summary, source-of-truth declaration, evidence integrity, phase sequencing, approval gates, anti-substitution rule

#### REA-FINAL/antigravity/workflows/rea-start-session.md [NEW]
Key content: Documentation loading steps, Skill discovery, workspace initialization, Phase 0 trigger

#### REA-FINAL/antigravity/workflows/rea-approve-reconstruction.md [NEW]
Key content: PART-07 approval checklist, explicit confirmation requirement, logging instruction

---

### REA-FINAL/installer/ [2 files]

#### REA-FINAL/installer/Install-ReaSkills.ps1 [NEW]
Per INSTALLER-AND-MANIFEST-PLAN.md

#### REA-FINAL/installer/skills-manifest.json [NEW]
Per INSTALLER-AND-MANIFEST-PLAN.md

---

### REA-FINAL/reports/ [generated in Stage Two]

Will contain the SKILL-REUSE-AND-COMPATIBILITY-REPORT.md after Stage Two analysis.

---

## Directory: REA-VALIDATION/

All 7 validation reports are generated at the end of Stage Two, after implementation:

| File | Generated From |
|---|---|
| FILE-CHANGE-REPORT.md | SHA-256 comparison of originals vs. final files |
| SKILL-REUSE-AND-COMPATIBILITY-REPORT.md | Inspection of existing 82 skills vs. new REA skills |
| CAPABILITY-VERIFICATION-REPORT.md | Phase 0 capability test results (requires live session) |
| INSTALLER-VALIDATION-REPORT.md | Dry-run and test-install results |
| SECURITY-VALIDATION-REPORT.md | Review of all safety rules; adapter trust boundaries |
| DOCUMENTATION-CONSISTENCY-REPORT.md | Cross-reference check; broken links; schema consistency |
| FINAL-ACCEPTANCE-REPORT.md | Summary of all validation results |

---

## Implementation Order (Stage Two)

```
Phase 1: Schemas and core documentation
  1. REA-FINAL/schemas/REA-SCHEMAS.md (extended)
  2. REA-FINAL/parts/PART-00 through PART-07 (additive)

Phase 2: Skills authoring
  3. rea-evidence-ledger (foundational)
  4. rea-application-graph
  5. rea-schemas-ir
  6. rea-rendering-analysis
  7. rea-feasibility-assessment
  8. rea-frontend-reconstruction
  9. rea-validation
  10. rea-orchestrator (references all above)
  11. rea-browser-toolkit-adapter (optional)

Phase 3: Master Prompt
  12. REA-MASTER-PROMPT.md

Phase 4: Antigravity packaging
  13. rea-identity.md (rules)
  14. Workflow files

Phase 5: Browser Toolkit evaluation (requires live REA session)
  15. BROWSER-TOOLKIT-EVALUATION-REPORT.md
  16. Adapter files (if adopted)

Phase 6: Installer
  17. skills-manifest.json
  18. Install-ReaSkills.ps1
  19. Test in temp environment

Phase 7: Validation reports
  20. FILE-CHANGE-REPORT.md
  21. All other validation reports

Phase 8: Updated matrices
  22. CAPABILITY-PRESERVATION-MATRIX.md (extended)
  23. SUBSTITUTE-CHECKLIST.md (extended)
  24. INTEGRATION-REPORT.md (updated)
```
