# MethodAlgo Market Intel Explorer

AI-facing skill for MethodAlgo crypto market intelligence. It routes natural-language market questions to `methodalgo-cli` commands for news, signals, chart snapshots, economic calendar data, macro indicators, crypto market totals, and Binance public spot/futures market data.

```text
▄▄▄      ▄▄▄             ▄▄             ▄▄   ▄▄▄▄   ▄▄
████▄  ▄████        ██   ██             ██ ▄██▀▀██▄ ██
███▀████▀███ ▄█▀█▄ ▀██▀▀ ████▄ ▄███▄ ▄████ ███  ███ ██ ▄████ ▄███▄
███  ▀▀  ███ ██▄█▀  ██   ██ ██ ██ ██ ██ ██ ███▀▀███ ██ ██ ██ ██ ██
███      ███ ▀█▄▄▄  ██   ██ ██ ▀███▀ ▀████ ███  ███ ██ ▀████ ▀███▀
                                                          ██
                                                        ▀▀▀
```

## Core Features

- News: `article`, `breaking`, `onchain`, and `report`.
- Signals: breakouts, liquidations, exhaustion reversals, Golden Pit, token unlocks, ETF flows, and `market-today`.
- Snapshots: chart image URLs for spot and futures symbols.
- Macro: dashboard, recession, liquidity, series, get, info, compare, spread, z-score, latest, and search.
- Totals: BTC/ETH dominance, total market cap, Fear & Greed, and Altseason Index.
- Binance public data: price, ticker, movers, book, trades, klines, funding, OI, sentiment, basis, exchange-info, and allowlisted raw endpoints.

## Install

Install from ClawHub:

```bash
clawhub install methodalgo-market-intel-explorer
```

Or clone the repository and point your AI agent to `SKILL.md`:

```bash
git clone https://github.com/methodalgo/methodalgo-market-intel-explorer.git
```

Install the CLI:

```bash
npm install -g methodalgo-cli
methodalgo --version
```

Use `methodalgo-cli >= 1.0.36` for `macro` and `totals`.

## Authentication

Most MethodAlgo service commands require a MethodAlgo API key:

```bash
methodalgo login
```

For normal MethodAlgo service usage, set `METHODALGO_API_KEY` in the environment or authenticate with `methodalgo login`. The CLI prioritizes this environment variable over local login config.

Binance public market data commands do not require a MethodAlgo API key or a Binance API key:

```bash
methodalgo binance price BTCUSDT.P --json
```

## Quick Examples

```bash
methodalgo news --type breaking --limit 50 --json
methodalgo signals breakout-mtf --limit 10 --json
methodalgo signals token-unlock --limit 1 --json
methodalgo snapshot BTCUSDT.P 60 --url --json
methodalgo calendar --countries US,EU --json
methodalgo macro dashboard --json
methodalgo macro liquidity --tail 52 --json
methodalgo totals --json
methodalgo totals fear-greed --history 30d --json
methodalgo binance movers --market futures --limit 10 --json
methodalgo binance funding BTCUSDT.P --json
methodalgo binance oi BTCUSDT.P --period 5m --json
```

## AI Agent Notes

- Use `--json` by default for all data commands.
- Use a two-phase flow: fetch a small preview, then deepen with `--after`, `--search`, larger limits, or symbol-specific calls.
- `token-unlock` returns `{ signals: [...] }` at the root; most other signal channels return an array.
- `market-today` is a Discord-style summary stream. Use `methodalgo totals --json` for structured dominance, market cap, Fear & Greed, and Altseason metrics.
- `BTCUSDT` means spot; `BTCUSDT.P` means USD-M perpetual futures. Use `--market futures` for list-style futures commands such as `movers`.

## References

- `SKILL.md`: compact AI routing guide and protected parsing rules.
- `references/command-reference.md`: full command and parameter reference.
- `references/signal-channels.md`: signal channel details and `details` field meanings.
- `references/sample-output.md`: compact JSON examples.
- `references/output-shape-catalog.md`: field-level shape catalog for less common command variants.
- `references/ai-prompts.md`: scenario templates for common market analysis tasks.

GitHub: https://github.com/methodalgo/methodalgo-market-intel-explorer

ClawHub: https://clawhub.ai/methodalgo/methodalgo-market-intel-explorer
