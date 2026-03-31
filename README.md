# 🛠️ Methodalgo Market Intel Explorer

`methodalgo-market-intel-explorer` is a market intelligence exploration skill specifically designed for AI agents (such as Claude). Through the integrated `methodalgo` CLI, it captures real-time cryptocurrency news, macroeconomic events, trading signals, ETF fund flows, and market sentiment indicators.

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

## ✨ Core Features

- **📰 Comprehensive News**: Supports deep-dive articles (`article`), real-time breaking news (`breaking`), on-chain monitoring (`onchain`), and institutional research reports (`report`).
- **📡 Real-time Signals**: Includes High/Medium Timeframe Breakouts (`breakout`), Large Liquidations (`liquidation`), Buyer/Seller Exhaustion (`exhaustion`), and "Golden Pit" signals based on Smart Cloud patterns.
- **📊 Market Data**: Provides token unlock countdowns, ETF fund flows, and daily market summaries (Fear & Greed Index).
- **📸 Instant Snapshots**: Fetch TradingView chart screenshots for any symbol at any time (supports Spot and Perpetual).
- **🤖 AI-Friendly**: Outputs pure JSON structured data, making it easy for AI to extract key information.
- **🧩 Smart Fetching**: Supports `--after` pagination, `--search` filtering, and time-window queries.

---

## 🏗️ Best Practices (AI Agent Recommendations)

### 1. Two-Phase Query Method
To save context overhead and improve accuracy, it is recommended to first fetch a summary of 5 items, then perform a deep dive based on key findings.
- **Preview**: `methodalgo signals breakout-mtf --limit 5 --json`
- **Deep Dive**: `methodalgo signals breakout-mtf --limit 50 --after "msgId" --json`

### 2. Structural Handling
Note that the `token-unlock` channel returns an object (`{ signals: [...] }`), while other channels return an array. The AI should select the corresponding extraction logic based on the channel type.

---

## 🚀 Part 1 — Installing the Skill

Choose one of the following methods to install this skill into your AI agent:

### Option A — ClawHub (Recommended)

```bash
clawhub install methodalgo-marketintel-explorer
```

> 🔗 **Skill Page**: [https://clawhub.ai/methodalgo/methodalgo-marketintel-explorer](https://clawhub.ai/methodalgo/methodalgo-marketintel-explorer)

### Option B — GitHub Clone

```bash
git clone https://github.com/methodalgo/methodalgo-market-intel-explorer.git
```

Then point your AI agent (e.g. Claude, Cursor, Antigravity) to the cloned folder and instruct it to read `SKILL.md` to activate.

---

## ⚙️ Part 2 — Installing the CLI (Required)

This skill relies on the `methodalgo` CLI to fetch market data. **You must install it before using any skill commands.**

```bash
npm install -g methodalgo-cli
```

Verify the installation and configure your API key:
```bash
methodalgo --version
methodalgo login
```

---

## 📖 Usage Guide

This skill primarily executes commands via the `methodalgo` CLI. It is recommended to always include the `--json` flag to obtain machine-readable data.

### Fetch News
```bash
# Get the latest 5 breaking news flashes
methodalgo news --type breaking --limit 5 --json
```

### Fetch Trading Signals
```bash
# Get the latest Medium Timeframe (MTF) breakout signals
methodalgo signals breakout-mtf --limit 10 --json
```

### Fetch Snapshots
```bash
# Get a 1-hour chart for SOLUSDT.P (Perpetual)
methodalgo snapshot SOLUSDT.P 60 --url --json
```

---

## 🎯 Common Scenarios

| Objective | Recommended Command |
| :--- | :--- |
| **Today's Hot Topics** | `methodalgo news --type article --limit 5 --json` |
| **Monitor Liquidations** | `methodalgo signals liquidation --limit 10 --json` |
| **Mid-term Breakouts** | `methodalgo signals breakout-mtf --limit 10 --json` |
| **Trend Reversals** | `methodalgo signals exhaustion-buyer --limit 5 --json` |
| **Buy the Dip (Golden Pit)** | `methodalgo signals golden-pit-mtf --limit 5 --json` |
| **Get Chart Snapshot** | `methodalgo snapshot BTCUSDT.P 60 --url --json` |
| **Check ETF Flows** | `methodalgo signals etf-tracker --limit 1 --json` |
| **Token Unlocks** | `methodalgo signals token-unlock --limit 10 --json` |
| **Sentiment Monitoring** | `methodalgo signals market-today --limit 1 --json` |

---

## ⚠️ Important Notes
- The `--limit` parameter controls the number of items returned; please set it reasonably based on the context window size. Avoid a limit that is too small (missing data) or too large (consuming excessive context).
- For the `token-unlock` channel, the root of the JSON response contains a `signals` array, which is slightly different from other channels.

---

## 📁 File Structure

```text
methodalgo-market-intel-explorer/
├── README.md                 # Overview and installation guide (this file)
├── SKILL.md                  # Main AI instruction file (System Prompt)
├── CLAUDE.md                 # Claude-specific instructions
└── references/               # Additional context for AI agents
    ├── ai-prompts.md         # Recommended prompts for data analysis
    ├── sample-output.md      # Example JSON responses for CLI commands
    └── signal-channels.md    # Supported Discord channels and descriptions
```

---

## 🔄 How to Update the Skill

When updating or extending this skill, please follow these guidelines:

1. **Adding New Channels/Features**: Update `references/signal-channels.md` and add relevant examples to `references/sample-output.md`.
2. **Modifying AI Instructions**: Any prompt adjustments or new rules must be centrally updated in `SKILL.md` to ensure the AI parses them correctly.
3. **Updating Documentation**: Keep `README.md` aligned with the latest features for human readability.
4. **Context Refresh**: After modifying any core files, make sure to instruct your AI agent to re-read `SKILL.md` to refresh its working context.
