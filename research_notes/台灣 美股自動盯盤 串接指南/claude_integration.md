# Claude × US-stock brokers / market data × LINE alerts: integration landscape, architecture, costs, risks (as of 2026-10-17)

> Research date: 2026-10-17. Method note: Several official pages could not be fetched directly from this research environment because of network blocks: docs.alpaca.markets, interactivebrokers.com/.ie, tw.linebiz.com, developers.line.biz, arxiv.org and core.telegram.org. For those pages, the facts below come from search-engine summaries of the official URLs and are marked "(via search summary)". I fetched these pages in full: the Anthropic pricing page, the Anthropic Usage Policy, the Claude Code / Agent SDK docs, and the Alpaca MCP GitHub README. Treat "via search summary" items as needing a final click-through check before publication.

## Q1. MCP servers for brokers and market data (official vs community, capabilities, maintenance, security)

### Takeaway
Only Alpaca ships an official, open-source MCP server that can place real orders (paper by default). Interactive Brokers launched an official MCP connector in July 2026. Sources describe it as login-authorized and drafting "AI Instructions" that the user reviews and submits in IBKR, but this is not fully verified. Market-data MCPs range from official ones (Massive/ex-Polygon, Financial Datasets) to community ones of mixed quality (Yahoo Finance wrappers, and the Alpha Vantage server, whose "official" status is unclear). All local stdio servers carry your API keys. None of them should be exposed as a remote server without auth.

