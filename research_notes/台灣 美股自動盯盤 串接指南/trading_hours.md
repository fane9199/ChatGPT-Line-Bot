# 美股交易時段、台灣時間換算、24 小時交易現況（截至 2026-10-17）

> Research method note: research date 2026-10-17. Direct page fetches to finra.org / nasdaq.com / sec.gov / jonesday.com / morningstar.com were blocked in this environment (DNS/proxy refusal), so findings come from search-engine extracts of those pages plus secondary press. Every Taiwan-time conversion below was computed with Python `zoneinfo` (America/New_York → Asia/Taipei), not taken from a source. Status labels used: **[Announced]** = company said it plans to, **[Filed]** = rule filing at SEC, **[Approved]** = SEC order issued, **[Live]** = actually operating.

## 1. Regular / pre-market / after-hours sessions, Taiwan-time conversion, DST switch dates, 2026–2027 holiday and early-close calendars

### Takeaway
Taiwan is fixed at UTC+8 (no DST), so every US session simply shifts by 1 hour twice a year: during US DST (EDT, UTC-4) Taiwan = ET + 12h; during US standard time (EST, UTC-5) Taiwan = ET + 13h. Regular session is 21:30–04:00 Taiwan in summer and 22:30–05:00 Taiwan in winter; the next switch is **Sunday 2026-11-01** (to winter time), then **2027-03-14** (to summer time) and **2027-11-07** (to winter time). Remaining 2026 closures: Thanksgiving Thu 2026-11-26 (closed), Fri 2026-11-27 (1:00 p.m. ET early close), Thu 2026-12-24 (1:00 p.m. ET early close, per secondary sources), Fri 2026-12-25 (closed).

### Cited Findings

