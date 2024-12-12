#!/usr/bin/env bash
set -x
# shellcheck source=./scripts/common.bash
source "$(dirname "$0")/common.bash"

echo "Installing nvm..."

if [[ ! -d "$XDG_DATA_HOME/nvm" ]]; then
    mkdir -p "$XDG_DATA_HOME/nvm"
fi

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
