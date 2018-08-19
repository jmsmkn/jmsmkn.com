#!/bin/bash
echo -e "Deploying updates to GitHub..."
# setup constants
REPO="jmsmkn.com"
GH_REPO="github.com/jmsmkn/${REPO}.git"
PUB_REPO="github.com/jmsmkn/jmsmkn.github.io.git" 
MSG=$(git log -1 --oneline)
git config --global user.email "jamesmeakin@gmail.com"
git config --global user.name "James Meakin"

git clone --recursive "https://$GH_REPO"

# Remove the avatars
rm themes/hugo-cactus-theme/static/images/avatar.png
rm themes/hugo-cactus-theme/static/images/avatar@2x.png

# Remove the old publications
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
