# REA PLAN — SKILL DEPENDENCY MAP
**Stage One | Generated:** 2026-11-06

---

## 1. REA-Specific Skill Dependency Tree

```
rea-orchestrator (root)
├── rea-evidence-ledger        (evidence model, E-IDs, F-IDs, provenance)
├── rea-application-graph      (Graph schema, JSONL fragments, compilation)
│   └── rea-schemas-ir         (IR schema, derivation, freeze rules)
├── rea-feasibility-assessment (feasibility gate, classification, reconciliation)
│   └── rea-rendering-analysis (rendering mode, component origin, initial HTML)
├── rea-frontend-reconstruction (Phase 13, IR handoff, mock behavior, QA)
│   └── rea-validation         (8-dimension acceptance, build checks)
└── rea-browser-toolkit-adapter [OPTIONAL — not auto-activated]
    (depends on user authorization + actual toolkit installation)
```

**No circular dependencies.** All dependency edges flow from consumer to provider.

---

## 2. Skill Dependency Details

### rea-orchestrator
- **Depends on:** rea-evidence-ledger, rea-application-graph, rea-feasibility-assessment, rea-frontend-reconstruction, rea-validation
- **Used by:** nothing (root entry point)
- **Activation:** Read at the start of a new REA session via REA-MASTER-PROMPT.md
- **Phase coverage:** All phases (Phase 0 through Phase 13)

### rea-evidence-ledger
- **Depends on:** nothing (foundational)
- **Used by:** rea-orchestrator, all other REA Skills
- **Activation:** Referenced whenever evidence records, E-IDs, or F-IDs are created
- **Phase coverage:** All phases

### rea-application-graph
- **Depends on:** rea-evidence-ledger
- **Used by:** rea-orchestrator, rea-schemas-ir
- **Activation:** Referenced when writing Graph fragments (Phases 0–11)
- **Phase coverage:** Phases 0–12

### rea-schemas-ir
- **Depends on:** rea-application-graph, rea-evidence-ledger
- **Used by:** rea-orchestrator, rea-frontend-reconstruction
- **Activation:** Referenced during Phase 12 IR freeze and Phase 13 input contract
- **Phase coverage:** Phases 11–13

### rea-feasibility-assessment
- **Depends on:** rea-evidence-ledger, rea-rendering-analysis
- **Used by:** rea-orchestrator
- **Activation:** Referenced during Phase 0 provisional assessment and Phase 11 final reconciliation
- **Phase coverage:** Phase 0, Phase 11

### rea-rendering-analysis
- **Depends on:** rea-evidence-ledger
- **Used by:** rea-feasibility-assessment
- **Activation:** Referenced during Phase 0 initial observation and Phase 6 full classification
- **Phase coverage:** Phase 0 (provisional), Phase 6 (full)

### rea-frontend-reconstruction
- **Depends on:** rea-schemas-ir, rea-evidence-ledger
- **Used by:** rea-orchestrator, rea-validation
- **Activation:** Referenced ONLY after explicit written user approval of Phase 13
- **Phase coverage:** Phase 13 only

### rea-validation
- **Depends on:** rea-frontend-reconstruction, rea-evidence-ledger
- **Used by:** rea-orchestrator
- **Activation:** Referenced during Phase 13 QA and final acceptance
- **Phase coverage:** Phase 13 (QA section)

### rea-browser-toolkit-adapter [OPTIONAL]
- **Depends on:** rea-evidence-ledger (for provenance normalization)
- **Used by:** rea-orchestrator (only when authorized)
- **Activation:** ONLY when: (a) user explicitly authorizes, (b) toolkit is confirmed installed and compatible, (c) adapter is registered in Skill Registry with SUPPORTED status and evidence
- **Phase coverage:** Evidence acquisition phases (Phases 0–10), optionally
- **Circular dependency:** None — does not depend on rea-orchestrator

---

## 3. Relationship to Existing Installed Skills

The following installed skills in `~/.gemini/config/skills/` are relevant to REA work:

| Installed Skill | REA Relevance | Overlap with REA Skills | Reuse Strategy |
|---|---|---|---|
| reverse-engineer-anything | **PRIMARY** — describes the REA MCP server and all its tools | High overlap with rea-orchestrator concepts | REA-specific Skills reference this skill's tool catalog; they do not replace it |
| web-design-guidelines | Phase 4 (design system) reference | None — complementary | Reference from rea-frontend-reconstruction |
| wcag-audit-patterns | Phase 8 (accessibility) | None — complementary | Reference from rea-validation |
| screen-reader-testing | Phase 8 (accessibility) | None — complementary | Optional reference |
| e2e-testing-patterns | Phase 13 QA | None — complementary | Optional reference from rea-validation |
| api-design-principles | Phase 7 (API analysis) | None — complementary | Reference from rea-application-graph |
| openapi-spec-generation | Phase 7 (API analysis) | None — complementary | Optional reference |
| architecture-patterns | Phase 7 (architecture report) | None — complementary | Optional reference |
| architecture-decision-records | REA architecture decisions | None — complementary | Used for REA's own ADRs if needed |
| security-requirement-extraction | Phase 9 (passive security) | None — complementary | Reference from rea-validation |
| stride-analysis-patterns | Phase 9 (security) | None — complementary | Optional reference |
| attack-tree-construction | Phase 9 (security) | None — complementary | Optional reference |
| threat-mitigation-mapping | Phase 9 (security) | None — complementary | Optional reference |
| debugging-strategies | General | None | Available to REA sessions |
| error-handling-patterns | Phase 13 (reconstruction) | None | Available to REA sessions |

---

## 4. Skill Registry (Runtime, Per Project) vs. Global Skills (Permanent)

**Important distinction:**

| Type | Location | Scope | Built when |
|---|---|---|---|
| **REA-Specific Skills** (rea-orchestrator etc.) | `~/.gemini/config/skills/rea-*/` | Global; always available | Stage Two installation |
| **Skill Registry** (`skill-registry.md`) | `{{AUDIT_DIR}}skill-registry.md` | Per-project; built at runtime | Phase 0 of each REA session |

The REA-Specific Skills are **documentation and guidance** for the agent.  
The Skill Registry is a **per-project runtime record** of which capabilities are available.  
These are complementary, not duplicates.

---

## 5. Activation Safety Rules

1. **rea-browser-toolkit-adapter** must NOT activate unless all conditions in its SKILL.md are met. It must include an activation checklist.
2. **rea-frontend-reconstruction** must NOT activate without Phase 11 gate passing AND explicit written user approval documented in progress-log.md.
3. All other REA Skills may be referenced freely during their relevant phases.
4. No REA Skill claims to provide browser or OS execution capabilities. Execution is provided by the REA MCP server (rea-agents@6.8.0 via npx).
