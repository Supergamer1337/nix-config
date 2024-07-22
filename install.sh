#!/bin/sh

# Automatied installation of nix-config

# Set the nix-config directory
if [ $# -gt 0 ]; then
	NIX_CONFIG_DIR=$1
else
	NIX_CONFIG_DIR=~/.nix-config
fi

# Clone repository
nix-shell -p git --command "git clone https://github.com/SuperGamer1337/nix-config.git $NIX_CONFIG_DIR"

# Generate the hardware configuration for the new system
sudo nixos-generate-config --show-hardware-config > $NIX_CONFIG_DIR/hardware-configuration.nix

# Rebuild and switch to the new system 
sudo nixos-rebuild switch --flake $NIX_CONFIG_DIR#system

# Install and build home-manager configuration
nix run home-manager/master --extra-experimental-features nix-command --extra-experimental-features flakes -- switch --flake $NIX_CONFIG_DIR#user