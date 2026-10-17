# 台灣居民可用、具程式交易 API 的美股券商比較（截至 2026-10-17）

> 方法說明：本次研究環境中 WebFetch 對所有外部網域都回報 DNS 失敗（getaddrinfo ENOTFOUND），所有發現都來自 WebSearch 的結果摘要與其列出的來源網址，**沒有逐頁打開原文核對**。凡是標「官方」的，指來源網址屬於券商自己的網域；標「部落格／第三方」的僅供佐證。下單前請以券商官網當下公告為準。來源日期能從搜尋結果看出的已註明，看不出的標「日期不明」。

---

## Q1. 整體結論：台灣居民實際能用哪幾家？（資格總表）

### Takeaway
2026 年 10 月，台灣個人「能開戶 + 有官方下單 API + 能做 24/7 無人值守」最確定的是 **Interactive Brokers（IBKR）**，其次是 **moomoo（Futu OpenAPI）** 與 **Longbridge 長橋**（後兩者資格多來自部落格）。**Alpaca 對台灣是否開放「無法確認」**（官方要求寫信問客服）。**Schwab International 台灣可開戶，但 Trader API 是否支援國際帳戶查不到官方說法**。**Firstrade 沒有官方 API**。國內複委託路線中，**凱基（複委託下單 API，C#）與群益（API 含複委託，限 Windows）** 是目前唯二查得到「API 可下複委託美股單」的券商；永豐 Shioaji、富邦 Neo API 的官方文件只涵蓋台股／期貨。

