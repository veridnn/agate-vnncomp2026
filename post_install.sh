#!/bin/bash
set -e

gpg --batch --yes --passphrase "$1" -d agate-vnnlib.0.0.1.tar.gz.gpg | tar xz
python3.14 -m venv $HOME/.venv
$HOME/.venv/bin/pip install --upgrade pip
cd agate-vnnlib.0.0.1
$HOME/.venv/bin/pip install -e ".[cuda13]"
$HOME/.venv/bin/agate --version
