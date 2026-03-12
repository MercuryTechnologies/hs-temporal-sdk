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

# Install Nix in single-user mode (no daemon, suitable for containers).
# The installer must run as root with --init none (no systemd/launchd).
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

# Transfer /nix ownership to ubuntu so nix works without sudo.
# In single-user container environments this is the standard approach:
# the db lock, store, and profiles all need to be writable by the
# user that invokes nix, and there is no daemon to mediate access.
RUN chown -R ubuntu:ubuntu /nix

USER ubuntu
WORKDIR /home/ubuntu
