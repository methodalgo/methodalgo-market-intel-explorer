# 🛠️ Methodalgo Market Intel Explorer

`methodalgo-market-intel-explorer` 是一个专为 AI 代理（如 Claude）设计的市场情报探索技能。它通过集成的 `methodalgo` CLI，实时捕捉加密货币新闻、宏观经济事件、交易信号、ETF 资金流以及市场情绪指标。

---

```text
▄▄▄      ▄▄▄             ▄▄             ▄▄   ▄▄▄▄   ▄▄             
████▄  ▄████        ██   ██             ██ ▄██▀▀██▄ ██             
███▀████▀███ ▄█▀█▄ ▀██▀▀ ████▄ ▄███▄ ▄████ ███  ███ ██ ▄████ ▄███▄ 
███  ▀▀  ███ ██▄█▀  ██   ██ ██ ██ ██ ██ ██ ███▀▀███ ██ ██ ██ ██ ██ 
███      ███ ▀█▄▄▄  ██   ██ ██ ▀███▀ ▀████ ███  ███ ██ ▀████ ▀███▀ 
                                                          ██       
                                                        ▀▀▀        
```
---

## ✨ 核心特性

- **📰 全方位新闻**: 支持深度文章（Article）、实时快讯（Breaking）、链上监测（On-chain）及机构报告（Report）。
- **📡 实时信号**: 包括高/中时间框架突破（Breakout）、大额强平（Liquidation）、买家/卖家耗尽（Exhaustion）以及 Smart Cloud 模式的黄金坑等信号。
- **📊 市场数据**: 提供代币解锁倒计时、ETF 资金流向及每日市场综述（恐慌贪婪指数）。
- **📸 实时快照**: 随时获取任意币种的 TradingView 图表截图（支持现货及合约）。
- **🤖 AI 友好**: 输出纯 JSON 结构化数据，方便 AI 提取关键信息。

---

## 🚀 快速开始

### 1. 前置要求
确保系统中已全局安装了 `methodalgo` CLI：

```bash
npm install -g methodalgo-cli
```

### 2. 验证安装
```bash
methodalgo --version
```

### 3. 配置密钥
初次使用需配置 API 密钥（按照 CLI 引导操作）：
```bash
methodalgo login
```

---

## 📖 使用指南

该技能主要通过 `methodalgo` CLI 执行命令。建议始终携带 `--json` 参数以获取机器可读的数据。

### 获取新闻
```bash
# 获取最新的 5 条实时快讯
methodalgo news --type breaking --limit 5 --json
```

### 获取交易信号
```bash
# 获取最新的中级别（MTF）突破信号
methodalgo signals breakout-mtf --limit 10 --json
```

### 获取快照
```bash
# 获取 SOLUSDT.P (合约) 的 1 小时图表
methodalgo snapshot SOLUSDT.P 60 --url --json
```

---

## 🎯 常用场景

| 目标 | 推荐命令 |
| :--- | :--- |
| **今日热点** | `methodalgo news --type article --limit 5 --json` |
| **监控强平** | `methodalgo signals liquidation --limit 10 --json` |
| **获取快照** | `methodalgo snapshot BTCUSDT.P 60 --url --json` |
| **查看 ETF** | `methodalgo signals etf-tracker --limit 1 --json` |
| **代币解锁** | `methodalgo signals token-unlock --limit 10 --json` |

---

## ⚠️ 注意事项
- 本技能默认优先返回中文（`zh`）内容。
- `--limit` 参数可调节返回的数据条数，请根据上下文窗口大小合理设定。
- 对于 `token-unlock` 频道，返回的 JSON 根部包含 `signals` 数组，与其他频道略有不同。

---
💡 *本技能由 Antigravity 强力驱动。*
