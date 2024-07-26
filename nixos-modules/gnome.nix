{ config, pkgs, ... }:

{
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
  ]) ++ (with pkgs; [
    # Top level Gnome packages
    cheese
    epiphany
    geary # email reader
    evince # document viewer
    totem # video player

    # Gnome namespaced packages
    gnome.gnome-music
    gnome.gnome-characters
    gnome.tali # poker game
    gnome.iagno # go game
    gnome.hitori # sudoku game
    gnome.atomix # puzzle game
  ]);
}