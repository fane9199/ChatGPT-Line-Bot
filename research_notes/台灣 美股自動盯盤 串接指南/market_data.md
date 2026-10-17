# US-Stock Market Data & News Sources for a Retail Developer's 24h Monitoring Bot (as of 2026-10-17)

> Research method note (read first): Vendor sites (massive.com, alpaca.markets, docs.alpaca.markets, databento.com, finnhub.io, sec.gov, etc.) were NOT directly fetchable from this research environment (DNS/egress block). Most findings below come from search-engine excerpts of the vendors' own official pages (URLs cited are the official pages the excerpts came from), plus GitHub pages that were fetched directly. Where only third-party sites support a number, it is labelled "(3rd-party)". Prices are USD/month unless noted. Research date: 2026-10-17. Every price should be re-checked on the vendor page before the final report states it as fact.

## Q1. Real-time vs delayed basics, exchange licensing (non-pro vs pro), and redistribution (can you push quotes to LINE?)

### Takeaway
"Real-time" from a free/cheap API usually means a single venue (IEX, ~3.8% of all US volume) rather than the consolidated SIP tape; full-market (SIP) real-time costs ~$99–$199/mo for a non-professional individual, while 15-minute-delayed data is widely free. Individual/non-pro licences cover personal use only: pushing quotes to your own LINE chat is likely within "personal use," but sending them to any other person (LINE group, friends, users of a bot) is "redistribution/display to third parties" and needs a business/redistribution licence.

