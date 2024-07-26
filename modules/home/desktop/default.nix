{ config, pkgs, lib, ... }:

{
  imports = [
    ./gnome
  ];

  options = {};

  config = {
    desktops.gnome.enable = lib.mkDefault true;
  };
}