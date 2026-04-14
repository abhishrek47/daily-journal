#!/bin/bash
# Run this ONCE from your Terminal to store your GitHub token for automatic nightly pushes.
# After running this, you won't need to touch it again.

echo "Storing GitHub token for daily-journal auto-publish..."

# Get token from gh auth
GH_TOKEN=$(gh auth token 2>/dev/null)

if [ -z "$GH_TOKEN" ]; then
  echo "ERROR: gh auth token returned empty. Make sure you're logged in: gh auth status"
  exit 1
fi

# Store token securely in macOS keychain
git config --global credential.helper osxkeychain

# Configure the remote to use token
cd ~/Documents/daily-journal
git remote set-url origin "https://abhishrek47:${GH_TOKEN}@github.com/abhishrek47/daily-journal.git"

# Do the initial push
git push -u origin main

echo ""
echo "Done! GitHub token stored. Future auto-pushes will work."
echo "Site will be live at: https://abhishrek47.github.io/daily-journal"
echo ""
echo "Next: Go to github.com/abhishrek47/daily-journal → Settings → Pages"
echo "Set source to: Deploy from branch → main → / (root)"
