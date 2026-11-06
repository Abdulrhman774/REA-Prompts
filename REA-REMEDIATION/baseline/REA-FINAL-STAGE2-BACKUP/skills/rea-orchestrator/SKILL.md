---
name: rea-orchestrator
description: Master orchestrator for the Reverse Engineering Agent (REA). Coordinates session initialization, documentation loading, Skill Registry construction, phase gating, and approval workflows.
---

# REA Master Orchestrator

## 1. Overview & Purpose
`rea-orchestrator` is the primary cognitive conductor of the REA system. It enforces phase sequencing, ensures strict compliance with `PART-00-MASTER-CONTROL.md`, manages the lifecycle of all subordinate REA skills, and guarantees that no protected phase (especially `PART-07` reconstruction) is executed without explicit written user approval.

REA is the primary orchestrator, evidence authority, and analysis engine. It is never replaced by external scripts, tools, or autonomous frameworks.

## 2. Activation Guidance
Activate this skill at the inception of any reverse-engineering task, when resuming an investigation from a checkpoint, or when coordinating phase transitions across `PART-00` through `PART-07`.

## 3. Preconditions
- The workspace contains the REA documentation suite (`PART-00` to `PART-07`, `REA-SCHEMAS.md`).
- Target URL (`{{TARGET_URL}}`) and project slug (`{{PROJECT_SLUG}}`) have been designated by the user.
- Execution environment has verified connectivity to the REA MCP provider (`rea-agents@6.8.0`) or documented fallbacks.

## 4. Inputs
- Project parameters: `{{PROJECT_NAME}}`, `{{TARGET_URL}}`, `{{PROJECT_SLUG}}`, `{{AUDIT_DIR}}`, `{{RECON_DIR}}`, `{{SESSION_ALIASES}}`.
- User instructions defining the active partition or target scope.
- Historical checkpoints (`checkpoint.md`) and progress logs (`progress-log.md`) when resuming.

## 5. Expected Outputs
- Per-phase gating verdicts (`PASS`, `FAIL`, `PARTIAL`).
- Initialized workspace audit directory structure.
- Coordinated invocations of specialized REA skills.
- End-of-partition status summaries and explicit stop checkpoints.

## 6. Relevant REA Phases
- **Phases 0–13:** Master lifecycle oversight across all partitions.

## 7. Required Capabilities
- `nav.open-url` (Phase 0 bootstrap verification)
- Local filesystem read/write for audit logs and checkpoints.

## 8. Dependencies
Directly orchestrates:
- `rea-evidence-ledger`
- `rea-feasibility-assessment`
- `rea-rendering-analysis`
- `rea-application-graph`
- `rea-schemas-ir`
- `rea-frontend-reconstruction`
- `rea-validation`
- `rea-browser-toolkit-adapter` (optional, capability-gated)

## 9. Evidence Requirements
- Every orchestration decision, phase transition, and gate evaluation must cite supporting Evidence IDs (`E-xxx`) or Checkpoint records.
- Unverified capabilities or incomplete phase prerequisites must be flagged with `[LIMITATION]` or `[UNKNOWN]`.

## 10. Safety & Security Requirements
- **Observe, Navigate, Read Only:** Enforce passive-only inspection; strictly prohibit exploitation, brute force, fuzzing, automated vulnerability scanning, or unauthorized credential use.
- **Stop Gates:** Automatically halt execution at the end of each partition. Never auto-advance to a subsequent Part without explicit user instruction.
- **Reconstruction Protection:** Phase 13 (`PART-07`) is strictly forbidden until Phase 11 passes and explicit written user approval is received.

## 11. Failure Handling & Fallback Behavior
- If an essential capability is missing or unverified during Phase 0: halt progression, log `[LIMITATION]` in `capability-matrix.md`, and report the blocker.
- If a phase gate fails: do not advance; detail the specific missing deliverables or unverified claims in `progress-log.md` and present remediation options to the user.

## 12. Explicit Limitations
- This skill provides procedural orchestration instructions; it does not execute browser actions or operating system commands directly. Concrete execution occurs exclusively through verified MCP tools.
