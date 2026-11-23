#!/data/data/com.termux/files/usr/bin/bash

read -p "👤 Nombre: " FIRST
read -p "👤 Apellido: " LAST
read -p "🏙️  Ciudad (opcional, ENTER para omitir): " CITY
read -p "🌎 País (opcional, ENTER para omitir): " COUNTRY

python - "$FIRST" "$LAST" "$CITY" "$COUNTRY" <<'PY'
import sys, urllib.parse
first, last, city, country = (sys.argv[1].strip(), sys.argv[2].strip(),
                              sys.argv[3].strip(), sys.argv[4].strip())
full = f"{first} {last}".strip()
loc  = ", ".join(x for x in [city, country] if x)
tag  = f"{full} {loc}".strip()

print(f"\n🔍 Buscando: {tag}\n")

# Generar variaciones de username
variants = set()
base = [first.lower(), last.lower()]
variants.update([
    f"{first.lower()}{last.lower()}",
    f"{first.lower()}.{last.lower()}",
    f"{first.lower()}_{last.lower()}",
    f"{first[0].lower()}{last.lower()}",
    f"{first.lower()}{last[0].lower()}",
])

print("════════ 🧠 USERNAMES PROBABLES EN INSTAGRAM ════════")
for v in sorted(variants):
    print(f"  → https://instagram.com/{v}")

print("\n════════ 🔎 GOOGLE DORKS ════════")
dorks = [
    ("Instagram",        f"site:instagram.com \"{tag}\""),
    ("Instagram+City",   f"site:instagram.com \"{full}\" \"{city}\"" if city else None),
    ("Facebook",         f"site:facebook.com \"{tag}\""),
    ("Facebook+City",    f"site:facebook.com \"{full}\" \"{city}\"" if city else None),
    ("Twitter/X",        f"site:twitter.com \"{tag}\""),
    ("TikTok",           f"site:tiktok.com \"{tag}\""),
    ("LinkedIn",         f"site:linkedin.com/in \"{tag}\""),
    ("Google general",   f"\"{tag}\""),
    ("PDF/DOCX",         f"\"{tag}\" (filetype:pdf OR filetype:docx)"),
    ("Emails+Nombre",    f"\"{full}\" (email OR gmail OR hotmail) \"{city}\"" if city else f"\"{full}\" email"),
]
for name, q in dorks:
    if q:
        print(f"  {name}:\n    → https://www.google.com/search?q={urllib.parse.quote(q)}")

print("\n════════ 🔗 BÚSQUEDA DIRECTA INSTAGRAM ════════")
ig_q = urllib.parse.quote(full)
print(f"  → https://www.instagram.com/web/search/topsearch/?query={ig_q}")
print(f"  → https://www.instagram.com/explore/tags/{first.lower()}{last.lower()}/")
if city:
    print(f"  → https://www.instagram.com/explore/tags/{city.lower().replace(' ','')}/")

print("\n════════ 🌐 OTRAS PLATAFORMAS ════════")
others = {
    "Facebook search": f"https://www.facebook.com/search/top?q={urllib.parse.quote(tag)}",
    "Twitter search":  f"https://twitter.com/search?q={urllib.parse.quote(tag)}",
    "TikTok search":   f"https://www.tiktok.com/search?q={urllib.parse.quote(tag)}",
    "LinkedIn search": f"https://www.linkedin.com/search/results/people/?keywords={urllib.parse.quote(tag)}",
    "Google Images":   f"https://www.google.com/search?tbm=isch&q={urllib.parse.quote(tag)}",
    "Yandex People":   f"https://yandex.com/search/?text={urllib.parse.quote(tag)}",
    "Bing":            f"https://www.bing.com/search?q={urllib.parse.quote(tag)}",
}
for name, url in others.items():
    print(f"  {name}:\n    → {url}")
PY
