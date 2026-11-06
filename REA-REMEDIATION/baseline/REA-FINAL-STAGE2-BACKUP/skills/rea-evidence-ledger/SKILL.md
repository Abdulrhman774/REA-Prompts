---
name: rea-evidence-ledger
description: Evidence and findings management for REA. Manages sequential E-IDs, F-IDs, evidentiary labels (OBSERVED, INFERRED, UNKNOWN, LIMITATION, IMPORTED), confidence levels, and strict provenance.
---

# REA Evidence Ledger

## 1. Overview & Purpose
`rea-evidence-ledger` manages the evidentiary foundation of all REA reverse-engineering work. It enforces the strict rule that **no substantive claim may be made without traceable evidence**. It maintains sequential, immutable Evidence IDs (`E-xxx`) and Findings IDs (`F-xxx`), enforces label discipline, tracks provenance, and guarantees data sanitization.

## 2. Activation Guidance
Activate this skill whenever capturing raw observations, recording discoveries, registering technology claims, formulating findings, or reviewing evidence integrity across all REA phases.

## 3. Preconditions
- `PART-00-MASTER-CONTROL.md` evidence and findings contract is loaded.
- `{{AUDIT_DIR}}evidence-ledger.md` and `{{AUDIT_DIR}}findings.md` are initialized (Phase 0).

## 4. Inputs
- Raw observation snippets from MCP tools (DOM snippets, HTTP headers, console messages, URL strings, screenshot references).
- Operational metadata: URL, element selector, REA operation, timestamp/step, role alias (`Session`), and Skill ID.
- External capture payloads (when imported via optional adapters).

## 5. Expected Outputs
- Formatted Evidence records in `{{AUDIT_DIR}}evidence-ledger.md`:
  `ID | Where | What | How | When | Session | Skill`
- Formatted Findings records in `{{AUDIT_DIR}}findings.md`:
  `ID | Title | Category | Label | Confidence | Severity | Evidence | URL(s) | Impact | Recommendation`
- Integrity validation reports confirming zero unlabeled claims, zero unevidenced technologies, and zero unredacted secrets.

## 6. Relevant REA Phases
- **Phases 0–13:** Continuous across every phase of discovery, analysis, auditing, and reconstruction verification.

## 7. Required Capabilities
- Filesystem read/append access to audit directory markdown files.

## 8. Dependencies
- Used by `rea-orchestrator`, `rea-application-graph`, `rea-feasibility-assessment`, and `rea-validation`.
- Integrates with `rea-browser-toolkit-adapter` for external provenance tagging.

## 9. Evidence Requirements & Label Definitions
Every statement must carry exactly one label:
- `[OBSERVED]`: Directly seen, read, or measured by REA through a verified Skill.
- `[INFERRED]`: Reasoned from direct observations; must include explicit reasoning text and confidence (`High` / `Medium` / `Low`).
- `[UNKNOWN]`: Information cannot be determined from available evidence. Never fabricate a placeholder value.
- `[LIMITATION]`: Information blocked by tool limitations, scope boundaries, or access controls.
- `[IMPORTED]`: Data imported from an optional external capture or adapter. Must cite source tool, capture file hash, and normalization method. Never upgrade to `OBSERVED`.

Confidence Scale (for technology, architecture, and vulnerability claims):
- `High`: Direct, unambiguous evidence (e.g. explicit header, verified runtime object, confirmed signature).
- `Medium`: Multiple consistent indirect signals.
- `Low`: A single weak or ambiguous signal.

## 10. Safety & Redaction Rules
- **Absolute Redaction:** Never record real credentials, session cookies, auth tokens, API keys, patient records, or personal data (PII) in any ledger, finding, graph node, or report.
- Secrets must be recorded by location and type only, with values redacted (at most first and last 3 characters, e.g. `eyJ...xyz`).
- Request and response bodies containing personal data must be recorded by field name and type only (e.g. `user_id: string`), never literal values.

## 11. Failure Handling & Fallback Behavior
- If an observation cannot be linked to a concrete URL or operation: mark as `[UNKNOWN]` and record the reason in the progress log.
- If conflicting evidence is encountered across phases: do not delete previous evidence; create an append-only reconciliation finding citing both E-IDs and logging the discrepancy in `contradictions-and-resolution.md`.

## 12. Explicit Limitations
- The Evidence Ledger is an audit tracking discipline; it does not collect network traffic or DOM snapshots independently. It formats, sanitizes, and indexes evidence emitted by concrete MCP execution tools.
