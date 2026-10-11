#!/bin/bash
# VIDA16 -> https://github.com/VityaIG/VIDA64.git

REPO_URL="${1:-https://github.com/VityaIG/VIDA64.git}"

echo "🚀 Отправка VIDA16 в репозиторий $REPO_URL..."

if [ ! -d ".git" ]; then
    git init
fi

git add .
git commit -m "feat: initial VIDA16 iOS hardware monitor (AIDA64 for iPhone)"
git branch -M main
git remote remove origin 2>/dev/null
git remote add origin "$REPO_URL"
git push -u origin main

echo "🎉 Успешно отправлено! GitHub Actions сейчас соберет VIDA16.ipa в облаке."
