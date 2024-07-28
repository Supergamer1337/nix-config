{ config, osConfig, pkgs, lib, ... }:

{
  imports = [
    ./dconf.nix
  ];

  options = {};

  config = lib.mkIf (osConfig.desktops.gnome.enable) {
    home.packages = with pkgs; [
      dconf2nix # Generate .nix files from dconf
    ];

    dconf.settings = lib.mkIf (!osConfig.desktops.gnome.enable) (lib.mkForce {});
  };
}