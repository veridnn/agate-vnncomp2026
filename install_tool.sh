#!/bin/bash
set -e

if [ -d "~/.cache/veridnn/$name/$version" ]; then
    rm -r ~/.cache/veridnn/$name/$version
fi

sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install -y python3.14 python3.14-venv python3.14-dev

curl -L -O https://github.com/veridnn/agate-vnncomp2026/releases/download/0.0.1a1.dev1/agate-vnnlib.0.0.1.tar.gz.gpg
