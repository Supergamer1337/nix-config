{ config, lib, pkgs, ... }:

{

  options = {
    systemSettings.desktop.hyprland = {
      enable = lib.mkEnableOption "Enable Hyprland desktop";

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

  config = lib.mkIf (config.systemSettings.desktop.hyprland.enable) {
    systemSettings.desktop.headless = false;
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
      hypridle
      hyprpolkitagent
      brightnessctl
      networkmanagerapplet

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

    # Fix for keyring
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.greetd.enableGnomeKeyring = true;
    security.pam.services.login.enableGnomeKeyring = true;

    # Fix for ssh keys
    programs.ssh.startAgent = true;

    # Setup display manager
    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "Hyprland";
          user = config.userSettings.username;
        };
        default_session = initial_session;
      };
    };
  };

}
