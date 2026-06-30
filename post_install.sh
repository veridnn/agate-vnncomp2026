#!/bin/bash
set -e

gpg --batch --yes --passphrase "$1" -d agate-vnnlib.0.0.1.tar.gz.gpg | tar xz
cp agate-vnnlib.0.0.1/agate .
