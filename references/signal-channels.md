# 信号频道详细参考

## 突破类信号 (Breakout)

### breakout-htf（高时间框架突破）
- **时间框架**: 1D / 3D
- **机制**: 100 根 K 线滚动窗口中，检测当前 K 线突破期间最高/低点
- **details 字段**: `Symbol`, `TimeFrame`, `Type`(UP/DOWN), `BreakPrice`, `Exchange`

### breakout-mtf（中时间框架突破）
- **时间框架**: 1H / 4H
- **机制**: 100 根 K 线滚动窗口中，检测当前 K 线突破期间最高/低点
- **details 字段**: 同 breakout-htf

### breakout-24h（24 小时突破）
- **时间框架**: 基于 24 小时滚动窗口
- **机制**: 持续检测基于过去 24 小时最高/低价的突破
- **details 字段**: 同 breakout-htf

---

## 强平类信号 (Liquidation)

### liquidation（大额强平）
- **机制**: 大额强平订单实时提醒
- **details 字段**: `Symbol`, `Side`, `Quantity`, `Average Price`, `Liquidation Price`, `Position Total`

---

## 反转类信号 (Exhaustion)

### exhaustion-buyer（买家耗尽）
- **机制**: 基于死神清算热力图，检测单边买家强平库存 <10% 与 <5%
- **含义**: 买家耗尽 → 价格可能反转下跌
- **details 字段**: `Type`, `Timeframe`, `Exhaustion Side`, `Safety`, `Tip`, `Exchange`

### exhaustion-seller（卖家耗尽）
- **机制**: 基于死神清算热力图，检测单边卖家强平库存 <10% 与 <5%
- **含义**: 卖家耗尽 → 价格可能反弹上涨
- **details 字段**: `Type`, `Timeframe`, `Exhaustion Side`, `Safety`, `Tip`, `Exchange`

> ⚠️ Exhaustion 是**反转信号**。例如 exhaustion-buyer 信号发出时，价格正在上涨，但算法检测到上方买盘有限，后续可能反转下跌。

---

## 黄金坑信号 (Golden Pit)

### golden-pit-mtf（中时间框架黄金坑）
- **时间框架**: 30m / 1h / 4h
- **机制**: Smart Cloud 模式检测，预示随后会有显著的程序化波动
- **Bull Pit**: 短暂回撤后价格会拉升
- **Bear Pit**: 短暂上扬后价格会继续下降
- **details 字段**: `Pattern`, `Safety`

### golden-pit-ltf（低时间框架黄金坑）
- **时间框架**: 5m / 15m
- **机制**: 同 golden-pit-mtf
- **details 字段**: 同 golden-pit-mtf

---

## 代币解锁 (Token Unlock)

### token-unlock
- **数据结构**: 与其他频道不同，返回 `{ signals: [...], updatedAt: timestamp }`
- **details 字段**: `symbol`, `perc`, `progress`, `circSup`, `countDown`, `marketCap`, `unlockToken`, `unlockTokenVal`

---

## ETF 追踪 (ETF Tracker)

### etf-tracker
- **机制**: BTC/ETH/SOL/XRP 每日资金流入流出追踪
- **details 字段**: `Net Inflow`, `7 Days Avg.`

---

## 市场综合指标 (Market Today)

### market-today
- **机制**: 包含两项指标 — 山寨季指数 + 恐慌贪婪指数
- 每次返回多条数据，分别对应不同指标
- **details 字段（山寨季）**: `Alt Season`, `Bitcoin Season`
- **details 字段（恐慌贪婪）**: `Yesterday`, `3Days Ago`, `7Days Ago`
