{ config, pkgs, lib, ... }:

{
	imports = [
		./candyland
	];

  options = {
    systemSettings.theme = lib.mkOption {
      type = lib.types.enum [ 
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