{ osConfig, lib, pkgs, ... }:

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

  options = {};

  config = lib.mkIf (osConfig.systemSettings.desktop.enable == "hyprland") {
    wayland.windowManager.hyprland.enable = true;

    services.hyprpaper.enable = true;

    programs.wofi.enable = true;

    services.network-manager-applet.enable = true;

    wayland.windowManager.hyprland.settings = {
      exec-once =
      # Want to minimize the amount of time before hyprlock kicks in, therefore it is first in the list
      lib.optional (osConfig.systemSettings.desktop.displayManager == "greetd") "hyprlock" ++
      [ 
      "hyprpaper" "hypridle" "mako" "waybar" "blueman-applet" "nm-applet --indicator"
      "systemctl --user start hyprpolkitagent"

      # Autostart programs
      "[workspace 10 silent] vesktop"
      "[workspace 10 silent] slack"

      "[workspace 9 silent] whatsapp-for-linux" 
      "[workspace 9 silent] caprine" 

      "[workspace 8 silent] obsidian"

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
          "AQ_DRM_DEVICES,/dev/dri/card2:/dev/dri/card1"
        ]

        (lib.mkIf (osConfig.systemSettings.hardware.gpu.vendor == "nvidia") [
          "LIBVA_DRIVER_NAME,nvidia"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        ])

      ];
    };
  };

}
