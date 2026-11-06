# REA PLAN — SECURITY AND RISK ASSESSMENT
**Stage One | Generated:** 2026-11-06

---

## 1. Security Principles (Non-Negotiable)

The following principles are inherited from the original source and must be preserved:

| Principle | Source | Status |
|---|---|---|
| Observe only — no exploitation, injection, brute force | PART-00 Safety rules | PRESERVED |
| No bypass of authentication, MFA, WAF, or rate limits | PART-00 Safety rules | PRESERVED |
| Stay within authorized scope | PART-00 Mission | PRESERVED |
| No real credentials stored, logged, or exported | PART-00 Safety rules | PRESERVED |
| No real payment, deletion, or irreversible actions | PART-00 Safety rules | PRESERVED |
| No personal or sensitive data in Graph, IR, or reconstruction artifacts | PART-00 Graph/IR contract | PRESERVED |
| Secrets recorded by location/type only, values redacted | PART-00 Safety rules | PRESERVED |
| Do not overwrite original files | PART-00 Safety rules | PRESERVED |
| Ask before installing dependencies | PART-00 Safety rules | PRESERVED |

---

## 2. Risks Introduced by the Work Order Enhancements

### 2.1 Feasibility Gate — Risk Assessment

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Provisional feasibility FEASIBLE leading to over-confidence | Medium | High | Mark ALL provisional assessments as PROVISIONAL/INFERRED; require Phase 11 reconciliation |
| NOT FEASIBLE causing premature abandonment when target is actually feasible | Low | Medium | Require explicit user confirmation before stopping; present alternatives |
| Feasibility classification based on insufficient evidence | Medium | Medium | Only use Phase 0 evidence; mark all unknowns explicitly |

### 2.2 Rendering Mode Analysis — Risk Assessment

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Incorrect rendering mode classification leading to wrong reconstruction | Medium | High | Evidence-based only; mark INFERRED; Phase 6 full classification overrides Phase 0 provisional |
| Claiming rendering mode without evidence | Low | Medium | PART-00 evidence rules already prohibit this |

### 2.3 Browser Toolkit Adapter — Risk Assessment

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Toolkit introduces mandatory Playwright/CDP dependency | Medium | High | Evaluate before design; reject if mandatory |
| Toolkit captures personal/sensitive data | Medium | High | REA evidence rules apply to ALL imported data; redaction required |
| Toolkit output claimed as direct REA observation | Low | High | Adapter provenance schema ensures IMPORTED label |
| Unauthorized installation of toolkit | Low | High | Explicit user approval required before any install |
| Toolkit has security vulnerabilities | Unknown | Medium | Evaluate dependencies; npm audit before use |

### 2.4 Installer — Risk Assessment

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Installer overwrites existing valuable skills | Low | High | Backup-before-replace is mandatory |
| Installer executes scripts without user consent | Low | High | Scripts excluded by default; opt-in required |
| Installer with wrong paths corrupts Antigravity config | Medium | High | Dry-run first; verify paths against confirmed conventions |
| Manifest with placeholder/invalid sources | Medium | Medium | Validation checks; never leave enabled entries with placeholder sources |

### 2.5 Antigravity Rules — Risk Assessment

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Rules file weakens existing safety requirements | Low | High | Rules are additive only; explicitly state they do not override PART-00 |
| Rules conflict with existing rules (browser.md, persistent-memory.md) | Low | Low | Different scope; deduplication by file path in Antigravity |

---

## 3. Privacy Risks

| Risk | Mitigation |
|---|---|
| REA session captures personal data from target website | Evidence rules already prohibit storing values; field names and types only |
| Reconstruction artifacts contain real data | PART-07 §5 explicitly forbids; monitoring in rea-validation Skill |
| Skill files contain investigation results | Skills are documentation; they do not contain project-specific data |
| Memory system captures sensitive session data | Persistent-memory skill's privacy rules apply; no secrets stored |

---

## 4. Integrity Risks

| Risk | Mitigation |
|---|---|
| Stage Two accidentally modifies original source files | SHA-256 checksums recorded in SOURCE-INVENTORY.md; FILE-CHANGE-REPORT.md will verify |
| Additive changes accidentally weaken safety requirements | Every PART file change will be reviewed against the CAPABILITY-PRESERVATION-MATRIX |
| Graph fragments are edited (not append-only) | rea-application-graph Skill explicitly enforces append-only rule |
| IR freeze bypassed | rea-schemas-ir Skill explicitly enforces freeze conditions |

---

## 5. Operational Risks

| Risk | Likelihood | Mitigation |
|---|---|---|
| Agent drifts from REA-MASTER-PROMPT instructions | Medium | Master Prompt includes explicit phase enforcement; Antigravity Rules reinforce |
| Skills claimed as execution providers | Medium | Every SKILL.md explicitly states the skill provides guidance, not execution |
| Part 07 auto-starts without approval | Low | Multiple gate layers: PART-06 stop gate + rea-frontend-reconstruction activation check |

---

## 6. Stage One Risks (This Phase)

| Risk | Status |
|---|---|
| Stage One modifying original source files | MITIGATED — only REA-PLAN/ directory created; source untouched |
| Stage One installing any dependencies | MITIGATED — no installations performed |
| Stage One accessing external tools | MITIGATED — only web search used; no browser sessions started |
| Stage One executing any external code | MITIGATED — no code executed |

---

## 7. What Cannot Be Verified Until Stage Two

| Item | Why |
|---|---|
| Installer safety in actual Antigravity environment | Cannot test without writing the installer first |
| Browser Toolkit security | Cannot evaluate without REA browser access |
| REA MCP server actual capability list | Requires a live Phase 0 session |
| Workflow directory conventions | Need to verify from full Antigravity documentation |
