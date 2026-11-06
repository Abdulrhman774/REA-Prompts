# REA PLAN — BROWSER TOOLKIT EVALUATION PLAN
**Stage One | Generated:** 2026-11-06  
**Status:** PLAN ONLY — No toolkit accessed, no code executed, no dependencies installed.

---

## 1. Subject Repository

**URL:** https://github.com/Dvurechensky/Browser.Reverse.Engineering.Toolkit  
**Access in Stage One:** Web search only (no direct REA browser session authorized in Stage One)

---

## 2. What Is Known from Web Search (Stage One)

| Property | Value | Confidence |
|---|---|---|
| License | MIT | INFERRED from web search result |
| Primary language | TypeScript / JavaScript | INFERRED |
| Three-part structure | SiteSnapshotter, SiteCrawlerSnapshotter, SiteReconstructor | INFERRED |
| Purpose | Browser session capture, automated crawling, offline reconstruction | INFERRED |
| Maintenance status | UNKNOWN | — |
| Installation requirements | UNKNOWN | — |
| Actual dependency list | UNKNOWN | — |
| Capture format | UNKNOWN | — |
| Output schemas | UNKNOWN | — |
| Browser automation dependencies (Playwright, CDP) | INFERRED (likely) based on description | INFERRED |
| Supported OS | UNKNOWN | — |

> [!WARNING]
> All above items are INFERRED from a web search summary, not from direct repository inspection. They must be verified in Stage Two before any adapter design decisions are made.

---

## 3. Evaluation Questions for Stage Two

The following questions must be answered through direct REA browser inspection of the repository in Stage Two:

### 3.1 Repository Structure
- What files and directories exist at the top level?
- Is there a package.json? What does it list as dependencies and devDependencies?
- Is there a README.md? What does it describe?
- Are there example outputs or test fixtures?
- Is there an actual implementation of each claimed component?

### 3.2 SiteSnapshotter Evaluation
- Does it capture DOM, CSS, and assets?
- Does it capture network requests and responses?
- Does it capture storage information (localStorage, sessionStorage, cookies)?
- Does it capture routes and routing behavior?
- Does it capture runtime JavaScript signals?
- What is the capture output format? (JSON? HAR? Custom?)
- Does the actual implementation match the described capability?

### 3.3 SiteCrawlerSnapshotter Evaluation
- Does it manage browser sessions?
- What is its route discovery mechanism?
- How does it handle authentication?
- What are its crawl scope limitations?
- What browser automation library does it use? (Playwright? Puppeteer? CDP?)
- Is the browser automation dependency optional or mandatory?

### 3.4 SiteReconstructor Evaluation
- Does it produce offline capture analysis?
- Does it produce architecture reports?
- Does it produce API analysis (OpenAPI format)?
- What is the actual output quality and completeness?
- Does it produce usable mock server or SDK drafts?
- Is the output in a schema REA can consume?

### 3.5 Technical Criteria
- What is the actual dependency footprint?
- Does it require Node.js installation?
- Is it compatible with Windows?
- What browser versions/types does it support?
- What is the maintenance activity? (last commit date, open issues, stars)
- Are there any security or privacy concerns in the code?
- Is the license (MIT) compatible with REA's project?

### 3.6 REA Compatibility Assessment
- Does it add capabilities REA does not already possess through its MCP server?
- Can its capture format be normalized to REA evidence records?
- Can provenance be preserved (source, collection method, adapter identity)?
- Does activating it require installing Playwright or other external dependencies that would become mandatory REA dependencies?
- Can REA already accomplish the same capture through its own `capture_browser_scenario` and `export_environment_bundle` tools?

---

## 4. Evaluation Method in Stage Two

**Step 1:** Use REA's browser capabilities (`capture_browser_scenario` or `list_browser_targets`) to inspect the GitHub repository page.  
**Step 2:** Read the README, package.json, and key source files through REA's web inspection.  
**Step 3:** Complete the evaluation questions above.  
**Step 4:** Determine recommendation: ADOPT as optional adapter / REJECT / DEFER.

---

## 5. Adoption Decision Criteria

| Scenario | Decision |
|---|---|
| Toolkit provides capabilities REA cannot achieve natively, can be used without mandatory dependencies, and its output can be normalized to REA evidence | Recommend OPTIONAL ADAPTER design |
| REA already achieves equivalent or superior results through its own tools | Recommend SKIP / NOTE as alternative |
| Toolkit requires Playwright or CDP as a mandatory installation | Recommend REJECT (violates PART-00 tool restriction) |
| Repository is inactive, poorly documented, or has concerning dependencies | Recommend REJECT with documentation |
| Repository cannot be accessed | Document as LIMITATION; adapter design remains PENDING |

---

## 6. If Adoption Recommended — Adapter Design Principles

If the evaluation recommends adoption, the adapter architecture in Stage Two must:

1. Be entirely **optional** — REA operates fully without it
2. Preserve **original capture files** unmodified
3. **Normalize** toolkit output into REA evidence records with:
   - Source: "Browser.Reverse.Engineering.Toolkit vX.Y.Z"
   - Collection method: "BrowserToolkitAdapter.normalize()"
   - Timestamp
   - Original file reference
   - Integrity hash of original capture
4. Mark all normalized evidence as `IMPORTED` (not `OBSERVED` by REA directly)
5. Never **duplicate** evidence already collected by REA's own tools
6. Document **unsupported fields** explicitly
7. Require **explicit user authorization** before activation
8. Not require Playwright, CDP, or any external browser tool as a mandatory REA dependency

---

## 7. Stage Two Authorization Required Before

The following actions require explicit user approval **not yet obtained**:
- Accessing the repository through REA browser tools
- Installing the toolkit
- Executing any toolkit code
- Designing the adapter (can design without install, but install needs approval)
