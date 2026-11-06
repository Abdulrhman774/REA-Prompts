# REA PLAN — CONFLICTS AND RESOLUTIONS
**Stage One | Generated:** 2026-11-06  
**Status:** ANALYSIS — Identified during source inspection. No source files modified.

---

## Conflict Classification

| Code | Meaning |
|---|---|
| **C-INTERNAL** | Contradiction within existing source files |
| **C-WORKORDER** | Tension between work order requirements and existing source |
| **C-NAMING** | Terminology inconsistency between documents |
| **C-GAP** | Work order requires something the source has no mechanism for |
| **R-ADDITIVE** | Resolution: additive clarification sufficient |
| **R-EXTEND** | Resolution: extend existing mechanism |
| **R-NEW** | Resolution: new file or section required |

---

## 1. Naming Inconsistency — Capability Status Labels

**Type:** C-NAMING  
**Location:** Work order §4 vs. PART-00 and REA-SCHEMAS §2.2

**Work order uses:** `SUPPORTED` / `NOT_SUPPORTED` / `NOT_VERIFIED`  
**Source uses:** `Supported` / `Not supported` / `Not verified` (mixed case)

**Resolution (R-ADDITIVE):** No source text removal required. The final REA-MASTER-PROMPT.md and new Skills will use `SUPPORTED` / `NOT_SUPPORTED` / `NOT_VERIFIED` (all-caps) consistently. A normalization note will clarify the two are equivalent in meaning. The original source text is not changed.

---

## 2. Work Order Feasibility Gate vs. PART-01 Current Structure

**Type:** C-GAP  
**Location:** Work order §6 vs. PART-01

**Issue:** PART-01 (Phase 0) currently ends with capability discovery and Skill Registry construction. The work order requires a mandatory provisional feasibility assessment as an additional Phase 0 step — classifying per-Route and per-Feature feasibility before the full investigation begins. This requires that the agent have enough initial data about the target (from one initial page load in Phase 0 step 5) to make provisional feasibility assessments.

**Contradiction potential:** The provisional feasibility assessment requires inspecting initial HTML, DOM, hydration indicators, JavaScript bundles, and routing behavior — but Phase 0 currently limits itself to "load the target exactly once" for baseline purposes. A full multi-step investigation belongs to Phases 1–7.

**Resolution (R-ADDITIVE):** The provisional feasibility assessment is explicitly scoped as:
- Performed only on the data available from Phase 0's single initial load
- Marked PROVISIONAL throughout
- Explicitly not a substitute for the full discovery process
- Using only evidence available from Phase 0 (initial HTML, page title, visible response characteristics, initial capability assessment)
- Items not determinable from Phase 0 evidence are marked UNKNOWN — not invented

This avoids expanding Phase 0's scope beyond its one-load baseline while satisfying the work order's requirement for an early gate. No existing Phase 0 text is changed; a new DO block is added.

---

## 3. Rendering Mode — PART-04 vs. Work Order Requirement

**Type:** C-WORKORDER  
**Location:** Work order §7 vs. PART-04 Phase 6

**Issue:** PART-04 Phase 6 already mentions rendering mode as part of technology fingerprinting. The work order requires rendering mode investigation to happen **early** (Phase 0, provisional) and again fully in Phase 6, with per-route classification, component origin labeling, and new capability contracts.

**Contradiction:** Moving rendering mode to Phase 0 without changing PART-04 would create duplication. Making it solely a Phase 0 activity would remove it from PART-04 where full evidence is available.

**Resolution (R-ADDITIVE):** Two-phase approach:
1. **Phase 0 (PART-01):** Provisional rendering mode observation from initial load only. Labeled PROVISIONAL/INFERRED.
2. **Phase 6 (PART-04):** Full rendering mode classification per-Route using all available evidence. Final classification.
3. **No text removed from PART-04.** PART-01 receives a new additive block. PART-04 receives an extension to its additive block.

---

## 4. Work Order "Feature" Node vs. Existing Graph Schema

**Type:** C-GAP  
**Location:** Work order §9 vs. REA-SCHEMAS §3.2

**Issue:** Work order §9 requires Feature nodes with feasibilityDecision, feasibilityReason, evidenceReferences, and reconstructionNotes. The current Graph schema has no Feature node type. Features are currently modeled within Routes, Components, and Interactions.

**Resolution (R-EXTEND):** Rather than introducing a new node type (which would require changing Phase definitions and the IR schema), feasibility properties will be added as optional attributes on the most relevant existing node types:
- Route-level features → `Route.attrs.feasibility` (new field group)
- Component-level features → `Component.attrs.feasibility` (new field group)
- Complex multi-route features → documented in the investigation plan and carried as an annotation

This is additive and avoids breaking the existing schema. A `feature` label can be used as an optional tag within existing node `attrs`. If the user later requests a full Feature node type, that is a minor revision.

---

## 5. Work Order §5 Variables vs. PART-00 Project Parameters

**Type:** C-WORKORDER  
**Location:** Work order §5 vs. PART-00 Project parameters table

