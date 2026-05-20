# Git

- [Git](#git)
  - [General config](#general-config)
  - [SSH key](#ssh-key)
  - [Git bash status line](#git-bash-status-line)
  - [Delta - better terminal diff viewer](#delta---better-terminal-diff-viewer)
  - [Github](#github)
    - [Account repository space used](#account-repository-space-used)

## General config

```sh
git config --global user.name "First Last"
git config --global user.email first.last@company.com
git config --global core.editor vim
```

## SSH key

```sh
ssh-keygen -t ed25519 -C first.last@company.com
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
# Use output to register new SSH key with source provider
```

## Git bash status line

Append the following to  `~/.bashrc`

```sh
# git bash status line
source /usr/share/git-core/contrib/completion/git-prompt.sh
export PS1='\[\e[32m\]\u@\h\[\e[0m\]:\[\e[33m\]\w\[\e[36m\]$(__git_ps1 " (%s)")\[\e[0m\]$(if [ -n "$(__git_ps1)" ]; then echo -e "\n\$ "; else echo "\$ "; fi)'
```

## Delta - better terminal diff viewer

1. Follow instructions on [delta > Getting Started](https://github.com/dandavison/delta#get-started)
   1. Ubuntu: `sudo apt install git-delta`
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

## Github

### Account repository space used

- Install [GitHub CLI](https://github.com/cli/cli?ref_product=cli&ref_type=engagement&ref_style=text#installation)
  - `choco install gh` or `winget install gh`

- (Git)Bash shell:

```sh
gh auth login # follow prompts to log into account

# Total repository space used (replace ACCOUNT_ID)
gh api user/repos --paginate -q '[.[] | select(.owner.login=="ACCOUNT_ID") | .size] | add / 1024 | "\(.) MB"'

# Repository size list  (replace ACCOUNT_ID)
gh api user/repos --paginate -q '.[] | select(.owner.login=="ACCOUNT_ID") | "\(.size) KB\t\(.full_name)"' | sort -n
```
