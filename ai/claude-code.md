# Claude Code

## GitHub integration

1. GitHub > Create new repo with README.md (requires at least one commit)
1. Open web editor using `.` keyboard shortcut and drag-drop any needed files into repo
1. Configure [Claude GitHub App](https://github.com/apps/claude) allow access to selected GitHub repos
1. Go to [Claude Code Web](https://claude.ai/code) and create a new workspace to start working on repo

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
