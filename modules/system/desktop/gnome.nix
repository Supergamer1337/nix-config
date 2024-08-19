{ config, pkgs, lib, ... }:

{

  options = {};

  config = lib.mkIf (config.systemSettings.desktop.enable == "gnome") {
    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "se";
      variant = "us";
    };

    # Some apps (e.g. Plex) needs this to login/click on links.
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
    };

    # Install relevant extensions
    environment.systemPackages = with pkgs.gnomeExtensions; [
      blur-my-shell
      gsconnect
      gnome-40-ui-improvements
      appindicator
    ]
    ++ (with pkgs; [
      gnome-tweaks
    ]);

    environment.gnome.excludePackages = (with pkgs; [
      gnome-photos
      gnome-tour
      gedit
      cheese
      epiphany
      geary # email reader
      evince # document viewer
      totem # video player
    ]) ++ (with pkgs.gnome; [
      # Gnome namespaced packages
      gnome-music
      gnome-characters
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
    ]);
  };
}