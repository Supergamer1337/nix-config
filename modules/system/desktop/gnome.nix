{
  config,
  pkgs,
  lib,
  ...
}:

{

  options = {
    systemSettings.desktop.gnome = {
      enable = lib.mkEnableOption "Enable GNOME desktop";
    };
  };

  config = lib.mkIf (config.systemSettings.desktop.gnome.enable) {
    systemSettings.desktop.headless = false;

    # Enable the X11 windowing system and GNOME desktop environment.
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

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
    environment.systemPackages =
      with pkgs.gnomeExtensions;
      [
        blur-my-shell
        gsconnect
        gnome-40-ui-improvements
        appindicator
      ]
      ++ (
        with pkgs.gnomeExtensions; lib.optional config.systemSettings.services.tailscale.enable tailscale-qs
      )
      ++ (with pkgs; [
        gnome-tweaks
      ]);

    environment.gnome.excludePackages = (
      with pkgs;
      [
        gnome-photos
        gnome-tour
        gedit
        cheese
        epiphany
        geary # email reader
        evince # document viewer
        totem # video player
        gnome-music
        gnome-characters
        tali # poker game
        iagno # go game
        hitori # sudoku game
        atomix # puzzle game
      ]
    );
  };
}
