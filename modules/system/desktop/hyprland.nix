{ config, lib, pkgs, ... }:

{

  options = {
    systemSettings.desktop.hyprland = {
      enable = lib.mkEnableOption "Enable Hyprland desktop";

      monitors = lib.mkOption {
        type = lib.types.listOf lib.types.lines;
        default = [ ", preferred, auto, 1" ];
        description = "Configure monitors for Hyprland";
      };

      workspaces = lib.mkOption {
        type = lib.types.listOf lib.types.lines;
	description = "Configure workspaces for Hyprland";
      };

    };
  };

  config = lib.mkIf (config.systemSettings.desktop.hyprland.enable) {
    programs.hyprland.enable = true;
    environment.sessionVariables.NIXOS_OZONE_WL = 1;

    xdg.portal = {
      enable = true;
    };

    environment.systemPackages = with pkgs; [
    	hyprpaper
    ];
  };

}
