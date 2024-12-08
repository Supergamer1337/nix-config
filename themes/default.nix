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
        "none" 
      ];
      default = "none";
      description = "The theme to use.";
    };

    themeSettings = {
      blur = {
        enable = lib.mkEnableOption "Enable blur effect";
        amount = lib.mkOption {
          type = lib.types.int;
          default = 0;
          description = "The amount of blur to apply.";
        };
      };

      opacity = {
        overall = lib.mkOption {
          type = lib.types.float;
          default = 1.0;
          description = "The overall opacity of the theme.";
        };

        applications = lib.mkOption {
          type = lib.types.float;
          default = config.themeSettings.opacity.overall;
          description = "The opacity of applications.";
        };

        desktop = lib.mkOption {
          type = lib.types.float;
          default = config.themeSettings.opacity.overall;
          description = "The opacity of desktop.";
        };

        popups = lib.mkOption {
          type = lib.types.float;
          default = config.themeSettings.opacity.overall;
          description = "The opacity of popups.";
        };

        terminal = lib.mkOption {
          type = lib.types.float;
          default = config.themeSettings.opacity.overall;
          description = "The opacity of terminals.";
        };
      };
    };
  };

  config = lib.mkIf (config.systemSettings.theme != "none") {
    stylix.enable = lib.mkDefault true;

    stylix.opacity = {
      applications = config.themeSettings.opacity.applications;
      desktop = config.themeSettings.opacity.desktop;
      popups = config.themeSettings.opacity.popups;
      terminal = config.themeSettings.opacity.terminal;
    };

    stylix.targets.grub = {
      enable = lib.mkDefault true;
      useImage = lib.mkDefault true;
    };
    stylix.fonts = lib.mkDefault {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
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
