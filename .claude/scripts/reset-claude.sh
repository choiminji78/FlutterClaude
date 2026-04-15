#!/bin/bash

TARGETS=(
  "$HOME/.claude"
  "$HOME/.config/claude"
  "$HOME/.cache/claude"
  "$HOME/.local/share/claude"
)

echo "다음 디렉토리를 삭제합니다:"
for dir in "${TARGETS[@]}"; do
  if [ -d "$dir" ]; then
    echo "  - $dir"
  fi
done

read -p "정말 삭제할까요? (y/N) " answer
if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
  echo "취소했습니다."
  exit 0
fi

for dir in "${TARGETS[@]}"; do
  if [ -d "$dir" ]; then
    rm -rf "$dir"
    echo "삭제 완료: $dir"
  fi
done

echo "초기화 완료."
