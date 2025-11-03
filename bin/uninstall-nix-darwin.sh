#!/usr/bin/env bash
set -eo pipefail

sudo nix --extra-experimental-features "nix-command flakes" run nix-darwin#darwin-uninstaller
rm -f $(which darwin-rebuild)
/nix/nix-installer uninstall
