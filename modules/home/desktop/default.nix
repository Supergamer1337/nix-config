{ config, osConfig, pkgs, lib, ... }:

{
  imports = [
    ./gnome
    ./hyprland
    ./kde.nix
  ];

  options = {};

  config = {};
}