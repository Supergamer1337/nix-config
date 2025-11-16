{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./gnome.nix
    ./hyprland.nix
    ./kde.nix
    ./cosmic.nix
  ];

  options = {
    systemSettings.desktop.headless = lib.mkOption {
      default = true;
      description = "Helper variable to determine if the system is headless. Should not be set directly in the configuration.";
    };
  };

  config = { };
}
