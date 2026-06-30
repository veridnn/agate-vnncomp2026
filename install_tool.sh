#!/bin/bash
set -e

if [ -d "~/.cache/veridnn/$name/$version" ]; then
    rm -r ~/.cache/veridnn/$name/$version
fi

curl -L -O https://github.com/veridnn/agate-vnncomp2026/releases/download/0.0.1a1.dev1/agate-vnnlib.0.0.1.tar.gz.gpg
