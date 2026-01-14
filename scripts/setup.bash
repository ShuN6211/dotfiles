#!/usr/bin/env bash
set -eux
# shellcheck source=./scripts/common.bash
source "$(dirname "$0")/common.bash"

/bin/bash "$CUR_DIR/setup-apt.bash"
/bin/bash "$CUR_DIR/setup-homebrew.bash"
/bin/bash "$CUR_DIR/setup-links.bash"
/bin/bash "$CUR_DIR/setup-deno.bash"
/bin/bash "$CUR_DIR/setup-sheldon.bash"
/bin/bash "$CUR_DIR/setup-nvm.bash"

# Change login shell to zsh if available
if command -v zsh >/dev/null 2>&1; then
    echo "Changing login shell to zsh..."
    if [ "$(basename "$SHELL")" != "zsh" ]; then
        chsh -s "$(which zsh)" || {
            echo "Warning: Failed to change shell to zsh. You may need to run:"
            echo "  chsh -s \$(which zsh)"
            echo "or set it manually in your user settings."
        }
    fi
fi
