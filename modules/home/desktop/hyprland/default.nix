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
      "systemctl --user start plasma-polkit-agent"

      # Autostart programs
      "vesktop" "whatsapp-for-linux" "caprine" "slack"

      ] ++ lib.optional (osConfig.systemSettings.hardware.openrgb.enable) "openrgb";

      monitor = osConfig.systemSettings.desktop.hyprland.monitors;
      workspace = osConfig.systemSettings.desktop.hyprland.workspaces;
    };
  };

}
