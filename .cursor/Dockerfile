FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    git \
    xz-utils \
    sudo \
    locales \
    ca-certificates \
    build-essential \
    pkg-config \
    libffi-dev \
    libgmp-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/* \
    && locale-gen en_US.UTF-8

ENV LANG=en_US.UTF-8

# Cursor cloud agents run as 'ubuntu'
RUN id -u ubuntu &>/dev/null || useradd -m -s /bin/bash ubuntu
RUN usermod -aG sudo ubuntu \
    && echo "ubuntu ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ubuntu

# Install Nix — root-only mode (no daemon needed in containers).
# See: https://github.com/DeterminateSystems/nix-installer#in-a-container
RUN curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
    sh -s -- install linux \
      --no-confirm \
      --init none \
      --extra-conf "sandbox = false" \
      --extra-conf "accept-flake-config = true" \
      --extra-conf "extra-substituters = https://cache.garnix.io https://devenv.cachix.org" \
      --extra-conf "extra-trusted-public-keys = cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g= devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=" \
      --extra-conf "filter-syscalls = false"

ENV PATH="/nix/var/nix/profiles/default/bin:${PATH}"

# Verify nix works at build time
RUN nix run nixpkgs#hello

# With --init none, nix is root-only. The ubuntu user runs nix via sudo.
# Set up a wrapper so `nix` just works from the ubuntu user's shell.
RUN printf '#!/bin/bash\nexec sudo /nix/var/nix/profiles/default/bin/nix "$@"\n' \
    > /usr/local/bin/nix && chmod +x /usr/local/bin/nix

USER ubuntu
WORKDIR /home/ubuntu