### Cited Findings
**Alpaca (official, can trade)**
- The official repo is `github.com/alpacahq/alpaca-mcp-server`. It describes itself as "A comprehensive MCP server for Alpaca's Trading API… Supports stocks, options, crypto, portfolio management, and real-time market data." — [Alpaca MCP README (GitHub main, fetched 2026-10-17)](https://github.com/alpacahq/alpaca-mcp-server)
- "Alpaca MCP Server v2" is "a complete rewrite built with FastMCP and OpenAPI". "None of the V1 tools exist in V2", so prompts or scripts that use V1 tool names are obsolete. — [Alpaca MCP README](https://github.com/alpacahq/alpaca-mcp-server)
- Order capability: it can "Place market, limit, stop, stop-limit, and trailing-stop orders for stocks, crypto, and options. Cancel orders individually or in bulk", handles multi-leg options, and can close or liquidate positions and exercise options. — [Alpaca MCP README](https://github.com/alpacahq/alpaca-mcp-server)
- Paper vs live: the env var `ALPACA_PAPER_TRADE` defaults to `true` ("Set to `false` for live trading"). Live trading also requires live API keys. — [Alpaca MCP README](https://github.com/alpacahq/alpaca-mcp-server)
- Least-privilege control: `ALPACA_TOOLSETS` restricts the server-side toolsets: `account`, `trading`, `watchlists`, `assets`, `stock-data`, `crypto-data`, `options-data`, `corporate-actions`, `news`, `fixed-income-data`, `locates`. By default all tools are enabled. — [Alpaca MCP README](https://github.com/alpacahq/alpaca-mcp-server)
- Security warning in the README: "This package does not configure remote MCP authentication, so do not expose it directly to the public internet with your Alpaca API keys. Use the local stdio setup." Claude Mobile and ChatGPT require a remote server, so the README tells users not to use them this way. — [Alpaca MCP README](https://github.com/alpacahq/alpaca-mcp-server)
- The README includes a `tool_registry.py` holding "Tool names, descriptions, and output risk classifications". Its disclaimer says "Users are responsible for monitoring algorithmic activity… Alpaca is not liable for any losses." — [Alpaca MCP README](https://github.com/alpacahq/alpaca-mcp-server)
- Setup needs Python 3.10+, uv, and Alpaca API keys (a free paper account). It can be added to Claude Code with `claude mcp add alpaca --scope user --transport stdio uvx alpaca-mcp-server`. — [Alpaca MCP README](https://github.com/alpacahq/alpaca-mcp-server)
- Activity: a third-party tracker reports about 708 stars and 221 forks, with the last push in April 2026. Alpaca's docs page states its info is "current as of November 20, 2025" (via search summary). The server sends a user-agent `ALPACA-MCP-SERVER` with API calls. — [gittrend.io](https://gittrend.io/repo/alpacahq/alpaca-mcp-server); [Alpaca docs](https://docs.alpaca.markets/docs/alpaca-mcp-server); [llmbase.ai](https://llmbase.ai/mcp-servers/alpaca/)

**Interactive Brokers (official connector, July 2026; community servers)**
- IBKR press release "Interactive Brokers Opens AI Connectivity to Any Tool Built on the MCP Standard". The URL slug `7-28-26` suggests 2026-07-28. Clients add it via "add MCP server/custom connector", log in through IBKR's secure screen and authorize a single account. It works across Client Portal, IBKR Desktop, GlobalTrader, Mobile and TWS. Gemini support is listed as "coming soon" (via search summary). — [IBKR press release](https://www.interactivebrokers.com/en/index.php?f=78687); [IBKR IE mirror](https://interactivebrokers.ie/en/general/about/mediaRelations/7-28-26.php)
- A third-party broker comparison says that with IBKR "the AI agent never reaches the order book". The AI drafts a trade instruction, and the user reviews it and submits it inside IBKR. A separate walkthrough says drafts show under "Orders & Trades → AI Instructions" with "Review & Submit / Reject". The same guide also notes "no read-only mode or caps documented." I could not confirm this on IBKR's own pages. — [StockBrokers.com AI-agent brokers guide (2026)](https://www.stockbrokers.com/guides/ai-agent-brokers); [mikareyes.com walkthrough](https://mikareyes.com/ai/how-to-setup-trades-with-interactive-brokers-and-claude)
- Community servers:
  - `code-rabi/interactive-brokers-mcp` is "unofficial… NOT affiliated with or endorsed by Interactive Brokers" and in "Alpha state". Last push 2026-03-25.
  - `osauer/ibkr` is read-only, v1.3.0 (2026-05-27).
  - `kelvingao/ibkr-mcp` requires TWS or IB Gateway to be running.
  - Community TWS/Gateway servers can place orders only if the user unchecks "Read-Only API".
  - The hosted "IBKR Gateway" bridge offers per-app Read-only, which hides `place_order` and `cancel_order`, or Read & write.
  - [Glama code-rabi README](https://glama.ai/mcp/servers/@code-rabi/interactive-brokers-mcp/blob/dc2095c53552b7379015dbba7a6c8ebc858032e7/README.md); [gittrend code-rabi](https://gittrend.io/repo/code-rabi/interactive-brokers-mcp); [getdrio osauer/ibkr](https://www.getdrio.com/mcp/io-github-osauer-ibkr/md); [Glama kelvingao](https://glama.ai/mcp/servers/@kelvingao/ibkr-mcp/tree/160f74c481d448eaa372d0136aed5386ab1c7baf); [IBKR Gateway](https://ibkr-gateway.bogdanripa.com/)
- Community projects advise: "always test with paper trading first" and "only be run locally, never on public servers" (via search summary). — [Glama code-rabi README](https://glama.ai/mcp/servers/@code-rabi/interactive-brokers-mcp/blob/dc2095c53552b7379015dbba7a6c8ebc858032e7/README.md)

**Market data MCPs**
- Massive (formerly Polygon.io) has an official MCP server (`polygon-io/mcp_polygon`, MIT). Instead of one tool per endpoint, it exposes composable tools: search, call, query, and in newer versions also docs. The README says it is "experimental and could be subject to breaking changes". Needs Python 3.12+, a Massive API key and uv. — [Glama manifest](https://glama.ai/mcp/servers/@polygon-io/mcp_polygon/blob/519b6666c02863481fcbf10ba9274cac6bc7125b/manifest.json); [mcpservers.org](https://mcpservers.org/de/servers/polygon-io/mcp_polygon)
- Alpha Vantage: directories list `https://mcp.alphavantage.co` as an "Official Alpha Vantage MCP Server", but the package and repo sit under a personal GitHub account (`calvernaz/alphavantage`). It supports stdio and streamable HTTP, has an optional OAuth 2.1 mode, and needs `ALPHAVANTAGE_API_KEY`. Its official status is **unverified**. — [mcpservers.org](https://mcpservers.org/servers/calvernaz/alphavantage); [Glama README](https://glama.ai/mcp/servers/@calvernaz/alphavantage/blob/fd5efd8d9d8b7cfe212750e230d38a1189cc886d/README.md)
- Financial Datasets: `financial-datasets/mcp-server` is listed as Official (MIT). It offers income statements, balance sheets, cash flows, prices, company news and crypto, and needs `FINANCIAL_DATASETS_API_KEY`. An aggregator shows about 2.1k stars but a **last push of 2025-06-05**, a possible maintenance concern. — [gittrend](https://gittrend.io/repo/financial-datasets/mcp-server); [Glama pyproject](https://glama.ai/mcp/servers/@financial-datasets/mcp-server/blob/08e7a3dbb949d3d99bbd6d6f3a22e5f02973ec58/pyproject.toml)
- Yahoo Finance: community wrappers of `yfinance` only. Examples: `narumiruna/yfinance-mcp` (about 149 stars, MIT, updated 2026-05-16), `a05031113/yahoo-fianace-mcp`, and `AgentX-ai` yahoo_finance_server. They depend on "Yahoo Finance's unofficial API which may change or throttle", so they are not production-grade. — [enterprisedna directory](https://enterprisedna.co/directories/mcp/narumiruna-yfinance-mcp); [Glama](https://glama.ai/mcp/servers/a05031113/yahoo-fianace-mcp); [agentpedia](https://agentpedia.codes/mcp/yfinance)
- Institutional: Claude for Financial Services (launched July 2025) added MCP connectors for S&P Capital IQ, Daloopa, Morningstar, PitchBook, LSEG (live market data), Moody's, MT Newswires, Aiera, Third Bridge, Chronograph and Egnyte. In May 2026, Anthropic released ten agent templates as plugins for Claude Cowork/Claude Code and as cookbooks for Managed Agents (via search summary). — [Anthropic: Advancing Claude for Financial Services](https://www.anthropic.com/news/advancing-claude-for-financial-services); [Anthropic: Claude for Financial Services](https://anthropic.com/news/claude-for-financial-services)

### Inferences
- For a Taiwan retail user who wants alerts and human-confirmed orders, the **Alpaca MCP server, or Alpaca's plain REST SDK, with `ALPACA_PAPER_TRADE=true` and `ALPACA_TOOLSETS` limited to read-only sets** (`stock-data,news,account,assets`) is the cleanest path. The order call should be done by your own code after LINE confirmation, not by the model. Whether Alpaca accepts Taiwan residents is out of scope here; check it (see Gaps).
- IBKR's official connector, if it really only drafts "AI Instructions" for manual submit, already enforces human-in-the-loop at the broker level. That suits "Claude analyses → human confirms", but the final confirmation happens in the IBKR app, not in LINE. An automated LINE→order flow on IBKR would need the TWS/Client Portal API or community servers, which are alpha-quality.
- For a 24/7 monitor, MCP is optional. A deterministic Python process that calls broker and data REST/WebSocket APIs directly and calls Claude only for analysis is simpler, cheaper and more auditable. MCP mainly helps when you want Claude itself to pick which data to fetch.
- Prefer data vendors with official servers or SDKs (Massive, Alpaca market data, Financial Datasets). Avoid yfinance wrappers for anything that triggers money movement.

### Gaps
- I could not fetch IBKR's own press release text. The exact order-placement semantics of the official connector (draft-only vs direct) and its availability for Taiwan accounts remain unverified.
- Alpaca account eligibility for Taiwan residents, and Alpaca live market-data plan pricing: not researched here (other researchers cover brokers).
- The Alpha Vantage MCP's official status was not confirmed on alphavantage.co.
- Exact current star counts and last-commit dates could not be verified via the GitHub API (blocked); the figures above are from third-party trackers.

## Q2. Ways to run Claude unattended, current models and pricing (Oct 2026), and monthly cost estimate

### Takeaway
For a 24/7 loop, the right shape is your own always-on process: a scheduler plus price/news triggers, calling the **Claude Messages API (Python `anthropic` SDK) with tool use / structured outputs** only when a trigger fires. Claude Code scheduling (`/loop`, Desktop tasks, cloud Routines) has a 7-day expiry, jitter of up to 30 minutes, or a 1-hour minimum interval, so it is unsuitable as the real-time monitor. At about 50 calls/day × (5k in + 1k out), list-price cost is about **US$60/mo on Opus 5.5, US$30/mo on Sonnet 5.5, and US$1.50/mo on Haiku 5.5**, before thinking-token overhead, web-search fees and caching.

### Cited Findings
**Model lineup and prices (Anthropic official pricing page, fetched 2026-10-17; USD per million tokens)**

| Model | Base input | 5m cache write | 1h cache write | Cache hit | Output | Batch in/out |
|---|---|---|---|---|---|---|
| Claude Fable 5.1 (top tier) | $10 | $12.50 | $20 | $0.25 | $50 | n/a here |
| Claude Opus 5.5 | $4 | $5 | $8 | $0.20 | $20 | $2 / $10 |
| Claude Sonnet 5.5 | $2 | $2.50 | $4 | $0.10 | $10 | $1 / $5 |
| Claude Sonnet 4.6 | $3 | $3.75 | $6 | $0.30 | $15 | $1.50 / $7.50 |
| Claude Haiku 5.5 (prompt ≤100K tokens) | $0.10 | $0.125 | $0.20 | $0.01 | $0.50 | $0.05 / $0.25 |
| Claude Haiku 5.5 (prompt >100K tokens) | $0.50 | $0.625 | $1 | $0.05 | $2.50 | $0.25 / $1.25 |
| Claude Haiku 4.5 | $1 | $1.25 | $2 | $0.10 | $5 | $0.50 / $2.50 |

— [Anthropic pricing docs](https://platform.claude.com/docs/en/about-claude/pricing)

- "Cache hits and refreshes on Claude Opus 5.5 and Claude Sonnet 5.5 are priced at 0.05x the base input price". On most other models a cache hit is 0.1x. Caching pays off after 1 read with a 5-minute TTL (1.25x write) or after 2 reads with a 1-hour TTL (2x write). These multipliers stack with the Batch discount and data residency. — [Anthropic pricing](https://platform.claude.com/docs/en/about-claude/pricing)
- Batch API: "asynchronous processing… with a 50% discount on both input and output tokens". Fast mode is not available with Batch. — [Anthropic pricing](https://platform.claude.com/docs/en/about-claude/pricing)
- US-only inference (`inference_geo: "us"`) applies a **1.1x multiplier** to all token categories on Claude 4.6+ models. Global routing is the default and uses standard price. — [Anthropic pricing](https://platform.claude.com/docs/en/about-claude/pricing)
- Fast mode for Opus 5.5 costs $8 / $40 per MTok and is available on the first-party API (and Foundry for Opus 5.5). — [Anthropic pricing](https://platform.claude.com/docs/en/about-claude/pricing)
- The web search server tool costs **$10 per 1,000 searches** plus tokens. Search results count as input tokens. Code execution is free when used with `web_search_20260209`/`web_fetch_20260209`. — [Anthropic pricing](https://platform.claude.com/docs/en/about-claude/pricing)
- Tokenizer: "Claude 4.7 and later models… use a newer tokenizer… approximately 30% more tokens for the same text"; Sonnet 4.6 and earlier use the previous tokenizer. — [Anthropic pricing](https://platform.claude.com/docs/en/about-claude/pricing)
- Managed Agents sessions are billed at the model token rates, with "no batch mode". Web search inside sessions costs the standard $10/1k. — [Anthropic pricing](https://platform.claude.com/docs/en/about-claude/pricing)
- Haiku 5.5 is priced by prompt length. A request whose prompt is over 100,000 tokens pays the higher tier, even when part of it is a cache hit. — [Anthropic pricing](https://platform.claude.com/docs/en/about-claude/pricing)
- Behaviour notes from Anthropic's bundled claude-api reference (model table cached 2026-10-06). These are local reference notes; I did not open the corresponding public doc page.
  - On Opus 5.5, thinking cannot be disabled and effort defaults to `medium`.
  - On Opus 5.5 and Sonnet 5.5, forced `tool_choice` `any`/`tool` returns a 400.
  - Sampling parameters (`temperature`/`top_p`/`top_k`) are rejected on Opus 5.5, and non-default values on Sonnet 5.5 and Haiku 5.5 are rejected. You cannot pin temperature to 0 on these models.
  - Thinking tokens are billed even when not displayed.

**Unattended execution options**
- **Claude API (Messages API) with tool use**: you own the loop and the hosting. **Agent SDK** = "Embed Claude Code's agent in your own Python or TypeScript application, in a process you operate", with built-in tools, hooks, MCP, permissions and sessions. **Managed Agents** = "a hosted agent harness that runs the agent loop, with sessions in an Anthropic-managed cloud sandbox". — [Claude Agent SDK overview (fetched 2026-10-17)](https://code.claude.com/docs/en/agent-sdk/overview)
- Agent SDK auth: "Unless previously approved, Anthropic does not allow third party developers to offer claude.ai login or rate limits for their products, including agents built on the Claude Agent SDK. Use the API key authentication methods." — [Agent SDK overview](https://code.claude.com/docs/en/agent-sdk/overview)
- Headless Claude Code:
  - `claude -p` runs non-interactively, exits non-zero on failure, and supports `--output-format json` (includes `total_cost_usd`) and `--json-schema` for structured output.
  - `--bare` is "the recommended mode for scripted and SDK calls". It requires `ANTHROPIC_API_KEY` because it "doesn't use your subscription login".
  - `--permission-prompts none` is for scheduled or unattended jobs.
  - `--max-budget-usd` caps spend.
  - `--allowedTools` and `--mcp-config` restrict tools and MCP.
  - [Run Claude Code programmatically (fetched 2026-10-17)](https://code.claude.com/docs/en/headless)
- Claude Code scheduling options compared:
  - Cloud Routines: no machine needed, **minimum interval 1 hour**.
  - Desktop tasks: machine must be on, 1-minute minimum.
  - `/loop`: session must stay open, 1-minute minimum.
  - Recurring session tasks "automatically expire 7 days after creation".
  - Recurring tasks run late "by up to half the gap to the next run, and by at most 30 minutes" (jitter).
  - There is no catch-up for missed fires.
  - The docs point to Routines, GitHub Actions or Desktop tasks for durable unattended cron.
  - [Claude Code scheduled tasks (fetched 2026-10-17)](https://code.claude.com/docs/en/scheduled-tasks)

**Monthly cost estimate (my arithmetic from official list prices above; 50 calls/day × 30 days = 1,500 calls = 7.5M input + 1.5M output tokens/month)**

| Model | Input cost | Output cost | Total / month | With Batch (−50%) | US-only geo (×1.1) |
|---|---|---|---|---|---|
| Opus 5.5 | $30.00 | $30.00 | **$60.00** | $30.00 | $66.00 |
| Sonnet 5.5 | $15.00 | $15.00 | **$30.00** | $15.00 | $33.00 |
| Sonnet 4.6 | $22.50 | $22.50 | $45.00 | $22.50 | $49.50 |
| Haiku 5.5 | $0.75 | $0.75 | **$1.50** | $0.75 | $1.65 |
| Haiku 4.5 | $7.50 | $7.50 | $15.00 | $7.50 | $16.50 |

- Sensitivity:
  - Each extra 1k output tokens per call (for example adaptive thinking, which is billed as output) adds about $30/mo on Opus 5.5, $15 on Sonnet 5.5 and $0.75 on Haiku 5.5.
  - One web search per call adds 1,500 × $10/1000 = **$15/mo** plus the result tokens.
  - If the "5k tokens" was measured with an older tokenizer, add about 30% on 4.7+/5.x models.
- Caching example on Sonnet 5.5, with a 3k-token fixed system prompt plus tool schemas and a 1h TTL:
  - Uncached prefix cost: 50 × 3k × $2/M ≈ $0.30/day, about $9/mo.
  - With about 10 cache writes/day (1h TTL at $4/M) plus 40 hits ($0.10/M): about $0.13/day, roughly $4/mo.
  - Saving is about $5/mo, so the total drops from about $30 to about $25.
  - Caching matters little at this volume. Calls more than 5 minutes apart miss a 5-minute cache.

### Inferences
- Recommended split: the trigger and monitor loop is plain Python (no LLM). A cheap model (Haiku 5.5) does first-pass triage and summarisation, and Sonnet 5.5 or Opus 5.5 handles the few high-stakes "should I act?" analyses. This likely puts the bill at US$5–35/mo, versus NT$1,000/mo (from Nov 2026) for a LINE mid plan. Both figures are of the same order.
- Batch API (50% off) does not fit real-time alerts because it is asynchronous. It fits overnight or pre-market digests, e.g. summarising earnings news for the watchlist before the US open (Taiwan night).
- Claude Code `/loop` or Routines are fine for a prototype or daily digest but not for the always-on monitor: hourly minimum (cloud), 7-day expiry (session), and up to 30 minutes of jitter.
- Use `--bare` / Agent SDK / API with an **API key from the Console, not a claude.ai subscription**, for anything automated.
- Because temperature cannot be pinned on current 5.x models, enforce determinism in code: structured outputs or JSON schema, then validation and hard-coded rules.

### Gaps
- No official per-call latency figures (seconds per call) for Opus/Sonnet/Haiku 5.5 were found. Real latency depends on thinking effort and output length. Measure it in a prototype.
- Batch completion-time SLA was not retrieved in this session.
- Managed Agents "scheduled deployments": seen only in Anthropic's bundled SDK reference. I did not verify its public docs page or its pricing beyond "billed at token rates".
- Rate limits per usage tier were not researched.

## Q3. Anthropic Usage Policy as it applies to financial and trading use

### Takeaway
The Usage Policy page (fetched 2026-10-17) shows a version **"Effective November 12, 2026"**, with a link to a "Previous Version". It classifies "a personalized recommendation to buy, sell, hold, or allocate among specific investment products, such as securities…" as a **High-risk AI Recommendation**, which requires a **qualified human-in-the-loop** plus **disclosure that AI was used**. Internal research, summarisation and analysis, and applying fixed rules where the model exercises no judgment, are explicitly excluded. A personal monitor that has Claude summarise news and a human make the final trade decision falls on the excluded side.

### Cited Findings
- Page header: "Usage Policy — Effective November 12, 2026 — Previous Version". Today is 2026-10-17, so this appears to be a **published-but-not-yet-effective** version. — [Anthropic Usage Policy](https://www.anthropic.com/legal/aup)
- "Certain uses of our products and services can impact an individual's health, legal rights, finances… When our products are used for these high-risk use cases, we require that a qualified person remain accountable for what is delivered or decided, and that the impacted individual knows AI was involved." — [Anthropic Usage Policy](https://www.anthropic.com/legal/aup)
- High-risk area "Finance — a personalized recommendation to buy, sell, hold, or allocate among specific investment products, such as securities, funds, digital assets, or annuities; advising an individual on their own taxes…". — [Anthropic Usage Policy](https://www.anthropic.com/legal/aup)
- Required controls:
  - "Qualified human-in-the-loop — A qualified person must meaningfully review a High-risk AI Recommendation, with the authority to change or modify it, before it is delivered as advice to an individual who might rely on it or before it is used to implement a decision… holds a license where applicable law requires one."
  - "Disclosure… must be clearly told that AI was used."
  - [Anthropic Usage Policy](https://www.anthropic.com/legal/aup)
- Not covered by the requirements: "General information or educational content, including… how investing works"; "Internal drafting, research, summarization, or analysis that is not the ultimate High-risk AI Recommendation delivered"; "Carrying out a decision a person has already made, or applying a fixed rule, formula, or algorithm where the model exercises no judgment about the individual." — [Anthropic Usage Policy](https://www.anthropic.com/legal/aup)
- The policy also says it does not replace local law: "Users should always default to following local laws if those laws conflict with or add additional requirements." — [Anthropic Usage Policy](https://www.anthropic.com/legal/aup)
- The Agent SDK is governed by Anthropic's Commercial Terms of Service. — [Agent SDK overview](https://code.claude.com/docs/en/agent-sdk/overview)

### Inferences
- For a **single-user, self-directed** tool, the design "Claude produces research/summary + suggested action → user (the account owner) reviews and taps Confirm in LINE → code executes" satisfies both readings of the policy. The human makes the final decision, and the AI's role is disclosed in the message. Label each LINE alert "AI 產生的分析，非投資建議" (AI-generated analysis, not investment advice).
- A fully autonomous Claude→order path, with no human review, for anyone other than yourself would land squarely in "High-risk AI Recommendation" territory and also raise Taiwan/US securities-advice licensing issues. Avoid it, or keep it strictly personal.
- Mechanical rules ("if price < stop, sell") executed by code, with no model judgment, are explicitly outside the requirement. That is another argument for keeping order logic deterministic.

### Gaps
- I could not retrieve the text of the **currently in-force previous version** (before 2026-11-12) to compare its finance wording. Check the "Previous Version" link on the AUP page.
- Taiwan FSC rules on personal algorithmic trading and investment-advice bots were not researched here.

## Q4. Existing open-source projects and real examples; evidence on LLM trading performance

### Takeaway
People do wire Claude and other LLMs to brokers: Alpaca MCP + Claude Desktop/Code, IBKR MCP, and TradingAgents (multi-agent, supports Claude). Live and long-horizon evidence is sobering. In Alpha Arena Season 1 (real money, crypto perps), Claude Sonnet 4.5 lost about 42%. Academic re-tests (FINSABER, KDD 2026; "The Alpha Illusion", May 2026) find that reported LLM alpha largely disappears over long horizons, after costs, or once memorisation is controlled for. LLMs are useful for monitoring and summarisation, not demonstrably for generating alpha.

### Cited Findings
- **TradingAgents** (TauricResearch) is a LangGraph multi-agent framework: fundamental, sentiment and technical analysts, researcher debate, trader and risk management. v0.3.1 (2026-07) added Claude Sonnet 5 and Fable 5 support; v0.2.2 (2026-03) added Claude 4.6 and effort control. It supports OpenAI, Google, Anthropic, xAI, DeepSeek, Qwen, Ollama and others. It is labelled "designed for research purposes". One snapshot shows about 69.4k stars. — [GitHub TauricResearch/TradingAgents](https://github.com/TauricResearch/TradingAgents); [gittrend](https://gittrend.io/repo/TauricResearch/TradingAgents)
- **Claude for Financial Services**: an enterprise offering with institutional data connectors and, from May 2026, agent templates (pitchbooks, KYC screening, month-end close). It targets institutions rather than retail trading. — [Anthropic news](https://www.anthropic.com/news/advancing-claude-for-financial-services)
- **Alpha Arena Season 1** (nof1, about Oct 2025 to Nov 3, 2025): $10,000 real capital per model, identical prompts, crypto perpetuals on Hyperliquid (BTC, ETH, SOL, BNB, DOGE, XRP). Final balances: Qwen3 Max $12,231; DeepSeek $10,489; **Claude Sonnet 4.5 $5,799**; Gemini 2.5 Pro $5,445; Grok $4,208; GPT-5 $4,126. Claude Sonnet 4.5 was among the leaders early (>25% up) and kept "a predominantly long stance". — [Forklog](https://forklog.com/en/four-out-of-six-ai-models-suffer-losses-in-trading-tournament/); [Decrypt](https://decrypt.co/345006/ai-crypto-trading-showdown-deepseek-grok-winning-gemini-implodes)
- **Alpha Arena Season 1.5** (ended about Dec 2025): a "Mystery Model (Grok 4.20)" won, up about 12% on average across four contests (Baseline, Monk Mode, Situational Awareness, Max Leverage). GPT-5.1 came second and Gemini 3 third. As of Dec 8 only Grok 4.2 remained profitable. About $320K was deployed in total. — [Forklog](https://forklog.com/en/news/ai-model-grok-4-2-triumphs-in-trading-tournament)
- **FINSABER** ("Can LLM-based Financial Investing Strategies Outperform the Market in Long Run?", Li, Kim, Cucuringu, Ma; arXiv 2505.07078, v1–v5; ACM SIGKDD 2026). Over two decades and more than 100 symbols, "previously reported LLM advantages deteriorate significantly". LLM strategies "underperform in bull markets due to excessive conservatism and suffer disproportionate losses in bear markets due to inadequate risk control". Regime-awareness and adaptive risk management matter more than architectural complexity. — [arXiv 2505.07078](https://arxiv.org/abs/2505.07078); [SKKU record](https://scholarx.skku.edu/item/1dd87e13-87fc-48e2-8a02-387082647bd1)
- **"The Alpha Illusion"** (arXiv 2605.16895, submitted 2026-05-16): in reproduction, LLM agents' gross returns often become net losses, or underperform buy-and-hold, once trading costs are applied. It also flags temporal contamination, where training data overlaps the backtest (via search summary). — [alphaXiv 2605.16895](https://www.alphaxiv.org/abs/2605.16895)
- **Memory-controlled benchmark** (arXiv 2605.28359, 2026): a single cumulative-return number cannot separate beta and style from stock-picking skill. Agent behaviour changes when tickers are anonymised, which suggests memorisation (via search summary). — [arXiv 2605.28359](https://arxiv.org/pdf/2605.28359)

### Inferences
- What worked:
  - LLMs as **news/filing summarisers** and explainers of "why did this move".
  - Multi-agent debate for structured research reports (TradingAgents).
  - Tool access via MCP for ad-hoc queries.
- What didn't work:
  - Autonomous position-taking, which loses money or merely tracks beta.
  - Leverage (the Max Leverage contest).
  - Backtests contaminated by training data.
  - Poor risk control in drawdowns.
- Design implication: have Claude explain and triage alerts, but keep entries, exits, position sizing and stops rule-based, with human confirmation.

### Gaps
- No peer-reviewed live-trading study specifically of Claude 5.x-generation models was found.
- The Season 1.5 asset class (US equities vs crypto) and Claude's placement in it were not confirmed in the retrieved sources.
- Anthropic's Claude for Financial Services pricing and retail availability were not found.

## Q5. Risks and safeguards

### Takeaway
The dominant risks are:
- prompt injection through news, web pages and filings that the agent reads;
- tool poisoning or "rug pulls" in third-party MCP servers;
- hallucinated tickers or numbers;
- non-deterministic outputs (temperature cannot be pinned on 5.x models);
- latency of seconds or more;
- over-scoped API keys.

Mitigation means keeping the LLM away from the order path. Claude only reads and suggests. Code validates against hard-coded limits. A human confirms in LINE. Everything is logged.

### Cited Findings
- Anthropic (Nov 2025): an agent that browses "encounters content it cannot fully trust… an attacker might have embedded malicious instructions to hijack the agent". Prompt injection "is far from a solved problem". Opus 4.5 was more robust but no agent is immune. — [Anthropic: prompt injection defenses](https://www.anthropic.com/research/prompt-injection-defenses)
- Anthropic developer guidance: label where tool output came from; state in the system prompt that tool results, documents and search results are untrusted data that must never override the system prompt or the user's request; monitor outputs. — [Claude docs: mitigating jailbreaks & prompt injections](https://platform.claude.com/docs/en/docs/mitigating-jailbreaks-prompt-injections)
- MCP-specific risks: tool poisoning (hidden instructions in tool metadata, demonstrated by Invariant Labs in April 2025), rug pulls (a tool changes after approval), confused deputy and token passthrough. Controls: per-use-case permission scoping, per-action authorization, treating tool output as untrusted, and **keeping untrusted input and sensitive write access in separate sessions**. — [OWASP MCP Security Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/MCP_Security_Cheat_Sheet.html); [Wiz MCP security](https://wiz.io/academy/ai-security/model-context-protocol-security)
- Alpaca MCP: no remote auth, so never expose it publicly with keys. Use `ALPACA_TOOLSETS` to restrict tools. Paper trading is the default. — [Alpaca MCP README](https://github.com/alpacahq/alpaca-mcp-server)
- IBKR community servers: run locally only and test on paper first. IBKR's TWS "Read-Only API" setting blocks order placement. The hosted bridge's Read-only mode hides `place_order`/`cancel_order`. — [Glama code-rabi](https://glama.ai/mcp/servers/@code-rabi/interactive-brokers-mcp/blob/dc2095c53552b7379015dbba7a6c8ebc858032e7/README.md); [IBKR Gateway](https://ibkr-gateway.bogdanripa.com/)
- Claude Code headless controls: `--allowedTools`, `--permission-mode dontAsk`, `--permission-prompts none` (prompts become denials), `--max-budget-usd`, and `--bare` so stray hooks or MCP configs are not loaded. — [Claude Code headless docs](https://code.claude.com/docs/en/headless)
- An unconfirmed Aug 2026 security-blog report (Zenity) claims zero-click hijacking of Claude's browsing features. I could not verify it against Anthropic. — [Security Arsenal blog](https://securityarsenal.com/blog/zero-click-prompt-injection-hijacks-claude-and-chatgpt-atlas-detection-and-containment-guide-for-ai-browsers)
- FINSABER: LLM strategies' "inadequate risk control" in bear markets. This supports hard-coded risk limits. — [arXiv 2505.07078](https://arxiv.org/abs/2505.07078)

### Inferences (safeguard checklist for the design)
1. **Two-key separation**. The "reader" agent, which ingests news and web content, has no trading tools. The order executor is plain code that runs only after a LINE postback confirm. This applies OWASP's "separate untrusted input from write access".
2. **Structured output + validation**. Claude returns JSON (ticker, side, qty, limit price, rationale, sources). Code checks that the ticker is in the watchlist/asset list from the broker API, that price is within ±X% of the live quote, that qty is ≤ max position, that daily loss limit and max orders/day are not exceeded, and that the market is open. If any check fails, drop the proposal.
3. **Hard-coded limits outside the model**: max notional per order and per day, allowed symbols, limit orders only (no market orders), no options or margin, and a kill-switch env var.
4. **Broker key scoping**: start with paper keys. Use a separate live key only for the executor. Never put keys into prompts. Restrict `ALPACA_TOOLSETS` (or IBKR Read-Only API) for any MCP the LLM can see.
5. **Human-in-the-loop**: each order proposal has an ID and expiry (e.g. 5 minutes). Requote at confirm time and re-validate. Confirms are idempotent.
6. **Audit log**: store every trigger, prompt, model ID, response, `request_id`, token usage/cost, validation result, user confirm, and broker order ID/fill in SQLite or Postgres.
7. **Latency**: assume seconds to tens of seconds per analysis call. Do not use Claude in any sub-second path. Price-trigger detection stays in code.
8. **Budget guards**: cap calls per day, alert on spend, and use `--max-budget-usd` for CLI runs.

### Gaps
- No quantitative hallucination rate for tickers or numbers on 5.x models in finance contexts was found.
- I could not fetch the official MCP spec "Security Best Practices" page (modelcontextprotocol.io); OWASP and vendor summaries were used instead.

## Q6. LINE side: push quotas and pricing in Taiwan (2026), reply vs push, quick reply/postback confirm flows; Telegram comparison

### Takeaway
In Taiwan, LINE Official Account plans are:
- **Light**: NT$0/mo, 200 free messages, no add-ons.
- **Mid**: NT$800/mo, 3,000 messages, no add-ons. **Rises to NT$1,000 from 2026-11-01**.
- **High**: NT$1,200/mo, 6,000 messages, with add-on messages from NT$0.2 each. **Rises to NT$1,400 from 2026-11-01**.

Push messages count toward the quota per recipient. **Reply messages are free.** A "confirm order" flow maps cleanly onto quick-reply or postback buttons: the postback event carries your data plus a replyToken, so the confirmation reply is free. Telegram bots are free, with only rate limits.

### Cited Findings
- Current TW plans (through end of Oct 2026): Light NT$0, 200 free messages, cannot buy add-ons. Mid NT$800, 3,000 messages, cannot buy add-ons (must upgrade). High NT$1,200, 6,000 messages, add-on messages from NT$0.2 each with tiered pricing (via search summary of official LINE Biz pages). — [LINE Biz TW: 2026 方案價格調整](https://tw.linebiz.com/column/LINEOA-2026-Price-Plan/); [LINE Biz TW: 訊息費用的計價方式](https://tw.linebiz.com/faq/oa-price/message-price-list/)
- **From 2026-11-01**:
  - Mid plan fixed fee goes from NT$800 to **NT$1,000**.
  - High plan goes from NT$1,200 to **NT$1,400**.
  - High-plan add-on messages become NT$0.2 each for messages 1–50,000 and NT$0.15 from 50,001.
  - Free message counts stay the same.
  - A third-party article says these prices exclude tax (未稅).
  - (via search summary) — [LINE Biz TW: 2026年 LINE 官方帳號方案價格調整](https://tw.linebiz.com/column/LINEOA-2026-Price-Plan/); [actgsys LINE Bot 費用 2026](https://actgsys.com/zh/blog/line-bot-development-cost-guide-2026)
- The High plan's add-on cap is 6,000 free + 994,000 add-on = 1,000,000 messages/month. Overage is billed on the 10th of the next month (via search summary). — [LINE Biz TW FAQ](https://tw.linebiz.com/faq/oa-price/17/)
- Reply messages are "not included in the message count" for the pricing plan. — [LINE Developers tips: How message counts are calculated (2026-05-28)](https://developers.line.biz/en/tips/2026/05/28/how-to-count-messages/)
- Push counting is by number of recipients. The number of message objects in one request does not change the count. Messages to users who blocked the account, or to non-existent IDs, are not counted. — [LINE Messaging API pricing](https://developers.line.biz/en/docs/messaging-api/pricing/)
- Quick reply: "up to 13 quick reply buttons to a message of any type". Postback, message, URI, datetime picker and clipboard actions are allowed. Buttons disappear after a tap or when a new message arrives. — [LINE Developers: Use quick replies](https://developers.line.biz/en/docs/messaging-api/using-quick-reply/)
- A postback action "sends your server a postback event with the text that you specified in the action", optionally displayed as the user's message. A postback event can be replied to with its replyToken. — [LINE Developers: Actions](https://developers.line.biz/en/docs/messaging-api/actions/); [LINE Messaging API reference](https://developers.line.biz/en/reference/messaging-api/)
- ReplyToken validity is reported inconsistently in secondary sources (30 seconds vs 1 minute). The official reference has the authoritative value, which I could not retrieve. — [Sinch community](https://community.sinch.com:443/t5/LINE/What-are-reply-messages-and-push-messages/ta-p/9785); [LINE Messaging API reference](https://developers.line.biz/en/reference/messaging-api/)
- **Telegram**: bots send messages at no cost. Bulk broadcast is limited to about 30 messages/second (429 errors above that), about 1 message/second per chat, and about 20 messages/minute in groups. Paid broadcasts (0.1 Star per message beyond the free limit) exist only for large bots (≥100k MAU). — [Telegram Bot FAQ](https://core.telegram.org/bots/faq); [grammY flood limits](https://grammy.dev/advanced/flood)

### Inferences
- Budget check for one user receiving pushes:
  - 50 alerts/day ≈ 1,500 pushes/month. That exceeds the free 200 and needs the Mid plan (3,000/mo, NT$1,000 from Nov 2026).
  - Batching alerts (e.g. one digest per 30 minutes, or only high-severity pushes) keeps you inside 200/mo, i.e. about 6 pushes/day.
  - Because message objects per request do not affect the count, pack several alert bubbles into one push.
- Confirm-order flow:
  1. Push a Flex/text alert with quick-reply buttons [確認下單 / 略過 / 詳情], each a postback with `data=action=confirm&pid=<proposal_id>`.
  2. The webhook receives the postback.
  3. The server re-validates (requote, limits, expiry) and places the order via the broker API.
  4. The server **replies** (free) with the order status.
  5. Later fill notifications are pushes (counted).
  6. Verify the webhook signature and the userId whitelist, and make `pid` single-use.
- Telegram is the zero-cost, quota-free alternative for a personal alert bot. LINE's advantage is that the user's existing repo and habits are already on LINE. A hybrid is possible: high-frequency alerts go to Telegram, and daily digests and confirmations go to LINE.

### Gaps
- I could not fetch tw.linebiz.com directly to verify tax treatment (未稅/含稅) and whether Messaging API pushes count identically to manual broadcasts under the 2026 plans.
- The official replyToken validity window was not verified.
- Telegram inline-keyboard / `callback_query` mechanics were not verified in this session (official docs unreachable).

## Q7. Hosting a 24/7 process (brief)

### Takeaway
A small always-on Linux VM or container in a US-East region, close to broker and data endpoints, is the conventional choice. The LINE webhook needs a public HTTPS endpoint. I did not verify specific VPS or cloud prices in this session, so none are quoted.

### Cited Findings
- Claude Code's cloud Routines run on Anthropic-managed infrastructure with a 1-hour minimum interval and no local file access. Desktop tasks need the machine on. Neither replaces an always-on monitor. — [Claude Code scheduled tasks](https://code.claude.com/docs/en/scheduled-tasks)
- The Claude API is global by default. US-only inference (`inference_geo: "us"`) costs 1.1x. Data-residency choice does not otherwise change latency guarantees on the pricing page. — [Anthropic pricing](https://platform.claude.com/docs/en/about-claude/pricing)
- Alpaca MCP and community IBKR MCP servers should run locally/stdio and not be exposed publicly. — [Alpaca MCP README](https://github.com/alpacahq/alpaca-mcp-server); [Glama code-rabi](https://glama.ai/mcp/servers/@code-rabi/interactive-brokers-mcp/blob/dc2095c53552b7379015dbba7a6c8ebc858032e7/README.md)

### Inferences
- Typical choices are a small VPS or VM (AWS Lightsail/EC2 us-east-1, GCP us-east, Hetzner/DigitalOcean US-East, or similar) running:
  - a systemd or Docker process for the monitor;
  - a small web app (Flask/FastAPI, like the existing ChatGPT-Line-Bot) behind HTTPS for the LINE webhook;
  - SQLite or Postgres for the audit log;
  - a watchdog/heartbeat that pushes a LINE or Telegram message if the monitor dies.

  Scale-to-zero serverless (e.g. Cloud Run) fits the webhook but not a persistent WebSocket price stream, unless min-instances is set to 1.
- Latency from Taiwan vs US-East matters little for human-confirmed orders, which take seconds to minutes. It matters only for automated fast triggers.

### Gaps
- No VPS, cloud or Cloud Run prices were verified (per the "no guessed prices" constraint). Check the vendors' official pricing pages.
