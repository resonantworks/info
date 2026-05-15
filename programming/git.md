# Git

- [Git](#git)
  - [General config](#general-config)
    - [Git - SSH key](#git---ssh-key)
  - [Delta - better terminal diff viewer](#delta---better-terminal-diff-viewer)

## General config

```sh
git config --global user.name "First Last"
git config --global user.email first.last@company.com
git config --global core.editor vim
```

### Git - SSH key

```sh
ssh-keygen -t ed25519 -C first.last@company.com
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
```

## Delta - better terminal diff viewer

1. Follow instructions on [delta > Getting Started](https://github.com/dandavison/delta#get-started).
1. Update `~/.gitconfig` for a dark theme side-by-side diff

```ini
[core]
    pager = delta

[interactive]
    diffFilter = delta --color-only

[delta]
    navigate = true  # use n and N to move between diff sections
    dark = true      # or light = true, or omit for auto-detection
    side-by-side = true
    line-numbers = true

[merge]
    conflictStyle = zdiff3
```
