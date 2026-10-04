#!/bin/bash
# Remove antenne and its launcher.
DATA="${XDG_DATA_HOME:-$HOME/.local/share}"
rm -f "$HOME/.local/bin/antenne" "$DATA/applications/antenne.desktop"
update-desktop-database "$DATA/applications" 2>/dev/null || true
echo "Removed antenne."
