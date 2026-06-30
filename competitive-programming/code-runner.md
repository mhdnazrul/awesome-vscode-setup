# Code Runner

The [Code Runner](https://marketplace.visualstudio.com/items?itemName=formulahendry.code-runner) extension lets you execute code snippets or files with a single shortcut (`Ctrl+Alt+N`).

## Recommended Configuration

Add these to your `.vscode/settings.json`:

```json
{
  "code-runner.executorMap": {
    "cpp": "g++ -std=c++17 -O2 -Wall -DLOCAL $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt",
    "python": "cd $dir && python $fileName",
    "javascript": "cd $dir && node $fileName",
    "typescript": "cd $dir && npx ts-node $fileName"
  },
  "code-runner.saveFileBeforeRun": true,
  "code-runner.runInTerminal": true,
  "code-runner.clearPreviousOutput": true,
  "code-runner.preserveFocus": false,
  "code-runner.ignoreSelection": true
}
```

## Usage

1. Open the file you want to run.
2. Press `Ctrl+Alt+N` to run, `Ctrl+Alt+M` to stop.
3. Output appears in the terminal panel.

## C++ Compilation Flags Explained

| Flag | Purpose |
|------|---------|
| `-std=c++17` | Use C++17 standard |
| `-O2` | Optimize for speed (default for judges) |
| `-Wall` | Enable most warnings |
| `-DLOCAL` | Define `LOCAL` for debug macros |

## Custom Runners

For interactive or multi-file programs, use the build task instead:

- `Ctrl+Shift+B` — compile current file
- `Ctrl+Shift+P` → "Tasks: Run Task" for more options

See [tasks.json](./tasks.json) for pre-configured build tasks.
