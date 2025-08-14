# dotfiles

Cloud‑native configurations from a desktop Linux nerd to make Esme’s machines feel like home 🙂

## About

This is my personal collection of dotfiles, scripts, and configuration bits for a Bluefin‑based Linux desktop, designed with replicability, portability, and a touch of infra‑nerd care.

While many of these tools and quirks will work across a variety of UNIX and UNIX-like environments, this setup was crafted specifically for:

- **Bluefin (rpm-ostree base)**
- **My ThinkPad T480s (treated more like a cat than cattle)**

_Yes, I know I should treat ThinkPads like cattle (I work with Kubernetes), but this one’s my T480s and I baby it like a cat. You’ll survive. 😛_

## Philosophy

**Immutable host, flexible layers** - Bluefin provides a stable, declarative base. Everything else — from dev tools to UX polish — lives in containers or overlay config.

**Containers over pets** - Dev environments run in Distrobox containers, keeping the host clean and project tooling isolated.

**Declarative by default** - Brewfiles and shell scripts track package sets and environment tweaks, so new machines can be set up in minutes.

**Human-first computing** - Because this isn’t just about optimising for speed — _it’s about making a laptop feel like home_.

## Repo Structure

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

Quick Start

If you’re me:

```bash
git clone https://github.com/esmeaioli/dotfiles.git ~/dotfiles
cd ~/dotfiles
./bootstrap.sh
```

If you’re not me:

- Read through the files.

- Steal anything useful.

- Adapt to your own environment.

## Why bother?

Because your desktop isn’t just a tool — it’s a living environment.

This repo is my way of approaching personal computing the same way I approach platform engineering:

- Reproducible.

- Declarative.

- Version‑controlled.

Also, it’s fun. 🙂

## License

MIT. Share, remix, learn.
