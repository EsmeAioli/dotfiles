# dotfiles

Cloud‑native configurations from a desktop Linux nerd to make Esme’s machines feel like home 🙂

## About

This repo is a collection of dotfiles, scripts, and configuration bits for a Bluefin‑based Linux desktop; built for replicability, portability in mind, and designed with Esme's infra nerd care and sensibilities.

The tools and optimisations reflect Esme's hobbyist adventures in nerdy spaces, and function a little more like a passport -- stamps of lovely nerds and ideas she's appreciated in her spare time.

While the scripts were designed to work across most UNIX and UNIX-like environments, this setup is most battle-tested on Esme's:

- Lenovo Thinkpad T480s
- running the lovely immutable [Project Bluefin](https://projectbluefin.io/)

## Repo Structure

#TODO: Figure out Nix ;)

```bash
dotfiles/
├── brew/           # Brewfile and package sets
├── containers/     # Distrobox container definitions
├── scripts/        # Helper scripts & utilities
├── shell/          # Bash configs, aliases, and functions
├── desktop/        # Desktop environment tweaks
├── .env            # Personal overrides (e.g: custom repo URLs, secrets, user-specific config)
└── bootstrap.sh    # One‑stop setup script for new machines
```

## Quick Start

```bash
git clone https://github.com/esmeaioli/dotfiles.git ~/dotfiles
cd ~/dotfiles
./bootstrap.sh
```

## License

MIT license
