#!/bin/bash
set -e

gpg --batch --yes --passphrase "$1" -d 2026.06.30.tar.gz | tar xz
