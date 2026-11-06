# REA MASTER PHASE & PART REGISTRY
**Document ID:** REA-REG-PHASE-001  
**Version:** 2.1.0  
**Authority:** REA Master Orchestrator  
**Status:** AUTHORITATIVE SPECIFICATION

---

## 1. Overview and Disambiguation

To eliminate phase numbering ambiguity across the REA system, this registry defines the canonical relationship between:
1. **Master Orchestrator Phases** (`MASTER-PHASE-00` through `MASTER-PHASE-17`): High-level system orchestration lifecycle executed by `REA-MASTER-PROMPT.md` and `rea-orchestrator`.
2. **Modular Parts** (`PART-00` through `PART-07`): The 8 modular specification documents.
3. **Part-Local Phases** (`PART-01-LOCAL-PHASE-00` through `PART-07-LOCAL-PHASE-13`): The numbering originally defined within individual modular documents.

> [!IMPORTANT]
> **CRITICAL DISAMBIGUATION:**
> - `MASTER-PHASE-13` refers strictly to **Framework-Agnostic IR Freeze** (`ir.json`).
> - `MASTER-PHASE-16` refers strictly to **Frontend-Only Reconstruction**, corresponding to `PART-07-LOCAL-PHASE-13`.
> - Never use the bare label "Phase 13" without explicitly prefixing either `MASTER-PHASE-13` (IR Freeze) or `PART-07-LOCAL-PHASE-13` (Reconstruction).

---

## 2. Master Phase to Part-Local Phase Mapping Table

| Master Phase ID | Master Phase Name | Primary Part Reference | Part-Local Phase ID | Prerequisites | Allowed Transitions | Approval Required? |
|---|---|---|---|---|---|---|
| `MASTER-PHASE-00` | Session Initialization & Variable Binding | `PART-00` | N/A | Target URL, Authorized Scope | -> `MASTER-PHASE-01` | No (Automatic if authorized) |
| `MASTER-PHASE-01` | Preflight Verification & Skill Registry Bootstrap | `PART-01` | `PART-01-LOCAL-PHASE-00` | `MASTER-PHASE-00` complete | -> `MASTER-PHASE-02` | No |
| `MASTER-PHASE-02` | Capability Probing & Registration | `PART-01` | `PART-01-LOCAL-PHASE-00.2` | `MASTER-PHASE-01` complete | -> `MASTER-PHASE-03` | No |
| `MASTER-PHASE-03` | Initial HTML & Pre-Hydration Capture | `PART-01` | `PART-01-LOCAL-PHASE-00.3` | `MASTER-PHASE-02` complete | -> `MASTER-PHASE-04` | No |
| `MASTER-PHASE-04` | Preliminary 10-Dimension Feasibility Gate | `PART-01` | `PART-01-LOCAL-PHASE-00.4` | `MASTER-PHASE-03` complete | -> `MASTER-PHASE-05` (Feasible/Partial/Unknown) or Scope Review | User Review if `CRITICAL_BLOCKER` |
| `MASTER-PHASE-05` | Entry Point Crawl & Route Discovery | `PART-02` | `PART-02-LOCAL-PHASE-01` | `MASTER-PHASE-04` evaluated | -> `MASTER-PHASE-06` | No |
| `MASTER-PHASE-06` | Route Inspection & DOM Landmark Extraction | `PART-02` | `PART-02-LOCAL-PHASE-02` | `MASTER-PHASE-05` complete | -> `MASTER-PHASE-07` | No |
| `MASTER-PHASE-07` | Component Hierarchy & State Mapping | `PART-03` | `PART-03-LOCAL-PHASE-03` | `MASTER-PHASE-06` complete | -> `MASTER-PHASE-08` | No |
| `MASTER-PHASE-08` | Design System Token Extraction | `PART-03` | `PART-03-LOCAL-PHASE-04` | `MASTER-PHASE-07` complete | -> `MASTER-PHASE-09` | No |
| `MASTER-PHASE-09` | Responsive Breakpoint & Mobile Analysis | `PART-03` | `PART-03-LOCAL-PHASE-05` | `MASTER-PHASE-08` complete | -> `MASTER-PHASE-10` | No |
| `MASTER-PHASE-10` | Technology Stack & Rendering Classification | `PART-04` | `PART-04-LOCAL-PHASE-06` | `MASTER-PHASE-09` complete | -> `MASTER-PHASE-11` | No |
| `MASTER-PHASE-11` | API Architecture & Dependency Contract Synthesis | `PART-04` | `PART-04-LOCAL-PHASE-07` | `MASTER-PHASE-10` complete | -> `MASTER-PHASE-12` | No |
| `MASTER-PHASE-12` | Quality, Accessibility, SEO & Passive Security Audits | `PART-05` | `PART-05-LOCAL-PHASES-08-10` | `MASTER-PHASE-11` complete | -> `MASTER-PHASE-13` | No |
| `MASTER-PHASE-13` | Completeness Verification, Feasibility Reconciliation & IR Freeze | `PART-06` | `PART-06-LOCAL-PHASES-11-12` | `MASTER-PHASE-12` complete | -> `MASTER-PHASE-14` (if PASS) | Human Review if `FAIL` |
| `MASTER-PHASE-14` | Master Audit Report Delivery | `PART-06` | `PART-06-LOCAL-PHASE-12` | `MASTER-PHASE-13` complete | -> `MASTER-PHASE-15` | No |
| `MASTER-PHASE-15` | Mandatory Reconstruction Stop Gate | `PART-00`, `PART-06` | N/A | `MASTER-PHASE-14` delivered | -> `MASTER-PHASE-16` ONLY with written user approval | **MANDATORY HUMAN WRITTEN APPROVAL** |
| `MASTER-PHASE-16` | Frontend-Only Reconstruction | `PART-07` | `PART-07-LOCAL-PHASE-13` | `MASTER-PHASE-15` APPROVED | -> `MASTER-PHASE-17` | Required before start |
| `MASTER-PHASE-17` | Local Build & Eight-Dimension Acceptance Verification | `PART-07` | `PART-07-LOCAL-PHASE-13.8` | `MASTER-PHASE-16` complete | Complete Session | Final Verification Sign-Off |

