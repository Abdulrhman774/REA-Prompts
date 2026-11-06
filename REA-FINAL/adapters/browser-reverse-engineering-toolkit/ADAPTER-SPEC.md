# BROWSER REVERSE ENGINEERING TOOLKIT ADAPTER — TECHNICAL SPECIFICATION

**Document ID:** REA-ADAPT-BRET-SPEC-001  
**Package:** `rea-browser-toolkit-adapter`  
**Schema Version:** 1.0  
**Target Toolkit:** `Dvurechensky/Browser.Reverse.Engineering.Toolkit`  
**Status:** DESIGN_ONLY — NOT VERIFIED (No executable source code present; specification only)

> [!NOTE]
> **PROVENANCE ENFORCEMENT:**  
> All external capture data ingested through this specification is strictly labeled `IMPORTED` (or `INFERRED`). External telemetry must **NEVER** be labeled `OBSERVED`, which is reserved exclusively for direct observations verified by REA.

---

## 1. Supported Operations

| Operation ID | Description | Source Component | Output Entity |
|---|---|---|---|
| `import.routes` | Extracts discovered URLs, route patterns, and navigation links | `SiteCrawlerSnapshotter` | `Route` nodes, `navigatesTo` edges |
| `import.dom` | Normalizes captured DOM trees and element hierarchies | `SiteSnapshotter` | `ComponentInstance` nodes, `renders` edges |
| `import.styles` | Normalizes extracted CSS rules and design variables | `SiteSnapshotter` | `DesignToken` nodes |
| `import.traffic` | Normalizes network request/response transactions | `SiteSnapshotter` / Crawler | `ApiEndpoint` nodes, `dependsOn` edges |
| `import.storage` | Extracts storage keys and data structures | `SiteSnapshotter` | `State` and `Route` storage attributes |
| `import.assets` | Extracts asset URLs, types, and resource hashes | `SiteSnapshotter` | `Asset` nodes, `asset-register.md` |
| `import.reconstructor-report` | Ingests offline architectural summaries and OpenAPI drafts | `SiteReconstructor` | `architecture-report.md` additions (labeled `INFERRED`) |

---

## 2. Input Directory Structure

The adapter expects capture bundles conforming to the standard BRET layout:

```text
<capture_root>/
├── metadata.json              # Timestamp, start URL, user agent, viewport settings
├── routes/
│   └── sitemap.json           # Array of discovered URLs and status codes
├── pages/
│   ├── <hash>/
│   │   ├── url.txt            # Target URL
│   │   ├── dom.html           # Final rendered DOM
│   │   ├── styles.json        # Extracted CSS rules and computed variables
│   │   ├── storage.json       # localStorage and sessionStorage dumps
│   │   └── screenshot.png     # Rendered screenshot
├── network/
│   ├── transactions.har       # HTTP Archive file (or JSON transaction list)
│   └── websockets.json        # Captured WebSocket frames (if any)
└── reconstructor/             # Optional SiteReconstructor outputs
    ├── openapi.yaml           # Inferred OpenAPI specification
    └── architecture.json      # Inferred component and API report
```

---

## 3. Field-by-Field Normalization Mapping Table

| BRET Capture Field | REA Evidence / Graph Target | Normalization Transform | Label Assigned |
|---|---|---|---|
| `routes.sitemap[].url` | `Route.urls[]` | Strip query secrets, validate against `ALLOWED_SCOPE` | `IMPORTED` |
| `routes.sitemap[].statusCode` | `Route.attrs.statusCode` | Direct integer mapping | `IMPORTED` |
| `pages[].dom.html` | `ComponentInstance.domLocator` | Extract semantic landmarks; strip inline scripts | `IMPORTED` |
| `pages[].styles.colors[]` | `DesignToken.attrs.value` | Normalize to hex/rgb; set `valueKind: "authored"` | `IMPORTED` |
| `pages[].storage.localStorage` | `Route.attrs.storage.local` | Scrub values; retain keys and inferred data types | `IMPORTED` |
| `network.transactions[].request.url` | `ApiEndpoint.urlPattern` | Extract endpoint pattern; redact sensitive query params | `IMPORTED` |
| `network.transactions[].request.method` | `ApiEndpoint.method` | Upper-case string (`GET`, `POST`, etc.) | `IMPORTED` |
| `network.transactions[].response.status` | `ApiEndpoint.status` | Direct integer mapping | `IMPORTED` |
| `network.transactions[].response.body` | `ApiEndpoint.shape` | Parse JSON; record field names and types only. **Drop values** | `INFERRED` |
| `reconstructor.openapi.paths` | `ir.json::mockContracts` | Map to mock contracts; tag as inferred drafts | `INFERRED` |

---

## 4. Output Schemas

### 4.1 Evidence Record Output Format
```markdown
| E-205 | https://target.app/api/user/profile | Response keys: id: int, name: str, email: str | adapter.browser-toolkit::SiteSnapshotter | 2026-11-06T15:30:00Z | guest | adapter.browser-toolkit |
```

### 4.2 Graph Fragment JSONL Output Format
```json
{
  "op": "add",
  "kind": "node",
  "record": {
    "id": "A-012",
    "type": "ApiEndpoint",
    "name": "/api/user/profile",
    "label": "IMPORTED",
    "confidence": "Medium",
    "evidence": ["E-205"],
    "phase": "7",
    "urls": ["https://target.app/api/user/profile"],
    "session": "guest",
    "skill": "adapter.browser-toolkit",
    "attrs": {
      "method": "GET",
      "urlPattern": "/api/user/profile",
      "status": 200,
      "resourceType": "xhr",
      "shape": "id: integer, name: string, email: string"
    }
  }
}
```

---

## 5. Error & Edge Case Handling

| Error Condition | Adapter Action | Log Level | Fallback |
|---|---|---|---|
| Unredacted Authorization Header found | Scrub header; alert in ingestion log | WARNING | Value replaced with `[REDACTED_SECRET]` |
| Malformed HAR file | Skip transaction file; log affected line | ERROR | Ingest remaining page DOM and route files |
| Out-of-Scope URL in crawl | Discard URL; do not create Route node | INFO | Recorded in `not-tested-passive-only.md` |
| Unrecognized JSON structure | Record raw snippet in unparsed records | WARNING | Tagged `[UNKNOWN]` with parse error reason |
| Missing metadata manifest | Synthesize metadata with timestamp `UNKNOWN` | WARNING | Timestamp omitted; source marked UNKNOWN |
