# REA PLAN — APPROVED CHANGES MAP
**Stage One | Generated:** 2026-11-06  
**Status:** ANALYSIS ONLY — Maps work-order requirements to source locations and implementation actions.

---

## Overview

This document maps every requirement from the work order (sections 4–23) to:
1. The source file(s) it affects
2. The nature of the change (additive / new file / structural extension)
3. The implementation approach
4. The dependency chain

---

## Group A — REA Core Identity and Architecture (Work Order §4)

| ID | Requirement | Affected Files | Change Type | Notes |
|---|---|---|---|---|
| A-01 | Preserve Tool/Adapter/Skill/Registry separation | PART-00 | Already present (P status in matrix); verify no regression | No change needed |
| A-02 | External tools are supporting only, never replacements | PART-00 | Already present | No change needed |
| A-03 | Skill status: SUPPORTED/NOT_SUPPORTED/NOT_VERIFIED | PART-01, REA-SCHEMAS | SUPPORTED/Not supported/Not verified already defined; need to verify alignment with work-order naming | Minor normalization check |
| A-04 | Actual execution provider must be verified | PART-01 | Already required by Phase 0 Gate | No change needed |

---

## Group B — REA Master Prompt (Work Order §5)

| ID | Requirement | Target File | Change Type | Notes |
|---|---|---|---|---|
| B-01 | Standalone REA-MASTER-PROMPT.md as session entry point | REA-FINAL/REA-MASTER-PROMPT.md | **NEW FILE** | Does not exist; must be authored in Stage Two |
| B-02 | Coordinate all 17 session phases (documentation loading through final reporting) | REA-MASTER-PROMPT.md | — | Content to be derived from PART-00 through PART-07 |
| B-03 | Enforce phase order, no auto-advance to protected phases | REA-MASTER-PROMPT.md | — | Mirrors PART-00 partition execution protocol |
| B-04 | Does not depend on previous chat history | REA-MASTER-PROMPT.md | — | Self-contained |
| B-05 | Template variables: {{REA_DOCS_SOURCE}}, {{TARGET_WEBSITE}}, {{AUTHORIZATION_CONFIRMATION}}, {{WORKSPACE_PATH}}, {{OPTIONAL_BROWSER_TOOLKIT_SOURCE}} | REA-MASTER-PROMPT.md | — | New variables; must be mapped to or added alongside existing PART-00 variables |
| B-06 | Capability state distinctions: installed / described / has provider / verified / unavailable | REA-MASTER-PROMPT.md | — | Extends existing SUPPORTED/NOT_SUPPORTED/NOT_VERIFIED |

---

## Group C — Feasibility Gate (Work Order §6)

| ID | Requirement | Affected Files | Change Type | Notes |
|---|---|---|---|---|
| C-01 | Mandatory provisional feasibility assessment in PART-01 before full investigation | PART-01 (Phase 0) | **ADDITIVE** — new DO block | Highest priority structural addition |
| C-02 | 10-dimension provisional assessment checklist | PART-01 | ADDITIVE | HTML, DOM, hydration, rendering mode, bundles, APIs, routes, features, capabilities, blockers |
| C-03 | Feasibility classifications: FEASIBLE/PARTIALLY FEASIBLE/NOT FEASIBLE/UNKNOWN | PART-01, PART-06, REA-SCHEMAS | ADDITIVE — new schema section | New classification vocabulary |
| C-04 | Per-Route and per-Feature feasibility | PART-01 | ADDITIVE | Each with reason, E-IDs, F-IDs, required capabilities, limitations, implications |
| C-05 | Final reconciliation in Phase 11 / PART-06 | PART-06 | ADDITIVE — new step in Phase 11 DO | Append-only; earlier evidence preserved |
| C-06 | NOT FEASIBLE stop behavior before PART-07 | PART-01 (new gate extension), PART-06 | ADDITIVE — new gate condition | Must not automatically discard Parts 01–06 |
| C-07 | Qualitative estimates only (Low/Medium/High/Unknown), marked INFERRED | PART-00, PART-01 | ADDITIVE — clarifying rule | Reinforces existing no-metric-invention rule |

---

## Group D — Rendering Mode and Component Origin (Work Order §7)

| ID | Requirement | Affected Files | Change Type | Notes |
|---|---|---|---|---|
| D-01 | Rendering classification early (not postponed to reconstruction) | PART-01 | ADDITIVE — new provisional investigation step | Moved forward from PART-04 |
| D-02 | CSR/SSR/SSG/Hybrid/UNKNOWN per route | PART-04, REA-SCHEMAS §3.4 | ADDITIVE — new Route.renderingMode attribute | Extends existing Route attrs |
| D-03 | Component origin: server/client/unknown | REA-SCHEMAS §3.4 | ADDITIVE — new Component.origin attribute | Extends existing Component attrs |
| D-04 | inspect.initial-html capability contract | REA-SCHEMAS §2.2, PART-01 | **NEW SKILL** — additive row in catalog | Collects initial HTML through available provider |
| D-05 | analyze.rendering-mode capability contract | REA-SCHEMAS §2.2, PART-01 | **NEW SKILL** — additive row in catalog | Analyzes HTML+DOM+hydration indicators |
| D-06 | Evidence and confidence for rendering classification | PART-04, PART-01 | ADDITIVE | Do not guess from framework name alone |