---

## 3. Phase Transition Rules & Governance

### 3.1 Allowed Transitions
- Sequential progression from `MASTER-PHASE-00` through `MASTER-PHASE-14` is permitted autonomously as long as safety and evidence rules are respected.
- `MASTER-PHASE-14` (Master Audit Report Delivery) is the final phase of the Reverse Engineering Audit lifecycle.

### 3.2 Forbidden Transitions (Hard Stops)
1. **Forbidden Automatic Reconstruction:** Transition from `MASTER-PHASE-14` or `MASTER-PHASE-15` to `MASTER-PHASE-16` without explicit written human authorization is strictly forbidden.
2. **Forbidden Phase Skipping:** Transitioning directly to `MASTER-PHASE-16` while bypassing `MASTER-PHASE-13` (Completeness PASS) is strictly forbidden.
3. **Forbidden State Mutation:** Transitioning into active form submissions, payment actions, or live backend mutation during any phase is strictly forbidden.

### 3.3 Feasibility Blocker Semantics (`NOT_FEASIBLE`)
- If an essential Route or Feature is provisionally evaluated as `NOT_FEASIBLE` during `MASTER-PHASE-04` or finally reconciled as `NOT_FEASIBLE` during `MASTER-PHASE-13`:
  - **`MASTER-PHASE-05` through `MASTER-PHASE-14` ARE NOT CANCELLED.**
  - Analysis, tech fingerprinting, API mapping, security auditing, and master report delivery proceed normally to capture all allowable evidence.
  - **ONLY `MASTER-PHASE-16` (Frontend Reconstruction) IS BLOCKED** by an unresolved `NOT_FEASIBLE` feature.
  - The agent must present the blocker, document scope limitations, and offer alternatives (e.g. mock shells or documentation-only delivery).

---

## 4. Mandatory Reconstruction Gate Prerequisites

`MASTER-PHASE-16` (`PART-07-LOCAL-PHASE-13`) cannot be entered unless all five criteria are verified:
1. `PART-06` audit deliverables are complete and saved.
2. `MASTER-PHASE-13` (Completeness Audit) has explicit status `PASS`.
3. Final Feasibility Reconciliation (`final-feasibility-reconciliation.md`) is complete.
4. No essential feature marked `NOT_FEASIBLE` is unaddressed or ignored.
5. The human user has provided **separate, explicit, written authorization** to proceed with frontend reconstruction.
