#!/bin/bash
echo -e "Deploying updates to GitHub..."
# setup constants
REPO="meakin.nl"
GH_REPO="github.com/jmeakin/${REPO}.git"
MSG=$(git log -1 --oneline)
git config --global user.email "jamesmeakin@gmail.com"
git config --global user.name "James Meakin"

git clone "https://$GH_REPO"
cd ${REPO}/themes
git clone https://github.com/digitalcraftsman/hugo-cactus-theme.git

cd ..
mkdir public
cd public
git clone "https://$GH_REPO"
git checkout gh-pages

# Build the project.
cd ..
hugo -t hugo-cactus-theme 

cd public
git add -A :/
git commit -a -m "via travis -- for $MSG"
git push "https://${GH_TOKEN}@${GH_REPO}" gh-pages > /dev/null 2>&1