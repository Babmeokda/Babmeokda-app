#!/bin/bash

echo "🎉 [1/5] 초기화 및 패키지 설치 중..."

# 1. package.json 생성
npm init -y

# 2. 필수 패키지 설치
npm install -D husky @commitlint/cli @commitlint/config-conventional

echo "✅ 패키지 설치 완료"

# 3. Husky 초기화 및 커밋 훅 설정
npx husky init

# 4. 불필요한 pre-commit 제거 (npm test 막힘 방지)
rm -f .husky/pre-commit

echo "✅ Husky hook 설정 완료"

# 4. commitlint 설정 파일 추가
cat << EOF > commitlint.config.js
module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [2, 'always', [
      'init', 'feat', 'fix', 'docs', 'style',
      'refactor', 'test', 'chore', 'design',
      'comment', 'rename', 'remove', 'breaking-change', 'hotfix'
    ]]
  }
};
EOF

echo "✅ commitlint 설정 완료"

# 5. 자동 이모지 삽입 스크립트 추가
mkdir -p scripts
cat << 'EOF' > scripts/verify-emoji-commit.sh
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
EOF

chmod +x scripts/verify-emoji-commit.sh

cat << 'EOF' > .husky/commit-msg
#!/bin/sh
. "$(dirname "$0")/_/husky.sh"

./scripts/verify-emoji-commit.sh "$1"
EOF

chmod +x .husky/commit-msg


echo "✅ 자동 이모지 스크립트 완료"
echo "🎉 모든 설정이 완료되었습니다!"