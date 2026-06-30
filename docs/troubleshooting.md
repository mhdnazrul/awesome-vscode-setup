# Troubleshooting

## "'code' command not found in PATH"

The VS Code CLI (`code`) must be in your PATH for extension installation scripts to work.

### Windows

1. Open VS Code.
2. `Ctrl+Shift+P` → "Shell Command: Install 'code' command in PATH".
3. Restart your terminal.

Alternatively, add manually to PATH:

```powershell
$env:Path += ";$env:LOCALAPPDATA\Programs\Microsoft VS Code\bin"
```

### macOS

In VS Code: `Ctrl+Shift+P` → "Shell Command: Install 'code' command in PATH".

### Linux

```bash
# Add to ~/.bashrc or ~/.zshrc
export PATH="$PATH:/usr/share/code/bin"
```

## Extensions not installing

1. Ensure `code` is in PATH (see above).
2. Verify the extension ID in `.vscode/extensions.json` is correct.
3. Run the installer with verbose output:

```powershell
.\scripts\install-extensions.ps1 2>&1
```

4. Check marketplace status — some extensions may be deprecated or unpublished.

## Settings not applying

1. Verify the file was copied to the correct location:

| Platform | Expected Path |
|----------|---------------|
| Windows | `%APPDATA%\Code\User\settings.json` |
| Linux | `~/.config/Code/User/settings.json` |
| macOS | `~/Library/Application Support/Code/User/settings.json` |

2. Run `Developer: Reload Window` (`Ctrl+Shift+P`).
3. Check for JSON syntax errors in the settings file.

## Keybinding conflicts

1. `Ctrl+Shift+P` → "Preferences: Open Keyboard Shortcuts".
2. Search for the conflicting shortcut.
3. Right-click → "Remove Keybinding" or change it.

## Debugger not working

**C++:** Ensure gdb or lldb is installed and available in PATH.

```bash
gdb --version
```

**Python:** Ensure the Python extension is installed:

```bash
code --install-extension ms-python.python
```

**Launch config:** Verify the `program` path in `launch.json` points to an existing file.

## Snippets not showing

1. Ensure the snippet file is valid JSON.
2. Check the file is in the `snippets/` directory.
3. Open the correct language file (e.g., `cpp.json` for `.cpp` files).
4. `Ctrl+Space` to manually trigger suggestions.
5. If using a profile, verify the profile includes the snippets directory.

## Git issues

**LF/CRLF warnings:** Normal on Windows. The repo uses LF. Git will convert on checkout.

```bash
git config core.autocrlf true
```

**Permission denied (setup.sh):**

```bash
chmod +x scripts/setup.sh
```

## Still stuck?

Open an issue at [github.com/mhdnazrul/awesome-vscode-setup/issues](https://github.com/mhdnazrul/awesome-vscode-setup/issues) with:
- Your OS and VS Code version
- The command you ran and its output
- What you expected to happen