### Cited Findings
- IBKR：台灣投資人可線上開 IBKR 個人帳戶，個人帳戶（IBKR Pro / Lite）沒有最低入金 — [Mr.Market 市場先生 2026 開戶教學（部落格）](https://rich01.com/ib-interactivebrokers-open/)；[Grenade 2026 教學（部落格）](https://grenade.tw/blog/interactive-brokers-tutorial/)
- moomoo：台灣用戶下載 moomoo App，帳戶落在美國持牌券商 Moomoo Financial Inc.，非香港實體；Moomoo 未取得台灣金管會核准 — [FM Studio（部落格）](https://fmstudio.blog/futu-moomoo-vs-niuniu-2025/)；[Money Daily 2026（部落格）](https://moneydaily.com.tw/futu-moomoo-taiwan-guide-2025/)；[米拉有料 2026（部落格）](https://mila4real.com/moomoo-taiwan-review-2025/)
- Longbridge：台灣部落格稱台灣人可用台灣護照申請，但需先有香港銀行帳戶；OpenAPI 免費、可交易美股與港股 — [Vocus 2025（部落格）](https://vocus.cc/article/69240e65fd89780001892511)；[China Daily 2022 OpenAPI 上線新聞](https://ex.chinadaily.com.cn/exchange/partners/82/rss/channel/cn/columns/sz8srm/stories/WS627c6e25a3101c3ee7ad4eaf.html)
- Alpaca：官方「countries Alpaca is available」頁（2026 年 2 月）未列國家清單，要求寄信給客服詢問是否支援 — [Alpaca 官方 support](https://alpaca.markets/support/countries-alpaca-is-available)
- Schwab International：多篇 2026 年部落格稱已取消 25,000 美元開戶門檻，台灣可線上開戶（護照 + 地址證明） — [Exiap 嘉信香港/台灣開戶 2026（部落格）](https://exiap.hk/guides/open-charles-schwab-account)；[George Dewi 2026（部落格）](https://george-dewi.com/charles-schwab/)
- Firstrade：沒有官方公開 API；只有非官方逆向工程 Python 套件 `firstrade-api`，作者明言 "this is not an official api"、"use at your own risk" — [GitHub MaxxRK/firstrade-api](https://github.com/MaxxRK/firstrade-api)；[API Evangelist（第三方）](https://providers.apievangelist.com/providers/firstrade/)
- Saxo：官方「Which countries are serviced by Saxo?」清單（Australia…Thailand, UAE, UK）中未見台灣；第三方 forexbrokers.tw 卻說台灣人可開戶，兩者矛盾 — [Saxo 官方 help](https://www.help.saxo/hc/en-us/articles/10611416570269-Which-countries-are-serviced-by-Saxo)；[forexbrokers.tw（第三方）](https://www.forexbrokers.tw/broker-reviews/saxo-bank-review/)
- Tradier：官方「Permitted and Blocked Countries」頁的 T 字頭段落為 Switzerland → Tajikistan → Thailand，未見 Taiwan（摘要片段，可能被截斷） — [Tradier 官方 support](https://support.tradier.com/kb/guide/en/permitted-and-blocked-countries-CLzSa0D1rf/Steps/4997916)
- Webull：查無任何來源顯示台灣居民可開 Webull 帳戶或用 OpenAPI；Webull OpenAPI 以區域分別上線（例：2026-07 馬來西亞） — [Manila Times / PR Newswire 2026-07-07](https://www.manilatimes.net/2026/07/07/tmt-newswire/pr-newswire/webull-malaysia-launches-openapi-allowing-investors-to-trade-us-stocks-and-etfs-via-plain-language-ai/2379419)；[brokerage-review Webull countries 2026（第三方）](https://www.brokerage-review.com/investing-firm/countries/webull-available-countries.aspx)
- 國內複委託 API：凱基提供「美股即時行情 API + 複委託下單 API」（2024-03 上線） — [鉅亨網](https://news.cnyes.com/news/id/5485188)；群益 API 官方頁稱單一 API 串接「國內證期、海外期權以及複委託」 — [群益官方 API 頁](https://www.capital.com.tw/campaign/stock/API/)

### Inferences
- 資格／API 總表（我方彙整，依上述及後續各節來源）：

| 券商 | 台灣居民可開戶？ | 官方下單 API | API 型態 | 無人值守難度 |
|---|---|---|---|---|
| IBKR | 是（部落格多篇 2026 實測；實體推測為 IBKR LLC） | 有 | TWS API（socket，需 TWS/IB Gateway）、Web API（REST+WebSocket，散戶需 CP Gateway） | 中：每週需一次 2FA 手機確認 |
| Alpaca | 不確定（官方要求問客服） | 有 | REST + WebSocket，API key | 低（API key 不過期，見 Q3 Gaps） |
| Schwab International | 是（部落格） | Trader API 有，但國際帳戶是否適用**查無官方說法** | REST（OAuth） | 高：refresh token 7 天就要人工重登 |
| Firstrade | 是 | **無** | 僅非官方逆向套件 | 不建議 |
| moomoo（Futu OpenAPI） | 是（部落格；Moomoo Financial Inc.） | 有 | 需本機/雲端跑 OpenD 閘道 + SDK | 中（OpenD 需常駐） |
| Tiger | 不確定 | 有 | REST/SDK | 不確定 |
| Longbridge | 可能（部落格，需香港銀行帳戶） | 有 | REST/WebSocket SDK | 不確定 |
| Webull / Saxo / Tradier / TradeStation | 多半否或查無證據 | — | — | — |
| 凱基（複委託） | 是（國內券商） | 有（複委託下單 API） | 官方文件為 C# | 受複委託時段限制 |
| 群益（複委託） | 是 | 有（含複委託 OS 帳號） | Socket 長連線，限 Windows | 受複委託時段限制 |
| 永豐 Shioaji / 富邦 Neo API | 是 | 僅台股/期貨，**查無美股複委託** | — | — |

- 對「24/7 監控 + LINE bot + Claude」的需求，IBKR 是最務實的首選；若想避開 IB Gateway 的每週 2FA，可把 Alpaca 當候選，但必須先寄信確認台灣稅籍是否能開實盤，否則只能用 paper trading。

### Gaps
- 所有「台灣可開戶」的判斷，除 IBKR 有多篇 2026 年實測外，其他多為部落格說法；無一家券商在官方頁面明列「Taiwan」。
- 研究環境無法打開原始網頁，未能直接閱讀任何官方國家清單全文。

---

## Q2. Interactive Brokers（IBKR）

### Takeaway
台灣居民可開戶、無最低入金，帳戶實體依居住地決定，台灣多半由 **Interactive Brokers LLC（美國）** 承接（第三方推論）。API 完整（TWS API socket、Web API REST/WebSocket、FIX），支援盤前盤後與 **Overnight 夜盤**下單；但散戶必須常駐 **IB Gateway/TWS 或 Client Portal Gateway（Java）**，且**每週至少一次需要手機 2FA 人工確認**，是 24/7 無人值守的最大痛點。

### Cited Findings
**資格與實體**
- IBKR 官方：承接帳戶的 IBKR 實體「generally based upon the account holder's country of legal residency」，可從 Activity Statement 頂端確認 — [IBKR Knowledge Base「Which IBKR entity carries my account?」](https://ibkb.interactivebrokers.com/es/node/1000)
- 第三方部落格推論台灣帳戶「目前看來屬於 Interactive Brokers LLC」（依台灣入金頁頁尾），並稱最終以開戶合約實體為準；SIPC 保障只適用 IBKR LLC — [penchan.co（部落格，日期不明）](https://penchan.co/en/market/us-stock/ibkr-open-account/)
- IBKR 官方：台灣與中國大陸居民**不能**透過 IBKR 交易台灣櫃買中心（TPEx）股票（顯示 IBKR 對台灣居民有特定規則，但不影響美股） — [IBKR TPEx 頁](https://www.interactivebrokers.com.sg/en/trading/taipei-exchange-tpex.php)

**費用**
- 個人帳戶無最低入金；IBKR 不收入金費，台灣銀行電匯成本約 NT$800–1,200 — [Mr.Market 2026（部落格）](https://rich01.com/ib-interactivebrokers-open/)；[暖心投資家 2026 入金教學（部落格）](https://warm-investor.com/interactive-brokers-remit-guide/)
- 美股佣金（IBKR Pro）：階梯式每股 0.0035 美元、每筆最低 0.35 美元；固定式每股 0.005 美元、每筆最低 1 美元；上限為交易金額 1%，另加監管費 — [Grenade 2026（部落格）](https://grenade.tw/blog/interactive-brokers-tutorial/)
- 出金：一說每月 1 次免費、之後每次 10 美元；另一說每月前 2 次可免費（矛盾） — [暖心投資家（部落格）](https://warm-investor.com/interactive-brokers/)；[Grenade（部落格）](https://grenade.tw/blog/interactive-brokers-tutorial/)

**API 型態與 SDK**
- TWS API 官方提供 Python、Java、C++、C#、VisualBasic；C# 與 Excel 只支援 Windows；最低版本 Python 3.11、Java 21、C++14；需「已開戶並入金的 IBKR Pro 帳戶」以及 TWS 或 IB Gateway — [IBKR TWS API 官方文件 Introduction](https://www.interactivebrokers.com/campus/ibkr-api-page/twsapi-doc/)；[IBKR TWS API Requirements](https://www.interactivebrokers.com/docs/tws-api/doc/notes-limitations/requirements)
- Web API：官方說明「for retail and individual clients, Authentication to our WebAPI is managed using the Client Portal Gateway, a small java program」；IBKR 2025-08 客服回覆稱散戶目前只能用 CP Gateway，OAuth 1.0a 留在機構端，OAuth 2.0「being considered for individual access in the future」；Trading Web API 頁將 OAuth 2.0 (beta) 列在 organization 下 — [IBKR Trading Web API 官方頁](https://www.interactivebrokers.com/campus/ibkr-api-page/web-api-trading/)
- 2026-03-17 Web API changelog 提到 OAuth 2.0 clients 建立 WebSocket 的方式；2026-04 IBKR 回覆用戶稱「working to produce new, alternate means of authentication for our WebAPI users」，未給時程 — [IBKR Web API Changelog](https://www.interactivebrokers.com/campus/ibkr-api-page/web-api-changelog/)
- API 本身不另收費（TWS API 無啟用費） — [PickMyTrade 2026（第三方）](https://blog.pickmytrade.io/ibkr-api-cost-every-charge-itemised-2026/)

**Session / 2FA / 無人值守**
- Web API：5 分鐘內沒有請求 session 會逾時，建議約每分鐘呼叫 `/tickle`；session 最長 24 小時，於紐約／Zug／香港午夜重置，每日伺服器維護可能更早中斷 — [IBKR Web API Authentication FAQ（官方）](https://www.interactivebrokers.com/docs/web-api/authentication/faq)
- IB Gateway：每日自動重啟（auto-restart）可沿用 session、不需 2FA；但約每週（週日美東約 01:00 重置後）強制完整登入，需 IBKR Mobile 推播確認；IBC 等工具可處理帳密輸入與每日重啟，但無法處理每週 2FA — [nautilus_trader issue #5069（GitHub）](https://github.com/nautechsystems/nautilus_trader/issues/5069)；[ibc2 PyPI](https://pypi.org/project/ibc2/0.1.0/)；[QuietAlpha Lab（部落格）](https://quietalphalab.com/ibkr-2fa-24-7-automated-trading/)
- 第三方工具 ibg-controller 宣稱設定 TOTP 後可不用手機完成每週重新驗證，與其他來源矛盾，查無 IBKR 官方確認 — [GitHub Nonug/ibg-controller](https://github.com/Nonug/ibg-controller)
- 2023 年社群留言稱散戶 Client Portal API session 約每 2 小時需重連（舊資料） — [GitHub Voyz/ibeam #150](https://github.com/Voyz/ibeam/issues/150)

**速率限制**
- TWS API：每秒最大請求數 =「Maximum Market Data Lines ÷ 2」，預設 100 lines → 50 req/s；增加 lines（佣金量或 Quote Booster）可提高；超過時訂單可能被排隊延遲，RTD 情境下 TWS 最終會斷線 — [IBKR TWS API Pacing Limitations（官方）](https://www.interactivebrokers.com/docs/tws-api/doc/pacing-limitations/introduction)
- Web API：現行 Pacing 頁寫每個已驗證 username 50 req/s；較舊文件寫 10 req/s；經 CP Gateway 的請求上限 10 req/s；`/portfolio/accounts` 等端點另有限制（1 req/5s）；超限回 429 — [IBKR Web API Pacing Limitations（官方）](https://www.interactivebrokers.com/docs/web-api/trading/usage-and-availability/pacing-limitations)；[IBKR Web API Documentation（官方，較舊）](https://www.interactivebrokers.com/campus/ibkr-api-page/webapi-doc/)

**夜盤／延長時段下單**
- TWS API 夜盤：Order 設 `includeOvernight=True`、Contract 的 exchange 設 `OVERNIGHT` 即只在夜盤；exchange 保持 `SMART` + `includeOvernight=True` 則可跨日盤與夜盤 — [IBKR TWS API「Trading The Overnight Session」（官方）](https://www.interactivebrokers.com/docs/tws-api/doc/orders/place-order/trading-the-overnight-session)；[IBKR Campus API Overnight Trading](https://www.interactivebrokers.com/campus/ibkr-quant-news/api-overnight-trading/)
- TWS build 10.50 起，OVERNIGHT 交易所訂單預設 TIF 為 OVERNIGHT + DAY — [IBKR Release Notes 10.50（官方）](https://www.ibkrguides.com/releasenotes/version-10.50.htm)
- IBKR 夜盤時段（ETF 起始公告）為美東 20:00–03:30，週日至週五 — [Barchart / IBKR 新聞稿](https://www.barchart.com/story/news/11855309/interactive-brokers-launches-overnight-trading-hours-for-us-etfs)

**市場資料**
- 預設所有用戶被歸為 Professional，個人須在 Client Portal 自行改為 Non-Professional；API 上的資料屬「off-platform」，TWS 內免費的資料不一定能透過 API 取得 — [IBKR Market Data Subscriptions（官方）](https://ibkrcampus.com/ibkr-api-page/market-data-subscriptions/)
- 「US Securities Snapshot and Futures Value Bundle」每月 10 美元，當月佣金達 30 美元免收；串流 NBBO 需 non-pro bundle 加「US Equity and Options Add-On Streaming Bundle」；延遲 15–20 分鐘資料免費 — [IBKR Market Data 定價頁（官方）](https://www.interactivebrokers.com/en/pricing/research-news-marketdata.php)

### Inferences
- 對 24/7 機器人：IB Gateway + IBC（Docker）可處理每日重啟，但每週一次需要使用者在手機 IBKR Mobile 按確認；LINE bot 可在 Gateway 斷線時推播提醒使用者去按。這是目前（2026-10）IBKR 散戶 API 不可避免的運維成本。
- Web API 對散戶仍需 CP Gateway（Java）常駐並每分鐘 tickle，和 IB Gateway 一樣不是「純雲端 API key」模式。
- 市場資料：不訂閱時 API 只拿到延遲報價；要即時美股報價需付費 bundle，且務必把身分改成 Non-Professional。

### Gaps
- 查無 IBKR 官方明文「台灣居民由哪個實體承接」，IBKR LLC 為第三方推論。
- IBKR paper trading 帳戶細節（是否需入金、資料是否共用）本次未取得官方內容；文件導覽有「Paper Trading」章節但未讀到。
- 非專業 US streaming bundle 的確切月費本次未取得。
- FIX 介面對散戶的門檻未查證。

---

## Q3. Alpaca

### Takeaway
Alpaca 是最「API 優先」、最適合 24/7 機器人的券商（API key、REST + WebSocket、24/5 交易、免費 paper trading），也確實對部分非美國居民開實盤帳戶且已取消 3 萬美元門檻；**但台灣是否在支援名單內，截至 2026-10 查不到任何官方或社群證據**，官方只說「寄信給 support 確認」，且若稅籍國不在下拉清單內就只能用 paper trading。

### Cited Findings
- 官方「countries Alpaca is available」頁（2026-02）未在可取得文字中列出國家，請用戶寄信給 support 確認 — [Alpaca 官方](https://alpaca.markets/support/countries-alpaca-is-available)
- 官方非美居民開戶指南：資格主要依稅籍國與實際居住國；不支援所有司法管轄區；加拿大居民不可開戶 — [Alpaca Learn: Live Trading Account as a Non-US Resident（官方）](https://alpaca.markets/learn/live-trading-account-non-us)
- 「If your country is not listed under Country of Tax Residence, you will only be eligible for paper trading」 — [Alpaca Learn: Connect to Alpaca API（官方）](https://alpaca.markets/learn/connect-to-alpaca-api)
- 搜尋摘要引述一則 2025-10 的 Alpaca 支援說明：已取消 30,000 美元最低入金，非美用戶最低 1 美元即可入金（舊論壇文仍寫 3 萬，已過時）。**注意：搜尋摘要未指明是哪一頁，以下官方頁為最可能出處，未能開頁核對** — [Alpaca Support: Is Alpaca available outside the US?（官方）](https://alpaca.markets/support/is-alpaca-available-outside-the-us)；舊說法見 [Alpaca 論壇（舊）](https://forum.alpaca.markets/t/are-non-us-entitled-to-trade-through-alpaca-api-now-or-not-yet/4520)
- 中文部落格（約 2026 年中）：非美居民需護照、稅號、地址證明、自拍 + W-8BEN，最低入金 0；資格依司法管轄區核定，社群有成功也有被拒 — [奇異果網絡日誌（部落格）](https://blog.kiwi.moe/blog/alpaca-brokerage-for-quant/)
- 台灣相關新聞只見 BingX 等平台透過 Alpaca Broker API 提供美股（B2B 合作，非台灣個人直接開戶） — [臺灣郵報 2026](https://taiwanpost.net/2026/prnasia/175912)
- 佣金：自主管理個人現金帳戶透過 API 交易美股與選擇權無佣金 — [Alpaca Support for Individuals（官方）](https://alpaca.markets/support/individuals)
- 24/5 交易：Trading API 支援美東週日 20:00 至週五 20:00；Overnight 為 20:00–04:00 ET，盤前 04:00–09:30，盤後 16:00–20:00；用 LIMIT + `time_in_force="day"` + `extended_hours=true`；Trading API 上線約 2026-02，Broker API 於 2025-05 先上線；paper 帳戶也支援 24/5 — [Alpaca Blog: 24/5 for Trading API（官方）](https://alpaca.markets/blog/introducing-stocks-24_5-overnight-with-alpaca-trading-api/)；[Alpaca Docs: Placing Orders（官方）](https://docs.alpaca.markets/us/docs/orders-at-alpaca)；[Crowdfund Insider 2026-02](https://www.crowdfundinsider.com/2026/02/259268-alpaca-introduces-24-5-trades-for-trading-api-providing-almost-round-the-clock-access/)
- 速率限制：Trading API 預設每帳戶 200 req/min，訂閱 Algo Trader Plus 不會提高交易 API 上限；市場資料 Basic（免費）200 req/min、只有 IEX 串流；Algo Trader Plus 提供完整 SIP 即時資料、最多 10,000 req/min — [Alpaca 社群論壇](https://forum.alpaca.markets/t/is-there-a-way-to-increase-the-200-min-api-call-limit-for-the-trading-endpoint/18110)；[Alpaca Support: usage limit（官方）](https://alpaca.markets/support/usage-limit-api-calls)；[apis.io Alpaca plans（第三方）](https://apis.io/plans/alpaca/alpaca-plans-pricing/)
- 官方 Python SDK `alpaca-py`；paper trading 免費，`TradingClient(paper=True)`；支援 market/limit/stop/trailing-stop 等 — [Alpaca Docs: alpaca-py Trading API（官方）](https://docs.alpaca.markets/docs/alpaca-py-trading-api)

### Inferences
- Alpaca 的 API key 模式不需常駐閘道、不需每週 2FA，對「雲端 24/7 + LINE bot」架構最友善；但對台灣用戶而言，資格未確認是最大風險。建議做法：先用 paper trading 開發，同時寄信 support 問台灣稅籍可否開實盤。
- 免費資料只有 IEX（約佔美股成交量一小部分），若要準確即時盯盤需付費 SIP 方案。

### Gaps
- 台灣是否在 Alpaca「Country of Tax Residence」清單內：無官方或社群證據。
- Algo Trader Plus 2026 年月費本次未查到官方數字。
- Alpaca live API key 有無過期、是否可設權限範圍（如禁止出金）未查證。

---

## Q4. Charles Schwab International（嘉信國際）

### Takeaway
台灣居民可開 Schwab One International 帳戶（2026 年部落格稱已取消 25,000 美元門檻），Trader API 對個人開放（REST、OAuth），但**查不到官方說明國際帳戶能否使用 Trader API**，第三方線索偏向「有限制」。即使可用，refresh token 7 天到期且無法程式續期，**每週需要人工重新 OAuth 登入**，不利無人值守。

### Cited Findings
- 開戶門檻：多篇 2026 年文章稱嘉信已取消 25,000 美元門檻，香港版與國際版都不設最低入金；較舊文章仍寫 25,000 美元 — [Exiap 2026（部落格）](https://exiap.hk/guides/open-charles-schwab-account)；[Mr.Market（部落格）](https://rich01.com/cs-charles-schwab-register/)；舊說法見 [brokerage-review（第三方）](https://www.brokerage-review.com/investing-firm/foreigner/charles-schwab-for-non-us-citizens.aspx)
- 出金費：線上匯款 15 美元、離線 25 美元（加銀行費） — [Vocus Grenade 2026（部落格）](https://vocus.cc/article/699beea9fd89780001b825ff)
- Schwab 國際站聲明 Schwab 及其產品可能未在你的司法管轄區註冊 — [Schwab International（官方）](https://international.schwab.com/open-account-step-1)
- Quicken 社群用戶回報「international accounts are no longer eligible to export account information」（論壇，未經官方證實） — [Quicken Community](https://community.quicken.com/discussion/comment/20224383)
- MultiCharts 對「Charles Schwab International Accounts」支援的功能請求仍為 Under Review，暗示國際帳戶整合尚未普遍可用 — [MultiCharts PM MC-2885](https://www.multicharts.com/pm/public/multicharts/issues/MC-2885)
- Trader API – Individual：在 developer.schwab.com 註冊為 Individual Developer、建立 app、等待「Ready for use」（數天），只能存取自己的帳戶；只連實盤（無 sandbox）；期貨、外匯、加密、債券、非美股不能經 API 交易 — [MyLinedChart（第三方）](https://mylinedchart.com/resources/articles/schwab-api-for-technical-traders-workflow-fit-checklist)；[pyschwab PyPI](https://pypi.org/project/pyschwab)；[schwabr CRAN 2026-08](https://cran.r-project.org/web/packages/schwabr/schwabr.pdf)
- Token：access token 30 分鐘；refresh token 7 天、無法程式續期，只能讓使用者重走 OAuth 登入（作者稱經 Schwab API support 確認） — [GitHub tda_to_schwab](https://github.com/48n116w/tda_to_schwab)；[MyLinedChart: Rate Limits and Token Expiry（第三方）](https://mylinedchart.com/resources/articles/schwab-api-rate-limits-and-token-expiry)
- 速率：普遍流傳約 120 req/min（Schwab 未公開官方頁）；下單另有更低節流（約 2–4 req/s，來源不一）；超限回 429 — [MyLinedChart（第三方）](https://mylinedchart.com/resources/articles/schwab-api-rate-limits-and-token-expiry)；[schwab-trader-api-field-notes（GitHub）](https://github.com/Jorg-AI-JorgAI/schwab-trader-api-field-notes)
- 延長時段：R 套件文件列 session = NORMAL / AM / PM（盤前盤後）；另一份實務筆記未驗證延長時段行為 — [schwabr 文件](https://altanalytics.github.io/schwabr/)

### Inferences
- 對台灣居民，Schwab International + Trader API 屬「高不確定 + 高運維」：資格未證實，且每 7 天需人工 OAuth 重登。除非使用者已有 Schwab International 帳戶並向 TraderAPI@Schwab.com 確認可用，否則不建議作為主方案。

### Gaps
- 查無 Schwab 官方說明 International 帳戶能否申請 Trader API；建議直接詢問 TraderAPI@Schwab.com（第三方稱此為官方信箱）。
- Schwab 是否支援 overnight（24 小時）交易經 API 未查證。
- 即時行情（Market Data API）對國際帳戶是否免費未查證。

---

## Q5. Firstrade（第一證券）

### Takeaway
Firstrade 在台灣很普及（0 佣金），但**沒有官方交易 API**；只有逆向工程的非官方套件，可能違反服務條款且隨時失效，不適合作為自動下單通道。

### Cited Findings
- Firstrade 無官方公開 REST API；可透過 Plaid 取得唯讀帳戶資料（餘額、交易、持倉），不能下單 — [API Evangelist（第三方）](https://providers.apievangelist.com/providers/firstrade/)
- 非官方 `firstrade-api`（MIT）：支援登入、報價、帳戶資料、下單、查單，作者聲明非官方、風險自負 — [GitHub MaxxRK/firstrade-api](https://github.com/MaxxRK/firstrade-api)；[PyPI firstrade](https://pypi.org/project/firstrade)
- 費用：線上股票/ETF/選擇權佣金 0 美元；出金費說法不一（25 或 35 美元）；單次電匯入金 10,000 美元以上補貼匯費最高 25 美元 — [Mr.Market（部落格）](https://rich01.com/firstrade-reviews-disadvantages/)；[Grenade 2026（部落格）](https://grenade.tw/blog/firstrade-deposit-withdraw-card/)；[懶人經濟學 2026（部落格）](https://earning.tw/firstrade/)
- 有一篇部落格稱 Firstrade 支援 24 小時夜盤交易（單一來源） — [OP 投資理財學院（部落格）](https://opop.tw/firstrade/)

### Inferences
- 若使用者已在 Firstrade，可考慮「監控用 IBKR/Alpaca 或資料商 API、下單仍手動在 Firstrade」，或乾脆另開有 API 的券商。

### Gaps
- Firstrade 官網未直接查證「無 API」；結論依第三方與非官方專案推得。

---

## Q6. moomoo / Futu OpenAPI

### Takeaway
台灣用戶用 moomoo App 開戶，帳戶據部落格屬美國 **Moomoo Financial Inc.**；Futu/moomoo OpenAPI 可程式取得港美股行情並下單，但需常駐 **OpenD 閘道**（本機或雲端）。台灣帳戶能否使用 OpenAPI 實盤，查無官方明文，但 OpenAPI 本身對 moomoo US 帳戶開放。

### Cited Findings
- 台灣用戶帳戶屬 Moomoo Financial Inc.（美國），非香港實體；不受金管會監管，爭議須走美國法律途徑 — [FM Studio（部落格）](https://fmstudio.blog/futu-moomoo-vs-niuniu-2025/)；[米拉有料 2026（部落格）](https://mila4real.com/moomoo-taiwan-review-2025/)
- 另一說：台灣用戶「通常被歸類為富途國際版」 — [uptogo.com.tw（部落格）](https://uptogo.com.tw/?p=1754593)（與上一條略有出入）
- 開戶文件說法分歧：2026 教學稱只需護照/身分證、地址證明、台灣身分證字號，不需 SSN；另一篇稱通常需要稅號與地址證明否則難通過 — [Grenade 2026（部落格）](https://grenade.tw/blog/moomoo/)；[Money Daily 2026（部落格）](https://moneydaily.com.tw/futu-moomoo-taiwan-guide-2025/)
- OpenAPI 架構：需在本機或雲端啟動 moomoo OpenD 閘道，再以 SDK 連線；官方提供多語言 SDK — [Moomoo US Help: What is OpenAPI（官方）](https://www.moomoo.com/us/support/topic3_436)
- 期貨實盤目前只開放 Moomoo SG 或 FUTU HK 帳戶 — [Moomoo Help（官方）](https://moomoo.com/support/topic3_436)
- OpenD 最新版 10.11.7108（2026-09-17） — [富途 OpenAPI 下載頁（官方）](https://www.futunn.com/hk/download/OpenAPI)
- OpenAPI 市場清單為港、美、A 股、新加坡、日本、馬來西亞、加密，不含台股 — [FinLab 2026（第三方）](https://finlab.finance/blog/futubull-quant-trading-taiwan)
- 速率：改單/撤單每帳戶 30 秒內最多 20 次（間隔 ≥0.04 秒）；查未成交訂單、當日成交、歷史訂單各 30 秒 10 次；下單與組合單共用額度（數字未取得）；訂閱推送的報價/盤口/K 線/逐筆無頻率限制 — [Futu API: Modify or Cancel Orders（官方）](https://openapi.futunn.com/futu-api-doc/en/trade/modify-order.html)；[Get open Orders（官方）](https://openapi.futunn.com/futu-api-doc/en/trade/get-order-list.html)；[Authorities and Quota（官方）](https://openapi.futunn.com/futu-api-doc/en/intro/authority.html)
- API 行情權限與 App 不完全相同，需看 API 專屬權限表 — [Futu API Quote FAQ（官方）](https://openapi.futunn.com/futu-api-doc/en/qa/quote.html)

### Inferences
- OpenD 和 IB Gateway 類似需常駐，但未見「每週強制 2FA」的報告（未查證）；對雲端部署可能比 IBKR 省事，但台灣帳戶 OpenAPI 實盤資格需先向客服確認。

### Gaps
- 下單 API 的確切頻率上限（傳聞 30 秒 15 次）未證實。
- 美股 API 即時報價（LV1/LV2）對 Moomoo Financial Inc. 帳戶是否免費未查到。
- OpenD 登入的 2FA／重新驗證週期未查到。
- moomoo 美股佣金與平台費 2026 數字未取得。

---

## Q7. Tiger Brokers（老虎證券）

### Takeaway
Tiger OpenAPI 功能完整（含盤前、盤後、Overnight 交易時段列舉、TWAP/VWAP），API 免費但行情需另訂閱；**台灣居民能否開戶查不到證據**，Tiger 不公開非本地國家清單。

### Cited Findings
- 新加坡、香港、澳洲、紐西蘭、美國居民由當地 Tiger 實體承接；Tiger 不公開其他接受國家的清單，需於註冊流程自行測試 — [Investing in the Web（第三方）](https://investingintheweb.com/reviews/tiger-brokers-review/)
- 開通 Open API：需開 TigerTrade 帳戶並入金；Open API 免費、無額外下單費；透過 API 取得行情須有 API 行情訂閱 — [Tiger OpenAPI: How to Access API Service（官方）](https://quant.itigerup.com/openapi/en/python/overview/openWay.html)
- 速率：低頻介面 10 次/分、中頻 60 次/分、高頻 120 次/分（60 秒滾動視窗），持續超限可能被列入黑名單 — [Tiger OpenAPI Rate Limits（官方）](https://docs-en.itigerup.com/docs/ratelimit)
- Python SDK `TradingSession` 列舉含 PreMarket / Regular / AfterHours / OverNight；Prime 帳戶支援美股盤前盤後；訂單型別含市價、限價、停損、停損限價、追蹤停損、附加單、TWAP/VWAP — [Tiger OpenAPI 列舉（官方）](https://quant.itigerup.com/openapi/en/python/appendix2/overview.html)；[Tiger docs Basic（官方）](https://docs-en.itigerup.com/docs/basic)
- 美股最低佣金 0.99 美元/筆（第三方香港比價頁） — [HongKongCard（第三方）](https://www.hongkongcard.com/securities/plan/tigerbrokers)
- 2025 年 Tiger、Futu 收緊中國大陸居民開戶（與台灣無直接關係） — [Yicai Global](https://www.yicaiglobal.com/news/brokers-futu-tiger-curb-mainland-accounts-as-china-tightens-offshore-investment-rules)

### Gaps
- 台灣居民資格：查無任何來源。Tiger 香港開戶指南均要求香港身分證與香港銀行帳戶。

---

## Q8. 其他：Webull、TradeStation、Tradier、Saxo、Longbridge、eToro

### Takeaway
除 Longbridge（部落格稱台灣人可開，需香港銀行帳戶）外，Webull、Tradier、Saxo、TradeStation 對台灣居民多半**不可用或查無證據**；eToro 的公開 API 仍屬 early access，台灣適用性不明。

### Cited Findings
- **Webull**：2026 國家清單（香港、加拿大、新加坡、日本、英、荷、澳、巴西、南非、泰、印尼、馬來西亞、墨西哥）不含台灣；OpenAPI 只對「eligible clients」開放並按區域上線 — [brokerage-review Webull countries 2026（第三方）](https://www.brokerage-review.com/investing-firm/countries/webull-available-countries.aspx)；[Manila Times 2026-07-07](https://www.manilatimes.net/2026/07/07/tmt-newswire/pr-newswire/webull-malaysia-launches-openapi-allowing-investors-to-trade-us-stocks-and-etfs-via-plain-language-ai/2379419)
- **TradeStation**：TradeStation International（英國 FCA）為 TradeStation Securities 的介紹經紀；2026 評論稱 TradeStation Global 已停收 EU 新客，且在美、加、澳、星、港、日不提供；台灣狀態查無；舊論壇（約 4 年前）稱 API key 需 1 萬美元資產（過時） — [TradeStation International Accounts（官方）](https://www.tradestation-international.com/accounts/)；[BrokerChooser 2026（第三方）](https://brokerchooser.com/broker-reviews/tradestation-global-review)；[EliteTrader（舊）](https://www.elitetrader.com/et/threads/seeking-info-about-tradestation-account-types-api.369178/)
- **Tradier**：官方允許國家清單片段未見台灣 — [Tradier Permitted and Blocked Countries（官方）](https://support.tradier.com/kb/guide/en/permitted-and-blocked-countries-CLzSa0D1rf/Steps/4997916)
- **Saxo**：官方服務國家清單未見台灣（第三方說可以，矛盾） — [Saxo 官方](https://www.help.saxo/hc/en-us/articles/10611416570269-Which-countries-are-serviced-by-Saxo)；[forexbrokers.tw](https://www.forexbrokers.tw/broker-reviews/saxo-bank-review/)
- **Longbridge**：OpenAPI 2022 推出，免費提供程式化行情與交易，涵蓋美股、港股股票/ETF/權證/期權；美股佣金 0、平台費 0.005 美元/股、最低 0.99 美元/筆；最低入金說法不一（HK$10,000 或 US$1,500）；台灣人需用台灣護照並先開香港銀行帳戶 — [China Daily 2022](https://ex.chinadaily.com.cn/exchange/partners/82/rss/channel/cn/columns/sz8srm/stories/WS627c6e25a3101c3ee7ad4eaf.html)；[MoneyHero 2026（第三方）](https://www.moneyhero.com.hk/zh/investment/provider/longbridge)；[Notesity 2026-10（推廣）](https://www.notesity.hk/pages/blog-longbridge-promo)；[Vocus（部落格）](https://vocus.cc/article/69240e65fd89780001892511)
- **eToro**：2025-10 推出公開 API，目前「available to select users in early access」，需已驗證帳戶；eToro 可用地區頁列有台灣，但未說明 API 是否對台灣開放 — [eToro 新聞稿（官方）](https://www.etoro.com/news-and-analysis/press-releases/etoro-marks-15-years-of-social-investing-with-launch-of-public-apis-and-expansion-of-copytradertm-to-the-us/)；[eToro API Docs（官方）](https://api-portal.etoro.com/)；[eToro availability（官方）](https://www.etoro.com/money/availability/)

### Gaps
- Longbridge 對台灣居民的官方資格、OpenAPI 速率與 session 機制未查證。
- eToro 是否讓台灣帳戶產生 API key 未查證；且 eToro 多數美股以 CFD 或實股形式提供，需另查。

---

## Q9. 台灣國內複委託（sub-brokerage）的 API 路線

### Takeaway
截至 2026-10，**凱基證券**（2024-03 推出「美股即時行情 API + 複委託下單 API」，官方文件為 C#）與 **群益證券**（群益 API 官方明列支援複委託，限 Windows、Socket 長連線）是查得到可用 API 下美股複委託單的國內券商。**永豐 Shioaji** 與 **富邦 Neo API** 的官方範圍只涵蓋台股、國內期貨（富邦期貨另有海外期貨），**查無美股複委託 API**。元大、國泰查無相關 API。

### Cited Findings
- **凱基**：2024-03 業界首家推出美股即時行情 API（與 Nasdaq 合作），提供美股現股與 ETF 即時報價、盤中成交量、最佳一檔，並可透過複委託下單 API 下單、成交回報與查詢；新舊客戶免費；官方提供 C# 詳盡文件 — [凱基官方公告](https://www.kgi.com.tw/zh-tw/product-market/news-and-announcement/announcement/announcement-detail?id=2fc401a0c12a41108f59d18e27d0300a)；[鉅亨網 2024](https://news.cnyes.com/news/id/5485188)；[工商時報 2024-03-13](https://www.ctee.com.tw/news/20240313700182-439901)
- 凱基員工部落格介紹 Python 套件 `kgisuperpy`（`pip install kgisuperpy`，含 Order/Account/Quote 模組），範例以台股為主，未明確說明是否支援美股複委託 — [gorich.tw 凱基證券 Leo（業務部落格）](https://gorich.tw/api-python-02/)；[gorich.tw 美股 API 文](https://gorich.tw/api-python-01/)
- **群益**：官方稱「單一 API 即可無縫串接全球多種交易市場，包含國內證期、海外期權以及複委託等跨國商品」；Socket 雙向長連線；申請前需連線測試並線上簽署 API 同意書；API 僅適用 Windows；提供 Python 與 C# 文件 — [群益官方 API 頁](https://www.capital.com.tw/campaign/stock/API/)
- 群益 API 帳號分類：TF 期貨、OF 海外期貨、TS 證券、**OS 複委託** — [iT 邦幫忙 群益 API 教學（第三方）](https://ithelp.ithome.com.tw/articles/10282980)
- **永豐 Shioaji**：官方總覽涵蓋股票、期貨、選擇權（含組合單），為台灣市場（TWSE/TPEX/TAIFEX）；查無美股或複委託支援 — [Shioaji 官方總覽](https://sinotrade.github.io/zh/)；[rshioaji 說明（第三方）](https://www.skills.sh/sinotrade/rshioaji/shioaji)
- 永豐的美股功能（2026）集中在「大戶投 APP」：美股即時報價免申請、雙幣別交割、六種智慧單（觸價、限定開盤、限定收盤、分時、分量、長效單），未提 API — [udn 經濟日報](https://money.udn.com/money/amp/story/5607/9320138)；[udn 智慧單](https://money.udn.com/money/story/5607/9047237)
- **富邦 Neo API**：官方文件分 Stock 與 Future 交易、Stock MarketData；行情來源 TWSE、TPEx、TAIFEX；Web API + WebSocket；最新 v2.4.0；官方 SDK Python、Node.js、C#；API Key 登入需 v2.2.7+ — [富邦 TradeAPI Market Data（官方）](https://www.fbs.com.tw/TradeAPI/en/docs/market-data/intro/)；[富邦 TradeAPI SDK Download（官方）](https://www.fbs.com.tw/TradeAPI/en/docs/download/download-sdk/)
- 富邦 2024-03 改版：新增 Go、導入 API Key 登入與權限控管（行情、交易下單、帳戶功能可分別控管） — [台灣新聞網 2024-03](https://www.taiwannews.com.tw/zh/news/6359399)
- 富邦複委託可交易美、港、滬深、日、英、德、星 — [富邦官方 海外股票](https://www.fbs.com.tw/OverseasStocks/OverseasStocks)

### Inferences
- 若使用者堅持走國內合法券商（資金不出境、受金管會保障），**凱基**是最可能的 API 選擇（但官方文件以 C# 為主、Python 支援需確認）；**群益**可行但 API 綁 Windows（雲端需 Windows VM）。
- 富邦 Neo API 的 API Key + 權限分層是國內最接近「可只開行情/交易、不開帳務」的設計，但目前不涵蓋美股。

### Gaps
- 凱基複委託下單 API 支援的委託類型、是否支援 Python、是否支援 2026 新開放的盤前盤後，皆未查到。
- 群益 SKCOM 複委託 API 支援的委託條件與時段未查到。
- 元大、國泰、玉山、兆豐是否有複委託 API：查無資料。

---

## Q10. 複委託 vs 海外券商：費用與限制（2026）

### Takeaway
2026 年複委託手續費已大幅下殺（多家 0.06%–0.1%、多數無低消，但多為限期或限條件優惠）。**2026-07 底券商公會核准複委託美股盤前、盤後交易**，國泰、富邦、兆豐、玉山等已在 2026-09/10 上線；**夜盤（23 小時）尚未開放**，券商預計配合美國交易所 12 月延長時段再評估。海外券商（IBKR、Alpaca）在 API、夜盤、條件單上仍明顯較完整。

### Cited Findings
- 2026 費率（第三方彙整，數字互有出入）：國泰個股 0.08%、ETF 每筆 3 美元、無低消；永豐每月 5 萬美元內 0.08%（2026-01-01 起，原 0.15%）；富邦一般 0.25%，2026 新戶於 AI PRO 平台 0.06%（2026-02-01～12-31，當月 5 萬美元內）；元大 0.1% 無低消；凱基最新多寫 0.1% 無低消；群益說法分歧（0.08% 限條件 vs 0.2%、低消 3 美元） — [stevenhongisme 2026 14 家比較（部落格）](https://stevenhongisme.com/securities_firms/sub-brokerage-intro/)；[喬王 2026（部落格）](https://mrjoewang.com/sub-brokerage/)；[ETtoday 永豐 5 折](https://finance.ettoday.net/news/3094588)；[富邦官方 海外股票](https://www.fbs.com.tw/OverseasStocks/OverseasStocks)
- 部分券商賣出時仍收低消（15–35 美元），小額交易成本放大 — [George Dewi（部落格）](https://george-dewi.com/double-commission/)
- **盤前盤後開放**：券商公會 2026-07 底核准複委託美股盤前（台灣時間 16:00–21:30）、盤後（台灣時間 05:00–09:00）；兆豐最早；國泰 2026-09-30 起 App 提供；富邦 2026-10-01 起；玉山 2026-10 中旬上線、手續費 0.08%；群益、中信、凱基、永豐規劃中；元大分兩階段 — [工商時報 2026-09-21](https://www.ctee.com.tw/news/20260921700106-439901)；[中央社 2026-09-28](https://www.cna.com.tw/news/afe/202609280032.aspx)；[Yahoo 股市](https://tw.stock.yahoo.com/news/%E7%BE%8E%E8%82%A123%E5%B0%8F%E6%99%82%E4%BA%A4%E6%98%93%E4%BE%86%E4%BA%86-%E5%8F%B0%E7%81%A3%E5%88%B8%E5%95%86%E6%90%B6%E5%8D%A1%E4%BD%8D-%E5%AF%8C%E9%82%A6%E6%8B%9A%E9%A6%96%E5%AE%B6-%E5%85%86%E8%B1%90%E5%B7%B2%E9%96%8B%E8%B7%91-033500972.html)；[蕃新聞 玉山 2026-10-15](https://n.yam.com/Article/20261015423306)
- **夜盤**：報導稱美國那斯達克自美東 12 月 6 日起延長交易時間、開放夜盤，串連成 23 小時；業者指夜盤因跨日、可動用資金與入帳問題系統難度高 — [中央社 2026-09-28](https://www.cna.com.tw/news/afe/202609280032.aspx)；[Newtalk 2026-09-28](https://newtalk.tw/news/view/2026-09-28/1062254)
- 2025 年時仍有群益業務文章稱「複委託盤前盤後基於法規限制台灣尚未開放」（已被 2026-07 核准取代） — [capital-mt5.com（業務部落格，過時）](https://capital-mt5.com/us-stock-trading-before-and-after-the-market-opens/)
- 複委託一般戶交易量前五（2025 年前 11 月）：國泰、永豐、元大、富邦、凱基 — [遠見](https://www.gvm.com.tw/article/128123)
- 對比：IBKR 固定式 0.005 美元/股、最低 1 美元；Alpaca API 交易 0 佣金；Firstrade 0 佣金 — 見 Q2、Q3、Q5 來源

### Inferences
- 以 1 萬美元單筆計：複委託 0.08% ≈ 8 美元；IBKR 固定式（假設 100 股）≈ 1 美元；Alpaca 0 美元（另計 SEC/FINRA 規費）。小額高頻交易海外券商成本明顯較低。
- 複委託目前「API + 盤前盤後」同時可用的組合，在 2026-10 尚未見任何券商公告；凱基、群益 API 是否同步支援新時段需直接詢問。

### Gaps
- 各家複委託 API 是否支援盤前盤後下單：無資料。
- 複委託是否支援條件單（停損、追蹤停損）經 API：無資料。

---

## Q11. 無人值守運作的實務問題（Session、2FA、IP 白名單、API 權限）

### Takeaway
真正能「一次設定、長期無人值守」的只有 API key 型（Alpaca、Tiger、富邦 Neo API Key）；IBKR 需常駐 Gateway 且每週一次手機 2FA；Schwab 每 7 天必須人工 OAuth；Futu 需常駐 OpenD。設計 LINE bot 時應內建「斷線／需重新驗證」推播。

### Cited Findings
- IBKR Web API：5 分鐘無請求即逾時，需每分鐘 tickle；session 最長 24 小時、午夜重置 — [IBKR Authentication FAQ（官方）](https://www.interactivebrokers.com/docs/web-api/authentication/faq)
- IBKR IB Gateway：每日自動重啟免 2FA；每週強制完整登入需 IBKR Mobile 推播確認，無工具可合法繞過（ibc2 明言不嘗試繞過） — [ibc2 PyPI](https://pypi.org/project/ibc2/0.1.0/)；[nautilus_trader #5069](https://github.com/nautechsystems/nautilus_trader/issues/5069)；IBC 設定 `ReloginAfterSecondFactorAuthenticationTimeout` 可在錯過 2FA 視窗時重試 — [NYC Servers（第三方）](https://newyorkcityservers.com/blog/interactive-brokers-vps-tws-ib-gateway)
- Schwab：refresh token 7 天、無法程式續期 — [GitHub tda_to_schwab](https://github.com/48n116w/tda_to_schwab)
- Futu：OpenD 需在本機或雲端常駐 — [Moomoo Help（官方）](https://www.moomoo.com/us/support/topic3_436)
- Tiger：持續超限可能被自動列入黑名單 — [Tiger Rate Limits（官方）](https://docs-en.itigerup.com/docs/ratelimit)
- 富邦 Neo API：API Key 登入並可分別控管「行情、交易下單、帳戶功能」權限 — [台灣新聞網 2024-03](https://www.taiwannews.com.tw/zh/news/6359399)；[富邦 SDK 文件（官方）](https://www.fbs.com.tw/TradeAPI/en/docs/download/download-sdk/)
- 群益 API 僅能在 Windows 執行 — [群益官方 API 頁](https://www.capital.com.tw/campaign/stock/API/)
- Alpaca paper 與 live 使用不同 key；paper 需 `paper=True` — [alpaca-py 文件（官方）](https://docs.alpaca.markets/docs/alpaca-py-trading-api)

### Inferences
- 建議架構：雲端 VM（Linux Docker）跑 IB Gateway + IBC（或 Alpaca 直接 REST），監控程式偵測斷線即透過 LINE 推播「請在 IBKR Mobile 確認登入」；下單前加入金額上限／白名單等硬性風控，避免 LLM（Claude）誤判直接下單。
- 出金權限：IBKR、Alpaca 的 API 本身都不提供出金到外部銀行的交易端點（屬一般認知，本次未取得來源佐證，見 Gaps）。

### Gaps
- IBKR、Alpaca、Futu、Tiger 是否支援 API 層級 IP 白名單：本次未查到官方說明。
- Alpaca API key 是否可設唯讀／權限範圍、是否有過期機制：未查到。
- Tiger、Longbridge OpenAPI 的登入是否需 2FA、token 有效期：未查到。
- 「API 無法出金」的說法未取得任何券商官方來源佐證。
