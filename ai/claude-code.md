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
    "allowUnsandboxedCommands": false,
    "filesystem": {
      "allowWrite": [
        "/tmp"
      ],
      "denyWrite": [
        "/mnt/c",
      ],
      "denyRead": [
        "/mnt/c",
      ]
    },
    "excludedCommands": [
      "ctest"
    ]
  },
}
```

## Custom status line

1. Copy [statusline.sh](/assets/statusline.sh) to `~/.claude/statusline.sh`
1. Update `~/.claude/settings.json` to include/modify the `statusLine` entry (replace `<user>` with username):

```json
  "statusLine": {
    "type": "command",
    "command": "bash \"/home/<user>/.claude/statusline.sh\""
  }
```

> Requires `jq` to be installed.
