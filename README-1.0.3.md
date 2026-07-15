# Carbor

**Carbor** ist eine lokale Film- und Serienverwaltung für Linux. Das Programm verwaltet bestehende Medienordner, zeigt Inhalte als Kacheln, ergänzt technische Daten und Metadaten, verwaltet persönliche Markierungen und übergibt die Wiedergabe an VLC.

**Aktuelle Version:** 1.0.3

## Entwicklung

Carbor wurde gemeinsam von **BrainticketFortunato** und **OpenAI ChatGPT** entwickelt.

- **BrainticketFortunato:** Projektidee, Projektleitung, Anforderungen, Bedienkonzept, Funktionsentscheidungen, Praxistests, Qualitätskontrolle und Freigaben.
- **OpenAI ChatGPT:** technische Zusammenarbeit bei Architektur, Codeentwürfen, Fehlersuche, Optimierung, Dokumentation und Strukturierung.

## Kernfunktionen

- lokale Bibliothek ohne Medienserver
- Film- und Serienordner als Kachelansicht
- technische Analyse mit FFmpeg/ffprobe
- Metadaten und Poster über optionale Onlinedienste
- Favoriten, Bewertungen und Wiedergabefortschritt
- interne Playlists mit XSPF- und M3U8-Export
- exaktes Fortsetzen in der von Carbor gestarteten VLC-Instanz
- Scan-Zentrale, Fehlerprotokolle und Analyseberichte
- Dateimanager-Aufrufe ohne eigene Dateioperationen
- integrierte lokale HTML-Hilfe

## Voraussetzungen

```bash
sudo apt install python3 python3-gi gir1.2-gtk-3.0 ffmpeg vlc
```

## Start

```bash
python3 src/carbor.py
```

## Benutzerdaten

Aus Kompatibilitätsgründen bleiben die bestehenden Verzeichnisse erhalten:

```text
~/.config/film-browser/
~/.local/share/film-browser/
~/.cache/film-browser/
```

Diese Verzeichnisse können API-Schlüssel, Medienpfade und persönliche Daten enthalten und dürfen niemals in ein öffentliches Repository übernommen werden.

## Lizenz

Carbor ist freie Software unter **GPL-3.0-or-later**. Der vollständige Text steht in [LICENSE](LICENSE).

## Drittanbieter

Hinweise zu GTK, PyGObject, FFmpeg, VLC, TMDb, OMDb, Wikipedia/Wikidata und OpenAI stehen in [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).
