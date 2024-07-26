{ config, pkgs, lib, ... }:

{

  options = {
    desktops.gnome.enable = lib.mkEnableOption "Enable gnome";
  };

  config = lib.mkIf config.desktops.gnome.enable {
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

    # Install relevant extensions
    environment.systemPackages = with pkgs.gnomeExtensions; [
      blur-my-shell
      gsconnect
      gnome-40-ui-improvements
    ];

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