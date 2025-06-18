#!/bin/sh

MSG_FILE=$1
MSG=$(cat "$MSG_FILE")

# 1. 커밋 메시지 유효성 검사 (기본 에러 메시지 숨기고 한글로 안내)
npx --no -- commitlint --edit "$MSG_FILE" > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo ""
  echo "❌ [오류] 유효한 커밋 타입이 아닙니다. 아래 중 하나를 사용해주세요:"
  echo ""
  echo "init, feat, fix, docs, style, refactor, test, chore, design, comment, rename, remove, breaking-change, hotfix"
  echo ""
  echo "예시: feat: 사용자 로그인 기능 구현"
  echo ""
  exit 1
fi

# 2. 커밋 타입에 따라 이모지 지정
case "$MSG" in
  init:*) EMOJI="🎉";;
  feat:*) EMOJI="✨";;
  fix:*) EMOJI="🐛";;
  docs:*) EMOJI="📝";;
  style:*) EMOJI="🎨";;
  refactor:*) EMOJI="♻️";;
  test:*) EMOJI="✅";;
  chore:*) EMOJI="🔧";;
  design:*) EMOJI="💎";;
  comment:*) EMOJI="💬";;
  rename:*) EMOJI="🔤";;
  remove:*) EMOJI="🔥";;
  breaking-change:*) EMOJI="💥";;
  hotfix:*) EMOJI="🚑";;
  *) EMOJI="";;
esac

# 3. 이모지가 앞에 없다면 자동 추가
if ! echo "$MSG" | grep -q "$EMOJI"; then
  echo "$EMOJI $MSG" > "$MSG_FILE"
fi
