# Carbor

**Carbor** ist eine lokale Film- und Serienverwaltung für Linux. Das Programm verwaltet bestehende Medienordner direkt auf dem Rechner, zeigt Inhalte übersichtlich als Kacheln an, ergänzt technische Daten und Metadaten und übergibt die Wiedergabe an VLC.

> Carbor arbeitet lokal und benötigt keinen Medienserver wie Jellyfin oder Kodi.

## Aktueller Stand

**Version:** 1.0.8  
**Plattform:** Linux  
**Oberfläche:** GTK 3 / PyGObject  
**Wiedergabe:** VLC  
**Lizenz:** GPL-3.0-or-later

## Funktionen

- lokale Verwaltung vorhandener Film- und Serienordner
- Kachelansicht für Ordner, Filme, Serien, Staffeln und Episoden
- Vorschaubilder aus Videodateien
- technische Analyse über FFmpeg und ffprobe
- optionale Metadaten- und Postersuche über Onlinedienste
- intelligente Suche bei schwer zuzuordnenden Titeln
- Favoriten, Bewertungen und Wiedergabefortschritt
- Fortsetzen an der zuletzt gespeicherten Position
- interne Playlists sowie XSPF- und M3U8-Export
- Wiedergabe in einer von Carbor gestarteten VLC-Instanz
- Scan-Zentrale mit Fortschrittsanzeige und Abbruchmöglichkeit
- zentrale Fehlerprotokolle und Analyseberichte
- integrierte lokale HTML-Hilfe

## Voraussetzungen

Unter Linux Mint oder Ubuntu:

```bash
sudo apt install python3 python3-gi gir1.2-gtk-3.0 ffmpeg vlc
```

## Start

Die aktuelle Programmdatei liegt im Ordner `src`.

```bash
/usr/bin/python3 src/carbor_v108.py
```

Bei der Entwicklung wird Carbor direkt in VS Code über den Startpfeil gestartet. Als Interpreter wird verwendet:

```text
/usr/bin/python3
```

## Benutzerdaten

Carbor verwendet aus Kompatibilitätsgründen weiterhin die bereits bestehenden Verzeichnisse:

```text
~/.config/film-browser/
~/.local/share/film-browser/
~/.cache/film-browser/
```

Diese Verzeichnisse können Medienpfade, Einstellungen, API-Zugangsdaten und persönliche Bibliotheksdaten enthalten. Sie gehören nicht in das öffentliche Git-Repository.

## Optionale Onlinedienste

Einige Funktionen können optionale externe Dienste verwenden, beispielsweise:

- TMDb
- OMDb
- Wikipedia und Wikidata
- OpenAI

Carbor funktioniert grundsätzlich als lokale Medienverwaltung. Zugangsdaten zu optionalen Diensten werden nicht im Quellcode veröffentlicht.

## Projektstruktur

```text
Carbor/
├── assets/          Grafiken und Programmsymbole
├── docs/            zusätzliche Dokumentation
├── help/            lokale HTML-Hilfe
├── packaging/       Vorbereitungen für Programmpakete
├── scripts/         Prüf-, Veröffentlichungs- und Hilfsskripte
├── src/             Python-Programmcode
├── LICENSE
├── README.md
├── requirements.txt
└── VERSION
```

## Entwicklung

Carbor wurde gemeinsam von **BrainticketFortunato** und **OpenAI ChatGPT** entwickelt.

**BrainticketFortunato**

- Projektidee und Projektleitung
- Anforderungen und Bedienkonzept
- Funktionsentscheidungen
- Praxistests und Qualitätskontrolle
- Freigabe der Versionen

**OpenAI ChatGPT**

- technische Zusammenarbeit
- Architektur und Codeentwürfe
- Fehlersuche und Optimierung
- Dokumentation und Projektstruktur

## Veröffentlichung

Neue Versionen können über das mitgelieferte Skript veröffentlicht werden:

```bash
./scripts/github_publish.sh
```

Das Skript führt unter anderem Syntaxprüfung, Commit, Push, Tag-Erstellung und GitHub-Release aus.

## Datenschutz

Carbor ist für die lokale Nutzung ausgelegt. Bibliotheksdaten und Medien bleiben grundsätzlich auf dem eigenen Rechner. Weitere Hinweise stehen in [PRIVACY.md](PRIVACY.md).

## Lizenz

Carbor ist freie Software unter der Lizenz **GNU General Public License v3.0 or later**.

Der vollständige Lizenztext steht in [LICENSE](LICENSE).

## Drittanbieter

Hinweise zu verwendeten Programmen, Bibliotheken und Diensten stehen in den Dateien zu Drittanbieterhinweisen im Projekt.
