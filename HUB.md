# WLAN-Antennen ausrichten

<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 128 128" width="72" height="72" role="img" aria-label="Icon WLAN-Antennen ausrichten">
  <defs><linearGradient id="antbg" x1="0" y1="0" x2="1" y2="1"><stop offset="0" stop-color="#0f766e"/><stop offset=".55" stop-color="#0ea5e9"/><stop offset="1" stop-color="#6366f1"/></linearGradient></defs>
  <rect width="128" height="128" rx="28" fill="url(#antbg)"/>
  <g fill="none" stroke="#fff" stroke-width="6" stroke-linecap="round" stroke-linejoin="round">
    <rect x="30" y="86" width="68" height="18" rx="5"/>
    <line x1="46" y1="86" x2="34" y2="30"/><line x1="82" y1="86" x2="98" y2="34"/>
    <path d="M22 26 a18 18 0 0 1 22 -6" opacity=".7"/><path d="M90 22 a18 18 0 0 1 20 10" opacity=".7"/>
  </g>
  <circle cx="44" cy="95" r="3" fill="#8ef0a0"/><circle cx="56" cy="95" r="3" fill="#8ef0a0"/>
</svg>

Desktop-WLAN-Karten mit zwei Schraubantennen (z. B. Intel BE200 / AX210) nutzen **2 Datenströme** nur, wenn die Antennen gut stehen.
Sonst fällt die Karte still auf 1 Strom zurück: halbe Geschwindigkeit, mehr Wiederholungen, mehr Lag.
`antenne` zeigt live, ob eine Stellung besser oder schlechter ist – drehen, warten, ablesen.

```
  ANTENNEN-EINSTELLER  (wlan0)
  Wi-Fi 7 · 160 MHz Kanal · max. ca. 2880 Mbit/s pro Richtung
  Funkband     6 GHz (Kanal 37, 6135 MHz)

  PUNKTZAHL    3202   ███████████████████░░░░░░░░░░░
  Bestwert    3250

  Download    1601 Mbit/s  ███████████░░░░░░░░░  2 Ströme ✓  EHT-MCS 9
  Upload      1601 Mbit/s  ███████████░░░░░░░░░  2 Ströme ✓  EHT-MCS 9

  Antenne A   -52 dBm  ████████████░░░░░░░░
  Antenne B   -55 dBm  ███████████░░░░░░░░░
```
*(Beispielwerte)*

## Was es zeigt

- **Punktzahl** – Download- + Upload-Datenrate in Mbit/s, Mittel über 4 s, mit Verlauf und Bestwert
- **Ströme** pro Richtung – `2 Ströme ✓` ist das Ziel
- **Signal pro Antenne** (Kette A/B) in dBm, grün/gelb/rot
- **MCS-Verlauf** für Download und Upload (64-QAM … 4096-QAM, Anzahl Wechsel)
- **Band / Kanal** – bei Wi-Fi 7 MLO jede Verbindung
- **Tipp-Zeile** – z. B. „Nur 1 Strom → eine Antenne senkrecht, die andere waagerecht“

## Bedienung

- Starten: **WLAN Antenne** im App-Starter (<kbd>Super</kbd> + <kbd>Space</kbd>) oder `antenne`
- Antenne ein Stück drehen → Hände weg → ca. 5 s warten → Zahl ablesen
- <kbd>1</kbd>–<kbd>9</kbd> Stellung merken (die beste bekommt `◀ beste`), <kbd>r</kbd> zurücksetzen, <kbd>q</kbd> beenden

## Installieren

```bash
git clone https://github.com/vsvito420/omarchy-antenne.git
cd omarchy-antenne
./install.sh
```

Entfernen mit `./uninstall.sh`.

## So funktioniert's

- **Code:** [`antenne`](https://github.com/vsvito420/omarchy-antenne/blob/main/antenne) – nur Python-Standardbibliothek
- alle 0,5 s `iw dev <iface> station dump` (Raten, NSS, MCS, Signal pro Kette) und `iw dev <iface> info` (Kanäle, MLO-Links)
- ein Hintergrund-`ping` (1400 Byte, alle 50 ms) zum Standard-Gateway hält Verkehr am Laufen, damit die Raten aktuell bleiben
  - anderes Ziel: `ANTENNE_TARGET=<host> antenne`
- Management-Frames (6 Mbit/s, ohne MCS) werden ignoriert
- „max. ca.“ = Kanalbreite × 18 Mbit/s, ungefähr das Maximum eines 2×2-Clients
- **Voraussetzungen:** `python3`, `iw`, `ip`, `ping` – unter Omarchy alles dabei

<div class="callout tip" markdown="1">
Gute Startstellung: die Antennen **schräg zueinander**, nicht beide gleich und nicht 180° auseinander –
so bekommen meist beide Richtungen 2 Ströme. Die Antennen A/B gelten für alle Bänder (2,4 / 5 / 6 GHz) gemeinsam.
</div>

<div class="callout warning" markdown="1">
Hände und Körper verändern das Signal. Vor dem Ablesen zurücktreten und ein paar Sekunden warten.
</div>

## Siehe auch

- [[Omarchy]], [[Netzwerktechnik]]
- [[Fix my Scaling]]
