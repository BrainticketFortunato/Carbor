# Carbor – GitHub-Automatisierung

## Ein Befehl für Einrichtung und spätere Releases

```bash
./scripts/github_publish.sh
```

Das Skript erledigt automatisch:

- einmalige GitHub-Anmeldung, falls nötig
- Ermittlung des GitHub-Benutzernamens
- lokales Git-Repository und Branch `main`
- lokale Git-Identität mit GitHub-Noreply-Adresse
- Syntaxprüfung der aktuellsten `src/carbor_v*.py`
- einfache Prüfung auf versehentlich enthaltene Zugangsdaten
- Anlegen oder Wiederverwenden des Repositorys `Carbor`
- Commit und Push
- annotierten Tag aus der Datei `VERSION`
- ZIP-Archiv aus dem tatsächlich eingecheckten Stand
- GitHub-Release mit Changelog
- Aktualisierung eines bereits vorhandenen Releases derselben Version

Standardmäßig wird ein öffentliches Repository namens `Carbor` verwendet.

Optionale Abweichungen ohne Bearbeitung des Skripts:

```bash
CARBOR_GITHUB_REPO=anderer-name ./scripts/github_publish.sh
CARBOR_GITHUB_VISIBILITY=private ./scripts/github_publish.sh
```

Bei einer neuen Veröffentlichung muss nur die Datei `VERSION` erhöht und ein passender
Changelog angelegt werden. Ein bereits vorhandener Tag darf nicht auf einen anderen
Programmstand verschoben werden.
