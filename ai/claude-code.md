# Claude Code

## Sandboxing within WSL2

- Install pre-requirements

```sh
# Ubuntu
sudo apt-get update
sudo apt-get install bubblewrap socat

# Fedora
sudo dnf install bubblewrap socat
```

- Activate sandbox within Claude Code with `/sandbox`
- Make settings permanent in `~/.claude/settings.json`

```json
{
  "sandbox": {
    "enabled": true,
    "filesystem": {
      "denyRead": ["/mnt/c", "/mnt/d"],
      "denyWrite": ["/mnt/c", "/mnt/d"]
    },
    "allowUnsandboxedCommands": false
  }
}
```
