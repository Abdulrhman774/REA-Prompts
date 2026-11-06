---
name: rea-browser-toolkit-adapter
description: Architectural specification for the optional Browser Reverse Engineering Toolkit adapter (DESIGN_ONLY / NOT VERIFIED). Documents provenance normalization and fail-closed secret redaction for external capture files.
---

# REA Browser Reverse Engineering Toolkit Adapter

## 1. Overview & Implementation Status
> [!IMPORTANT]
> **STATUS: DESIGN_ONLY — NOT VERIFIED**  
> This skill defines the architectural specification and evidence normalization contract for the optional `Dvurechensky/Browser.Reverse.Engineering.Toolkit` adapter. **No executable adapter source code, parser script, or automated test is currently present in the REA package.** In the Skill Registry, this adapter is categorized as `DESCRIBED` / `NOT_SUPPORTED` / `NOT_VERIFIED`.

`rea-browser-toolkit-adapter` is an **optional, capability-gated translation layer** connecting offline capture outputs (`SiteSnapshotter`, `SiteCrawlerSnapshotter`, `SiteReconstructor`) to REA's provider-neutral evidence model. 

It normalizes external telemetry into standardized REA Evidence IDs (`E-xxx`), tags all imported observations with explicit provenance, verifies data sanitization, and prevents external claims from being mistaken for direct REA observations.

## 2. Activation Guidance & Strict Gate
**Default Status: NOT ACTIVATED.**
This skill must **NEVER** activate automatically. It requires all of the following conditions to be satisfied:
1. **User Written Approval:** The user must explicitly authorize loading and processing an external Browser Toolkit capture archive.
2. **Verified Local Availability:** The external capture files must physically exist in the local workspace with confirmed SHA-256 integrity digests.
3. **Skill Registry Registration:** The adapter must be explicitly registered in `{{AUDIT_DIR}}skill-registry.md` as `SUPPORTED` with evidence.

If any condition is missing, this skill remains inactive, and REA continues using native inspection capabilities exclusively.

## 3. Preconditions
- Evidence Ledger (`rea-evidence-ledger`) is active to receive normalized records.
- External capture package is accessible in a read-only local directory.

## 4. Inputs
- `SiteSnapshotter` / `SiteCrawlerSnapshotter` capture directory containing raw DOM snapshots, CSS sheets, network HAR/JSON captures, and storage dumps.
- `SiteReconstructor` generated API schemas or report exports.

## 5. Expected Outputs
- Normalized Evidence records in `{{AUDIT_DIR}}evidence-ledger.md` labeled `[IMPORTED]`.
- Adapter provenance metadata records linking each E-ID to its source capture file and SHA-256 digest.
- Ingestion audit log: `{{AUDIT_DIR}}reports/adapter-ingestion-log.md`.

## 6. Relevant REA Phases
- **Phases 0–10:** Evidence acquisition and enrichment (only when authorized).

## 7. Required Capabilities
- Filesystem read access to the external capture directory.
- JSON parsing and data sanitization routines.

## 8. Dependencies
- Normalizes into `rea-evidence-ledger`.
- Translates entities for `rea-application-graph`.
- Governed by `rea-orchestrator`.

## 9. Normalization & Provenance Contract
Every imported observation must be formatted as:
- `ID`: Sequential REA Evidence ID (`E-xxx`).
- `Label`: Mandatory `[IMPORTED]` or `[INFERRED]`. Never `[OBSERVED]`.
- `Where`: URL or element selector from the external capture.
- `What`: Sanitized telemetry snippet (DOM structure, header name, status code).
- `How`: `adapter.browser-toolkit::<component>` (e.g. `adapter.browser-toolkit::SiteSnapshotter`).
- `Provenance`:
  - `source`: `"Dvurechensky/Browser.Reverse.Engineering.Toolkit"`
  - `captureFile`: Relative path to capture file.
  - `captureSha256`: Cryptographic digest of the raw capture archive.
  - `timestamp`: Capture recording timestamp.

## 10. Security & Redaction Trust Boundaries
1. **Zero Raw Execution:** Never execute scripts, HTML snippets, or binaries contained within the external capture package.
2. **Mandatory Redaction:** All imported storage dumps, cookies, and HTTP headers must pass through REA's sanitization filter. Any discovered tokens, session IDs, passwords, or personal data must be redacted before entering the ledger.
3. **No Mandatory External Dependencies:** REA core never requires Playwright, Puppeteer, or the Browser Toolkit to be installed. REA operates 100% independently when this adapter is omitted.

## 11. Failure Handling & Fallback
- If capture files are malformed or unreadable: abort adapter ingestion, log `[LIMITATION]: External capture corrupt or unparseable`, and proceed using REA's native inspection tools.
- If sanitization fails to confirm clean data: reject the affected capture records and notify the user.

## 12. Explicit Limitations
- This adapter does not run browser automation or crawl live websites. It parses static, already-captured archives provided by an operator. The toolkit never replaces REA as the orchestrator or primary evidence authority.