---

## Group E — Evidence and Findings System (Work Order §8)

| ID | Requirement | Affected Files | Change Type | Notes |
|---|---|---|---|---|
| E-01 | Preserve E-IDs and F-IDs | All Parts | Already present | No change needed |
| E-02 | Provenance fields for external-tool output | PART-00, REA-SCHEMAS | ADDITIVE — new adapter provenance schema | External observations ≠ direct REA observations |
| E-03 | Adapter provenance schema | REA-SCHEMAS | **NEW SCHEMA SECTION** | Source, collection method, timestamp, provider/adapter, integrity info |
| E-04 | INFERRED cannot be upgraded to OBSERVED | PART-00 | Already present (P status) | No change needed |

---

## Group F — Application Intelligence Graph (Work Order §9)

| ID | Requirement | Affected Files | Change Type | Notes |
|---|---|---|---|---|
| F-01 | Route.renderingMode | REA-SCHEMAS §3.4 | ADDITIVE | New field in Route attrs |
| F-02 | Route.feasibility | REA-SCHEMAS §3.4 | ADDITIVE | New field in Route attrs |
| F-03 | Route.feasibilityReason | REA-SCHEMAS §3.4 | ADDITIVE | New field in Route attrs |
| F-04 | Route.evidenceReferences (for feasibility) | REA-SCHEMAS §3.4 | ADDITIVE | New field |
| F-05 | Route.limitations | REA-SCHEMAS §3.4 | ADDITIVE | New field |
| F-06 | Component.origin | REA-SCHEMAS §3.4 | ADDITIVE | New field |
| F-07 | Component.evidenceReferences | REA-SCHEMAS §3.4 | ADDITIVE | New field |
| F-08 | Component.confidence | REA-SCHEMAS §3.4 | ADDITIVE (confidence already listed as optional) | Clarify it applies here |
| F-09 | Feature feasibilityDecision, feasibilityReason, evidenceReferences, reconstructionNotes | REA-SCHEMAS §3.4 | ADDITIVE — new Feature node or Component attr | Features currently modeled as Components; need clarification |

---

## Group G — Framework-Agnostic IR (Work Order §10)

| ID | Requirement | Affected Files | Change Type | Notes |
|---|---|---|---|---|
| G-01 | IR carries renderingMode and componentOrigin | REA-SCHEMAS §5.1 | ADDITIVE — extend routes[] and components[] sections | New fields |
| G-02 | IR carries feasibility information | REA-SCHEMAS §5.1 | ADDITIVE — extend routes[] section | New fields |
| G-03 | Insufficiently evidenced elements become clearly labeled placeholders | PART-07, REA-SCHEMAS §5 | Already present (UNKNOWN → placeholder); reconfirm | Minor clarification |

---

## Group H — Eight-Dimension Acceptance Framework (Work Order §11)

| ID | Requirement | Affected Files | Change Type | Notes |
|---|---|---|---|---|
| H-01 | Eight acceptance dimensions in PART-07 | PART-07 (§7 Quality assurance + Final acceptance criteria) | **ADDITIVE** — new acceptance section | Extends existing §7 and final acceptance |
| H-02 | Dimension statuses: Verified/Not verified/Not verified due to limitation | PART-07 | ADDITIVE | New vocabulary for acceptance report |
| H-03 | Final report identifies what was tested, evidence, routes/features, unavailable capabilities, discrepancies | PART-07 | ADDITIVE | Extends reconstruction-report.md content |
| H-04 | Visual comparison requires usable render.local capability | PART-07 | Already present in §7; reinforce | Reconfirm existing rule |

---

## Group I — Safe UI State Discovery (Work Order §12)

| ID | Requirement | Affected Files | Change Type | Notes |
|---|---|---|---|---|
| I-01 | States documented only when naturally observed or safely triggered | PART-03 | Already present (safe actions only); reconfirm | No change needed |
| I-02 | Forbidden methods: fuzzing, brute force, destructive, unauthorized | PART-00, PART-03 | Already present in safety rules | No change needed |
| I-03 | Unknown states remain UNKNOWN | PART-03, PART-00 | Already present | No change needed |

---

## Group J — JavaScript Functionality (Work Order §13)

