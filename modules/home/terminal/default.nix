{ config, osConfig, pkgs, lib, ... }:

{
  imports = [
    ./alacritty.nix
    ./zsh.nix
  ];

  options = {};

  config = {};
}