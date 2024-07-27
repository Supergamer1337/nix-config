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

  config = lib.mkIf (config.systemSettings.theme != "None") {
    stylix.enable = true;
    stylix.targets.grub.enable = false;
  };
}