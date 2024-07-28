{ config, pkgs, lib, ... }:

{
  options = {};

  config = lib.mkIf (config.systemSettings.theme == "candyland") {
    stylix.image = ./candyland.png;
    stylix.polarity = "dark";
    stylix.cursor.package = pkgs.bibata-cursors;
    stylix.cursor.size = 24;
    stylix.cursor.name = "Bibata-Modern-Ice";
  };
}