#!/usr/bin/env bash

set -e

git checkout main

git branch -D main-pub
git checkout --orphan main-pub

git apply --check --verbose patches/pub.patch
git apply --verbose patches/pub.patch

git apply --check --verbose patches/del.patch
git apply --verbose patches/del.patch

rm -rf patches/del.patch

git add .
git commit -m "public commit"
git push origin-pub main-pub -f

git checkout main