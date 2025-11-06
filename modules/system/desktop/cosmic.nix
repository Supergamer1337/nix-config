{ config, pkgs, lib, ... }:

{

  options = {
    systemSettings.desktop.cosmic = {
      enable = lib.mkEnableOption "Enable the COSMIC desktop environment.";
    };
  };

  config = lib.mkIf (config.systemSettings.desktop.cosmic.enable) {
    systemSettings.desktop.headless = false;

    services.displayManager.cosmic-greeter.enable = true;
    services.desktopManager.cosmic.enable = true;

    # To enable Gnome Keyring for password management in Cosmic
    security.pam.services.cosmic.enableGnomeKeyring = true;
    services.gnome.gnome-keyring.enable = true;

    environment.sessionVariables = {
      # Enable Wayland support for Electron apps in Cosmic
      NIXOS_OZONE_WL = "1";
      SDL_VIDEODRIVER = "wayland";
    };
  };
}