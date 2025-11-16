{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:

{
  imports = [ ];

  options = { };

  config = {
    nixpkgs.overlays = [
      # Overlay to get unstable packages
      (final: _: {
        unstable = import inputs.unstable {
          inherit (final.stdenv.hostPlatform) system;
          inherit (final) config;
        };
      })

      # Overlay to use unstable cosmic
      (final: prev: {
        # Core COSMIC packages that the NixOS module uses internally
        cosmic-applets = final.unstable.cosmic-applets;
        cosmic-applibrary = final.unstable.cosmic-applibrary;
        cosmic-bg = final.unstable.cosmic-bg;
        cosmic-comp = final.unstable.cosmic-comp;
        cosmic-files = final.unstable.cosmic-files;
        cosmic-greeter = final.unstable.cosmic-greeter;
        cosmic-idle = final.unstable.cosmic-idle;
        cosmic-initial-setup = final.unstable.cosmic-initial-setup;
        cosmic-launcher = final.unstable.cosmic-launcher;
        cosmic-notifications = final.unstable.cosmic-notifications;
        cosmic-osd = final.unstable.cosmic-osd;
        cosmic-panel = final.unstable.cosmic-panel;
        cosmic-session = final.unstable.cosmic-session;
        cosmic-settings = final.unstable.cosmic-settings;
        cosmic-settings-daemon = final.unstable.cosmic-settings-daemon;
        cosmic-workspaces-epoch = final.unstable.cosmic-workspaces-epoch;

        # Additional COSMIC applications
        cosmic-edit = final.unstable.cosmic-edit;
        cosmic-icons = final.unstable.cosmic-icons;
        cosmic-player = final.unstable.cosmic-player;
        cosmic-randr = final.unstable.cosmic-randr;
        cosmic-screenshot = final.unstable.cosmic-screenshot;
        cosmic-term = final.unstable.cosmic-term;
        cosmic-wallpapers = final.unstable.cosmic-wallpapers;
        cosmic-store = final.unstable.cosmic-store;

        # XDG portal
        xdg-desktop-portal-cosmic = final.unstable.xdg-desktop-portal-cosmic;
      })
    ];
  };
}
