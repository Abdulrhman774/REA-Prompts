# REA PLAN — FINAL ARCHITECTURE PROPOSAL
**Stage One | Generated:** 2026-11-06  
**Status:** PROPOSED — Not yet implemented. Pending user approval.

---

## 1. Architecture Overview

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         REA — MASTER ORCHESTRATOR                           │
│  REA-MASTER-PROMPT.md + rea-orchestrator SKILL                              │
│  Loads documentation → Discovers Skills → Verifies capabilities →           │
│  Builds Skill Registry → Runs phases → Enforces gates → Manages approval    │
└────────────────────────┬──────────────────────────────────┬─────────────────┘
                         │ uses Skills                       │ writes
              ┌──────────▼─────────┐               ┌────────▼────────────────┐
              │   Skill Registry   │               │  Evidence + Findings    │
              │  (Phase 0, from    │               │  (E-IDs, F-IDs)         │
              │   REA docs only)   │               │  rea-evidence-ledger    │
              └──────────┬─────────┘               └────────┬────────────────┘
                         │ provider-neutral Skills           │ cited by
              ┌──────────▼─────────┐               ┌────────▼────────────────┐
              │     Adapters       │               │  Graph fragments (JSONL)│
              │  (per provider /   │               │  Phases 0–10, append-   │
              │   framework)       │               │  only, evidence-linked  │
              │  [Browser Toolkit  │               │  rea-application-graph  │
              │   Adapter: OPTIONAL│               └────────┬────────────────┘
              │   user-authorized] │                        │ Phase 11 verify
              └──────────┬─────────┘                        │ Phase 12 freeze
                         │ expose              ┌────────────▼────────────────┐
              ┌──────────▼─────────┐          │  application-graph.json     │
              │  Tools / engines   │          │  ir.json (derived)          │
              │  (REA MCP Server   │          │  rea-schemas-ir             │
              │   rea-agents@6.8.0)│          └────────────┬────────────────┘
              └────────────────────┘                        │ after written approval
                                              ┌─────────────▼───────────────┐
              ┌─────────────────────────────── │  PART 07 Reconstruction    │
              │  FEASIBILITY GATE (new)        │  rea-frontend-reconstruction│
              │  rea-feasibility-assessment    └────────────┬────────────────┘
              │  Phase 0: provisional                       │
              │  Phase 11: final reconciliation ┌───────────▼────────────────┐
              └─────────────────────────────── │  8-Dimension QA & Validation│
                                               │  rea-validation             │
              ┌─────────────────────────────── └─────────────────────────────┘
              │  RENDERING ANALYSIS (new)
              │  rea-rendering-analysis
              │  Phase 0: provisional (inspect.initial-html)
              │  Phase 6: full (analyze.rendering-mode)
              └───────────────────────────────
```

---

## 2. The Six-Layer Architecture

### Layer 1: Orchestration
**Files:** REA-MASTER-PROMPT.md, rea-orchestrator SKILL  
**Responsibility:** Session lifecycle, documentation loading, Skill discovery, phase sequencing, approval gates

### Layer 2: Capability Definition
**Files:** REA-SCHEMAS.md, Skill Registry (per-project, Phase 0)  
**Responsibility:** Define what REA can do; verify at runtime; expose as provider-neutral Skill contracts

### Layer 3: Evidence Authority
**Files:** rea-evidence-ledger SKILL, evidence-ledger.md (per-project), graph fragments  
**Responsibility:** Every claim traces to evidence; E-IDs and F-IDs; four labels; confidence scale; provenance

### Layer 4: Knowledge Model
**Files:** rea-application-graph SKILL, rea-schemas-ir SKILL, application-graph.json, ir.json  
**Responsibility:** Structured, evidence-driven model of the target; framework-neutral IR as handoff to reconstruction

### Layer 5: Analysis Intelligence
**Files:** rea-feasibility-assessment SKILL, rea-rendering-analysis SKILL  
**Responsibility:** Provisional and final feasibility classification; rendering mode classification; component origin

### Layer 6: Delivery
**Files:** rea-frontend-reconstruction SKILL, rea-validation SKILL, {{RECON_DIR}}  
**Responsibility:** Frontend-only reconstruction from IR; eight-dimension acceptance; build verification

---

## 3. Data Flow

```
Target Website
    ↓ (REA MCP tools — navigate, inspect, capture)
