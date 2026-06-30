# Installation

## Prerequisites

- [VS Code](https://code.visualstudio.com/)
- [Git](https://git-scm.com/)

## Clone

```bash
git clone https://github.com/mhdnazrul/awesome-vscode-setup.git
cd awesome-vscode-setup
```

## Apply Settings

### Option 1: Setup Script (Recommended)

**Linux/macOS:**

```bash
chmod +x scripts/setup.sh
./scripts/setup.sh
```

**Windows (PowerShell):**

```powershell
.\scripts\install-extensions.ps1
.\scripts\restore.ps1
```

The setup script:
- Backs up your existing `settings.json` (if any)
- Copies the repo's settings to your VS Code user directory
- Installs recommended extensions

### Option 2: Manual

Copy files individually to your VS Code user directory:

| Platform | Path |
|----------|------|
| Windows | `%APPDATA%\Code\User\` |
| Linux | `~/.config/Code/User/` |
| macOS | `~/Library/Application Support/Code/User/` |

```bash
cp .vscode/settings.json "$VSCODE_USER_DIR/settings.json"
cp .vscode/keybindings.json "$VSCODE_USER_DIR/keybindings.json"
```

### Option 3: Profiles

Import a [profile](../profiles/) for a tailored setup:

1. `Ctrl+Shift+P` → "Profiles: Import Profile"
2. Select the `.code-profile` file
3. Apply

## Install Extensions

```powershell
.\scripts\install-extensions.ps1
```

Or install manually from the marketplace using the IDs listed in `.vscode/extensions.json`.

## Post-Install

1. Restart VS Code or run `Developer: Reload Window`.
2. Open the Command Palette (`Ctrl+Shift+P`) and verify settings are applied.
3. Open a file and test snippets by typing a prefix (e.g., `fastio` in a `.cpp` file).

## Update

```bash
git pull
.\scripts\restore.ps1
```
