#!/bin/bash

# Script to synchronize system state
# with config files for the system

# Rebuild system
sudo nixos-rebuild switch --flake $NIX_CONFIG_DIR#system;