**Issue:** Work order §5 defines new Master Prompt variables: `{{REA_DOCS_SOURCE}}`, `{{TARGET_WEBSITE}}`, `{{AUTHORIZATION_CONFIRMATION}}`, `{{WORKSPACE_PATH}}`, `{{OPTIONAL_BROWSER_TOOLKIT_SOURCE}}`. PART-00 defines: `{{PROJECT_NAME}}`, `{{TARGET_URL}}`, `{{PROJECT_SLUG}}`, `{{AUDIT_DIR}}`, `{{RECON_DIR}}`, `{{SESSION_ALIASES}}`.

`{{TARGET_WEBSITE}}` from the work order corresponds to `{{TARGET_URL}}` in PART-00.

**Resolution (R-ADDITIVE):** The REA-MASTER-PROMPT.md will use the work order's variable names for the session initialization block, and explicitly map them to the PART-00 equivalents:
- `{{TARGET_WEBSITE}}` → maps to `{{TARGET_URL}}`
- `{{WORKSPACE_PATH}}` → maps to `{{AUDIT_DIR}}` base path
- `{{REA_DOCS_SOURCE}}` → path to REA-FINAL documentation
- `{{AUTHORIZATION_CONFIRMATION}}` → user's authorization statement from PART-00
- `{{OPTIONAL_BROWSER_TOOLKIT_SOURCE}}` → optional; only used if adapter is activated

The PART-00 variables are NOT changed. The Master Prompt sits above PART-00 and resolves values before passing them to the Parts.

---

## 6. Work Order "SUPPORTED/NOT_SUPPORTED" vs. Source "Supported/Not supported" for Skill Status

**Already covered in Conflict 1 above.** Marked for normalization in REA-MASTER-PROMPT and new Skills only.

---

## 7. Missing Appendix E / Final Checklist

**Type:** C-INTERNAL  
**Location:** PART-06 Phase 11 step 7 references "the final checklist in PART 00 and the original Appendix E requirements"

**Current status:** SUBSTITUTE-CHECKLIST.md exists and is explicitly labeled as a substitute. PART-06 step 7a already handles this case with the generation of `completion-checklist-substitute.md`.

**Resolution:** ALREADY HANDLED in source. No change required. Stage Two final SUBSTITUTE-CHECKLIST.md will be updated to include any new checklist items from the feasibility gate and eight-dimension acceptance framework additions.

---

## 8. Antigravity Path Conventions

**Type:** C-NAMING  
**Location:** Work order §15 vs. agy-customizations SKILL.md

**Issue:** Work order §15 says to verify current official Antigravity documentation before selecting paths. The user's config shows skills are in `~/.gemini/config/skills/`. The agy-customizations skill confirms global config is `~/.gemini/config/`.

**Verified conventions (from agy-customizations SKILL.md):**
- Global Skills: `~/.gemini/config/skills/<name>/SKILL.md`
- Global Rules: `~/.gemini/config/rules/*.md` (confirmed: browser.md and persistent-memory.md exist there)
- Workspace Skills: `.agents/skills/<name>/SKILL.md` in project root
- Skill format: folder with SKILL.md having YAML frontmatter (name, description)

**Resolution:** The REA-FINAL package will use these verified paths. The installer will deploy to these locations. No invented paths used.

---

## 9. Work Order §17 — Skills Count Discrepancy

**Type:** C-WORKORDER  
**Location:** Work order §17 vs. actual inspection

**Work order claims:** "The user previously reported 82 installed Skill folders."  
**Actual inspection:** 
- `C:\Users\abd alrhman\.agents\skills`: **79 folders** found
- `C:\Users\abd alrhman\.gemini\config\skills`: **82 folders** found (includes persistent-memory, reverse-engineer-anything, rtk which are absent from .agents)

**Resolution:** The `.gemini/config/skills` directory is the active global skills location per verified Antigravity conventions. The `.agents/skills` directory appears to be a secondary or legacy location. Both contain the same core set. Stage Two work targets `~/.gemini/config/skills/`.

---

## 10. Browser Toolkit Evaluation — Limited Evidence

**Type:** C-GAP  
**Location:** Work order §14 vs. Stage One access constraints

**Issue:** The work order requires evaluating `https://github.com/Dvurechensky/Browser.Reverse.Engineering.Toolkit`. Direct repository access was not available in Stage One (no browser tool authorized for Stage One). Web search returned a summary but not actual repository inspection.

**What is known from web search:**
- MIT License ✓
- Three components: session capture, automated crawling, offline reconstruction ✓
- TypeScript/JavaScript implementation
- Designed for web reverse engineering

**What is unknown:** Actual file structure, actual dependency list, actual capture format schema, actual output schemas, actual maintenance activity, actual installation requirements.

**Resolution:** The BROWSER-TOOLKIT-EVALUATION-PLAN.md documents what can be evaluated in Stage Two using the REA browser tools (which are already authorized for web investigation tasks). The evaluation must use REA's own browser capabilities to inspect the GitHub repository before any adapter is designed.

**Stage One constraint respected:** No toolkit accessed, no code executed, no dependencies installed.
