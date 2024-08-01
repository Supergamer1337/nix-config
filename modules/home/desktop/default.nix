{ config, osConfig, pkgs, lib, ... }:

{
  imports = [
    ./gnome
    ./hyprland.nix
  ];

  options = {};

  config = {};
}