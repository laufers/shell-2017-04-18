#!/bin/bash

# Get the path of the directory that contains this script.
REPO_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "${REPO_PATH}"

COMMIT_MESSAGE=" - auto_push.sh"
DATE=$(date "+%Y-%m-%d")
while true; do
  bash make_html.sh
  git add *
  git commit -m "${DATE}${COMMIT_MESSAGE}"
  git push -u origin master
  sleep 10s
done
