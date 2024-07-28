{ config, pkgs, lib, ...}:

{
  imports = [
    ./gnome.nix
  ];

  options = {
    headless.enable = lib.mkEnableOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable headless mode (no desktop environment).";
    };
  };

  config = {
    desktops.gnome.enable = lib.mkDefault true;
  };
}