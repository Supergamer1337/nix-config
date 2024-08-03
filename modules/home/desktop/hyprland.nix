{ osConfig, lib, pkgs, ... }:

{

  options = {};

  config = lib.mkIf (osConfig.systemSettings.desktop.hyprland.enable) {
    wayland.windowManager.hyprland.enable = true;
    
    # Enable hyprpaper
    services.hyprpaper.enable = true;

    # Configure hyprland
    wayland.windowManager.hyprland.settings = let
	mainMod = "SUPER";
	additionalMod = "SHIFT";
    in {
      exec-once = [ "hyprpaper" ];
      "$mainMod" = "${mainMod}";
      "$secondaryMod" = "${mainMod}${additionalMod}"; 
      bind = [
        "$mainMod, Return, exec, alacritty"
        "$mainMod, W, killactive"
        "$secondaryMod, W, exec, brave"
      ];
      monitor = ",preferred,auto,1";

    };
  };

}
