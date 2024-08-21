{ osConfig, lib, pkgs, ... }:

{
  imports = [
    ./appearance.nix
    ./behaviour.nix
    ./input.nix
    ./keybinds.nix

    ./waybar.nix
    ./hyprlock.nix
  ];

  options = {};

  config = lib.mkIf (osConfig.systemSettings.desktop.enable == "hyprland") {
    wayland.windowManager.hyprland.enable = true;

    services.hyprpaper.enable = true;

    services.mako.enable = true;
    programs.wofi.enable = true;

    wayland.windowManager.hyprland.settings = {
      exec-once = [ 
      "hyprpaper" "mako" "waybar" 

      # Autostart programs
      "vesktop" "whatsapp-for-linux" "caprine" "openrgb"

      ];

      monitor = osConfig.systemSettings.desktop.hyprland.monitors;
      workspace = osConfig.systemSettings.desktop.hyprland.workspaces;
    };
  };

}
