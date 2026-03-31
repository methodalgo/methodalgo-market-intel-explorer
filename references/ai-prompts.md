# 🤖 AI 代理指令模板 (AI Prompts)

本文件提供了一系列经过优化的 Prompt 示例，旨在帮助 AI 代理（如 Claude, GPT-4）最高效地利用 `methodalgo-market-intel-explorer` 技能。

---

## ⚡ 核心原则
- **JSON 驱动**: 始终要求输出 JSON 以进行精确解析。
- **两阶段查询**: 优先预览，后深挖。
- **上下文感知**: 结合当前日期进行时间范围过滤。

---

## 📝 场景化模板

### 1. 每日早报/市场综述
**Prompt**:
> 请使用 `methodalgo-market-intel-explorer` 技能，为我生成一份今日加密市场综述。
> 1. 调用 `signals market-today` 获取恐慌贪婪指数和山寨季指标。
> 2. 调用 `signals etf-tracker` 获取最新的 ETF 资金流向。
> 3. 调用 `news --type article --limit 5` 获取今日最重要的 5 条深度分析。
> 请结合以上数据，用简洁的中文分析当前市场情绪和潜在风险。

### 2. 特定币种深度扫描 (如 SOL)
**Prompt**:
> 我需要对 SOL 进行深度扫描：
> 1. 搜索关于 SOL 的最新 10 条新闻：`news --type article --search 'SOL' --limit 10`。
> 2. 检查是否有针对 SOL 的 MTF 突破信号：`signals breakout-mtf --limit 50` 并过滤出 SOL 相关的项。
> 3. 获取一张 SOLUSDT.P 的 1 小时图表快照：`snapshot SOLUSDT.P 60 --url`。
> 请整合以上信息，判断 SOL 当前的短期走势。

### 3. 监控大额强平与情绪反转
**Prompt**:
> 实时监控市场异动：
> 1. 获取最新的 50 条大额强平记录：`signals liquidation --limit 50`。
> 2. 检查是否有 `exhaustion-buyer` 或 `exhaustion-seller` 反转信号：`signals exhaustion-seller --limit 5`。
> 3. 如果发现大额强平（超过 $1M）或强反转信号，请立即警示并提供对应的图表快照链接。

### 4. 代币解锁提醒
**Prompt**:
> 查询即将到来的重要代币解锁事件：
> 调用 `signals token-unlock --limit 1`。
> 注意：此命令返回的是对象，请提取 `signals` 数组中的 `symbol`, `perc` (解锁百分比), `countDown` 和 `unlockTokenVal` (解锁价值)。`ts`是计划解锁时间.
> 重点标记解锁比例超过流通量 1% 的项目，并分析其对价格的潜在压力。

---

## 🛠️ 常见问题处理 (Troubleshooting for AI)

- **如果遇到 `token-unlock` 数据解析失败**:
  - *原因*: 该频道返回 `{ signals: [...] }` 而非普通频道返回的 `[...]`。
  - *对策*: AI 应该检查根对象是否包含 `signals` 键，如果是，则迭代该键下的数组。

- **如果数据过旧**:
  - *对策*: 检查返回 JSON 中的 `timestamp` 或 `updatedAt` 字段。如果超过 24 小时，建议提醒用户可能存在延迟，或尝试增量拉取最新数据。

- **如果上下文溢出**:
  - *对策*: 将 `--limit` 从 50 缩减至 10，或增加 `--search` 关键词精确匹配。
