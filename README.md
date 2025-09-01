# Claude Desktop for Debian/Ubuntu Linux

A security-focused fork that creates **Debian packages (.deb)** for Claude Desktop on Linux systems. This project takes the Windows Claude Desktop installer and adapts it for Debian-based distributions by replacing Windows-specific components with Linux-compatible implementations.

**Originally forked from:** [aaddrick/claude-desktop-debian](https://github.com/aaddrick/claude-desktop-debian) and [joshuacox/claude-desktop-appimage](https://github.com/joshuacox/claude-desktop-appimage)

## Features

- ✅ **Full MCP (Model Context Protocol) Support**
- ✅ **System Tray Integration** 
- ✅ **Ctrl+Alt+Space Global Popup**
- ✅ **Wayland & X11 Support**
- ✅ **Desktop Integration** (icons, menu entries, file associations)
- ✅ **SHA256 Checksum Verification** for security
- ✅ **Docker-based Reproducible Builds**

Claude Desktop PoPOS Launcher
![Claude Desktop PoPOS Launcher](https://github.com/user-attachments/assets/0b7c9510-adc8-4ea4-8ffe-a444e19dbae8)
Claude Desktop running on PoPOS Linux
![Claude Desktop running on PoPOS Linux](https://github.com/user-attachments/assets/bf128447-bc8b-45a9-8677-0a79abc0d5c2)

## Quick Start (Docker - Recommended)

The Docker method works on any Linux distribution and provides reproducible builds:

```bash
# Clone this repository
git clone https://github.com/yousshark/claude-desktop-debian.git
cd claude-desktop-debian

# Build Debian package using Docker
./docker-builder.sh --build deb

# Install the generated package
sudo apt install ./output/claude-desktop_*.deb
```

## Manual Build (Debian/Ubuntu)

For native builds on Debian-based systems:

```bash
# Clone this repository
git clone https://github.com/yousshark/claude-desktop-debian.git
cd claude-desktop-debian

# Build Debian package
./build.sh --build deb

# Install the generated package
sudo dpkg -i ./claude-desktop_*.deb

# Fix any dependency issues if needed
sudo apt --fix-broken install
```

## Installation Options

### Option 1: Install Debian Package

After building, install with:

```bash
sudo apt install ./output/claude-desktop_*.deb
```

**Benefits:**
- Full system integration
- Automatic dependency management
- Easy updates and removal
- Proper desktop file associations

### Option 2: Direct Package Installation

```bash
sudo dpkg -i ./claude-desktop_*.deb
sudo apt --fix-broken install  # If dependencies are missing
```

## Configuration

### MCP Configuration

Claude Desktop supports MCP (Model Context Protocol). Configuration file location:
```
~/.config/Claude/claude_desktop_config.json
```

### Runtime Logs

Application logs are stored in:
```
~/claude-desktop-launcher.log
```

## Uninstallation

### Remove Package
```bash
sudo dpkg -r claude-desktop
```

### Remove Package + Configuration
```bash
sudo dpkg -P claude-desktop
rm -rf ~/.config/Claude  # Remove user settings
```

## Troubleshooting

### Window Scaling Issues
If the window doesn't scale correctly initially:
1. Right-click the taskbar icon
2. Select "Quit" (don't force-kill)
3. Restart the application

This saves the window state to `~/.config/Claude/` and resolves scaling issues.

### Build Issues

**SHA256 Checksum Mismatch:**
```bash
# The build script automatically uses current checksums, but if you encounter issues:
# Check build.sh lines 2-3 for the expected hashes
```

**Missing Dependencies:**
```bash
# The build script auto-installs dependencies, but you can manually install:
sudo apt update
sudo apt install curl file p7zip-full wget icoutils imagemagick nodejs npm dpkg-dev
```

## How It Works

Claude Desktop is an Electron application. This build process:

1. **Downloads** the official Windows Claude Desktop installer
2. **Verifies** SHA256 checksum for security
3. **Extracts** app.asar and resources using 7zip
4. **Replaces** Windows-specific native module with Linux stub
5. **Patches** JavaScript for Linux title bar support
6. **Bundles** Electron runtime locally
7. **Creates** proper Debian package with desktop integration

## Architecture Support

- **amd64** (x86_64) - Primary support
- **arm64** (aarch64) - Supported

## Security Features

- SHA256 checksum verification of downloads
- No execution as root during build
- Official Claude Desktop source files only
- Transparent build process with full source visibility

## Docker Build Details

The Docker build:
- Uses Debian Trixie base image
- Installs all dependencies in isolated environment
- Ensures reproducible builds across different host systems
- Outputs final package to `./output/` directory

## System Requirements

- Debian-based distribution (Debian, Ubuntu, Pop!_OS, Linux Mint, etc.)
- Modern Node.js and npm (auto-installed if missing)
- ~500MB free disk space during build
- ~100MB for final installed package

## Contributing

This is a security-focused fork. Contributions should:
- Maintain or improve security posture
- Keep the build process transparent
- Focus on Debian package creation only
- Include proper testing

## License

The build scripts are dual-licensed under MIT and Apache License (Version 2.0).
- See [LICENSE-MIT](LICENSE-MIT) and [LICENSE-APACHE](LICENSE-APACHE)
- Claude Desktop application is covered by [Anthropic's Consumer Terms](https://www.anthropic.com/legal/consumer-terms)

## Acknowledgments

- **k3d3**: Original Linux Claude Desktop implementation for NixOS
- **aaddrick**: Original Debian build scripts
- **emsi**: Title bar fix and alternative implementation
- **Anthropic**: Claude Desktop application

---

**Disclaimer:** This is an unofficial build script. For issues with the build process, please open an issue here. Don't contact Anthropic about build-related problems.