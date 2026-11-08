# JarvisOS ISO Builder

Automatischer Build einer bootfähigen JarvisOS Installations-ISO via GitHub Actions.

## 🚀 Quick Start

### 1. Repository auf GitHub erstellen

```bash
cd jarvisos-iso-builder
git init
git add .
git commit -m "Initial commit: JarvisOS ISO builder"
git branch -M main
git remote add origin https://github.com/DEIN-USERNAME/jarvisos-iso.git
git push -u origin main
```

### 2. GitHub Actions starten

- Gehe zu deinem Repository auf GitHub
- Klicke auf **Actions** Tab
- Klicke auf **Build JarvisOS ISO** Workflow
- Klicke auf **Run workflow** → **Run workflow**

### 3. ISO herunterladen (nach ~1-2 Stunden)

**Option A: Artifacts (7 Tage verfügbar)**
- Actions → Letzter Build → **Artifacts** → Download `jarvisos-iso`

**Option B: Releases (permanent)**
- Releases → Neuester Release → Download `jarvisos.iso`

## 📦 Was wird gebaut?

- **Basis**: Arch Linux (neueste Version)
- **Desktop**: Plasma/KDE
- **Display Manager**: SDDM
- **Vorinstalliert**: Firefox, Dolphin, Kate, Git
- **JarvisOS**: Automatisch integriert via `/root/install-jarvis.sh`
- **Größe**: ~2-3 GB ISO

## 🔧 Manuelle Anpassungen

### Packages hinzufügen

Bearbeite `build-iso.sh`, Zeile 20-30:

```bash
cat >> packages.x86_64 << 'EOF'
# Deine zusätzlichen Pakete
vim
htop
neofetch
EOF
```

### JarvisOS-Installation anpassen

Bearbeite `build-iso.sh`, Zeile 34-42 (install-jarvis.sh)

## 📋 Build-Prozess

1. **Setup** (5 min): archiso Profile erstellen
2. **Customize** (2 min): JarvisOS-Pakete hinzufügen
3. **Build** (30-60 min): mkarchiso kompiliert ISO
4. **Upload** (10 min): ISO wird zu GitHub Artifacts hochgeladen

**Gesamt**: ~1-1,5 Stunden

## 🖥️ Installation auf Zielrechner

1. ISO auf USB-Stick schreiben:
   - **Windows**: Rufus/Etcher
   - **Linux**: `dd if=jarvisos.iso of=/dev/sdX bs=4M status=progress`

2. Von USB booten

3. Nach Installation (optional):
   ```bash
   sudo /root/install-jarvis.sh
   ```

## ⚠️ Troubleshooting

### Build schlägt fehl mit "Out of disk space"
- GitHub Actions hat ~14 GB freien Speicher
- Workflow räumt bereits auf (dotnet, ghc, boost)
- Falls nötig: Packages in `build-iso.sh` reduzieren

### Docker-Fehler "Operation not permitted"
- `--privileged` Flag ist erforderlich für mkarchiso
- Bereits im Workflow enthalten

### ISO bootet nicht
- UEFI/Legacy BIOS Einstellung prüfen
- Secure Boot deaktivieren
- USB-Stick neu schreiben mit anderen Tool

## 📁 Projekt-Struktur

```
jarvisos-iso-builder/
├── .github/
│   └── workflows/
│       └── build-iso.yml    # GitHub Actions Workflow
├── Dockerfile               # Arch Linux Build-Umgebung
├── build-iso.sh            # ISO Build-Skript
└── README.md               # Diese Datei
```

## 🔗 Links

- [JarvisOS GitHub](https://github.com/JARVISOS/JARVIS)
- [Arch Linux ISO](https://archlinux.org/download/)
- [archiso Documentation](https://wiki.archlinux.org/title/Archiso)

## 📝 Lizenz

Dieses Build-Setup ist MIT-lizenziert. JarvisOS unterliegt seiner eigenen Lizenz.
