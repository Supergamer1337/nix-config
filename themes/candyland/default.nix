{ config, pkgs, lib, ... }:

{
  options = {};

  config = lib.mkIf (config.systemSettings.theme == "candyland") {
    stylix.image = ./candyland.png;
    stylix.polarity = "dark";
  };
}