| ID | Requirement | Affected Files | Change Type | Notes |
|---|---|---|---|---|
| J-01 | Reimplement from observed behavior, not from copying bundles | PART-07 | Already present in §3-5; reconfirm | No change needed |
| J-02 | Do not assume original source is available | PART-07 | Already present | No change needed |

---

## Group K — Browser Toolkit Adapter (Work Order §14)

| ID | Requirement | Affected Files | Change Type | Notes |
|---|---|---|---|---|
| K-01 | Evaluate Dvurechensky/Browser.Reverse.Engineering.Toolkit | REA-PLAN/BROWSER-TOOLKIT-EVALUATION-PLAN.md | ANALYSIS only in Stage One | Cannot access repo directly; web search summary obtained |
| K-02 | Optional adapter architecture design | REA-FINAL/adapters/browser-reverse-engineering-toolkit/ | **NEW FILES** in Stage Two | Only after evaluation and user approval |
| K-03 | Adapter must be optional, preserve provenance, normalize to REA evidence | Adapter design docs | — | Core constraint |
| K-04 | Do not make Playwright/CDP mandatory | PART-00 | Already present | Reconfirm |
| K-05 | Do not install/execute toolkit without explicit approval | Work order constraint | Operational rule | No install in Stage One or Two without approval |

---

## Group L — Antigravity Architecture (Work Order §15)

| ID | Requirement | Affected Files | Change Type | Notes |
|---|---|---|---|---|
| L-01 | Permanent Rules (REA identity, safety, source-of-truth, phase sequence) | REA-FINAL/antigravity/rules/ | **NEW FILES** | 2 existing rules in ~/.gemini/config/rules/ (browser.md, persistent-memory.md); REA rules do not exist |
| L-02 | User-triggered Workflows (controlled operations) | REA-FINAL/antigravity/workflows/ | **NEW FILES** | No existing REA workflows |
| L-03 | Verify Antigravity path conventions before implementation | agy-customizations SKILL.md | VERIFIED in Stage One | Global: ~/.gemini/config/; workspace: .agents/ |

---

## Group M — REA-Specific Skills (Work Order §16)

| ID | Skill Name | Current Status | Stage Two Action |
|---|---|---|---|
| M-01 | rea-orchestrator | NOT PRESENT | Create SKILL.md |
| M-02 | rea-evidence-ledger | NOT PRESENT | Create SKILL.md |
| M-03 | rea-application-graph | NOT PRESENT | Create SKILL.md |
| M-04 | rea-schemas-ir | NOT PRESENT | Create SKILL.md |
| M-05 | rea-feasibility-assessment | NOT PRESENT | Create SKILL.md |
| M-06 | rea-rendering-analysis | NOT PRESENT | Create SKILL.md |
| M-07 | rea-browser-toolkit-adapter | NOT PRESENT | Create SKILL.md (optional, conditional) |
| M-08 | rea-frontend-reconstruction | NOT PRESENT | Create SKILL.md |
| M-09 | rea-validation | NOT PRESENT | Create SKILL.md |

---

## Group N — Installer and Manifest (Work Order §19)

| ID | Requirement | Current Status | Stage Two Action |
|---|---|---|---|
| N-01 | PowerShell installer (Install-ReaSkills.ps1) | NOT PRESENT | Create from scratch |
| N-02 | Skills manifest JSON | NOT PRESENT | Create from scratch |
| N-03 | Global and workspace installation modes | — | Build into installer |
| N-04 | Dry-run, check-only, force modes | — | Build into installer |
| N-05 | No automatic script execution; opt-in | — | Core installer requirement |
| N-06 | No silent overwrite; backup before replace | — | Core installer requirement |

---

## Summary of Change Types

| Type | Count | Examples |
|---|---|---|
| Already present — no change | 12 | Safety rules, evidence model, PART-07 write approval gate |
| Additive to existing files | 23 | Feasibility gate in PART-01, rendering mode in PART-04 attrs, 8-dim acceptance in PART-07 |
| New file — documentation | 2 | inspect.initial-html and analyze.rendering-mode Skill rows in REA-SCHEMAS |
| New file — REA Skills | 9 | All rea-* Skills |
| New file — Antigravity Rules | 1–2 | REA identity + safety rules |
| New file — Antigravity Workflows | 2–4 | Phase trigger workflows |
| New file — Adapter design | 1 | browser-reverse-engineering-toolkit adapter |
| New file — Installer | 2 | Install-ReaSkills.ps1 + skills-manifest.json |
| New file — Master Prompt | 1 | REA-MASTER-PROMPT.md |
| New file — Final Parts | 8 | Updated PART-00 through PART-07 in REA-FINAL/parts/ |
| New file — Updated Schemas | 3 | REA-SCHEMAS.md, CAPABILITY-PRESERVATION-MATRIX.md, SUBSTITUTE-CHECKLIST.md |
