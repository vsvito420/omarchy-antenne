<div align="center">

# 📡 omarchy-antenne

**Point your Wi-Fi antennas the right way: a live score in the terminal, turn, wait, read.**
For [Omarchy](https://omarchy.org) / any Linux with `iw`. The UI is German.

[![Omarchy](https://img.shields.io/badge/Omarchy-Hyprland-1793d1?style=for-the-badge&logo=archlinux&logoColor=white)](https://omarchy.org)
[![Python](https://img.shields.io/badge/Python-stdlib_only-3776ab?style=for-the-badge&logo=python&logoColor=white)](#requirements)
[![License: MIT](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)
[![Deutsch](https://img.shields.io/badge/lies_mich-Deutsch-black?style=for-the-badge)](README.de.md)

</div>

---

## Why?

Desktop Wi-Fi cards with two screw-on antennas (e.g. Intel BE200 / AX210) can only use **2 spatial streams** when the antennas are angled well.
Point them badly and the card silently drops to 1 stream: half the speed, more retries, more lag.
Signal strength (dBm) alone doesn't tell you that. The PHY rate and the number of streams do.

## What it shows

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
*(example values)*

- 🎯 **Score** = download + upload PHY rate (Mbit/s), averaged over 4 s. Bigger is better.
- 🟢 **Streams** per direction: `2 Ströme ✓` is what you want.
- 📶 **Signal per antenna** (chain A/B) in dBm.
- 📊 **MCS history** for download and upload (modulation: 64-QAM … 4096-QAM).
- 📻 **Band / channel**, including every link of a Wi-Fi 7 MLO connection.
- 💡 A tip line: *"only 1 stream → try one antenna vertical, the other horizontal"*.

## How to use

1. Start it: **Super + Space → "WLAN Antenne"**, or run `antenne`.
2. Turn an antenna a bit → hands off → wait ~5 seconds → read the score.
3. Press **1–9** to remember a position. The best one is marked `◀ beste`.
4. `r` resets, `q` quits.

Hands and body change the signal, so always step back before you read.

## Install

```bash
git clone https://github.com/vsvito420/omarchy-antenne
cd omarchy-antenne
./install.sh
```

Remove with `./uninstall.sh`.

## Requirements

`python3` (stdlib only), `iw`, `ip`, `ping`. All present on Omarchy.

## How it works

- Every 0.5 s: `iw dev <iface> station dump` (bitrates, NSS, MCS, per-chain signal) and `iw dev <iface> info` (channels / MLO links).
- A background `ping` (1400 bytes, every 50 ms) to the default gateway keeps traffic flowing, so the rates stay current.
  Set `ANTENNE_TARGET=<host>` to ping something else.
- Management frames (6 Mbit/s, no MCS) are ignored.
- "max. ca." = channel width × 18 Mbit/s, roughly the top rate of a 2×2 client.

## License

MIT