### Cited Findings
**SIP vs single-venue (IEX) feeds**
- Alpaca: the free plan "provides real time data more current than 15 minutes … but only representing executions on the IEX exchange"; full SIP real-time requires the paid plan — [Alpaca Market Data FAQ](https://docs.alpaca.markets/us/docs/market-data-faq) (official, undated excerpt; forum staff answer at [Alpaca forum](https://forum.alpaca.markets/t/iex-or-sip-with-a-free-account/17141)).
- IEX's own self-reported share: 3.8% of total US equity volume (incl. off-exchange) as of Q2 2026; 7.8% of exchange-only volume as of H1 2026; 12.4% intraday S&P 500 exchange share Q1 2026 — [IEX Newsroom](https://www.iex.io/news) (2026). Older figure 2.4% (Feb 2021) — [Wikipedia: IEX](https://en.wikipedia.org/wiki/IEX).
- Twelve Data states its default US real-time feed covers ~5% of total US trading activity — [Twelve Data support: US equities market data](https://support.twelvedata.com/en/articles/9935903-us-equities-market-data) (undated).
- Implication shown by vendors: IEX-only last price / volume can differ from consolidated price & volume; volume-spike triggers on an IEX-only feed will see only a small slice of real volume (see Inferences).
- IEX Cloud (the former popular retail API) retired all products on 2024-08-31 (announced 2024-05-31); the IEX exchange itself continues — [Databento migration guide](https://databento.com/blog/migrating-from-iex-cloud); [Waters Technology](https://waterstechnology.com/node/7951882); [Alpha Vantage analysis](https://www.alphavantage.co/iexcloud_shutdown_analysis_and_migration/).

**What "15-minute delayed" means in practice**
- Alpaca free plan: SIP historical queries are allowed only if the `end` parameter is at least 15 minutes old; otherwise error "subscription does not permit querying recent SIP data" — [Alpaca Market Data FAQ](https://docs.alpaca.markets/us/docs/market-data-faq); [forum thread](https://forum.alpaca.markets/t/your-subscription-does-not-permit-querying-data-from-the-past-15-minutes/8057).
- IBKR: "10-15 minute delayed streaming data is available for many types of instruments without market data subscriptions" (via `reqMarketDataType(3)` or `4` = delayed-frozen); historical data via API still requires subscriptions — [TWS API: Delayed Streaming Data](https://interactivebrokers.github.io/tws-api/delayed_data.html); [TWS API: Market Data Types](https://interactivebrokers.github.io/tws-api/market_data_type.html).
- Alpha Vantage API exposes `entitlement=realtime` vs `entitlement=delayed` (15-minute delayed intraday) — [Alpha Vantage documentation](https://www.alphavantage.co/documentation/).
- Massive (ex-Polygon) Starter ($29) and Developer ($79) stock plans are 15-minute delayed; delayed WebSocket endpoint is `wss://delayed.massive.com/stocks` — [Massive WebSocket docs: Trades](https://massive.com/docs/websocket/stocks/trades); [Massive WS overview](https://massive.com/docs/websocket/stocks/overview).

**Non-professional vs professional subscriber**
- Non-professional = a natural person, not registered with SEC/CFTC/etc., not acting as investment adviser; account must be in own name, data used solely for personal, non-business purposes; a trust/organization cannot qualify — [NYSE Market Data Policy Package](https://www.nyse.com/publicdocs/nyse/data/NYSE_Market_Data_Complete_Policy_Package.pdf); [CTA Nonprofessional Subscriber Policy](https://www.ctaplan.com/publicdocs/ctaplan/notifications/trader-update/Policy%20-%20Non-Professional%20Subscribers%20-%20CTA.pdf).
- UTP (Nasdaq-listed tape) fee figures: $1/month non-professional vs $24/month professional (document dated Sept 2023 — may be outdated) — [UTP Data Policies (Sept 2023)](https://www.utpplan.com/DOC/datapolicies.pdf). CTA Q4 2025 metrics report describes non-pro per-quote usage capped at $1.00/month — [CTA Q4 2025 Subscriber Metrics](https://www.ctaplan.com/publicdocs/ctaplan/Q4_2025_CTA_Subscribers_Metrics_Report.pdf).
- Massive labels individual tiers "Individual use only" and Stocks Advanced ($199) as "Non-pros only" — [Massive pricing](https://massive.com/pricing); [Massive KB: pro vs non-pro for stock data](https://massive.com/knowledge-base/article/what-are-pro-and-non-pro-classifications-for-massives-stock-data).
- Alpaca Elite gives a free Algo Trader Plus subscription (worth $99/mo) "only for personal use" — [Alpaca Elite](https://alpaca.markets/elite).

**Redistribution (pushing quotes to LINE)**
- Massive: individual plans licensed "exclusively for your personal, non-business, and non-commercial purposes"; Market Data is "strictly for display use only" unless another agreement says otherwise — [Massive Market Data Terms of Service](https://massive.com/legal/market-data-terms-of-service) (last updated 2025-08-28).
- Massive KB: showing data to your own users, publishing it, or passing it to another party is redistribution; "any tester, colleague, or staging user who sees it requires a Business subscription … during development as well as after launch" — [Massive KB: Which plan do I need to show Massive data in my own app?](https://massive.com/knowledge-base/article/which-plan-do-i-need-to-show-massive-data-in-my-app).
- Tiingo: Power and Commercial plans are "internal use only"; redistribution sold separately: EOD + IEX redistribution $250/mo (startup) / $500/mo (enterprise) — [Tiingo IEX API page](https://www.tiingo.com/products/iex-api); [Tiingo pricing](https://www.tiingo.com/about/pricing).
- EODHD: self-serve personal plans do not permit commercial use; B2B plans start at $399/mo — [EODHD pricing](https://eodhd.com/pricing) (snapshot possibly old) and (3rd-party) [FindMyMoat EODHD](https://www.findmymoat.com/tools/eodhd).
- Finnhub free plan "licensed for personal use" — [Finnhub pricing](https://api.finnhub.io/pricing).
- Twelve Data states all paid plans include real-time US stock data "suitable for both personal and commercial use" — [Twelve Data support: US equities market data](https://support.twelvedata.com/en/articles/9935903-us-equities-market-data). (Commercial internal use ≠ redistribution; Twelve Data separately sells Business plans — [Twelve Data business pricing](https://twelvedata.com/pricing-business).)
- Generic exchange/vendor contracts treat distribution to "subscribers, other customers, and other third parties via external applications" as External Distribution requiring a vendor licence — [OTC Markets Market Data Distribution Agreement (2022)](https://www.otcmarkets.com/files/MDDA%20(1.1.2022).pdf); [ICE Endex Market Data Policy (Jan 2026)](https://www.ice.com/publicdocs/ICE_Endex_Market_Data_Policy.pdf).

### Inferences
- For a solo developer in Taiwan who is not a registered professional, non-pro pricing applies as long as the data account is in his own name and used for personal trading/monitoring.
- A LINE bot that messages only the developer himself is plausibly "personal display." A LINE group, family/friends, or a public bot = redistribution → need Business plan (e.g., Massive Business from ~$499–$1,999/mo) or vendor's written permission. A safe pattern: send derived alerts/text explanations ("AAPL broke 200-day MA, volume 3× average") rather than raw quote streams — but even derived values may be covered by vendor terms; this is not legal advice and must be checked per vendor.
- IEX-only feeds (Alpaca Basic, Tiingo IEX) are fine for price-level triggers on liquid names but unreliable for volume-based triggers (they see ~4% of volume); use SIP (Alpaca Algo Trader Plus $99, Massive Advanced $199) or delayed SIP for volume logic.
- Twelve Data's ~5% coverage statement suggests its "real-time" US feed is also not full SIP on cheaper plans.

### Gaps
- Could not retrieve current (2026) CTA/UTP official fee schedules; the $1 non-pro UTP figure is from a Sept-2023 doc.
- Could not find an exchange-policy primary source stating that 15-minute-delayed data is fee-exempt; vendors behave as if it is (free delayed tiers), but this is not confirmed here.
- No vendor explicitly addresses "push to my own chat app" — the LINE-to-self interpretation is an inference.

## Q2. Market data APIs compared (free tier, paid tiers, real-time vs delayed, WebSocket, extended hours, rate limits)

### Takeaway
Best fits for a retail monitoring bot: (a) Alpaca Basic (free, IEX real-time + delayed SIP, 30 WS symbols) or Algo Trader Plus ($99, full SIP, unlimited WS symbols, includes Benzinga news API); (b) Massive (ex-Polygon) Advanced ($199, real-time SIP, non-pro only) with $29/$79 delayed tiers; (c) IBKR if the user already has an IBKR account (non-pro US quotes ~$4.50–$14.50/mo, often partly waived; free overnight data). Databento is institutional-grade and its US Equities pricing changed in June 2026 (re-verify). yfinance is free but unofficial, "personal use only," and frequently rate-limited.

### Cited Findings

**Summary table (all USD; see bullet sources below for each cell)**

| Vendor | Free tier | Paid tiers (monthly) | Real-time? | WebSocket | Extended / overnight | Notes |
|---|---|---|---|---|---|---|
| Massive (ex-Polygon.io) | Basic $0: 5 calls/min, EOD (3rd-party) | Starter $29 (15-min delayed), Developer $79 (15-min delayed), Advanced $199 (real-time, non-pro only); Business: Full Market Delayed $499, Full Market real-time $1,999 | Advanced+ | Yes (delayed WS on Starter/Developer; RT on Advanced) | 04:00–20:00 ET all plans; overnight not stated | Rebrand eff. 2025-10-30; per-asset-class billing |
| Alpaca | Basic: IEX real-time, SIP only if >15 min old, 30 WS symbols, 200 calls/min | Algo Trader Plus $99: SIP all exchanges, unlimited WS symbols, 10,000 calls/min, OPRA options | Basic=IEX only; $99=SIP | Yes | Pre/post via SIP; overnight: BOATS feed (extra monthly fee) + derived "overnight" feed | News API (Benzinga) included |
| Interactive Brokers | Delayed 10–15 min streaming free | Snapshot+Futures Value Bundle $10 (waived at $30 commissions; another IBKR page says $20) + US Equity & Options Add-On Streaming $4.50 (not waivable); or à la carte NYSE/AMEX/Nasdaq top-of-book $1.50 each; snapshots $0.01/request | With subscriptions | TWS/IB Gateway API streaming | Overnight data free (IBEOS/OVERNIGHT, 20:00–03:50 ET) | Must hold brokerage account |
| Databento | $125 historical credits (3rd-party) | US Equities Standard $199 (Jan 2025 launch; live, no exchange licence fees); June 22 2026 update lists "Databento US Equities: $4,000" (tier unclear) | Yes (Standard+) | Live API (TCP/client libs) | BOATS (OCEA.MEMOIR) live + historical | Institutional tick data |
| Finnhub | 60 calls/min, WS 50 symbols, US, personal use | Official page shows All-In-One $3,500/mo (annual); 3rd-party claims $49.99+ entry tiers (unverified) | Free WS trades (US) | Yes | Not documented in sources | Free company news + earnings calendar |
| Alpha Vantage | 25 requests/day | $49.99 (75/min), $99.99 (150/min), $149.99 (300/min), $199.99 (600/min), $249.99 (1,200/min) | 3rd-party: $49.99 = 15-min delayed; RT from $99.99; entitlement process required | No WS found | n/a | Official MCP |
| Tiingo | Free tier exists (limits not captured) | Power $30 ($300/yr) individual; Commercial $50 ($499/yr) internal; redistribution $250/$500 | IEX real-time (15 ms delay added 2022) | Yes (IEX tick + top-of-book) | BOATS overnight real-time +$9/mo (2026-07-21) | Internal use only |
| Twelve Data | Basic: 8 credits/min, 800/day, 8 trial WS credits | Grow $79 ($66 annual), Pro $229 ($191), Ultra $999 ($832) | RT US on Grow+ (feed ≈5% of US volume) | Full WS from Pro | Pre/post Pro+ (RT 07:00–20:00 ET) | Official MCP |
| FMP | 250 calls/day, EOD | Starter $29 (300/min), Premium $69 (750/min), Ultimate $139 (3,000/min) (3rd-party transcription 2026-07-22) | Conflicting for Starter | WS on Premium/Ultimate (old FMP page) | Not captured | Official MCP unconfirmed |
| EODHD | 20 calls/day, 15-min delayed | EOD $19.99, EOD+Intraday $29.99, All-In-One $99.99; B2B from $399 | Live/"extended" US quotes on All-In-One | WS, 50 tickers | "US extended quotes" listed | Personal plans non-commercial |
| Intrinio | none noted | Individual $150 (personal only); Startup $333; Enterprise $1,250+ | IEX real-time labelled Enterprise; "EquitiesEdge" modeled RT from $150 | — | — | Expensive for retail |
| yfinance (Yahoo, unofficial) | Free | n/a | Unofficial, no SLA | No official WS | n/a | "Personal use only"; frequent 429s |

**Massive (formerly Polygon.io)**
- Rebrand: Polygon.io became Massive effective 2025-10-30 4 PM ET; existing APIs/keys keep working; `api.polygon.io` remains supported "for an extended period" alongside `api.massive.com` — [EIN Presswire: Polygon.io is now Massive](https://www.einpresswire.com/article/863823068/polygon-io-is-now-massive); [FISD](https://fisd.net/polygon-io-is-now-massive). (One aggregator says "early 2026" — [apis.io](https://apis.io/providers/massive-com/) — conflicts; the press release is more reliable.)
- Stocks plans: Starter $29 and Developer $79 = 15-minute delayed; Advanced $199 = real-time; Basic free = end-of-day — [Massive WebSocket docs (Trades)](https://massive.com/docs/websocket/stocks/trades); [Massive Stocks page](https://massive.com/stocks). Prices unchanged across rebrand (3rd-party, Sept 2026) — [apicostcalc](https://apicostcalc.com/blog/polygon-massive-rebrand-api-pricing.html). One aggregator claims Developer is real-time — [DataGlobeHub](https://dataglobehub.com/api-finder/massive-api/) — contradicted by official docs.
- Basic free: 5 API calls/min, EOD, ~2 years history (3rd-party) — [QVeris guide (competitor)](https://qveris.ai/guides/polygon-pricing-optimized).
- Business: "Full Market" real-time trades + BBO quotes from every US exchange $1,999/mo; "Full Market Delayed" $499/mo; unlimited API calls, up to 3 concurrent WS connections + 1 per expansion — [Massive Stocks API for Business](https://massive.com/business-stocks).
- Extended hours: every US stock trade/quote 04:00–20:00 ET on any Stocks plan (tier only limits recency); no session parameter, filter by timestamp; extended-hours aggregate bars sparse — [Massive KB: pre-market and after-hours](https://massive.com/knowledge-base/article/does-massive-offer-pre-market-and-after-hours-data); [Massive KB: outside normal hours](https://massive.com/knowledge-base/article/market-data-outside-of-normal-hours).

**Alpaca**
- Basic (free): real-time IEX only, WebSocket capped at 30 symbols, 200 historical API calls/min; Algo Trader Plus $99/mo: all US exchanges (SIP), unlimited WS symbols, 10,000 calls/min — [Alpaca About Market Data API](https://docs.alpaca.markets/us/docs/about-market-data-api); [Alpaca data page](https://alpaca.markets/data). Some 3rd parties say "unlimited calls" — official figure is 10,000/min.
- Algo Trader Plus also includes OPRA options — [Alpaca Elite page](https://alpaca.markets/elite).
- Free plan SIP restriction (end ≥15 min old) and set `feed=iex`/`feed=sip` explicitly — [Alpaca Market Data FAQ](https://docs.alpaca.markets/us/docs/market-data-faq); real-world 403 example — [GitHub PR comgood/swing-scan #80](https://github.com/comgood/swing-scan/pull/80).
- Non-US availability: Alpaca says non-US residents can open live accounts depending on country; not all jurisdictions served — [Alpaca Learn: non-US resident account](https://alpaca.markets/learn/live-trading-account-non-us). Taiwan not explicitly confirmed in any source found.

**Interactive Brokers (non-professional)**
- US Securities Snapshot and Futures Value Bundle USD 10/mo, waived with USD 30 commissions (another IBKR page says waiver at > USD 20 — both pages ~3+ years old) — [IBKR Market Data Pricing](https://www.interactivebrokers.com/en/pricing/market-data-pricing.php); [IBKR research/news/market data](https://www.interactivebrokers.com/en/pricing/research-news-marketdata.php).
- Streaming stock quotes for non-pros = Value Bundle AND US Equity and Options Add-On Streaming Bundle ($4.50/mo, not waivable per 3rd-party) — [IBKR pricing](https://www.interactivebrokers.com/en/pricing/market-data-pricing.php); [QuantLabsNet (3rd-party)](https://www.quantlabsnet.com/post/ibkr-market-data-cost-for-options-futures-and-other-derivatives).
- À la carte: NYSE (Network A), AMEX (Network B), NASDAQ (Network C) real-time top-of-book USD 1.50/mo each; snapshot requests capped at $1.50/exchange/month after 150 requests — [IBKR FAQ: US market data subscription considerations (non-pro)](https://www.ibkrguides.com/kb/en-us/subscription-consideration-us-market-data.htm) (~2025).
- Snapshot quotes: US listed equities USD 0.01/request; USD 1.00/month waiver for all accounts — [IBKR Market Data Pricing](https://www.interactivebrokers.com/en/pricing/market-data-pricing.php).
- API: free delayed data via `reqMarketDataType(3/4)`; errors 354 (not subscribed) / 10090 (partial) — [TWS API docs](https://interactivebrokers.github.io/tws-api/delayed_data.html); [supa.is guide (3rd-party, 2026)](https://supa.is/article/interactive-brokers-tws-api-market-data-not-subscribed-how-to-fix-2026). Market data subscription guide for API — [IBKR Campus: Market Data Subscriptions](https://ibkrcampus.com/ibkr-api-page/market-data-subscriptions/).

**Databento**
- US Equities Standard plan at launch: $199/mo, live data with no exchange licence fees, 7 years OHLCV, 12 months L0/L1, 1 month L2/L3 — [Databento: Introducing Databento US Equities](https://databento.com/blog/introducing-databento-us-equities) (Jan 2025).
- Pricing update effective 2026-06-22 (notice dated 2026-05-29) due to higher exchange licence fees; lists "Databento US Equities: $4,000"; existing Plus/Unlimited customers unaffected — [Databento: Updates to subscription pricing](https://databento.com/blog/updates-to-subscription-pricing). Which tier the $4,000 applies to could not be confirmed; a 2026 3rd-party site still lists Standard at $199 — [TradingDataCompare](https://tradingdatacompare.com/providers/databento/). **CONFLICT – flag.**
- Real-time/intraday require Standard, Plus, or Unlimited — [Databento equities page](https://databento.com/equities). Zero-licence-fee benefit via "US Equities Mini" feed — [LiquidityFinder](https://liquidityfinder.com/news/databento-launches-the-industrys-first-zero-license-fee-us-equities-data-bundle-bafb7).
- $125 free credits (historical only, 3rd-party) — [TradingDataCompare](https://tradingdatacompare.com/providers/databento/).

**Finnhub**
- Free: $0, 60 API calls/min, US coverage, WebSocket 50 symbols, personal use — [Finnhub pricing](https://api.finnhub.io/pricing).
- Official page shows All-In-One $3,500/mo (billed annually, 900 calls/min) as the only listed paid tier; 3rd-party sites claim Basic $49.99 / Standard $129.99 / Professional $199.99 — unverified — [Finnhub pricing](https://api.finnhub.io/pricing); [apicostcalc (3rd-party)](https://apicostcalc.com/finnhub.html). Estimates add-on $75/$200 per market — [Finnhub estimates pricing](https://finnhub.io/pricing-stock-estimates).

**Alpha Vantage**
- Free 25 requests/day; premium $49.99/$99.99/$149.99/$199.99/$249.99 for 75/150/300/600/1,200 req/min, no daily cap (3rd-party summaries) — [Blocksentient review 2026](https://blocksentient.com/review/alpha-vantage/); [TradingToolsHub](https://tradingtoolshub.com/blog/alpha-vantage-pricing-guide-2026-all-plans-costs-hidden-fees/).
- $49.99 tier = 15-min delayed US; realtime US from $99.99 (3rd-party, two sources agree; Brightdata disagrees) — [Blocksentient](https://blocksentient.com/review/alpha-vantage/); [Brightdata](https://brightdata.com/blog/web-data/best-stock-data-providers).
- Premium key alone does not unlock realtime; personal users go through a data-entitlement process (3rd-party, "Alpha X Terminal") — [QVeris (competitor)](https://qveris.ai/guides/alpha-vantage-pricing-alternative/?lang=en).

**Tiingo**
- Power $30/mo ($300/yr) individuals; $50/mo ($499/yr) internal commercial — [Tiingo pricing](https://www.tiingo.com/about/pricing).
- IEX WebSocket (tick trades + top-of-book); 15 ms delay added in 2022 per IEX requirement — [Tiingo IEX API](https://www.tiingo.com/products/iex-api); [Tiingo changelog](https://www.tiingo.com/documentation/general/changelog).
- 2026-07-21 changelog: BOATS overnight real-time product +$9/mo on Power/Commercial; "Equity Realtime WebSocket" new product (beta) — [Tiingo changelog](https://www.tiingo.com/documentation/general/changelog); [Tiingo blog: Overnight Stock Data API](https://www.tiingo.com/blog/overnight-stock-data-api/).

**Twelve Data**
- Grow $79 ($66 annual), Pro $229 ($191), Ultra $999 ($832; 10,946 API credits + 10,000 WS credits/min); older $29/$99/$329 tiers still shown on stale 3rd-party pages — [Twelve Data pricing](https://twelvedata.com/pricing).
- Basic free: 8 API credits/min (800/day) + 8 trial WS credits; full WebSocket requires Pro+ — [Twelve Data stocks page](https://twelvedata.com/stocks); [Twelve Data Trial article](https://support.twelvedata.com/en/articles/5335783-trial).
- Pre/post-market: Pro (individual) / Venture (business) and above; real-time extended 07:00–20:00 ET; historical extended 04:00–20:00 ET; `prepost=true` — [Twelve Data: Pre/Post-market data](https://support.twelvedata.com/en/articles/5195429-pre-post-market-data); [API docs](https://twelvedata.com/docs).

**Financial Modeling Prep (FMP)**
- Basic free 250 calls/day, EOD, 5 years history; Starter $29 (300 calls/min), Premium $69 (750/min), Ultimate $139 (3,000/min) — 3rd-party transcription of FMP pricing page dated 2026-07-22 — [apis.io FMP plans](https://apis.io/plans/financial-modeling-prep/financial-modeling-prep-plans-pricing/); [FindMyMoat](https://www.findmymoat.com/tools/financial-modeling-prep-fmp). Whether Starter is real-time vs 15-min delayed conflicts between sources — [Geekflare](https://geekflare.com/guides/best-stock-market-api/).
- Older FMP page: Premium real-time + WebSocket, Ultimate real-time + WebSocket (page ~4 years old) — [FMP how-to account page](https://site.financialmodelingprep.com/how-to/how-to-create-a-financial-modeling-prep-account).

**EODHD**
- Free 20 calls/day, 15-min delayed; EOD Historical $19.99; EOD+Intraday $29.99; All-In-One $99.99 (~$999.90/yr); WebSocket up to 50 tickers on EOD+Intraday and All-In-One; "live US extended quotes" on All-In-One; B2B from $399 — [EODHD pricing](https://eodhd.com/pricing) (snapshot may be old); [EODHD real-time API](https://eodhd.com/lp/realtime-api); [FindMyMoat (3rd-party 2026)](https://www.findmymoat.com/tools/eodhd).

**Intrinio**
- Individual $150/mo (personal use only); IEX Real-Time Stock Prices labelled "Enterprise"; Startup $333/mo; Enterprise $1,250+/mo; EquitiesEdge (modeled fair-value real-time, no exchange fees) on all plans from $150 — [Intrinio pricing](https://intrinio.com/pricing); [Intrinio home](https://intrinio.com/); [EquitiesEdge](https://intrinio.com/financial-market-data/equitiesedge).

**Yahoo Finance via yfinance (unofficial)**
- README: "yfinance is **not** affiliated, endorsed, or vetted by Yahoo, Inc."; "intended for research and educational purposes"; "Remember - the Yahoo! finance API is intended for personal use only." — [yfinance GitHub README](https://github.com/ranaroussi/yfinance) (fetched 2026-10-17).
- Recurring `YFRateLimitError('Too Many Requests')` reports Feb–May 2025 (v0.2.57–0.2.59), even at a few requests/day — [yfinance issue #2422](https://github.com/ranaroussi/yfinance/issues/2422); [#2480](https://github.com/ranaroussi/yfinance/issues/2480); [#2289](https://github.com/ranaroussi/yfinance/issues/2289).
- Data-center / non-US IPs blocked for >48 h (user report) — [TradingAgents issue #1425](https://github.com/TauricResearch/TradingAgents/issues/1425).

### Inferences
- Cheapest viable stack for a Taiwan retail dev: Alpaca Basic (free IEX WS, 30 symbols) for live triggers + Alpaca/Massive delayed SIP for volume confirmation; upgrade to Alpaca Algo Trader Plus ($99) when volume-accurate real-time triggers are needed. Massive Advanced ($199) is the alternative if not using Alpaca.
- If the user already trades at IBKR (common in Taiwan), IBKR non-pro streaming (~$14.50/mo, $10 portion waivable) via IB Gateway is cheapest for real-time SIP-quality quotes, but requires running TWS/IB Gateway 24/7 and is less developer-friendly.
- Running a cloud server (data-center IP) makes yfinance even less reliable — avoid it for a 24h production bot.
- Databento is over-spec for this use case; and its post-June-2026 US Equities pricing must be checked.

### Gaps
- Massive Basic free-tier limits (5/min, 2 yrs) only from 3rd parties.
- Finnhub paid tier prices: official page only shows $3,500 All-In-One; lower tiers unverified.
- Alpha Vantage tier→real-time mapping only from 3rd parties.
- Alpaca BOATS overnight feed monthly price not found.
- Tiingo free tier limits not captured.
- Whether each vendor sells to Taiwan residents: no vendor found explicitly restricting non-US residents for data-only subscriptions; Alpaca account eligibility for Taiwan unconfirmed.
- Databento: tier the $4,000 (June 2026) price applies to is unclear.

## Q3. News, filings, fundamentals, earnings & economic calendars — free vs paid

### Takeaway
Free core: SEC EDGAR (official, 10 req/s, submissions JSON typically <1 s after dissemination), Alpaca News API (Benzinga-sourced, REST + WebSocket, free with plan limits), Finnhub company news & earnings calendar (free tier), Massive ticker news (reportedly on all plans). Paid: Benzinga direct (quote-based; $99/mo individual via Massive), Finnhub economic calendar (premium). Macro calendars (FOMC, CPI) can be taken from official Fed/BLS schedules and FRED API (free).

### Cited Findings
**SEC EDGAR (free)**
- Max request rate 10 requests/second; SEC may limit rates — [SEC: Accessing EDGAR Data](https://www.sec.gov/search-filings/edgar-search-assistance/accessing-edgar-data).
- data.sec.gov JSON "updated throughout the day, in real time, as submissions are disseminated"; submissions API typical processing delay < 1 second; XBRL APIs < 1 minute; longer at peak filing times; bulk ZIPs recompiled nightly — [SEC: EDGAR APIs](https://www.sec.gov/search-filings/edgar-application-programming-interfaces).
- Declared User-Agent with company/contact email required; undeclared UA throttled/blocked (3rd-party guides) — [tldrfiling](https://tldrfiling.com/blog/sec-edgar-api-rate-limits-best-practices); [dealcharts](https://dealcharts.org/blog/edgar-scraping-rate-limits-explained).
- Structured-disclosure (XBRL) RSS feeds update every 10 minutes Mon–Fri 06:00–22:00 ET — [SEC Structured Disclosure RSS Feeds](https://www.sec.gov/structureddata/rss-feeds). Latest-filings Atom feed via `browse-edgar?action=getcurrent&output=atom` filterable by form type (example from 2016; cadence unconfirmed) — [hex.pm parser package](https://www.hex.pm/packages/sec_recent_filings_rss_feed_parser/0.0.1).
- 2021 SEC launch of data APIs — [SEC press/announcement](https://www.sec.gov/newsroom/whats-new/osd-announcement-090821-sec-disclosure-data-api).

**Alpaca News API (free with any plan)**
- REST + WebSocket (`wss://stream.data.alpaca.markets/v1beta1/news`), source Benzinga, history back to 2015, ~130+ articles/day — [Alpaca Historical News docs](https://docs.alpaca.markets/us/docs/historical-news-data); [Alpaca Real-time News docs](https://docs.alpaca.markets/us/docs/streaming-real-time-news).
- "Currently available for free with rate limits determined by Market Data plan; 200 calls/min for Free plans" (launch blog, ~3 yrs old) — [Alpaca blog: Introducing News API](https://alpaca.markets/blog/introducing-news-api-for-real-time-fiancial-news/).
- Gap reported in 2015-02 → 2016-10 coverage — [Alpaca forum](https://forum.alpaca.markets/t/historical-news-data-missing-for-2016/13576).

**Benzinga**
- Via Massive: Benzinga expansions "start at $99/month" for individuals; business = contact sales — [Massive: Build with Benzinga](https://massive.com/partners/benzinga); [Massive blog: Benzinga data on Massive](https://massive.com/blog/benzingadata-partnership).
- Direct Benzinga API: licensing-led, no public price — [Datarade profile](https://datarade.ai/data-providers/benzinga/profile). Benzinga Pro terminal (not API) $37/$147/$197 — [Benzinga Pro pricing](https://www.benzinga.com/pro/pricing).

**Massive news**
- Ticker News with categorical per-ticker sentiment reportedly included on every Stocks plan incl. Basic; updates hourly (3rd-party, unverified) — [Adanos: news sentiment APIs 2026](https://adanos.org/insights/blog/best-financial-news-sentiment-apis-2026/).

**Finnhub**
- Company news: free tier = 1 year history + new updates; earnings calendar free (1 month history); all-company earnings calendar truncates at 1,500 rows per query; economic calendar = Premium — [Finnhub API docs](https://finnhub.io/docs/api/market-news); [GitHub PR jere67/parallax #47](https://github.com/jere67/parallax/pull/47).

**Press-release wires**
- PR Newswire publishes official RSS feeds by category — [PR Newswire RSS](https://prnewswire.com/rss/). No official RSS docs found for GlobeNewswire/Business Wire in this research.

**Economic calendars**
- FOMC 2026 scheduled meetings: Jan 27–28, Mar 17–18, Apr 28–29, Jun 16–17, Jul 28–29, Sep 15–16, Oct 27–28, Dec 8–9; statement 2:00 PM ET on day 2; SEP/dot plot in Mar/Jun/Sep/Dec (secondary sites citing federalreserve.gov) — [FedRateCalc](https://fedratecalc.com/fomc-meeting-schedule/); [MarketClock](https://marketclock.net/fomc-dates-2026).
- CPI released 08:30 ET; September-2026 CPI released 2026-10-14; 2027 schedule unpublished as of 2026-09-18 (secondary) — [eco3min](https://eco3min.fr/en/next-us-cpi-release/); [Medium: 2026 CPI schedule](https://medium.com/@mkroh09/2026-us-cpi-release-schedule-the-complete-calendar-for-investors-2bd3dac0b44a).
- FRED API: free key; 120 requests/min per key (secondary) — [DatasetIQ guide](https://datasetiq.com/blog/api-access-economic-data-guide).
- Alpha Vantage API has an `economic_indicators` category; Twelve Data includes earnings and IPO calendars (via their MCP tool lists) — [Alpha Vantage MCP repo](https://github.com/alphavantage/alpha_vantage_mcp); [Twelve Data MCP repo](https://github.com/twelvedata/mcp).

### Inferences
- A zero-cost "why did it move?" pipeline: trigger → pull last N hours of Alpaca News (Benzinga) + Finnhub company news + latest EDGAR submissions (8-K, 6-K, Form 4, 13D/G) for that CIK → send to Claude. EDGAR's sub-second submissions API is good enough for 8-K detection if polled responsibly (≤10 req/s).
- Macro events can be hard-coded from official Fed/BLS calendars each year (cheaper than a paid economic calendar API).

### Gaps
- Could not access federalreserve.gov / bls.gov directly to confirm calendar dates; dates come from secondary aggregators.
- FRED rate limit only from secondary source.
- Massive news-on-free-tier claim unverified; Finnhub press-release endpoint plan level unknown.
- No pricing found for Benzinga direct API.

## Q4. Overnight (24-hour) session data — which feeds include Blue Ocean ATS / other overnight venues

### Takeaway
Until 2026-12-06 the SIP does not carry an overnight session; overnight quotes come only from venue-specific feeds — Blue Ocean ATS (BOATS, 20:00–04:00 ET Sun–Thu) via Alpaca (paid BOATS feed or cheaper derived "overnight" feed), Tiingo (+$9/mo), Databento (OCEA.MEMOIR), or IBKR's own overnight venues (free data). From 2026-12-06 the CTA/UTP SIPs move to 23×5 (overnight session 21:00–04:00 ET, maintenance 20:00–21:00 ET), so SIP-based vendors may begin carrying overnight exchange trades — but each vendor's coverage must be re-checked after launch.

### Cited Findings
- SEC approved CTA/UTP plan amendments on 2026-07-07 allowing SIPs to run 21:00 ET Sunday → 20:00 ET Friday with a one-hour nightly maintenance window — [PR Newswire: SIPs receive SEC approval](https://www.prnewswire.com/news-releases/sips-receive-sec-approval-for-extended-trading-hours-initiative-302820006.html); [UTP Vendor Alert #2026-24](https://www.nasdaqtrader.com/TraderNews.aspx?id=UTP2026-24); [UTP Vendor Alert #2026-30 (testing)](https://www.nasdaqtrader.com/TraderNews.aspx?id=UTP2026-30).
- Go-live Sunday 2026-12-06: three existing sessions unchanged, new Overnight session 21:00–04:00 ET, maintenance pause 20:00–21:00 ET, futures-style trade dates (Monday's trade date begins Sunday evening); overnight participation optional for exchanges — [Massive blog: US Equities Move to 23/5 Trading on December 6, 2026](https://massive.com/blog/us-equities-move-to-23-5-trading) (~Aug 2026).
- Readiness: at the SEC 2026-09-17 roundtable, NYSE said CTA and UTP are "fully on schedule"; FINRA TRFs also move to 23×5 in December — [Traders Magazine](https://www.tradersmagazine.com/featured_articles/u-s-markets-prepare-for-december-shift-toward-24-hour-trading/).
- Blue Ocean ATS session 20:00–04:00 ET, Sunday–Thursday — [Blue Ocean: 23/5 exchange trading (2026-08-01)](https://blueocean-tech.io/2026/08/01/23-5-exchange-trading-overnight-market/); [Databento OCEA.MEMOIR dataset](https://databento.com/datasets/OCEA.MEMOIR).
- Date-stamping risk: one overnight trade can carry two different dates (BOATS FIX session date vs TRF calendar date) — [TickDB analysis (Oct 2026)](https://tickdb.ai/blog/general/us-overnight-trading-data-5-questions-to-answer-before-nasdaq-goes-near-245-on-d-mv23yb1q).
- **Alpaca**: overnight trading/data on BOATS 20:00–04:00 ET; BOATS feed available "for a monthly fee"; a cheaper but "slightly less accurate" derived `overnight` feed; historical uses `feed=boats`; 24/5 launched Jan 2026 (Sun 20:00 → Fri 20:00 ET); Alpaca building toward industry go-live 2026-12-06 — [Alpaca 24/5 Trading docs](https://docs.alpaca.markets/us/docs/245-trading); [Alpaca blog: 24/5 launch](https://alpaca.markets/blog/introducing-stocks-24_5-overnight-with-alpaca-trading-api/); [Alpaca Real-time Stock Data docs](https://docs.alpaca.markets/us/docs/real-time-stock-pricing-data). Forum reports access issues — [Alpaca forum](https://forum.alpaca.markets/t/overnight-data-access-not-working/17723).
- **Tiingo**: BOATS-sourced overnight real-time data, "at cost," +$9/mo on Power/Commercial (changelog 2026-07-21) — [Tiingo blog](https://www.tiingo.com/blog/overnight-stock-data-api/); [Tiingo changelog](https://www.tiingo.com/documentation/general/changelog).
- **Databento**: BOATS live + historical (L1/L2/L3, trades, OHLCV) as OCEA.MEMOIR; added to Databento US Equities; PCAPs from $500/mo — [Databento: Blue Ocean ATS now available](https://databento.com/blog/blue-ocean-ats-now-available); [Databento on X](https://x.com/DatabentoHQ/status/2041863736206475270).
- **IBKR**: overnight venues IBEOS (internal) and OVERNIGHT (internal + external liquidity incl. Blue Ocean ATS, displays live NBBO); 20:00–03:50 ET; 10,000+ US stocks/ETFs; overnight market data free with US stock trading permission — [IBKR Overnight Trading](https://www.interactivebrokers.com/en/trading/us-overnight-trading.php); [IBKR Campus: Overnight trading in TWS](https://www.interactivebrokers.com/campus/trading-lessons/overnight-trading-in-tws/).
- **Massive**: documented coverage 04:00–20:00 ET (no overnight session stated in KB) — [Massive KB](https://massive.com/knowledge-base/article/does-massive-offer-pre-market-and-after-hours-data).
- **Twelve Data**: real-time extended hours 07:00–20:00 ET (Pro+); no overnight — [Twelve Data pre/post-market](https://support.twelvedata.com/en/articles/5195429-pre-post-market-data).

### Inferences
- For "around the clock" monitoring from Taiwan (where US overnight 20:00–04:00 ET = Taiwan 08:00/09:00–16:00/17:00, i.e., Taiwan daytime), BOATS data matters. Cheapest options: IBKR (free overnight data if account exists), Tiingo (+$9 on $30 Power), Alpaca (BOATS fee unknown, derived feed cheaper).
- After 2026-12-06, SIP-based vendors (Alpaca SIP, Massive) may pick up exchange overnight prints — this research found no vendor confirmation yet; the bot should be designed so the session/feed parameter is configurable and trade-date logic handles the futures-style convention.

### Gaps
- Alpaca BOATS feed price; whether Massive will add the SIP overnight session after Dec 6, 2026 — not found.
- Whether other ATSs (e.g., Bruce ATS, Moon ATS) are offered by retail APIs — not researched/found.
- Taiwan-time conversion depends on US DST (inference, not a sourced fact).

## Q5. Official MCP servers from data vendors (list only)

### Takeaway
Official/vendor-run MCP servers exist for Massive, Alpha Vantage, Twelve Data, Alpaca, Financial Datasets and EODHD; no official FMP, Finnhub, Databento, Tiingo or Intrinio MCP server was found.

### Cited Findings
- **Massive (ex-Polygon)**: `massive-com/mcp_massive` (v0.10.0, "experimental"; `POLYGON_API_KEY` is a deprecated alias of `MASSIVE_API_KEY`); tools `search_endpoints`, `call_api`, `query_data`; hosted at `https://mcp.massive.com` — [GitHub massive-com/mcp_massive](https://github.com/massive-com/mcp_massive) (fetched 2026-10-17).
- **Alpha Vantage**: "The official Alpha Vantage API MCP server"; remote `https://mcp.alphavantage.co/mcp` with OAuth; listed in claude.ai connector directory; categories incl. core stock, options, news sentiment ("alpha_intelligence"), fundamentals, economic indicators, technical indicators — [GitHub alphavantage/alpha_vantage_mcp](https://github.com/alphavantage/alpha_vantage_mcp); [PyPI alphavantage-mcp](https://pypi.org/project/alphavantage-mcp/).
- **Twelve Data**: hosted `https://mcp.twelvedata.com/mcp` (OAuth browser login) or self-hosted; covers prices, 60+ indicators, fundamentals, news/press releases, EDGAR filings, insider data — [GitHub twelvedata/mcp](https://github.com/twelvedata/mcp).
- **Alpaca**: official `alpacahq/alpaca-mcp-server` v2 (FastMCP/OpenAPI rewrite; runs locally; can place real orders) — [GitHub alpacahq/alpaca-mcp-server](https://github.com/alpacahq/alpaca-mcp-server); [Alpaca docs: MCP Server](https://docs.alpaca.markets/us/docs/alpaca-mcp-server).
- **Financial Datasets**: `financial-datasets/mcp-server` (10 tools: statements, current/historical prices, company news, crypto; local) — [GitHub financial-datasets/mcp-server](https://github.com/financial-datasets/mcp-server); hosted OAuth version listed at [PulseMCP](https://www.pulsemcp.com/servers/financial-datasets).
- **EODHD**: official MCP server documented on vendor site (two auth variants; ~72 read-only tools per a comparison) — [EODHD MCP Server](https://eodhd.com/financial-apis/mcp-server-for-financial-data-by-eodhd); [Shibui Finance comparison](https://shibui.finance/guide-best-mcp-server-stock-data).
- **FMP**: only community-built MCP servers found (need FMP API key) — [Glama listing example](https://glama.ai/mcp/servers/shadi-fsai/fmp_mcp_server).

### Inferences
- Several of these (Alpha Vantage, Twelve Data, Massive hosted) are remote OAuth MCP servers, convenient for Claude.ai connectors; the bot's 24h trigger engine should still call REST/WebSocket directly, with MCP used only for Claude's on-demand analysis.

### Gaps
- Did not search exhaustively for Finnhub, Databento, Tiingo, Intrinio MCP servers; none surfaced in searches.
- FMP official MCP existence unconfirmed.
