{ config, pkgs, lib, ...}:

{
  imports = [
    ./displayManagers.nix
    ./gnome.nix
    ./hyprland.nix
    ./kde.nix
  ];

  options = {
    systemSettings.desktop.enable = lib.mkOption {
      type = lib.types.enum [ "gnome" "kde" "hyprland" "none" ];
      default = "none";
      description = "Which desktop environment to use";
    };
  };

  config = {};
}