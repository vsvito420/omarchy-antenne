<div align="center">

# 📡 omarchy-antenne

**WLAN-Antennen richtig ausrichten: Live-Punktzahl im Terminal, drehen, warten, ablesen.**
Für [Omarchy](https://omarchy.org) / jedes Linux mit `iw`.

[![Omarchy](https://img.shields.io/badge/Omarchy-Hyprland-1793d1?style=for-the-badge&logo=archlinux&logoColor=white)](https://omarchy.org)
[![Python](https://img.shields.io/badge/Python-nur_stdlib-3776ab?style=for-the-badge&logo=python&logoColor=white)](#voraussetzungen)
[![Lizenz: MIT](https://img.shields.io/badge/Lizenz-MIT-green?style=for-the-badge)](LICENSE)
[![English](https://img.shields.io/badge/read_me-English-black?style=for-the-badge)](README.md)

</div>

---

## Warum?

Desktop-WLAN-Karten mit zwei Schraubantennen (z. B. Intel BE200 / AX210) nutzen **2 Datenströme** nur, wenn die Antennen gut stehen.
Stehen sie schlecht, fällt die Karte still auf 1 Strom zurück: halbe Geschwindigkeit, mehr Wiederholungen, mehr Lag.
Die Signalstärke (dBm) allein verrät das nicht. Datenrate und Anzahl der Ströme schon.

## Was es zeigt

```
  ANTENNEN-EINSTELLER  (wlan0)
  Wi-Fi 7 · 160 MHz Kanal · max. ca. 2880 Mbit/s pro Richtung
  Funkband     6 GHz (Kanal 37, 6135 MHz)

  PUNKTZAHL    3202   ███████████████████░░░░░░░░░░░
  Verlauf     ▅▆▆▇▇▇▇██
  Bestwert    3250

  Download    1601 Mbit/s  ████████████░░░░░░░░  2 Ströme ✓  EHT-MCS 9
  Upload      1601 Mbit/s  ████████████░░░░░░░░  2 Ströme ✓  EHT-MCS 9

  Antenne A   -52 dBm  ████████████░░░░░░░░
  Antenne B   -55 dBm  ███████████░░░░░░░░░
```
*(Beispielwerte)*

- 🎯 **Punktzahl** = Download- + Upload-Datenrate (Mbit/s), Mittel über 4 s. Größer ist besser.
- 🟢 **Ströme** pro Richtung: `2 Ströme ✓` ist das Ziel.
- 📶 **Signal pro Antenne** (Kette A/B) in dBm.
- 📊 **MCS-Verlauf** für Download und Upload (Modulation: 64-QAM … 4096-QAM).
- 📻 **Band / Kanal**, bei Wi-Fi 7 MLO jede Verbindung.
- 💡 Tipp-Zeile: *„Nur 1 Strom → eine Antenne senkrecht, die andere waagerecht“*.

## Bedienung

1. Starten: **Super + Leertaste → „WLAN Antenne“** oder `antenne`.
2. Antenne ein Stück drehen → Hände weg → ca. 5 Sekunden warten → Zahl ablesen.
3. Mit **1–9** eine Stellung merken. Die beste bekommt `◀ beste`.
4. `r` setzt zurück, `q` beendet.

Hände und Körper verändern das Signal, also vor dem Ablesen zurücktreten.

## Installieren

```bash
git clone https://github.com/vsvito420/omarchy-antenne
cd omarchy-antenne
./install.sh
```

Entfernen mit `./uninstall.sh`.

## Voraussetzungen

`python3` (nur Standardbibliothek), `iw`, `ip`, `ping`. Unter Omarchy alles vorhanden.

## So funktioniert's

- Alle 0,5 s: `iw dev <iface> station dump` (Datenraten, NSS, MCS, Signal pro Antenne) und `iw dev <iface> info` (Kanäle / MLO-Links).
- Ein Hintergrund-`ping` (1400 Byte, alle 50 ms) zum Standard-Gateway sorgt für Verkehr, damit die Raten aktuell bleiben.
  Mit `ANTENNE_TARGET=<host>` pingt es etwas anderes.
- Management-Frames (6 Mbit/s, ohne MCS) werden ignoriert.
- „max. ca.“ = Kanalbreite × 18 Mbit/s, ungefähr das Maximum eines 2×2-Clients.

## Lizenz

MIT
