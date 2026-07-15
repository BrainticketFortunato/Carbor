# Versionierung in Carbor

Aktueller Stand: **1.0.3**

## Regel

Jede inhaltlich geänderte Datei erhält eine Versionsnummer im Dateinamen.
Das gilt insbesondere für:

- Pythoncode
- Hilfe
- rechtliche Hinweise
- Veröffentlichungs- und Paketierungsdokumente
- Skripte
- Release-Archive

Stabile Startdateien wie `src/carbor.py` bleiben absichtlich unversioniert.
Sie verweisen ausschließlich auf die aktuelle versionierte Programmdatei.

## Namensschema

- Python: `carbor_v103.py`
- Hilfe: `Carbor-Hilfe-1.0.3.html`
- Dokumente: `NAME-1.0.3.md`
- Projektarchiv: `Carbor-1.0.3-Quellprojekt.zip`

## Versionssprünge

- Fehlerkorrektur: 1.0.3 → 1.0.4
- neue kompatible Funktion: 1.0.x → 1.1.0
- inkompatible Hauptänderung: 1.x → 2.0.0
