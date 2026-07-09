# cli-tools

Installiert eine Sammlung nützlicher CLI-Tools.

## Enthaltene Tools

| Tool | Beschreibung | Standard-Installation |
|------|--------------|----------------------|
| **bat** | Modernes `cat` mit Syntax-Highlighting | `apt install bat` |
| **zoxide** | Smartes `cd`, lernt deine Gewohnheiten | `apt install zoxide` (Ubuntu 22.04+) |
| **eza** | Modernes `ls` mit Farben und Icons | [Offizieller Installer](https://github.com/eza-community/eza) oder `cargo install eza` |
| **fd-find** | Schnellerer `find`-Ersatz | `apt install fd-find` |
| **fzf** | Fuzzy Finder für interaktive Suche | `apt install fzf` |
| **ripgrep** | Ultra-schneller `grep`-Ersatz | `apt install ripgrep` |
| **atuin** | Shell-History mit Sync und Suche | [Setup Script](https://github.com/atuinsh/atuin) oder `apt install atuin` (Ubuntu 23.10+) |
| **uv** | Ultra-schneller Python-Paketmanager | [Offizieller Installer](https://astral.sh/uv) |
| **tealdeer** | Better man pages (`tldr`-Client) | `cargo install tealdeer` |
| **lazydocker** | Terminal UI für Docker | `go install github.com/jesseduffield/lazydocker@latest` |

## Installation

Via apt (Standard):
```bash
ansible-playbook playbook.yml --tags cli-tools
```

Alternativ manuell (siehe Tabelle oben).

## Hinweise

- **eza**: Nicht in apt auf den meisten Distros. Nutze den offiziellen Installer.
- **atuin**: Benötigt Ubuntu 23.10+ für apt, sonst das Setup-Script.
- **uv**: Hat keinen apt-Befehl; nutze den offiziellen Installer.
- **tealdeer** & **lazydocker**: Nur via cargo/go oder Ubuntu 23.10+ apt.

## Fish-Integration

Folgende Pfade werden in `roles/fish/files/config.fish` hinzugefügt:
- `$HOME/go/bin` — für Go-Installationen
- `$HOME/.local/bin` — für cargo-Installationen