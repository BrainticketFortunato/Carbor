# Installation aus dem Quellprojekt

## Voraussetzungen

Unter Linux Mint, Ubuntu oder einer vergleichbaren Debian-basierten Distribution:

```bash
sudo apt install python3 python3-gi gir1.2-gtk-3.0 ffmpeg vlc
```

## Start

```bash
/usr/bin/python3 src/carbor_v108.py
```

In VS Code wird `src/carbor_v108.py` direkt über den Startpfeil ausgeführt.  
Der Projektinterpreter ist fest auf `/usr/bin/python3` eingestellt.

Vorhandene API-Schlüssel, Einstellungen und Bibliotheksdaten bleiben in den bisherigen
XDG-Verzeichnissen unter `film-browser` gespeichert und gehören nicht ins Repository.
