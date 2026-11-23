#!/data/data/com.termux/files/usr/bin/bash

echo "📦 Instalando THEO TOOL..."
pkg update -y && pkg upgrade -y
pkg install -y python curl wget git jq

echo "🐍 Instalando Python deps..."
pip install -r requirements.txt

chmod +x theo.sh menu.sh modules/*.sh

echo "✅ Listo. Ejecuta: ./theo.sh"
