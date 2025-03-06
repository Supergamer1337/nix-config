{ config, lib, pkgs, ... }:

{

  options = {
    systemSettings.desktop.hyprland = {
      monitors = lib.mkOption {
        default = [ ", preferred, auto, 1" ];
        description = "Configure monitors for Hyprland";
      };

      workspaces = lib.mkOption {
        default = [ ];
	      description = "Configure workspaces for Hyprland";
      };

    };
  };

  config = lib.mkIf (config.systemSettings.desktop.enable == "hyprland") {
    programs.hyprland.enable = true;

    xdg.portal = {
      enable = true;
      configPackages = [ pkgs.xdg-desktop-portal-hyprland ];
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
    };

    environment.systemPackages = with pkgs; [
    	hyprpaper
      hyprlock
      hyprpolkitagent

      # Extra programs for hyprland
      wofi
      swaynotificationcenter
      waybar
      
      # Utilities
      nautilus
      wl-clipboard
    ];

    # Fonts for Hyprland stuff, such as waybar
    fonts.packages = with pkgs; [
      font-awesome
    ];

    # Enable pam module for hyprlock
    security.pam.services.hyprlock = {};
  };

}
