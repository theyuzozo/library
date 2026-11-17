#!/bin/zsh
# Publish the Obsidian vault to yuzozo.com
# Usage: ./publish.sh            -> copy vault + push to GitHub (live in ~2 min)
#        ./publish.sh preview    -> copy vault only (to check on http://localhost:8080 first)
set -e

VAULT="$HOME/Library/CloudStorage/Dropbox-ASU/Zoey Tian/Yu Tian/3 Yu Zozo/1 Yu Zozo/yuzozo.com/Yu Zozo/"
QUARTZ="$HOME/quartz"

if [ ! -d "$VAULT" ]; then
  echo "❌ Can't find the vault at:"
  echo "   $VAULT"
  echo "   (Did the folder move or get renamed? Update VAULT in $QUARTZ/publish.sh)"
  exit 1
fi

cd "$QUARTZ"
echo "📂 Copying notes from Obsidian..."
rsync -a --delete --exclude '.obsidian' --exclude '.DS_Store' "$VAULT" "content/Yu Zozo/"
echo "✅ Notes copied."

if [ "$1" = "preview" ]; then
  echo "👀 Check http://localhost:8080 (refresh with Cmd+Shift+R). Run 'yuzozo' when ready to publish."
  exit 0
fi

echo "🚀 Publishing to GitHub..."
npx quartz sync
echo "🎉 Done! yuzozo.com will update in about 2 minutes."
echo "   Progress: https://github.com/theyuzozo/library/actions"
