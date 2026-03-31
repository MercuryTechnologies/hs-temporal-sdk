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

# Install Nix (multi-user daemon mode)
RUN curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix/tag/v3.17.0 | \
    sh -s -- install linux --no-confirm --init none

ENV PATH="/nix/var/nix/profiles/default/bin:${PATH}"

RUN mkdir -p /etc/nix && printf '%s\n' \
    'experimental-features = nix-command flakes' \
    'accept-flake-config = true' \
    'extra-substituters = https://cache.garnix.io https://devenv.cachix.org' \
    'extra-trusted-public-keys = cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g= devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=' \
    'trusted-users = root ubuntu' \
    'allow-import-from-derivation = true' \
    'filter-syscalls = false' \
    > /etc/nix/nix.conf

# Make nix available in all shell sessions (interactive and non-interactive).
# The Determinate installer creates a profile script, but bash won't source it
# in non-login shells. Write PATH into locations that cover all cases.
RUN NIX_PROFILE_SCRIPT="/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" && \
    echo "[ -f $NIX_PROFILE_SCRIPT ] && . $NIX_PROFILE_SCRIPT" >> /etc/bash.bashrc && \
    echo "[ -f $NIX_PROFILE_SCRIPT ] && . $NIX_PROFILE_SCRIPT" >> /etc/profile.d/nix.sh

# Also ensure ubuntu's own shell configs source it, in case /etc/ files are skipped
RUN NIX_PROFILE_SCRIPT="/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" && \
    echo "[ -f $NIX_PROFILE_SCRIPT ] && . $NIX_PROFILE_SCRIPT" >> /home/ubuntu/.bashrc && \
    echo "[ -f $NIX_PROFILE_SCRIPT ] && . $NIX_PROFILE_SCRIPT" >> /home/ubuntu/.profile && \
    chown ubuntu:ubuntu /home/ubuntu/.bashrc /home/ubuntu/.profile

# Write a helper that starts the daemon if it isn't already running.
# Called from environment.json install/start commands.
RUN printf '#!/bin/bash\nif ! pgrep -x nix-daemon >/dev/null 2>&1; then\n  sudo /nix/var/nix/profiles/default/bin/nix-daemon &\n  sleep 2\nfi\n' \
    > /usr/local/bin/ensure-nix-daemon && chmod +x /usr/local/bin/ensure-nix-daemon

USER ubuntu
WORKDIR /home/ubuntu
