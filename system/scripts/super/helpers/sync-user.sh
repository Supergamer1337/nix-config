#!/bin/bash

# Script to synchronize user state
# with home-manager config 

# Rebuild user directory
home-manager switch --flake $NIX_CONFIG_DIR#user;