**DST dates (US)**
- 2026: clocks sprang forward Sunday 2026-03-08 at 2:00 a.m.; fall back Sunday 2026-11-01 at 2:00 a.m. — [timeanddate 2026a](https://www.timeanddate.com/time/dst/2026a.html); [timeanddate 2026b](https://www.timeanddate.com/time/dst/2026b.html)
- 2027: spring forward Sunday 2027-03-14 at 2:00 a.m. — [timeanddate 2027a](https://www.timeanddate.com/time/dst/2027a.html). The fall-back date 2027-11-07 was NOT found in a source; it follows from the US rule (first Sunday of November) and Python `zoneinfo` confirms the offset change on 2027-11-07 (computed, see Inferences).
- Europe-style dates (e.g., 2027-10-31) that show up on some timetables do not apply to US clocks — [timeanddate (Albania example)](https://www.timeanddate.com/time/change/@41.3237,19.8203?year=2027)

**Session times (ET) and Taiwan conversion (conversion computed by me with zoneinfo; session definitions sourced)**

| Session (ET) | Source for ET times | Taiwan time, US DST (EDT; 2026-03-08→11-01, 2027-03-14→11-07) | Taiwan time, US standard (EST; 2026-11-01→2027-03-14) |
|---|---|---|---|
| Pre-market 4:00–9:30 | Nasdaq Day Session starts 4:00 a.m. — [Troutman](https://www.troutman.com/insights/nasdaq-23-hour-equity-trading-proposal-approved-by-sec/); 24X day session 4:00 a.m.–8:00 p.m. — [Markets Media](https://www.marketsmedia.com/24x-exchange-to-launch-on-29-september/) | 16:00–21:30 (same day) | 17:00–22:30 |
| Regular 9:30–16:00 | Standard NYSE/Nasdaq core session (circuit-breaker rules reference 3:25 p.m./close — [Schwab](https://www.schwab.com/learn/story/what-are-stock-market-circuit-breakers)) | 21:30–04:00 (+1 day) | 22:30–05:00 (+1 day) |
| After-hours 16:00–20:00 | Nasdaq Day Session ends 8:00 p.m. — [Troutman](https://www.troutman.com/insights/nasdaq-23-hour-equity-trading-proposal-approved-by-sec/) | 04:00–08:00 | 05:00–09:00 |
| ATS overnight 20:00–04:00 (Blue Ocean, Bruce, MOON) | Blue Ocean 8:00 p.m.–4:00 a.m. Sun–Thu — [Blue Ocean ATS](https://www.blueocean-tech.io/blue-ocean-ats/); Bruce ATS 8:00 p.m.–4:00 a.m. — [Bruce Markets](https://www.brucemarkets.com/about/) | 08:00–16:00 | 09:00–17:00 |
| IBKR overnight 20:00–03:50 | [IBKR Overnight Trading](https://www.interactivebrokers.com/en/trading/us-overnight-trading.php) | 08:00–15:50 | 09:00–16:50 |
| Exchange "Night Session" 21:00–04:00 (Nasdaq/NYSE Arca/Cboe, target 2026-12-06, NOT live yet) | [Troutman](https://www.troutman.com/insights/nasdaq-23-hour-equity-trading-proposal-approved-by-sec/); [Cboe IR](https://ir.cboe.com/news/news-details/2026/Cboe-Files-Proposal-with-the-SEC-to-Launch-Near-24x5-U-S--Equities-Trading/default.aspx) | 09:00–16:00 | 10:00–17:00 (first session would be Mon 2026-12-07 10:00 Taiwan) |
| Exchange maintenance pause 20:00–21:00 | [Troutman](https://www.troutman.com/insights/nasdaq-23-hour-equity-trading-proposal-approved-by-sec/) | 08:00–09:00 | 09:00–10:00 |
| Week opens Sun 20:00 ET (ATS / Robinhood / Schwab) | Robinhood 24 Hour Market "Sunday 8 PM ET through Friday 8 PM ET" — [Robinhood](https://robinhood.com/us/en/support/articles/24hour-market) | Mon 08:00 | Mon 09:00 |
| Week closes Fri 20:00 ET | same | Sat 08:00 | Sat 09:00 |

- Practical summary for a Taiwanese user (computed): in winter (Nov–Mar), Taiwan 05:00–09:00 = after-hours, 09:00–17:00 = overnight ATS, 17:00–22:30 = pre-market, 22:30–05:00 = regular session. In summer, subtract 1 hour from every boundary. Under today's broker 24/5 offerings, the only true gap is the weekend (Sat 08:00/09:00 → Mon 08:00/09:00 Taiwan). (Computed from the sourced ET times above.)

**2026 NYSE/Nasdaq holidays (official source: NYSE Group release of 2025-12-23)**
- NYSE Group published the 2026/2027/2028 holiday & early-closing calendar on 2025-12-23; Independence Day 2026 observed Friday July 3; early close Friday 2026-11-27 — [Business Wire / NYSE Group](https://www.businesswire.com/news/home/20251223981478/en/NYSE-Group-Announces-2026-2027-and-2028-Holiday-and-Early-Closings-Calendar); [ICE IR](https://ir.theice.com/press/news-details/2025/NYSE-Group-Announces-2026-2027-and-2028-Holiday-and-Early-Closings-Calendar/default.aspx)
- 2026 full-day closures: Jan 1 (Thu), Jan 19 (MLK, Mon), Feb 16 (Presidents' Day, Mon), Apr 3 (Good Friday), May 25 (Memorial Day), Jun 19 (Juneteenth, Fri), Jul 3 (Independence Day observed, Fri), Sep 7 (Labor Day), Nov 26 (Thanksgiving, Thu), Dec 25 (Christmas, Fri) — [Kiplinger](https://www.kiplinger.com/investing/stock-market-holidays); [CalendarLabs](https://www.calendarlabs.com/nyse-market-holidays-2026/) (weekdays verified with Python)
- 2026 early closes (1:00 p.m. ET): Fri Nov 27 (confirmed in NYSE release excerpt); Thu Dec 24 (listed by CalendarLabs and other secondary calendars; the NYSE excerpt retrieved was cut off before the second date) — [CalendarLabs](https://www.calendarlabs.com/nyse-market-holidays-2026/); [Business Wire](https://www.businesswire.com/news/home/20251223981478/en/NYSE-Group-Announces-2026-2027-and-2028-Holiday-and-Early-Closings-Calendar)
- Conflict: Kiplinger and The Standard list a Thu 2026-07-02 1:00 p.m. early close; the NYSE excerpt retrieved did not show it. (Now in the past, so irrelevant for forward monitoring.) — [Kiplinger](https://www.kiplinger.com/investing/stock-market-holidays); [The Standard](https://www.standard.com/individuals-families/workplace-benefits/retirement/stock-market-and-bank-holidays)
- Early close 1:00 p.m. ET in winter = 02:00 Taiwan the next day (e.g., Nov 27 early close = Sat 2026-11-28 02:00 Taiwan; Dec 24 early close = Fri 2026-12-25 02:00 Taiwan) — computed.

**2027 NYSE/Nasdaq holidays**
- Full-day closures: Jan 1 (Fri), Jan 18 (MLK), Feb 15 (Washington's Birthday), Mar 26 (Good Friday), May 31 (Memorial Day), Jun 18 (Juneteenth observed, Fri), Jul 5 (Independence Day observed, Mon), Sep 6 (Labor Day), Nov 25 (Thanksgiving), Dec 24 (Christmas observed, Fri). Only early close: Fri 2027-11-26, 1:00 p.m. ET — [ICE IR (2025 release)](https://ir.theice.com/press/news-details/2025/NYSE-Group-Announces-2026-2027-and-2028-Holiday-and-Early-Closings-Calendar/default.aspx); [ICE IR (2024 release)](https://ir.theice.com/press/news-details/2024/NYSE-Group-Announces-2025-2026-and-2027-Holiday-and-Early-Closings-Calendar/default.aspx); [stockmarkethours.org](https://stockmarkethours.org/nyse-holidays-2027)
- Schwab: extended-hours trading "will not take place on official Exchange holidays or when Exchanges close early" — [Schwab extended hours](https://www.schwab.com/stocks/extended-hours-trading)

### Inferences
- 2027-11-07 is the US fall-back date (first Sunday in November; Python `zoneinfo` shows the UTC offset changing on 2027-11-07). Treat as high confidence but not source-cited.
- Implementation advice: never hard-code "+12" or "+13"; store all schedules in America/New_York and convert with a tz library (zoneinfo / pytz / moment-timezone). Taiwan itself never changes, so the only switch events are the US ones.
- 2027-12-31 (Fri): Jan 1, 2028 is a Saturday; by NYSE's usual practice the market is NOT closed on the preceding Friday at year-end, but I did not find this in a source — verify with the NYSE 2028 calendar.
- Overnight sessions adjacent to holidays (e.g., Wednesday night before Thanksgiving, whose trade date would be the holiday) are presumably not offered; Cboe's proposal says near-24x5 "excluding U.S. market holidays" ([Cboe IR](https://ir.cboe.com/news/news-details/2026/Cboe-Files-Proposal-with-the-SEC-to-Launch-Near-24x5-U-S--Equities-Trading/default.aspx)), but exact per-venue holiday rules for night sessions were not found.

### Gaps
- Could not open the full NYSE 2025-12-23 release table to confirm Dec 24, 2026 early close directly (secondary calendars agree).
- Extended-hours end time on early-close days (whether after-hours runs 1:00–5:00 p.m. ET on NYSE Arca/Nasdaq) was not confirmed.

## 2. Overnight trading venues (Blue Ocean, Bruce, MOON, others) and broker routing / eligible symbols

### Takeaway
As of Oct 2026, all "24-hour" US stock trading available to retail is **broker + ATS overnight (≈20:00–04:00 ET)**, not exchange trading. Main ATSs: Blue Ocean ATS (largest, 2024 outage), Bruce ATS (backed by PEAK6/Robinhood; weekend trading announced 2026-09-29, not live), OTC Markets' MOON ATS (launched Nov 2024), plus IBKR's in-house IBEOS. Each broker exposes only its own eligible list (IBKR 10,000+ symbols; Schwab 1,100+; Robinhood a curated list), limit orders only.

### Cited Findings

**Blue Ocean ATS (BOATS)**
- Hours 8:00 p.m.–4:00 a.m. ET Sunday–Thursday; trades NMS stocks, ETFs, ADRs — [Blue Ocean ATS](https://www.blueocean-tech.io/blue-ocean-ats/)
- August 2024 incident: during the yen carry-trade unwind (night of Sun Aug 4 → Mon Aug 5, 2024) Blue Ocean detected issues around 1:45 a.m. ET Monday and **cancelled all trades from that point to ~3:06 a.m.**, halting the session; Robinhood and other brokers relying on it suspended overnight trading; IBKR re-routed client orders to its own venue (IBEOS) — [BNN Bloomberg, 2024-08-06](https://www.bnnbloomberg.ca/investing/2024/08/06/biggest-overnight-stock-venue-suspends-trading-after-volatility/); [Markets Media](https://www.marketsmedia.com/blue-ocean-ats-resumes-after-cancelling-trades/)
- Reuters (2024-08-19, reposted by Blue Ocean): Blue Ocean completed a fix for capacity issues — [Blue Ocean / Reuters](https://blueocean-tech.io/2024/08/19/reuters-us-overnight-trading-platform-blue-ocean-completes-fix-for-capacity-issues/)
- Later stress events without reported outages: US election night Nov 2024 record volume; DeepSeek Sunday session Jan 2025 record $2.7bn notional — [Markets Media (DeepSeek)](https://www.marketsmedia.com/deepseek-triggers-record-trading-session-at-blue-ocean-ats/); [itiger (election)](https://itiger.com/news/2481163490)
- No comparable outage in 2025–2026 found; Blue Ocean maintains a public service-status page — [Blue Ocean service status](https://www.blueocean-tech.io/blue-ocean-ats-service-status/); [Tiingo blog](https://www.tiingo.com/blog/overnight-stock-data-api/) (Tiingo is a data vendor reselling BOATS data, so not neutral)
- Data distribution: ICE provides Blue Ocean overnight real-time feed (2023-03-13) — [Business Wire](https://www.businesswire.com/news/home/20230313005311/en/ICE-Provides-Access-to-Blue-Ocean-Technologies-Overnight-Real-Time-Equity-Data-Feed); also on TradingView — [TradingView blog](https://www.tradingview.com/blog/en/blue-ocean-ats-data-on-tradingview-53016); Tiingo API — [Tiingo](https://www.tiingo.com/blog/blue-ocean-ats-overnight-stock-data/)

**Bruce ATS (Bruce Markets)**
- US equities ATS for overnight trading 8:00 p.m.–4:00 a.m. ET; majority shareholder PEAK6 — [Bruce Markets](https://www.brucemarkets.com/about/)
- **[Announced, not live]** 2026-09-29/30: Bruce Markets announced it will launch continuous **weekend** US equities trading, with strategic investments led by PEAK6 and Robinhood; launch starts with limited symbols, "subject to regulatory review"; no exact date — [Bruce Markets PR](https://www.brucemarkets.com/markets-to-be-open-seven-days-a-week-bruce-markets-to-launch-first-continuous-weekend-us-equities-trading-with-strategic-investments-led-by-peak6-and-robinhood/); [Bloomberg 2026-09-29](https://www.bloomberg.com/news/articles/2026-09-29/robinhood-debuts-weekend-trading-perpetual-futures-to-customers); [InvestmentNews](https://www.investmentnews.com/equities/weekend-equity-trading-is-coming-what-advisors-need-to-know/268413)
- Robinhood said 24-hour trading including weekends for select stocks/ETFs would start "in early 2027" — [TipRanks](https://www.tipranks.com/news/robinhood-expands-ai-agent-predictions-and-24-7-trading-tools-in-bold-end-to-2026); [Yahoo Finance](https://finance.yahoo.com/markets/stocks/articles/robinhood-markets-unveils-24-7-010214206.html)

**MOON ATS (OTC Markets Group)**
- Launched Nov 2024 (OTC Markets blog 2025-01-08 discusses the launch); 8 p.m.–4 a.m. ET Sun–Thu; NMS securities (and OTC equities); targeted at APAC daytime investors — [OTC Markets blog](https://blog.otcmarkets.com/2025/01/08/with-moon-ats-launch-otc-markets-group-lights-the-way-to-overnight-tradings-bright-future/); [Seeking Alpha PR](https://seekingalpha.com/pr/19922939-otc-markets-group-announces-launch-of-moon-ats-a-new-overnight-trading-platform-for-national); data via dxFeed — [dxFeed](https://dxfeed.com/market-data/equities-etfs/moon-ats/)
- DriveWealth (B2B broker infrastructure used by many apps) added multiple overnight venues including MOON — [Nasdaq PR](https://www.nasdaq.com/press-release/drivewealth-expands-overnight-coverage-include-multiple-venues-support-24-hour)

**Brokers**
| Broker | Hours (ET) | Venue | Eligible symbols | Order rules | Source |
|---|---|---|---|---|---|
| Interactive Brokers "Overnight" | 8:00 p.m.–3:50 a.m., Sun night–Fri morning | Smart-routes between Blue Ocean and IBEOS (own ATS); can direct-route IBEOS | 10,000+ US stocks & ETFs (2022 launch was 24 ETFs only) | Limit orders; TIF "overnight" or "overnight + day"; trades 8 p.m.–midnight carry next trading day's trade date | [IBKR](https://www.interactivebrokers.com/en/trading/us-overnight-trading.php); [IBKR Campus](https://www.interactivebrokers.com/campus/trading-lessons/overnight-trading-in-tws/); [Business Wire 2022-11-21](https://www.businesswire.com/news/home/20221121005086/en/Interactive-Brokers-Launches-Overnight-Trading-Hours-for-US-ETFs) |
| Robinhood "24 Hour Market" | Sun 8 p.m. → Fri 8 p.m. | ATS(s) for overnight (Bruce among them) | Curated list ("some of our most popular… stocks and ETFs"; 43 names at 2023 launch) | Limit only; GFD expires 8 p.m. ET; GTC up to 90 days; ATS price bands vs. last extended-hours price | [Robinhood help](https://robinhood.com/us/en/support/articles/24hour-market); [Motley Fool](https://www.fool.com/the-ascent/buying-stocks/articles/robinhood-now-lets-users-trade-stocks-245-but-does-that-mean-you-should) |
| Charles Schwab 24/5 (thinkorswim only) | Overnight 8 p.m.–7 a.m.; extended 7 a.m.–8 p.m. | Not disclosed in sources found | All S&P 500, Nasdaq-100, Dow 30 + 600+ ETFs; later >1,100 securities; "24 Hour Trading" watchlist | Limit only, EXTO orders expire 8 p.m. ET; size cap conflicts ($2M/50,000 shares vs. $10M) | [Schwab 24/5](https://www.schwab.com/learn/story/ins-and-outs-245-trading); [Business Wire 2025-02-12](https://www.businesswire.com/news/home/20250212055274/en/Schwab-Makes-Expanded-24-Hour-Trading-Available-to-All-Clients); [Schwab International](https://international.schwab.com/node/9706) |
| Webull (US) | 8 p.m.–4 a.m.; Sun–Thu at Nov 2024 launch; current page says Sun–Fri | Blue Ocean ATS | Select stocks & ETFs | Trades 8–11:59 p.m. get next-day trade date | [Finance Magnates](https://www.financemagnates.com/forex/webull-launches-overnight-trading-for-retail-clients-expands-market-hours-to-245/); [Webull guide](https://www.webull.com/blog/279-Comprehensive-Guide-to-Cboe-24x5-Trading-and-Overnight-Markets) |
| Webull Canada | Same hours, beta from June 2026 | — | — | — | [FinTech Global 2026-06-16](https://fintech.global/2026/06/16/webull-canada-launches-24-5-overnight-trading) |

- Schwab International pages exist (relevant to non-US/Taiwan clients) and describe the 24/5 offering — [Schwab International](https://international.schwab.com/node/9706)

### Inferences
- For a Taiwan-based monitor, the overnight session (09:00–17:00 Taiwan in winter, 08:00–16:00 in summer) coincides with the Taiwan workday; this is exactly the window the MOON ATS launch release markets to APAC investors.
- "Eligible symbol" lists differ per broker; the program should fetch the broker's list (or test quote availability) rather than assume a symbol trades overnight.
- Because overnight trades from 8 p.m.–midnight ET carry the next trading day's trade date (IBKR, Webull), daily P&L / "today's change" computed by date can be off unless the code uses trade date rather than wall-clock date.

### Gaps
- moomoo (Futu) overnight hours, venue and symbol list: no source found in this session.
- Schwab's overnight routing venue not disclosed in sources found.
- Clear Street "24/6 trading" press release appeared in results but was not read — [Clear Street](https://www.clearstreet.io/news/press-releases/clear-street-launches-24-6-trading).
- No confirmed list of 2025–2026 Blue Ocean outages beyond Aug 2024; absence of reports ≠ no incidents.

## 3. Exchange-level 23/5 trading: Nasdaq, NYSE Arca, Cboe EDGX, 24X, MEMX, SIPs (CTA/UTP), DTCC

### Takeaway
"24/5" has become **23/5** at the exchange level: Sunday 9:00 p.m. ET → Friday 8:00 p.m. ET with a daily 8–9 p.m. ET pause. All plumbing is approved, and clearing is already live, but **as of 2026-10-17 no exchange overnight session is live**. Nasdaq, NYSE Arca and the SIPs all target **Sunday 2026-12-06** (first night session = Mon 2026-12-07 10:00 Taiwan). 24X's day session (4 a.m.–8 p.m. ET) has been live since 2025-09-29; its overnight session waits for the SIPs, with a fallback exemption that kicks in on 2027-01-24 if the SIPs are still not ready.

### Cited Findings

**Nasdaq** — [Approved 2026-04-10], target live 2026-12-06
- SEC approved SR-NASDAQ-2025-109 on 2026-04-10 (Release No. 34-105199): Day Session 4:00 a.m.–8:00 p.m. ET, Night Session 9:00 p.m.–4:00 a.m. ET, 8–9 p.m. pause for maintenance/testing/corporate actions; night session limit orders only (no unpriced or pegged orders); Limit Order Protection and clearly-erroneous rules apply; approval conditioned on temporary static 20% "Overnight Price Bands", broker-level controls to block client overnight orders, and clearly-erroneous review procedures — [Troutman Pepper Locke](https://www.troutman.com/insights/nasdaq-23-hour-equity-trading-proposal-approved-by-sec/); [Simpson Thacher 2026-04-29](https://www.stblaw.com/about-us/publications/view/2026/04/29/looking-ahead-to-extended-trading-sec-approves-nasdaq-s-23-5-trading-proposal); [SEC 34-105199 PDF](https://www.sec.gov/files/rules/sro/nasdaq/2026/34-105199.pdf)
- Approval is not launch: Nasdaq must file a further rule change confirming systems readiness; night session depends on SIP readiness; Nasdaq set Sunday 2026-12-06 as effective date — [Troutman](https://www.troutman.com/insights/nasdaq-23-hour-equity-trading-proposal-approved-by-sec/); [Nasdaq 23/5 hub](https://www.nasdaq.com/products/north-american-markets/market-structure-policy/24-hour-trading-hub)
- Earlier framing was "24/5"; official current framing is 23 hours/5 days — [Nasdaq 23/5 hub](https://www.nasdaq.com/23-5-trading); [Cooley](https://governancebeat.cooley.com/24-hour-trading-nasdaqs-faqs-and-secs-roundtable/); August 2026 coverage: [Benzinga](https://www.benzinga.com/markets/equities/26/08/61262081/nasdaq-going-almost-24-7-exchange-eyes-23-hour-trading-day)

**NYSE Arca** — 22-hour plan [Approved 2025-02-11], replaced by 23/5-style Overnight Session [Filed/effective rule 2026], target 2026-12-06
- SEC order of 2025-02-11 (Release 34-102400) approved NYSE Arca's proposal to extend to 22 hours/day, 5 days/week — cited in [SEC 34-105532 (SR-NYSEARCA-2026-53)](https://www.sec.gov/files/rules/sro/nysearca/2026/34-105532.pdf)
- 2026-05-27 Federal Register: NYSE Arca filing (immediately effective) to amend Temporary Rule 7.34-E(T) to provide an **Overnight Trading Session** and change Early/Late session hours — [Federal Register](https://www.federalregister.gov/documents/2026/05/27/2026-10450/self-regulatory-organizations-nyse-arca-inc-notice-of-filing-and-immediate-effectiveness-of-proposed)
- NYSE FAQ: overnight session 9:00 p.m.–4:00 a.m. ET; launch 2026-12-06 subject to SEC approvals, SIP availability and DTCC modernization; NYSE Arca extended its launch window from 18 to 24 months to align with industry — [NYSE Extended Hours FAQ](https://www.nyse.com/publicdocs/nyse/NYSE_Extended_Hours_Trading_FAQ.pdf); [NYSE Arca extended hours](https://www.nyse.com/extended-hours-trading)
- Jones Day (Sept 2026): "NYSE and Nasdaq Move to 23-Hour Trading Day … Evolution, But Not Yet a Revolution"; several implementing rules still subject to SEC approval — [Jones Day](https://www.jonesday.com/en/insights/2026/09/nyse-and-nasdaq-move-to-23hour-trading-day-overnight-session-is-an-evolution-but-not-yet-a-revolution)

**Cboe EDGX** — [Filed 2026-03-16], target December 2026
- Filed with SEC 2026-03-16 for near-24x5 on EDGX: Sunday 9 p.m. → Friday 8 p.m. ET, 8–9 p.m. pause Mon–Thu, excluding US market holidays; all NMS stocks eligible; cleared via DTCC; launch "December 2026, pending regulatory approval … and readiness of required industry infrastructure providers" — [Cboe IR](https://ir.cboe.com/news/news-details/2026/Cboe-Files-Proposal-with-the-SEC-to-Launch-Near-24x5-U-S--Equities-Trading/default.aspx); [InvestmentNews](https://www.investmentnews.com/equities/round-the-clock-trading-of-us-equities-could-begin-by-year-end-as-cboe-files-sec-proposal/265716)
- Secondary sources list five exchanges with conditional (SIP-contingent) approval: 24X, Cboe EDGX, MEMX, Nasdaq, NYSE Arca — [WilmerHale 2026-09-29](https://www.wilmerhale.com/en/insights/client-alerts/20260929-23x5-trading-comes-to-us-exchanges-what-firms-should-know-before-launch) (via search summary); MEMX filing SR-MEMX-2026-28 — [fintechlaw.ai](https://fintechlaw.ai/blog/memx-23x5-overnight-trading-sr-memx-2026-28-compliance-guide)

**24X National Exchange** — day session [Live 2025-09-29]; overnight [Approved Nov 2024, conditional] not live
- First stage launched 2025-09-29: US equities 4:00 a.m.–8:00 p.m. ET weekdays — [Markets Media](https://www.marketsmedia.com/24x-exchange-to-launch-on-29-september/); [Markets Media](https://www.marketsmedia.com/24x-national-exchange-opens-for-trading/); [The TRADE](https://www.thetradenews.com/24x-national-exchange-goes-live-with-23-hour-weekday-us-equities-trading/)
- SEC approved 23/5 in Nov 2024 contingent on Equity Data Plan (SIP) changes; 24X filed for exemption 2025-12-15; 2026-04-29 response letter urged SEC to grant temporary exemption — [PR Newswire](https://www.prnewswire.com/news-releases/24x-national-exchanges-response-letter-urges-sec-approval-of-temporary-exemption-to-launch-overnight-trading-302756559.html)
- SEC denied the immediate SIP exemption "for now"; 24X must wait for SIPs (Dec 6) — [WatersTechnology](https://www.waterstechnology.com/data-management/7953204/sec-denies-24xs-requested-sip-exemption-for-now)
- SEC then granted a **temporary conditional exemption** (File S7-2026-06; Release 34-106061, dated ~2026-08-07 per Massive): 24X may run overnight without consolidated-tape coverage only starting **2027-01-24** and only if SIPs have not launched by then — [Federal Register public inspection](https://public-inspection.federalregister.gov/2026-16572.pdf); [Better Markets (critical)](https://bettermarkets.org/analysis/the-sec-is-enabling-24-7-stock-trading-without-the-conditions-it-previously-put-in-place-to-protect-investors/); [Massive blog](https://massive.com/blog/us-equities-move-to-23-5-trading)

**SIPs (CTA / UTP)** — [Approved 2026-07-07], production 2026-12-06
- SEC approved CTA and UTP Plan amendments (announced 2026-07-07); from Sunday 2026-12-06 SIPs support 9:00 p.m. ET Sunday → 8:00 p.m. ET Friday, with a one-hour maintenance window 8–9 p.m. ET each evening — [PR Newswire / Morningstar](https://www.morningstar.com/news/pr-newswire/20260707ny99770/sips-receive-sec-approval-for-extended-trading-hours-initiative); [UTP Vendor Alert 2026-24](https://www.nasdaqtrader.com/TraderNews.aspx?id=UTP2026-24)
- New overnight LULD indicator from 2026-12-06; Extended Trading Hours UAT testing began October 2026; Saturday test windows run Fri 11 p.m.–Sat 12 p.m. ET, last one 2026-12-04 — [UTP Vendor Alert 2026-24](https://www.nasdaqtrader.com/TraderNews.aspx?id=UTP2026-24); [UTP SIP Extended Hours FAQ](https://www.utpplan.com/DOC/Nasdaq%20UTP%20SIP%20Extended%20Trading%20Hours%20FAQ%20Finalized%20Version%201.pdf)
- Earlier SIP plan amendment (pre-approval) proposed 8 p.m. Sunday–8 p.m. Friday contingent on DTCC and TRF coverage — [PR Newswire](https://www.prnewswire.com/news-releases/sips-submit-plan-amendment-to-extend-operating-hours-to-accommodate-overnight-trading-302647034.html); Capco (pre-approval) warned other SEC priorities such as tick-size changes could affect the Dec 2026 date — [Capco](https://www.capco.com/intelligence/capco-intelligence/us-equities-extended-trading-hours)

**LULD Plan overnight bands** — [Approved 2026-08-05]
- SEC approved LULD Plan Amendment 27 on 2026-08-05: overnight protected hours 9:00 p.m.–4:00 a.m. ET Sun–Thu; temporary static ±20% bands — [Federal Register 2026-08-10](https://www.govinfo.gov/content/pkg/FR-2026-08-10/html/2026-16201.htm)
- SIPs publish overnight bands once at 9 p.m. ET; clear them at 4 a.m. (zero price band messages); **no bands 4:00–9:30 a.m. ET** — [UTP SIP FAQ](https://www.utpplan.com/DOC/Nasdaq%20UTP%20SIP%20Extended%20Trading%20Hours%20FAQ%20Finalized%20Version%201.pdf) (via search extract)

**DTCC / NSCC clearing** — [Live June 2026]
- NSCC extended clearing to Sunday 8:00 p.m. ET → Friday 8:00 p.m. ET; DTCC release dated 2026-06-29 (some outlets say go-live 2026-06-28); CCP guarantee covers overnight trades; industry testing began Jan 2026; built on Sept 2024 earlier-acceptance enhancement — [DTCC press release](https://www.dtcc.com/press-releases/2026/nscc-now-live-with-clearing-hours-extended); [The TRADE](https://www.thetradenews.com/national-securities-clearing-corporation-goes-live-with-24-5-clearing/); [Finadium](https://finadium.com/dtcc-goes-live-with-24x5-model-in-us-equities/)

**Status table (as of 2026-10-17)**
| Item | Announced/Filed | SEC approved | Live? |
|---|---|---|---|
| Nasdaq 23/5 Night Session | filed SR-NASDAQ-2025-109 (Dec 2025) | 2026-04-10 (34-105199) | No — target 2026-12-06 |
| NYSE Arca overnight | 22h approved 2025-02-11; overnight-session rule FR 2026-05-27 | yes (conditional) | No — target 2026-12-06 |
| Cboe EDGX near-24x5 | filed 2026-03-16 | conditional per secondary sources (date not found) | No — target Dec 2026 |
| 24X | 23/5 approved Nov 2024 | day session approved; overnight exemption effective only 2027-01-24 if SIPs late | Day session yes (since 2025-09-29); overnight no |
| SIPs CTA/UTP | plan amendment filed early 2026 | 2026-07-07 | No — production 2026-12-06; UAT running since Oct 2026 |
| LULD overnight bands | — | 2026-08-05 | No — effective with SIP launch |
| DTCC/NSCC 24x5 clearing | — | — | **Yes**, since late June 2026 |

### Inferences
- From Dec 7, 2026 (Taiwan) onward, a Taiwan user should expect exchange-quoted, SIP-consolidated overnight prices 10:00–17:00 Taiwan (winter); before that, overnight prices come only from ATS proprietary feeds (Blue Ocean/Bruce/MOON) or the broker's own data.
- Exchange Night Session starts at 9 p.m. ET while the ATSs start at 8 p.m. ET; the 8–9 p.m. ET hour (09:00–10:00 Taiwan in winter) will still be ATS-only.
- The Dec 6 date has been repeatedly described as contingent; the monitor should treat the session calendar as data (config) rather than code so a slip can be absorbed.

### Gaps
- No source confirming Nasdaq/NYSE Arca filed the final "systems-readiness" rule change yet (an SEC PDF 34-106631 for Nasdaq 2026 appeared in results but content was not retrieved).
- Cboe EDGX approval date not found.
- Whether broker-ATS overnight trading will continue alongside exchange night sessions, and how brokers will route after Dec 6, was not found.
- Overnight trade-date convention at the exchange level (expected: night-session trades belong to the next trading day, matching broker practice) not confirmed in a primary source.

## 4. Practical risks of extended / overnight sessions

### Takeaway
Overnight = thin liquidity, wide spreads, limit-only, price-banded, and historically subject to wholesale trade cancellation (Blue Ocean, Aug 2024). Data is fragmented until SIP coverage starts (target 2026-12-06), and every broker has its own symbol list, order caps and trade-date quirks.

### Cited Findings
- Thinner liquidity and wider spreads overnight — [Broadridge](https://www.broadridge.com/campaigns/23-5); firms must treat overnight as a full session (routing, data feeds, risk limits, surveillance) — [Mill5](https://mill5.com/insights/the-new-operating-model-for-us-equities/); staffing/supervision review — [KPMG](https://kpmg.com/us/en/articles/2025/trading.html)
- A search extract attributes to "SEC staff analysis" that overnight volume ≈0.9% of total NMS share volume with 359% YoY growth; original document not identified, treat as unverified — [WilmerHale search cluster](https://www.wilmerhale.com/en/insights/client-alerts/20260929-23x5-trading-comes-to-us-exchanges-what-firms-should-know-before-launch)
- Limit orders only: Nasdaq Night Session (no market, unpriced or pegged orders) — [Troutman](https://www.troutman.com/insights/nasdaq-23-hour-equity-trading-proposal-approved-by-sec/); Robinhood 24 Hour Market — [Robinhood](https://robinhood.com/us/en/support/articles/24hour-market); Schwab EXTO — [Schwab](https://www.schwab.com/learn/story/ins-and-outs-245-trading); IBKR — [IBKR Campus](https://www.interactivebrokers.com/campus/trading-lessons/overnight-trading-using-limit-order/)
- Unmatched limit orders simply don't execute in extended hours — [Schwab extended hours](https://www.schwab.com/stocks/extended-hours-trading)
- Trade busts: Blue Ocean cancelled all trades ~1:45–3:06 a.m. ET on 2024-08-05 — [BNN Bloomberg](https://www.bnnbloomberg.ca/investing/2024/08/06/biggest-overnight-stock-venue-suspends-trading-after-volatility/); clearly-erroneous rules apply in exchange Night Session — [Troutman](https://www.troutman.com/insights/nasdaq-23-hour-equity-trading-proposal-approved-by-sec/)
- Price bands: ATS bands relative to the last extended-hours price (Robinhood) — [Robinhood](https://robinhood.com/us/en/support/articles/24hour-market); exchange static ±20% bands 9 p.m.–4 a.m., none 4–9:30 a.m. — [Federal Register](https://www.govinfo.gov/content/pkg/FR-2026-08-10/html/2026-16201.htm); [UTP FAQ](https://www.utpplan.com/DOC/Nasdaq%20UTP%20SIP%20Extended%20Trading%20Hours%20FAQ%20Finalized%20Version%201.pdf)
- Brokers may block client overnight orders (SEC condition on Nasdaq approval) — [Troutman](https://www.troutman.com/insights/nasdaq-23-hour-equity-trading-proposal-approved-by-sec/)
- Order size caps: Schwab overnight $2M notional/50,000 shares (learn article) vs. $10M/50,000 (international page) — [Schwab](https://www.schwab.com/learn/story/ins-and-outs-245-trading); [Schwab International](https://international.schwab.com/node/9706)
- Data: overnight ATS executions/quotes come from the ATS, not the SIP (Webull) — [Webull guide](https://www.webull.com/blog/279-Comprehensive-Guide-to-Cboe-24x5-Trading-and-Overnight-Markets); 24X's exemption explicitly contemplates overnight trading "without consolidated tape coverage" — [WatersTechnology](https://www.waterstechnology.com/data-management/7953204/sec-denies-24xs-requested-sip-exemption-for-now)
- Trade-date shift: overnight trades 8 p.m.–midnight ET carry the next trading day's trade date — [IBKR](https://www.interactivebrokers.com/en/trading/us-overnight-trading.php); [Webull](https://www.financemagnates.com/forex/webull-launches-overnight-trading-for-retail-clients-expands-market-hours-to-245/)
- Single-venue dependency: when Blue Ocean halted, brokers that relied on it suspended overnight trading, while IBKR could reroute to IBEOS — [BNN Bloomberg](https://www.bnnbloomberg.ca/investing/2024/08/06/biggest-overnight-stock-venue-suspends-trading-after-volatility/)

### Inferences
- Alert design: a price move seen only on an overnight ATS (thin book) should be labeled "overnight/ATS" in the LINE alert and possibly use wider thresholds; a % change vs. prior regular close can be distorted by a single small print.
- The monitor should detect stale quotes (no trades for N minutes) and venue halts rather than assume continuous prices.

### Gaps
- No quantitative spread data (bps) for overnight vs. regular session found in this session.

## 5. Other time-related events: earnings, FOMC, CPI/jobs, quad witching, circuit breakers, LULD, T+1

### Takeaway
Key scheduled US events fall at fixed ET times: BLS CPI/jobs 8:30 a.m. ET (20:30 Taiwan summer / 21:30 winter), FOMC statement 2:00 p.m. ET (02:00/03:00 Taiwan next day) with press conference 30 min later. Remaining 2026 dates: FOMC Oct 27–28 and Dec 8–9; jobs Nov 6 & Dec 4; CPI Nov 10 & Dec 10; quad witching Dec 18. Circuit breakers: S&P 500 −7%/−13% (15-min halt if before 3:25 p.m. ET) and −20% (closed for day). T+1 settlement since 2024-05-28.

### Cited Findings

**FOMC**
- 2026 remaining meetings: Oct 27–28 (statement 14:00 EDT, presser 14:30 EDT) and Dec 8–9 (statement 14:00 EST, presser 14:30 EST; SEP/dot-plot meeting) — [Reuters calendar via Capital.com](https://capital.com/en-gb/news/federal-reserve-events); [Yahoo Finance](https://finance.yahoo.com/personal-finance/banking/article/when-is-the-next-fed-meeting-150709150.html)
- Taiwan time (computed): Oct 28 statement = **Thu 2026-10-29 02:00** Taiwan (EDT still in effect); Dec 9 statement = **Thu 2026-12-10 03:00**, presser 03:30 Taiwan.
- 2027 tentative schedule (announced Sept 2025): Jan 26–27, Mar 16–17, Apr 27–28, Jun 8–9, Jul 27–28, Sep 14–15, Oct 26–27, Dec 7–8; decision 2 p.m. ET second day, presser 2:30 p.m. — [MNI](https://www.mnimarkets.com/articles/mni-federal-reserve-sets-2027-fomc-meeting-schedule-1757093400287); [LegiStorm (Fed release)](https://www.legistorm.com/stormfeed/view_rss/5961750/organization/95474/title/federal-open-market-committee-announces-its-tentative-meeting-schedule-for-2027.html). A few secondary sites differ (e.g., Oct 27 / Dec 8 single dates); Fed release governs.

**BLS data (8:30 a.m. ET)**
- Employment Situation (Oct data) Fri 2026-11-06; CPI (Oct) Tue 2026-11-10; PPI (Oct) Fri 2026-11-13; Employment Situation (Nov) Fri 2026-12-04; CPI (Nov) Thu 2026-12-10; PPI (Nov) Tue 2026-12-15 — [BLS 2026 schedule](https://www.bls.gov/schedule/2026/); [BLS Dec 2026 list](https://www.bls.gov/schedule/2026/12_sched_list.htm); [BLS CPI schedule](https://www.bls.gov/schedule/news_release/cpi.htm); [BLS CPS calendar](https://www.bls.gov/cps/publications/release-calendar.htm)
- Taiwan time (computed): 8:30 a.m. ET = 20:30 Taiwan (EDT) / **21:30 Taiwan (EST)** — all Nov/Dec 2026 releases above are 21:30 Taiwan.

**Quad witching**
- 2026: Mar 20, Jun 18 (Thursday, because Jun 19 Juneteenth), Sep 18, **Dec 18** — [TradeStation](https://www.tradestation.com/insights/2026/01/23/quadruple-witching-dates-2026-stock-futures-trading/)
- Third Friday of Mar/Jun/Sep/Dec — [TradeStation](https://www.tradestation.com/insights/2026/01/23/quadruple-witching-dates-2026-stock-futures-trading/)

**Market-wide circuit breakers (MWCB)**
- S&P 500 decline vs. prior close: Level 1 −7%, Level 2 −13%, Level 3 −20%; L1/L2 before 3:25 p.m. ET → 15-minute halt of all listed stocks; at/after 3:25 p.m. no halt; L3 any time → trading suspended for rest of day — [Schwab](https://www.schwab.com/learn/story/what-are-stock-market-circuit-breakers); [FINRA](https://finra.org/investors/insights/guardrails-market-volatility); [SEC 34-88402](https://www.sec.gov/files/rules/sro/nyse/2020/34-88402.pdf)
- 3:25 p.m. ET = 03:25 Taiwan (EDT) / 04:25 Taiwan (EST) — computed.

**LULD single-stock bands**
- Bands from rolling 5-minute average price; 5% for Tier 1 (S&P 500, Russell 1000, select ETPs) and 10% for others; doubled in the last 25 minutes (3:35–4:00 p.m. ET) — [Schwab](https://www.schwab.com/learn/story/what-are-stock-market-circuit-breakers); [LULD Plan](https://www.luldplan.com); [Nasdaq LULD FAQ](https://m.nasdaqtrader.com/content/MarketRegulation/LULD_FAQ.pdf). Sources conflict on whether doubling also applies at the open.
- Overnight: static ±20% bands 9 p.m.–4 a.m. ET from SIP launch; none 4–9:30 a.m. — see section 3.

**T+1 settlement**
- SEC adopted T+1 on 2023-02-15; compliance date **2024-05-28**; FINRA conforming amendments same date — [A&O Shearman](https://www.aoshearman.com/en/insights/t1-settlement-coming-may-28-2024); [Davis Polk](https://www.davispolk.com/insights/client-update/sec-adopts-t-1-settlement-effective-may-2024); [Kelley Drye](https://www.kelleydrye.com/viewpoints/client-advisories/upcoming-compliance-date-the-t-1-settlement-cycle)

### Inferences
- Earnings: US companies conventionally report either before the open (≈7:00–9:00 a.m. ET → 19:00–22:00 Taiwan winter) or after the close (≈4:00–4:30 p.m. ET → 05:00–05:30 Taiwan winter); the after-close reaction trades in after-hours and then overnight ATS sessions, i.e., during the Taiwan morning/workday. (General market convention; no source fetched for exact times — use an earnings-calendar API with BMO/AMC flags.)
- Quad witching 2027 (computed, not sourced): Mar 19, Jun 17 (Thu, since Fri Jun 18, 2027 is the Juneteenth-observed holiday — expiration presumably moves earlier), Sep 17, Dec 17.
- T+1 + overnight trade-date rule: a trade at Monday 9 p.m. ET (Tuesday 10:00 Taiwan in winter) has trade date Tuesday and settles Wednesday.
- MWCB and LULD rules as described apply to the regular session; overnight protection is the separate static 20% band regime.

### Gaps
- LULD trading-pause mechanics (limit state 15 seconds → 5-minute pause) not re-verified in this session.
- FOMC minutes release dates (3 weeks after each meeting, 2 p.m. ET) not sourced.
- Whether MWCB applies during the new exchange Night Session was not found.

## 6. Retail regulation: FINRA Pattern Day Trader (PDT) reform, and applicability to non-US residents / offshore entities

### Takeaway
The PDT rule ($25,000 minimum, 4-day-trades-in-5-days count) is gone: SEC approved FINRA's Rule 4210 amendments on **2026-04-14**, FINRA Regulatory Notice 26-10 (2026-04-20) set the effective date **2026-06-04**, with firms allowed until **2027-10-20** to implement. It is replaced by risk-based intraday margin; the general $2,000 margin minimum remains. PDT was a FINRA rule binding FINRA-member broker-dealers (regardless of customer residence); non-FINRA offshore entities were never subject to it, but are also outside FINRA/SIPC protections.

### Cited Findings
- SEC approved FINRA's amendments to Rule 4210 on 2026-04-14 (one secondary source cites Release No. 34-105226), removing the $25,000 minimum and PDT designation — [Schwab, 2026-04-16](https://www.schwab.com/learn/story/sec-approves-scrapping-25000-day-trader-minimum); [Schwab International copy](https://international.schwab.com/story/sec-approves-scrapping-25000-day-trader-minimum); [groktrade](https://www.groktrade.com/pdt-rule-change-2026.html)
- FINRA Regulatory Notice 26-10 (published 2026-04-20): new intraday margin standards "replace in their entirety" the day-trading margin requirements; effective 2026-06-04; phase-in up to 18 months, through 2027-10-20 — [FINRA RN 26-10](https://www.finra.org/rules-guidance/notices/26-10); [FINRA PDF](https://www.finra.org/sites/default/files/2026-04/Regulatory-Notice-26-10.pdf); [ACA Group](https://www.acaglobal.com/industry-insights/finra-ends-the-pattern-day-trader-rule/); [King & Spalding](https://www.kslaw.com/insights/articles/finra-adopts-sweeping-changes-to-margin-requirements-for-day-trading)
- Enforcement detail: customer failing to meet intraday margin deficits by the 5th business day "as a practice" → 90-day freeze on new debits/shorts — [King & Spalding](https://www.kslaw.com/insights/articles/finra-adopts-sweeping-changes-to-margin-requirements-for-day-trading) (via search extract)
- Margin accounts above $2,000 can get intraday buying power, set by each broker — [Schwab](https://www.schwab.com/learn/story/sec-approves-scrapping-25000-day-trader-minimum)
- Schwab stopped counting day trades / restricting by frequency on 2026-06-08 and opens no new PDT accounts; intraday margin buying power "will soon" be introduced — [Schwab, 2026-05-27](https://www.schwab.com/learn/story/schwab-changes-rules-around-day-trading)
- IBKR implemented on 2026-06-04 "for eligible securities clients" — [Traders Magazine](https://www.tradersmagazine.com/featured_articles/regulators-end-pdt-rule/); [Benzinga 2026-06](https://www.benzinga.com/trading-ideas/movers/26/06/53007723/robinhood-webull-interactive-brokers-set-to-gain-as-pdt-rule-dies-today)
- FINRA Rules 2130 (approval of day-trading accounts) and 2270 (day-trading risk disclosure) remain in force — [SECLaw](https://seclaw.com/pattern-day-trader-rule-elimination-defense-view/)
- Non-US residents: PDT applied to margin accounts at US (FINRA-member) broker-dealers regardless of the customer's citizenship/address; FINRA has no jurisdiction over non-member offshore brokers — [Tradezella](https://www.tradezella.com/blog/pattern-day-trading-rule); [Wikipedia](https://en.wikipedia.org/wiki/Pattern_day_trader); offshore brokers lack FINRA/SEC protections — [Warrior Trading](https://www.warriortrading.com/how-to-get-around-the-pdt-rule/) (secondary/marketing sources; low authority)

### Inferences
- For a Taiwan resident: if the account is held at a FINRA member (e.g., a US-domiciled broker-dealer entity), the new intraday-margin regime applies; if at a non-US entity (e.g., an Asian subsidiary of a broker), the entity's local regulator and house rules apply. Either way, PDT counting may linger at some brokers until they finish implementation (deadline 2027-10-20), so the bot should not assume unlimited day trades — check the broker's current notice.
- Cash accounts are still constrained by settlement (T+1) / free-riding rules regardless of PDT (general rule; not re-verified here).

### Gaps
- Could not read FINRA RN 26-10 full text directly (blocked); details of the intraday margin computation and any explicit statement on foreign customers not confirmed.
- Which broker entity serves Taiwan residents (IBKR, Schwab International, Firstrade, moomoo, etc.) and whether each has implemented the new rule: not researched in this session.
- SEC Release number 34-105226 for the PDT approval comes from a single secondary source.
