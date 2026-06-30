#!/bin/bash
set -e

if [ -d "~/.cache/veridnn/$name/$version" ]; then
    rm -r ~/.cache/veridnn/$name/$version
fi

curl -L -O https://github.com/veridnn/agate-vnncomp2026/releases/download/2026.06.30/agate-vnnlib.0.0.1.tar.gz.gpg_part_0
curl -L -O https://github.com/veridnn/agate-vnncomp2026/releases/download/2026.06.30/agate-vnnlib.0.0.1.tar.gz.gpg_part_1
curl -L -O https://github.com/veridnn/agate-vnncomp2026/releases/download/2026.06.30/agate-vnnlib.0.0.1.tar.gz.gpg_part_2
curl -L -O https://github.com/veridnn/agate-vnncomp2026/releases/download/2026.06.30/agate-vnnlib.0.0.1.tar.gz.gpg_part_3

cat agate-vnnlib.0.0.1.tar.gz.gpg_part_* > agate-vnnlib.0.0.1.tar.gz.gpg
