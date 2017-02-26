#!/bin/bash
echo -e "Deploying updates to GitHub..."
# setup constants
REPO="meakin.nl"
GH_REPO="github.com/jmeakin/${REPO}.git"
MSG=$(git log -1 --oneline)
git config --global user.email "jamesmeakin@gmail.com"
git config --global user.name "James Meakin"

# Build the project.
hugo -t hugo-cactus-theme 

git clone "https://$GH_REPO"
# clean up repo
cd  ${REPO}
rm -rf *
cd ..
# copy files to commit
cp -R public/* ${REPO}
cd ${REPO}
git remote
git add -A :/
git commit -a -m "via travis -- for $MSG"
git push "https://${GH_TOKEN}@${GH_REPO}" master > /dev/null 2>&1