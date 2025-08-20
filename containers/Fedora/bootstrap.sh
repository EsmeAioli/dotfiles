distrobox create --name fedora-dev \
  --file containers/Fedora/Containerfile \
  --home ~ \
  --yes

distrobox enter fedora-dev