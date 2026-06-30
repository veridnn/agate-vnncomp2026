#!/bin/bash
set -e

if [ -d "~/.cache/veridnn/$name/$version" ]; then
    rm -r ~/.cache/veridnn/$name/$version
fi

curl -L -O https://github.com/veridnn/agate/archive/refs/tags/2026.06.30.tar.gz
