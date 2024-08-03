{ config, pkgs, lib, ...}:

{
  imports = [
    ./displayManagers.nix
    ./gnome.nix
    ./hyprland.nix
    ./kde.nix
  ];

  options = {};

  config = {
    systemSettings.desktop.gnome.enable = lib.mkDefault true;
    systemSettings.desktop.kde.enable = lib.mkDefault false;
  };
}