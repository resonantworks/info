# Git

- [Git](#git)
  - [Delta - better terminal diff viewer](#delta---better-terminal-diff-viewer)

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
