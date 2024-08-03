{ config, osConfig, pkgs, lib, ... }:

# Command to generate .nix files from dconf
# dconf dump / | dconf2nix > ~/.nix-config/modules/home/desktop/gnome/dconf.nix

{
  imports = [
    ./dconf.nix
  ];

  options = {};

  config = lib.mkIf (osConfig.systemSettings.desktop.gnome.enable) {
    home.packages = with pkgs; [
      dconf2nix # Generate .nix files from dconf
    ];

    dconf.settings = lib.mkIf (!osConfig.systemSetting.desktop.gnome.enable) (lib.mkForce {});
  };
}