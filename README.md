## chezmoi Notes
### init
```bash
chezmoi init --apply git@github.com:zyf2007/dotfiles.git

chezmoi add ~/.zshrc
chezmoi add ~/.profile
...

chezmoi cd
git add . ; git commit -m "init" ; git push
```

### update
```bash
chezmoi add ~/.bashrc
chezmoi diff
chezmoi cd
git add . ; git commit -m "update" ; git push
```

### sync_to_new_devics
```bash
paru chezmoi / sh -c "$(curl -fsLS get.chezmoi.io)"
chezmoi init git@github.com:zyf2007/dotfiles.git
chezmoi apply
```

### sync (pull & apply)
```bash
chezmoi update
```
