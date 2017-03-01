#!/bin/bash
echo -e "Deploying updates to GitHub..."
# setup constants
REPO="meakin.nl"
GH_REPO="github.com/jmeakin/${REPO}.git"
PUB_REPO="github.com/jmeakin/jmeakin.github.io.git" 
MSG=$(git log -1 --oneline)
git config --global user.email "jamesmeakin@gmail.com"
git config --global user.name "James Meakin"

git clone "https://$GH_REPO"
cd ${REPO}/themes
git clone https://github.com/digitalcraftsman/hugo-cactus-theme.git

# Remove the old publications
cd ..
rm -rf public

git clone "https://$PUB_REPO" public

# Remove the existing files
rm -rf public/*
echo ${REPO} > public/CNAME

# Build the project.
hugo

cd public
git add --all
git commit -a -m "via travis -- for $MSG"
git push "https://${GH_TOKEN}@${PUB_REPO}" > /dev/null 2>&1