---
name: methodalgo-market-intel-explorer
version: 1.0.0
category: data-provider
description: 获取加密货币新闻、图表快照、宏观经济事件、交易信号。当用户要求查看最新加密货币新闻、市场快照、图表截图、交易信号、代币解锁、ETF 资金流、恐慌贪婪指数等市场数据时使用此技能。
---

# Methodalgo 市场情报探索技能

## 前置条件

`methodalgo` CLI 必须全局安装：
```bash
npm install -g methodalgo-cli
```

验证：`methodalgo --version`

---

## 使用方法

直接调用 `methodalgo` CLI，**必须加 `--json`** 获取结构化数据：

```bash
# 新闻
methodalgo news --type <type> --limit <N> --json

# 信号
methodalgo signals <channel> --limit <N> --json

# 快照
methodalgo snapshot <symbol> [tf] --url --json
```

---

## 📸 快照命令

```bash
methodalgo snapshot <symbol> [tf] --url --json
```

### 参数说明

| 参数 | 说明 | 示例 |
|------|------|------|
| `symbol` | 交易对符号（必填） | `SOLUSDT` (现货) / `SOLUSDT.P` (合约) |
| `tf` | 时间周期（可选，默认 60） | `15` / `30` / `60` / `240` / `D` / `2D` / `W` / `2W` / `M` |
| `--url` | 强制返回 URL 链接而非二进制流 | `--url` |
| `--buffer` | 输出原始二进制格式图片流（适合程序直接处理） | `--buffer` |
| `--json` | 输出结构化 JSON 数据 | `--json` |

### 输出结构

```json
{
  "symbol": "SOLUSDT.P",
  "tf": "60",
  "url": "https://m.methodalgo.com/tmp/xxx.webp",
  "timestamp": 1774899516784
}
```

---

## 📰 新闻命令

```bash
methodalgo news --type <type> --limit <N> --json
```

### 可用类型

| 类型 | 说明 |
|------|------|
| `article` | 深度加密市场新闻与分析（含摘要和 AI 分析） |
| `breaking` | 实时突发快讯 |
| `onchain` | 链上数据异动监测 |
| `report` | 机构研究报告 |

### 可选参数

| 参数 | 说明 | 示例 |
|------|------|------|
| `--type` | 新闻类型（必填） | `--type breaking` |
| `--limit` | 数量限制，最高 500 | `--limit 10` |
| `--language` | 语言 `zh` / `en` | `--language zh` |
| `--search` | 标题关键词搜索 | `--search 'Bitcoin'` |
| `--start-date` | 起始日期 | `--start-date 2026-03-20` |
| `--end-date` | 结束日期 | `--end-date 2026-03-30` |

### 输出结构

```json
[
  {
    "type": "breaking",
    "title": { "en": "...", "zh": "..." },
    "excerpt": { "en": "...", "zh": "..." },
    "description": { "en": "...", "zh": "..." },
    "analysis": { "en": "...", "zh": "..." },
    "publish_date": "2026-03-30T19:15:56+00:00",
    "url": "https://..."
  }
]
```

> `article` 类型通常包含 `excerpt`、`analysis` 和 `url`；`breaking`、`onchain`、`report` 类型通常无 excerpt。建议一次获取足够数量的新闻, 如50-100条, 以确保能覆盖到足够的时间范围。 

---

## 📡 信号命令

```bash
methodalgo signals <channel> --limit <N> --json
```

### 频道

| 频道 | 说明 | 更新频率 |
|------|------|----------|
| `breakout-htf` | 高时间框架突破（1D/3D），100 K线滚动窗口 | 中频 |
| `breakout-mtf` | 中时间框架突破（1H/4H），100 K线滚动窗口 | 高频 |
| `breakout-24h` | 24 小时滚动窗口突破检测 | 超高频 |
| `liquidation` | 大额强平订单实时提醒 | 实时 |
| `exhaustion-seller` | 卖家耗尽反转信号（死神清算热力图，库存 <10%/<5%） | 中低频 |
| `exhaustion-buyer` | 买家耗尽反转信号（死神清算热力图，库存 <10%/<5%） | 中低频 |
| `golden-pit-mtf` | Smart Cloud的黄金坑信号（30m/1h/4h），Bull=回撤后将拉升，Bear=上扬后将下跌 | 中频 |
| `golden-pit-ltf` | Smart Cloud的黄金坑信号（5m/15m），Bull=回撤后将拉升，Bear=上扬后将下跌 | 高频 |
| `token-unlock` | 代币解锁事件，含解锁时间,代币基本面数据、解锁量等等 | 每日 |
| `etf-tracker` | BTC/ETH/SOL/XRP ETF 每日资金流入流出 | 每日 |
| `market-today` | 山寨季指数 + 恐慌贪婪指数 | 每日 |

### 输出结构

**常规信号频道**（breakout / liquidation / exhaustion / golden-pit / etf-tracker / market-today）：

