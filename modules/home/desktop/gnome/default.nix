{ config, pkgs, lib, ... }:

{
  imports = [
    ./dconf.nix
  ];

  options = {
    desktops.gnome.enable = lib.mkEnableOption "Enable gnome";
  };

  config = lib.mkIf (config.desktops.gnome.enable) {
    home.packages = with pkgs; [
      dconf2nix # Generate .nix files from dconf
    ];
  };
}