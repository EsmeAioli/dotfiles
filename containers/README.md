# containers/

Containerised development environments for Esme’s workflow, powered by [Distrobox](https://distrobox.it/), for the distros I care about 🙂.

Each container is:

- Declared using a `.ini` file to specify base image, mounts, and init config
- Bootstrapped with a `setup.sh` script for eventual language/tools provisioning
- Designed for specific dev contexts (e.g. Go, observability, desktop tinkering)

## Available (and Planned) Containers

- **`ubuntu/`**
- **`fedora/`**
- **`bluefin/`**

💡 Note: These containers are **scaffolded but minimal** for now — they exist to show intent and future layering. Setup scripts are placeholders for upcoming toolchains, SDKs, and environment tweaks.

## Philosophy

Containers aren't just isolated sandboxes — they're reproducible layers that can carry a consistent dev experience across machines. This structure is built to scale with Esme’s setup over time:

- `.ini` = intent and definition
- `setup.sh` = bootstrap logic
- `bootstrap.sh` (optional) = project-level tooling per container context

Want to reuse or extend? Start with an `.ini`, tailor `setup.sh`, and go wild.

## Notes

I'm still exploring what makes sense across these containers — particularly for custom image use, package layering, and Brewfile integration. This is a space for iterative learning rather than polished artefacts (for now 😉).

⚠️ Expect some ✨Esme-shaped chaos✨ here: Everything here is intentionally scaffolded — but not yet tested. This repo shows structure and direction more than working code (for now!).
