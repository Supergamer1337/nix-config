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

    ./scripts
  ];

  options = {};

  config = lib.mkIf (osConfig.systemSettings.desktop.enable == "hyprland") {
    wayland.windowManager.hyprland.enable = true;

    services.hyprpaper.enable = true;

    programs.wofi.enable = true;

    wayland.windowManager.hyprland.settings = {
      exec-once = [ 
      "hyprpaper" "mako" "waybar" 
      "systemctl --user start hyprpolkitagent"

      # Autostart programs
      "[workspace 10 silent] vesktop"
      "[workspace 10 silent] slack"

      "[workspace 9 silent] whatsapp-for-linux" 
      "[workspace 9 silent] caprine" 

      "[workspace 8 silent] obsidian"

      ] ++ lib.optional (osConfig.systemSettings.hardware.openrgb.enable) "openrgb";

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
