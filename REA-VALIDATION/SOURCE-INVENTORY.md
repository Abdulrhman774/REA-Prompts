# REA PLAN — SOURCE INVENTORY
**Stage One | Generated:** 2026-11-06  
**Status:** VERIFIED — All 12 expected source files present. 0 missing, 0 unexpected, 0 duplicates.

---

## 1. Project Root

```
C:\Users\abd alrhman\Downloads\Prompts\
```

## 2. File Inventory

| # | Filename | Bytes | Lines (total) | Non-empty Lines | Last Modified | SHA-256 |
|---|---|---|---|---|---|---|
| 1 | CAPABILITY-PRESERVATION-MATRIX.md | 35,057 | 404 | 340 | 2026-11-06 09:03:34 | C787F93B525C20EED76E8ACC09F951F791A7B2B97A59154D171EEE9ACB3F9911 |
| 2 | INTEGRATION-REPORT.md | 12,923 | 136 | 104 | 2026-11-06 09:03:34 | 71DFDE0BCB2129D653520C6606F1765690B5D5E2FC4D310FC6EF1E521F392325 |
| 3 | PART-00-MASTER-CONTROL.md | 16,614 | 208 | 178 | 2026-11-06 09:03:34 | D1210EB77A9EA9C3524B1E62ECD407E604ECEB3FC6F7302E935D41FE84D822FA |
| 4 | PART-01-PREFLIGHT.md | 5,025 | 87 | 76 | 2026-11-06 09:03:34 | 971B25E27A8A24FFB234CFAE75B17FB32BFBB51EA298A7F9BE5F54E6B854615D |
| 5 | PART-02-DISCOVERY-AND-PAGE-INSPECTION.md | 7,653 | 106 | 79 | 2026-11-06 09:03:34 | 9CCF47B91C60C4700C3CD0345801C3259FD0F80ED6DEC0EA1FB2DF3F62D0168C |
| 6 | PART-03-INTERACTIONS-DESIGN-RESPONSIVE.md | 5,939 | 110 | 81 | 2026-11-06 09:03:36 | FF192674FE321BC3EF81A9E6970CDAAA363A3F213F17AF874CA1B67010975C4C |
| 7 | PART-04-TECHNOLOGY-ARCHITECTURE.md | 5,251 | 83 | 63 | 2026-11-06 09:03:36 | AA2EA790B3B0771E4B25C0F15C8A97B14CD504156B6B0A3052AF51DB5042D658 |
| 8 | PART-05-QUALITY-SECURITY.md | 7,452 | 117 | 93 | 2026-11-06 09:03:36 | 993D9E99E99DBCBF531DD18EBC1EA404A75E6583D052D2B4497BFD55BCCA07B3 |
| 9 | PART-06-COMPLETENESS-AND-MASTER-REPORT.md | 7,169 | 106 | 89 | 2026-11-06 09:03:36 | 0F06C935BC8C8A09DB50A86FD89C8C4274FCCEF2BAF0FD5832F4D5DEF9875623 |
| 10 | PART-07-FRONTEND-RECONSTRUCTION.md | 8,163 | 134 | 115 | 2026-11-06 09:03:36 | F72E77037FF139025ADD1C11E5C27EB4B0E8DEB3CE506F67C4FC75E86E80567F |
| 11 | REA-SCHEMAS.md | 15,926 | 257 | 207 | 2026-11-06 09:03:34 | 59F4624B35B1B95426804732F86FCACDD3A4A23270ADA3EF490CE69AFCC764A4 |
| 12 | SUBSTITUTE-CHECKLIST.md | 7,801 | 93 | 77 | 2026-11-06 09:03:34 | C80EF2F8E55FBF7BF64B9D339331C256F987360A9A1DED1F11E81D4222256657 |

**Total:** 12 files | 123,973 bytes

---

## 3. File Role Summary

| File | Role | Version Claim |
|---|---|---|
| PART-00-MASTER-CONTROL.md | Permanent project contract; mission, variables, safety, evidence model, Graph/IR contract | Unified v1.x (post-integration) |
| PART-01-PREFLIGHT.md | Phase 0 — Capability discovery, Skill Registry bootstrap, Graph init | Unified v1.x |
| PART-02-DISCOVERY-AND-PAGE-INSPECTION.md | Phases 1–2 — URL discovery, page-by-page analysis | Unified v1.x |
| PART-03-INTERACTIONS-DESIGN-RESPONSIVE.md | Phases 3–5 — Interactions, design system, responsive | Unified v1.x |
| PART-04-TECHNOLOGY-ARCHITECTURE.md | Phases 6–7 — Tech fingerprint, architecture | Unified v1.x |
| PART-05-QUALITY-SECURITY.md | Phases 8–10 — Quality, security, conditional modules | Unified v1.x |
| PART-06-COMPLETENESS-AND-MASTER-REPORT.md | Phases 11–12 — Completeness gate, final report, IR freeze, stop gate | Unified v1.x |
| PART-07-FRONTEND-RECONSTRUCTION.md | Phase 13 — Frontend-only reconstruction | Unified v1.x |
| REA-SCHEMAS.md | Skill catalog, Graph schema, IR schema, evidence label mapping | Unified v1.x |
| CAPABILITY-PRESERVATION-MATRIX.md | Verbatim-preservation audit of original v. unified prompt; decision cross-reference | Unified v1.x |
| INTEGRATION-REPORT.md | Architecture documentation for v1 merge; gaps and decisions D1–D13 | Unified v1.x |
| SUBSTITUTE-CHECKLIST.md | Replacement for missing Appendix E; 10 sections A–J | Unified v1.x |

---

## 4. Missing, Unexpected, or Duplicate Files

| Category | Count | Notes |
|---|---|---|
| Missing expected files | **0** | All 12 files listed in the brief are present |
| Unexpected files | **0** | No other files in project root |
| Duplicate files | **0** | — |
| Installer (.ps1) | **MISSING** | No PowerShell installer found anywhere in the workspace |
| Skills manifest (.json) | **MISSING** | No skills-manifest.json found anywhere in the workspace |

> [!IMPORTANT]
> The installer and manifest were described as existing in prior project discussions but are **not present** in the current workspace. They must be created from scratch in Stage Two after user approval.

---

## 5. Existing REA-PLAN / REA-FINAL / REA-VALIDATION Directories

| Directory | Status |
|---|---|
| `REA-PLAN/` | CREATED by Stage One (this run) |
| `REA-FINAL/` | NOT YET CREATED — Stage Two only |
| `REA-VALIDATION/` | NOT YET CREATED — Stage Two only |

---

## 6. Original Document Protection Confirmation

These SHA-256 checksums are recorded as the **immutable baseline**. Any Stage Two file must not alter the original 12 source files. All implementation work is additive and placed in `REA-FINAL/` and `REA-VALIDATION/`.
