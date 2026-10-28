#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
PYTHONPATH=src python -m gbt_art_chain info
PYTHONPATH=src python -m gbt_art_chain check --payload '{}'
PYTHONPATH=src python -m gbt_art_chain run   --payload '{}'
