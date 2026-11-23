#!/data/data/com.termux/files/usr/bin/bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MOD="$BASE_DIR/modules"

show_banner() {
    clear
    echo -e "\e[1;35m"
    cat << "EOF"
  ████████╗██╗  ██╗███████╗ ██████╗ 
  ╚══██╔══╝██║  ██║██╔════╝██╔═══██╗
     ██║   ███████║█████╗  ██║   ██║
     ██║   ██╔══██║██╔══╝  ██║   ██║
     ██║   ██║  ██║███████╗╚██████╔╝
     ╚═╝   ╚═╝  ╚═╝╚══════╝ ╚═════╝ 
        INSTAGRAM OSINT TOOL
EOF
    echo -e "\e[0m"
}

while true; do
    show_banner
    echo "  [1] 📱 Instagram por número de teléfono"
    echo "  [2] 👤 Instagram por nombre + apellido"
    echo "  [3] 🌍 Instagram por nombre + ciudad + país"
    echo "  [4] 🔎 Búsqueda cruzada (IG + FB + Google)"
    echo "  [0] ❌ Salir"
    echo
    read -p "👉 Opción: " opt

    case $opt in
        1) bash "$MOD/ig_phone.sh" ;;
        2) bash "$MOD/ig_person.sh" ;;
        3) bash "$MOD/ig_person.sh" ;;
        4) bash "$MOD/multi_search.sh" ;;
        0) echo "👋 Adiós"; exit 0 ;;
        *) echo "❌ Opción inválida"; sleep 1 ;;
    esac

    echo
    read -p "⏎ ENTER para continuar..."
done
