{
  osConfig,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./appearance.nix
    ./behaviour.nix
    ./input.nix
    ./keybinds.nix

    ./swaync.nix
    ./waybar.nix
    ./hyprlock.nix
    ./hypridle.nix

    ./scripts
  ];

  options = { };

  config = lib.mkIf (osConfig.systemSettings.desktop.hyprland.enable) {

    wayland.windowManager.hyprland.enable = true;

    services.hyprpaper.enable = true;

    programs.wofi.enable = true;

    services.network-manager-applet.enable = true;

    # Fix for missing GTK app icons
    gtk = {
      enable = true;
      iconTheme = {
        package = pkgs.adwaita-icon-theme;
        name = "Adwaita";
      };
    };

    wayland.windowManager.hyprland.settings = {
      exec-once =
        # Want to minimize the amount of time before hyprlock kicks in, therefore it is first in the list
        [
          "hyprlock"
          "hyprpaper"
          "hypridle"
          "mako"
          "waybar"
          "blueman-applet"
          "nm-applet --indicator"
          "systemctl --user start hyprpolkitagent"

          # Autostart programs
          "[workspace 10 silent] vesktop"
          "[workspace 10 silent] slack"

          "[workspace 9 silent] whatsapp-for-linux"
          "[workspace 9 silent] caprine"

          "[workspace 8 silent] ticktick"

        ]
        ++ lib.optional (osConfig.systemSettings.hardware.openrgb.enable) "openrgb";

      windowrulev2 = [
        "idleinhibit fullscreen, class:^(*)$"
        "idleinhibit fullscreen, title:^(*)$"
        "idleinhibit fullscreen, fullscreen:1"
      ];

      monitor = osConfig.systemSettings.desktop.hyprland.monitors;
      workspace = osConfig.systemSettings.desktop.hyprland.workspaces;

      env = lib.mkMerge [
        [
          "SSH_AUTH_SOCK,$XDG_RUNTIME_DIR/ssh-agent"
          "NIXOS_OZONE_WL, 1" # for ozone-based and electron apps to run on wayland
          "MOZ_ENABLE_WAYLAND, 1" # for firefox to run on wayland
          "MOZ_WEBRENDER, 1" # for firefox to run on wayland
          "XDG_SESSION_TYPE, wayland"
          "WLR_NO_HARDWARE_CURSORS, 1"
          "WLR_RENDERER_ALLOW_SOFTWARE, 1"
          "QT_QPA_PLATFORM, wayland"
        ]

        (lib.mkIf (osConfig.systemSettings.hardware.gpu.vendor == "nvidia") [
          "LIBVA_DRIVER_NAME,nvidia"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        ])

      ];
    };
  };

}
