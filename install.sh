#!/bin/bash
# Install antenne for the current user:
#   ~/.local/bin/antenne                      command
#   ~/.local/share/applications/antenne.desktop  launcher "WLAN Antenne" (Super + Space)
set -e
SRC="$(cd "$(dirname "$0")" && pwd)"
DATA="${XDG_DATA_HOME:-$HOME/.local/share}"
BIN="$HOME/.local/bin"

for cmd in python3 iw ip ping; do
  command -v "$cmd" >/dev/null || { echo "Missing: $cmd (sudo pacman -S iw iproute2 iputils python)"; exit 1; }
done

mkdir -p "$BIN" "$DATA/applications"
install -m 755 "$SRC/antenne" "$BIN/antenne"
sed "s|@BIN@|$BIN|" "$SRC/antenne.desktop" >"$DATA/applications/antenne.desktop"
update-desktop-database "$DATA/applications" 2>/dev/null || true

echo "Installed antenne."
echo "Open it from the app launcher (Super + Space → \"WLAN Antenne\") or run: antenne"
