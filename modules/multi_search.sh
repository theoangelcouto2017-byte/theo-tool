#!/data/data/com.termux/files/usr/bin/bash

read -p "🔎 Nombre completo / término: " NAME
read -p "🏙️  Ciudad (opcional): " CITY

python - "$NAME" "$CITY" <<'PY'
import sys, urllib.parse, requests

name = sys.argv[1].strip()
city = sys.argv[2].strip() if len(sys.argv) > 2 else ""
tag  = f"{name} {city}".strip()
q    = urllib.parse.quote(tag)

print(f"\n🔎 Búsqueda cruzada: {tag}\n")

# Listado de motores con URLs directas
engines = [
    ("Instagram perfil",  f"https://www.instagram.com/{name.replace(' ','').lower()}/"),
    ("Instagram search",  f"https://www.instagram.com/web/search/topsearch/?query={q}"),
    ("Facebook search",   f"https://www.facebook.com/search/top?q={q}"),
    ("Twitter/X",         f"https://twitter.com/search?q={q}"),
    ("TikTok",            f"https://www.tiktok.com/search?q={q}"),
    ("LinkedIn",          f"https://www.linkedin.com/search/results/all/?keywords={q}"),
    ("GitHub",            f"https://github.com/search?q={q}&type=users"),
    ("Pinterest",         f"https://www.pinterest.com/search/users/?q={q}"),
    ("Reddit",            f"https://www.reddit.com/search/?q={q}"),
    ("YouTube",           f"https://www.youtube.com/results?search_query={q}"),
    ("Google",            f"https://www.google.com/search?q={q}"),
    ("Google Images",     f"https://www.google.com/search?tbm=isch&q={q}"),
    ("Bing",              f"https://www.bing.com/search?q={q}"),
    ("Yandex",            f"https://yandex.com/search/?text={q}"),
    ("DuckDuckGo",        f"https://duckduckgo.com/?q={q}"),
]

print("════════ 🌐 ENLACES DE BÚSQUEDA ════════")
for name_p, url in engines:
    print(f"  {name_p}:\n    → {url}")

# Verificación rápida de existencia en Instagram (best-effort)
uname = name.replace(" ", "").lower()
print("\n════════ ✔️  CHEQUEO RÁPIDO INSTAGRAM ════════")
try:
    r = requests.get(
        f"https://www.instagram.com/{uname}/",
        headers={"User-Agent": "Mozilla/5.0"},
        timeout=8,
        allow_redirects=True,
    )
    if r.status_code == 200 and "Page Not Found" not in r.text:
        print(f"  \033[1;32m[+] Posible perfil: https://instagram.com/{uname}\033[0m")
    else:
        print(f"  \033[1;33m[-] /{uname} no parece existir. Prueba variantes.\033[0m")
except Exception as e:
    print(f"  ⚠️  {e}")

print("\n💡 Consejo: abre los links en el navegador. Instagram bloquea scraping duro,")
print("   pero el buscador interno + Google dorks te dan casi todo gratis.")
PY
