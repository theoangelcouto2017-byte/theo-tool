#!/data/data/com.termux/files/usr/bin/bash

read -p "👤 Username de Instagram (sin @): " U

python - "$U" <<'PY'
import sys, requests, re
u = sys.argv[1].strip().lstrip("@")
url = f"https://www.instagram.com/{u}/"
print(f"\n🔍 Consultando {url}\n")
try:
    r = requests.get(url, headers={"User-Agent": "Mozilla/5.0"}, timeout=10)
    if r.status_code != 200 or "Page Not Found" in r.text:
        print("❌ No encontrado"); sys.exit()
    print("\033[1;32m[+] Perfil existe\033[0m")
    m = re.search(r'"description":"(.*?)"', r.text)
    if m:
        print(f"📝 {m.group(1)[:300]}")
    followers = re.search(r'"edge_followed_by":\{"count":(\d+)\}', r.text)
    if followers:
        print(f"👥 Seguidores: {followers.group(1)}")
except Exception as e:
    print(f"⚠️ {e}")
PY
