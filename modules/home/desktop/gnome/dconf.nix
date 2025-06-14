# Generated via dconf2nix: https://github.com/nix-commmunity/dconf2nix
{ lib, osConfig, ... }:

with lib.hm.gvariant;

{
  dconf.settings = lib.mkIf (osConfig.systemSettings.desktop.gnome.enable) {
    "org/gnome/control-center" = {
      last-panel = "background";
      window-state = mkTuple [ 980 640 false ];
    };

    "org/gnome/desktop/app-folders" = {
      folder-children = [ "Utilities" "YaST" "Pardus" ];
    };

    "org/gnome/desktop/app-folders/folders/Pardus" = {
      categories = [ "X-Pardus-Apps" ];
      name = "X-Pardus-Apps.directory";
      translate = true;
    };

    "org/gnome/desktop/app-folders/folders/Utilities" = {
      apps = [ "gnome-abrt.desktop" "gnome-system-log.desktop" "nm-connection-editor.desktop" "org.gnome.baobab.desktop" "org.gnome.Connections.desktop" "org.gnome.DejaDup.desktop" "org.gnome.Dictionary.desktop" "org.gnome.DiskUtility.desktop" "org.gnome.Evince.desktop" "org.gnome.FileRoller.desktop" "org.gnome.fonts.desktop" "org.gnome.Loupe.desktop" "org.gnome.seahorse.Application.desktop" "org.gnome.tweaks.desktop" "org.gnome.Usage.desktop" "vinagre.desktop" ];
      categories = [ "X-GNOME-Utilities" ];
      name = "X-GNOME-Utilities.directory";
      translate = true;
    };

    "org/gnome/desktop/app-folders/folders/YaST" = {
      categories = [ "X-SuSE-YaST" ];
      name = "suse-yast.directory";
      translate = true;
    };

    "org/gnome/desktop/input-sources" = {
      sources = [ (mkTuple [ "xkb" "se+us" ]) ];
      xkb-options = [ "terminate:ctrl_alt_bksp" ];
    };

    "org/gnome/desktop/interface" = {
      show-battery-percentage = true;
      toolkit-accessibility = false;
    };

    "org/gnome/desktop/notifications" = {
      application-children = [ "brave-browser" "org-gnome-evolution-alarm-notify" ];
    };

    "org/gnome/desktop/notifications/application/brave-browser" = {
      application-id = "brave-browser.desktop";
    };

    "org/gnome/desktop/notifications/application/com-github-eneshecan-whatsappforlinux" = {
      application-id = "com.github.eneshecan.WhatsAppForLinux.desktop";
    };

    "org/gnome/desktop/notifications/application/dbeaver" = {
      application-id = "dbeaver.desktop";
    };

    "org/gnome/desktop/notifications/application/gnome-power-panel" = {
      application-id = "gnome-power-panel.desktop";
    };

    "org/gnome/desktop/notifications/application/jetbrains-rider-1beaeaa6-859a-41f1-a074-3321c6bac056" = {
      application-id = "jetbrains-rider-1beaeaa6-859a-41f1-a074-3321c6bac056.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-clocks" = {
      application-id = "org.gnome.clocks.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-evolution-alarm-notify" = {
      application-id = "org.gnome.Evolution-alarm-notify.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-fileroller" = {
      application-id = "org.gnome.FileRoller.desktop";
    };

    "org/gnome/desktop/notifications/application/pycharm-professional" = {
      application-id = "pycharm-professional.desktop";
    };

    "org/gnome/desktop/notifications/application/rider" = {
      application-id = "rider.desktop";
    };

    "org/gnome/desktop/notifications/application/slack" = {
      application-id = "slack.desktop";
    };

    "org/gnome/desktop/notifications/application/vesktop" = {
      application-id = "vesktop.desktop";
    };

    "org/gnome/desktop/notifications/application/zen" = {
      application-id = "zen.desktop";
    };

    "org/gnome/desktop/peripherals/keyboard" = {
      numlock-state = true;
    };

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
      natural-scroll = false;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/privacy" = {
      old-files-age = mkUint32 30;
      recent-files-max-age = -1;
    };

    "org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "/home/felbjar/.nix-config/resources/wallpapers/candy-river-land.png";
      picture-uri-dark = "/home/felbjar/.nix-config/resources/wallpapers/candy-river-land.png";
      primary-color = "#3a4ba0";
      secondary-color = "#2f302f";
    };

    "org/gnome/desktop/search-providers" = {
      sort-order = [ "org.gnome.Contacts.desktop" "org.gnome.Documents.desktop" "org.gnome.Nautilus.desktop" ];
    };

    "org/gnome/desktop/session" = {
      idle-delay = mkUint32 300;
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>w" ];
    };

    "org/gnome/evolution-data-server" = {
      migrated = true;
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      workspaces-only-on-primary = true;
    };

    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "icon-view";
      migrated-gtk-settings = true;
      search-filter-time-type = "last_modified";
    };

    "org/gnome/portal/filechooser/alacritty" = {
      last-folder-path = "/home/felbjar/Programming/Nix";
    };

    "org/gnome/portal/filechooser/brave-browser" = {
      last-folder-path = "/home/felbjar/Downloads";
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "alacritty";
      name = "Open Terminal";
    };

    "org/gnome/shell" = {
      enabled-extensions = [ "blur-my-shell@aunetx" "gnome-ui-tune@itstime.tech" "appindicatorsupport@rgcjonas.gmail.com" "tailscale@joaophi.github.com" ];
      favorite-apps = [ "Alacritty.desktop" "zen.desktop" "org.gnome.Nautilus.desktop" ];
      last-selected-power-profile = "performance";
      welcome-dialog-last-shown-version = "46.2";
    };

    "org/gnome/shell/extensions/blur-my-shell" = {
      settings-version = 2;
    };

    "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
      sigma = 30;
    };

    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      blur = true;
      sigma = 30;
      static-blur = true;
      style-dash-to-dock = 0;
    };

    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      sigma = 30;
    };

    "org/gnome/shell/extensions/blur-my-shell/window-list" = {
      sigma = 30;
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Stylix";
    };

    "org/gnome/shell/world-clocks" = {
      locations = mkArray "v" [];
    };

    "org/gnome/software" = {
      check-timestamp = mkInt64 1721933437;
      first-run = false;
      flatpak-purge-timestamp = mkInt64 1721724387;
    };

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };

    "org/gtk/gtk4/settings/file-chooser" = {
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = false;
      sidebar-width = 140;
      sort-column = "name";
      sort-directories-first = true;
      sort-order = "ascending";
      type-format = "category";
      view-type = "list";
      window-size = mkTuple [ 859 372 ];
    };
  };
}
