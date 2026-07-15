# Windows-Port

Eine Windows-EXE ist möglich, aber kein einfacher Export der GTK-Linux-Fassung. Plattformabhängig sind unter anderem XDG-Pfade, `fcntl`, D-Bus, `xdg-open`, Unix-Prozessgruppen, WM_CLASS und Linux-Sensoren.

Empfohlener Weg:

1. Programmlogik von GTK und Linux-Hilfsfunktionen trennen.
2. Plattformmodul für Linux und Windows einführen.
3. Windows-Pfade über APPDATA/LOCALAPPDATA verwenden.
4. Dateimanageraufruf durch `explorer.exe /select,` ersetzen.
5. Ein-Instanz-Sperre über Windows-Mutex umsetzen.
6. VLC/FFmpeg unter Windows suchen und testen.
7. Oberfläche langfristig auf PySide6/Qt portieren oder GTK-Runtime vollständig bündeln.
8. Build in einer echten Windows-VM mit PyInstaller oder Nuitka erzeugen.
9. Installer und Signierung getrennt behandeln.

Die Windows-Fassung sollte erst nach Stabilisierung der Linux-1.x-Reihe begonnen werden.