```json
[
  {
    "id": "1488261183843864617-0-0",
    "timestamp": 1774899516784, // 信号发送时间戳
    "attachments": [],
    "image": "https://m.methodalgo.com/tmp/xxx.webp", // 图表或数据图链接（可选，或为 null）
    "signals": [
      {
        "title": "信号标题展示...",
        "description": "信号简述内容（不同频道格式不一）...",
        "direction": "bull/bear/空字符串", // 方向提示
        "details": { 
          // ⚠️ 不同频道的 details 对象字段不一致，具体枚举如下：
        }
      }
    ]
  }
]
```

**各常规频道 `details` 结构枚举：**

1. **`breakout-*` 系列**（现获取到突破交易机会）
```json
{
  "Symbol": "NIGHTUSDT.P", "TimeFrame": "1h", "Type": "DOWN / UP", 
  "BreakPrice": "0.04284", "Exchange": "BINANCE"
}
```
2. **`liquidation`**（发现大额爆仓/清算订单）
```json
{
  "Symbol": "ZECUSDT.P", "Side": "🔴 SHORT / 🟢 LONG", "Quantity": "88.245", 
  "Average Price": "$227.43", "Liquidation Price": "$229.70", "Position Total": "$20069"
}
```
3. **`exhaustion-*` 系列**（买家或卖家耗尽，趋势可能逆转）
```json
{
  "Type": "Early Reversal", "Timeframe": "30m", "Exhaustion Side": "SELLER / BUYER", 
  "Safety": "...", "Tip": "...", "Exchange": "Binance"
}
```
4. **`golden-pit-*` 系列**（Smart Cloud 形态中回踩/冲高的反切机会）
```json
{
  "Pattern": "Pull then Push", "Safety": "Wait 6-10 bars to develop..."
}
```
5. **`etf-tracker`**（ETF 资金流入流出播报）
```json
{
  "Net Inflow": "$0K", "7 Days Avg.": "$663.0K"
}
```
6. **`market-today`**（市场情绪，含山寨季指标与恐慌贪婪指数）
```json
// 类型 A (Season Index)
{ "Alt Season": "...", "Bitcoin Season": "..." }
// 类型 B (Fear And Greed Index)
{ "Yesterday": "12", "3Days Ago": "10", "7Days Ago": "10" }
```

**token-unlock 频道**（数据结构不同，外层有 `signals` 数组）：

```json
{
  "signals": [
    {
      "ts": 1774915176616,//解锁时间
      "symbol": "OP",//代币名称
      "perc": 1.52,//解锁百分比
      "progress": "40.91%",//解锁进度
      "circSup": "6.79 B ICE",//代币当前流通量
      "countDown": "0Day23Hr30Min",//解锁倒计时 相对于解锁更新时间, 请根据用户当前时区 使用数据中的ts与updatedAt计算实时倒计时
      "marketCap": "$218.99 M",//代币当前市值
      "unlockToken": "32.21 M",//解锁代币数量
      "unlockTokenVal": "$3.36 M (1.52% of M.Cap)"//解锁代币价值
    }
  ],
  "updatedAt": 1774915176616//数据更新时间
}
```

---

## 🎯 使用场景速查

| 用户意图 | 命令 |
|----------|------|
| 查最新会影响市场情绪的快讯 | `methodalgo news --type breaking --limit 50 --json` |
| 查加密行业新闻 | `methodalgo news --type article --limit 100 --json` |
| 搜索某币种新闻 | `methodalgo news --type article --search 'Bitcoin' --limit 5 --json` |
| 查突破信号 | `methodalgo signals breakout-mtf --limit 10 --json` |
| 查代币解锁 | `methodalgo signals token-unlock --limit 1 --json` |
| 查 ETF 资金流 | `methodalgo signals etf-tracker --limit 10 --json` |
| 查市场情绪 | `methodalgo signals market-today --limit 5 --json` |
| 查强平事件 | `methodalgo signals liquidation --limit 10 --json` |
| 查黄金坑信号 | `methodalgo signals golden-pit-mtf --limit 10 --json` |
| 查图表快照 | `methodalgo snapshot BTCUSDT.P 60 --url --json` |
| 增量拉取更多信号 (不适用token-unlock类型的信号)| `methodalgo signals <channel> --limit 100 --after "消息ID" --json` |

---

## 注意事项

1. **输出格式**：输出是**纯 JSON**，直接 `JSON.parse` 即可。
2. **两阶段拉取策略**：
   - 第一阶段（快照）：取 5 条数据，用于初步判断趋势。
   - 第二阶段（深挖）：基于特定 ID 或关键字进行增量拉取（`--after` / `--search`）。
3. **数据量限制**：`--limit` 控制数据量。新闻最高 500 条；信号最高 600 条。
4. **语言处理**：新闻类数据优先读取 `title.zh` / `excerpt.zh` / `analysis.zh`。
5. **结构不一致性提醒**：`token-unlock` 返回对象（包含 `signals` 数组），其他频道返回数组。AI 必须根据 `channel` 判断处理逻辑。
6. **快照截图**：`snapshot` 默认通过 `--url` 返回图片链接，请通过该链接获取可视化的行情图表。

> Github: https://github.com/methodalgo/methodalgo-market-intel-explorer