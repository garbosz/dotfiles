#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"
HOST=$(hostname)
PACKAGES=(niri noctalia kitty fish btop lazygit alacritty)

# make sure the nvim submodule is actually downloaded
git submodule update --init

# per-host niri files first, so niri never sees a missing include
if [ ! -d "hosts/$HOST" ]; then
    echo "No hosts/$HOST/ folder. Make one by copying an existing one:"
    ls hosts
    exit 1
fi
mkdir -p ~/.config/niri/cfg
for f in display autostart; do
    ln -sfn "$PWD/hosts/$HOST/$f.kdl" ~/.config/niri/cfg/$f.kdl
done

# then symlink everything else
stow --no-folding "${PACKAGES[@]}"
stow nvim

echo "Done. Linked configs for $HOST."
