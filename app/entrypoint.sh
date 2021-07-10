#!/bin/bash

for f in /startup-sequence/*; do
    (echo "Load sequence $f" && source "$f") || exit 1
done
