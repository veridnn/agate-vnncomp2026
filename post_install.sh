#!/bin/bash
set -e

gpg --batch --yes --passphrase "$1" -d agate-vnnlib.0.0.1.tar.gz.gpg | tar xz
python3 -m venv .venv
.venv/bin/pip install --upgrade pip
cd agate-vnnlib.0.0.1
../.venv/bin/pip install .
