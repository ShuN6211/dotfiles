#!/usr/bin/env bash
# shellcheck source=./scripts/common.bash
source "$(dirname "$0")/common.bash"

command -v apt-get >/dev/null || exit 0
[ -z "${SKIP_APT:-}" ] || exit 0

sudo /bin/sh "$REPO_DIR/config/apt/install.sh"
