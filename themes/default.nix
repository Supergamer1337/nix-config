{ config, pkgs, lib, ... }:

{
	imports = [
    ./catppuccin
		./candyland
	];

  options = {
    systemSettings.theme = lib.mkOption {
      type = lib.types.enum [ 
        "catppuccin"
        "candyland"
        "None" 
      ];
      default = "None";
      description = "The theme to use.";
    };
  };

  config = {
    stylix.enable = lib.mkDefault true;
    stylix.targets.grub = {
      enable = lib.mkDefault true;
      useImage = lib.mkDefault true;
    };
    stylix.fonts = lib.mkDefault {
      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font Mono";
      };

      sansSerif = {
        package = pkgs.roboto;
        name = "Roboto";
      };

      serif = {
        package = pkgs.roboto;
        name = "Roboto";
      };
    };
  };
}