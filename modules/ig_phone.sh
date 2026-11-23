#!/data/data/com.termux/files/usr/bin/bash

read -p "📱 Teléfono (con código país, ej +525512345678): " PHONE

python - "$PHONE" <<'PY'
import sys, requests, urllib.parse
from concurrent.futures import ThreadPoolExecutor
try:
    import phonenumbers as pn
    from phonenumbers import geocoder, carrier, timezone
except ImportError:
    print("❌ pip install phonenumbers"); sys.exit(1)

raw = sys.argv[1].strip()
try:
    num = pn.parse(raw, None)
except Exception as e:
    print(f"❌ Número inválido: {e}"); sys.exit(1)

print("\n════════ 📱 INFO DEL NÚMERO ════════")
print(f"  Válido:        {pn.is_valid_number(num)}")
print(f"  Formato int.:  {pn.format_number(num, pn.PhoneNumberFormat.INTERNATIONAL)}")
print(f"  E.164:         {pn.format_number(num, pn.PhoneNumberFormat.E164)}")
print(f"  País/Región:   {geocoder.description_for_number(num, 'es') or 'N/A'}")
print(f"  Operador:      {carrier.name_for_number(num, 'es') or 'N/A'}")
print(f"  Zona horaria:  {', '.join(timezone.time_zones_for_number(num))}")

e164 = pn.format_number(num, pn.PhoneNumberFormat.E164).replace("+", "")

print("\n════════ 🔎 BÚSQUEDAS EN INTERNET ════════")
searches = {
    "Instagram":     f"site:instagram.com \"{e164}\"",
    "Instagram+":    f"\"{raw}\" instagram",
    "Facebook":      f"site:facebook.com \"{e164}\"",
    "Facebook+":     f"\"{raw}\" facebook",
    "Google":        f"\"{raw}\"",
    "TrueCaller":    f"https://www.truecaller.com/search/{geocoder.description_for_number(num,'en').lower().replace(' ','-')}/{e164}",
    "WhatsApp":      f"https://wa.me/{e164}",
    "Telegram":      f"https://t.me/+{e164}",
    "Viber":         f"viber://chat?number={e164}",
}
for name, q in searches.items():
    if q.startswith("http"):
        print(f"  {name}:\n    → {q}")
    else:
        print(f"  {name}:\n    → https://www.google.com/search?q={urllib.parse.quote(q)}")

# Intentar avatar de WhatsApp/Telegram (pista visual)
print("\n════════ 🖼️  AVATARES PÚBLICOS ════════")
try:
    wa = requests.get(f"https://api.whatsapp.com/send?phone={e164}", timeout=10)
    if "profile" in wa.text.lower():
        print(f"  📷 Posible avatar WhatsApp: https://api.whatsapp.com/send?phone={e164}")
except Exception:
    pass

print(f"\n💡 Tip: abre los links de Instagram en el navegador e inicia sesión.")
print(f"   Si el perfil aparece asociado al número → match confirmado.")
PY
