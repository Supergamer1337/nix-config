# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "org/gnome/desktop/background" = {
      picture-uri = "/home/felbjar/.nix-config/resources/wallpapers/candy-river-land.png";
      picture-uri-dark = "/home/felbjar/.nix-config/resources/wallpapers/candy-river-land.png";
      primary-color = "#3a4ba0";
      secondary-color = "#2f302f";
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      show-battery-percentage = true;
    };

    "org/gnome/desktop/peripherals/mouse" = {
      natural-scroll = true;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "/home/felbjar/.nix-config/resources/wallpapers/candy-river-land.png";
      picture-uri-dark = "/home/felbjar/.nix-config/resources/wallpapers/candy-river-land.png";
      primary-color = "#3a4ba0";
      secondary-color = "#2f302f";
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>w" ];
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = true;
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "alacritty";
      name = "Open Terminal";
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [ "blur-my-shell@aunetx" "gsconnect@andyholmes.github.io" "gnome-ui-tune@itstime.tech" ];
      favorite-apps = [ "brave-browser.desktop" "org.gnome.Nautilus.desktop" ];
      welcome-dialog-last-shown-version = "46.2";
    };

    "org/gnome/shell/extensions/blur-my-shell" = {
      settings-version = 2;
    };

    "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
      brightness = 0.6;
      sigma = 30;
    };

    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      blur = true;
      brightness = 0.6;
      sigma = 30;
      static-blur = true;
      style-dash-to-dock = 0;
    };

    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      brightness = 0.6;
      sigma = 30;
    };

    "org/gnome/shell/extensions/blur-my-shell/window-list" = {
      brightness = 0.6;
      sigma = 30;
    };

    "org/gnome/shell/extensions/gsconnect" = {
      id = "9e2df182-cd23-40c2-8cb3-2d5bd9609824";
      name = "roctim-nix";
    };
  };
}
