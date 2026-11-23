#!/data/data/com.termux/files/usr/bin/bash
# THEO TOOL launcher

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v python &>/dev/null; then
    echo "❌ Python no instalado. Ejecuta ./install.sh"
    exit 1
fi

bash "$BASE_DIR/menu.sh"
