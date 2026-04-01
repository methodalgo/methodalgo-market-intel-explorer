#!/bin/bash

SKILL_FILE="SKILL.md"
DIR_PATH=$(pwd)

# 1. 提取当前版本号 (例如 version: 1.0.4)
CURRENT_VERSION=$(grep -E "^version: [0-9]+\.[0-9]+\.[0-9]+" $SKILL_FILE | awk '{print $2}')

if [ -z "$CURRENT_VERSION" ]; then
    echo "❌ 错误: 无法在 $SKILL_FILE 中找到版本号。"
    exit 1
fi

# 2. 版本号自增逻辑 (1.0.4 -> 1.0.5)
IFS='.' read -ra ADDR <<< "$CURRENT_VERSION"
MAJOR=${ADDR[0]}
MINOR=${ADDR[1]}
PATCH=${ADDR[2]}
NEW_PATCH=$((PATCH + 1))
NEW_VERSION="$MAJOR.$MINOR.$NEW_PATCH"

echo "🆙 正在将版本从 $CURRENT_VERSION 更新为 $NEW_VERSION..."

# 3. 更新 SKILL.md 文件
# 使用 MacOS 兼容的 sed 语法
sed -i "" "s/^version: $CURRENT_VERSION/version: $NEW_VERSION/" "$SKILL_FILE"

# 4. 执行发布命令
echo "🚀 正在发布 Skill: methodalgo-market-intel-explorer ($NEW_VERSION)..."
clawhub publish "$DIR_PATH" --version "$NEW_VERSION"

if [ $? -eq 0 ]; then
    echo "✅ 发布成功！"
else
    echo "❌ 发布失败，请检查错误输出。"
    exit 1
fi
