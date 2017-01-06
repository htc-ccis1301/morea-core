#!/bin/bash

if [ ! -d "./master" ]; then
  echo "master/ directory does not exist.  Exiting..."
  exit 1
fi

if [ ! -d "./gh-pages" ]; then
  echo "gh-pages/ directory does not exist.  Exiting..."
  exit 1
fi

if [ $# != 1 ]; then
    echo "morea-publish <git commit message>"
    exit 1
fi

echo "Sync gh-pages directory with GitHub repo before updating."
( set -x ; cd ./gh-pages ; git pull )

echo "Generating HTML site into gh-pages directory"
( set -x ; jekyll build --source ./master/src --destination ./gh-pages)

echo "Committing the gh-pages branch."
( set -x ; cd ./gh-pages ; git add --all . ; git commit -a -m "$1" ; git push origin gh-pages )

echo "Committing the master branch"
( set -x ; cd ./master ; git add --all . ; git commit -a -m "$1" ; git push origin master )
