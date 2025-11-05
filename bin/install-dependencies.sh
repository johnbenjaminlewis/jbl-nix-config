#!/usr/bin/env bash
set -eo pipefail

DETERMINATE_NIX_INSTALLER="https://install.determinate.systems/nix"
HOMEBREW_INSTALLER="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"

url_script() {
  local url=$1
  local tmp
  shift

  tmp=$(mktemp)
  curl --proto '=https' --tlsv1.2 -sSf -L  > "$tmp"
  chmod +x "$tmp"
  "$tmp" "$@"
}

check_nix() {
    # Check if the 'nix-shell' command exists in the system's PATH.
    # We use 'command -v' which is a reliable way to check for executables.
    if command -v nix-shell &> /dev/null; then
      echo "🎉 Nix is already installed!"
      echo "You can run 'nix-shell --version' to see your Nix version."
    else
      echo "😞 Nix is not found on your system."
      return 1
    fi
}

check_nix_darwin() {
    if nix profile list | grep github:nix-darwin &> /dev/null; then
      echo "🎉 nix-darwin is already installed!"
    else
      echo "😞 nix-darwin is not found on your system."
      return 1
    fi
}

check_homebrew() {
    if which brew &> /dev/null; then
      echo "🎉 nix-darwin is already installed!"
    else
      echo "😞 nix-darwin is not found on your system."
      return 1
    fi
}

if ! check_nix; then
    url_script "$DETERMINATE_NIX_INSTALLER" install --no-confirm
fi

if ! check_nix_darwin; then
    echo "Installing nix-darwin in this profile"
    nix profile install github:nix-darwin/nix-darwin
fi

if ! check_homebrew; then
    echo "Installing homebrew in this profile"
    url_script "$HOMEBREW_INSTALLER"
fi

echo "You can run 'make build' (or 'sudo darwin-rebuild switch --flake .')"
