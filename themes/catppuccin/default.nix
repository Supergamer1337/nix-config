{ pkgs, config, lib, ... }:

{
  options = {
    
  };

  config = lib.mkIf (config.systemSettings.theme == "catppuccin") {
    stylix.image = ./catppuccin_landscape.jpg;
    stylix.polarity = "dark";
    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    stylix.cursor.package = pkgs.catppuccin-cursors.mochaDark;
    stylix.cursor.size = 24;
    stylix.cursor.name = "catppuccin-mocha-dark-cursors";
  };
}