Evidence Records (E-IDs, OBSERVED/INFERRED/UNKNOWN/LIMITATION)
    ↓
Provisional Feasibility Assessment (Phase 0 — PROVISIONAL)
    ↓
Full Investigation (Phases 1–10 — per-Part, per-Phase gating)
    ↓
Graph Fragments (append-only JSONL, Phases 0–10)
    ↓
Phase 11: Completeness Verification + Final Feasibility Reconciliation
    ↓ (gate: PASS required)
Phase 12: Final Report + IR Freeze
    ↓ (stop gate: written approval required)
Phase 13: Frontend Reconstruction from IR
    ↓
8-Dimension Acceptance Verification
    ↓
Reconstruction Report
```

---

## 4. New Capabilities vs. Original Architecture

| Capability | Original | Proposed Addition | Integration Point |
|---|---|---|---|
| Feasibility gate | None | FEASIBLE/PARTIALLY/NOT FEASIBLE/UNKNOWN per route and feature | PART-01 (provisional) + PART-06 (final) |
| Rendering mode per-Route | Brief mention in Phase 6 | Full CSR/SSR/SSG/Hybrid/UNKNOWN classification; early provisional | PART-01 + PART-04 |
| Component origin | None | server/client/unknown | PART-04 + REA-SCHEMAS |
| inspect.initial-html | Not defined | New Skill contract | REA-SCHEMAS + PART-01 |
| analyze.rendering-mode | Not defined | New Skill contract | REA-SCHEMAS + PART-01 + PART-04 |
| Eight-dimension acceptance | None | 8 dimensions with Verified/Not verified/Not verified due to limitation | PART-07 |
| Adapter provenance schema | Not defined | Source, method, timestamp, provider, integrity | REA-SCHEMAS |
| Antigravity Rules | Not present | REA identity and safety rules | antigravity/rules/ |
| Antigravity Workflows | Not present | Session start, reconstruction approval | antigravity/workflows/ |
| REA-specific Skills | Not present | 9 dedicated Skills | skills/ |
| Master Prompt | Not present | Self-contained session entry point | REA-MASTER-PROMPT.md |
| Browser Toolkit Adapter | Not present | Optional adapter (pending evaluation) | adapters/ |
| PowerShell Installer | Not present | Full-featured installer with safety | installer/ |

---

## 5. What the Architecture Preserves (Non-Negotiable)

1. **REA as primary orchestrator** — not replaceable
2. **Original documentation unchanged** — 12 source files protected
3. **Evidence as basis of every claim** — E-IDs, F-IDs, four labels
4. **UNKNOWN stays UNKNOWN** — never invented
5. **Skills are guidance, not execution** — execution is through REA MCP
6. **Adapters are optional and capability-gated** — never mandatory
7. **Browser Toolkit never replaces REA** — supporting only
8. **Frontend reconstruction is frontend-only** — no backend
9. **PART-07 requires explicit written approval** — multiple gates
10. **No external dependency installation without permission** — strict
11. **No unsafe target interactions** — observe-only
12. **No silent file overwrites** — backup first
13. **No invented capabilities** — SUPPORTED requires evidence
14. **No false completion claims** — cannot call done without evidence
15. **All original requirements preserved** — additive only

---

## 6. Open Questions for User Decision

| # | Question | Impact if Not Resolved |
|---|---|---|
| 1 | Should the Browser Toolkit evaluation be authorized in Stage Two? REA browser tools would be used to inspect the GitHub repository. | Adapter cannot be designed without evaluation. Adapter remains PENDING. |
| 2 | Should the REA Skills be deployed globally (all projects) or workspace-only (this project)? | Installer default depends on this decision. |
| 3 | Should workflows be created for specific phase triggers (e.g., `/rea-start`, `/rea-approve-reconstruction`)? | Workflow count and content vary. |
| 4 | Is the Appendix E / original final checklist available? The SUBSTITUTE-CHECKLIST.md notes it is missing. | If available, include in SUBSTITUTE-CHECKLIST.md update. |
| 5 | Should the INTEGRATION-REPORT.md be updated in-place (additive) in REA-FINAL or treated as a new document? | If new document, the original in Prompts/ is preserved; if updated copy, it lives in REA-FINAL/reports/. |
