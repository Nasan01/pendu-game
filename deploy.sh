#!/usr/bin/env sh

set -e

npm run build

cd dist

git init
git add -A
git commit -m "First deployement test"
git push -f git@github.com:Nasan01/pendu-game.git master:gh-pages

cd -