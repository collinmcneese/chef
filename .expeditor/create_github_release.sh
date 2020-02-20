#!/bin/bash

set -euo pipefail

snap install --classic hub

RELEASE_TITLE=`grep -Pom1 '(?<=# )Chef Infra Client .*' RELEASE_NOTES.md`

wget https://github.com/dahlia/submark/releases/download/0.2.0/submark-linux-x86_64 -O submark

chmod 755 submark

echo -e "Chef Infra Client ${EXPEDITOR_VERSION}\n" > release_description.md

./submark --h1 "${RELEASE_TITLE}" --omit-heading RELEASE_NOTES.md >> release_description.md

hub release create --file release_description.md "v${EXPEDITOR_VERSION}"

rm release_description.md