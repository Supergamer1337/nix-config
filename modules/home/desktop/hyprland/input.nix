{ osConfig, lib, pkgs, ... }:

{

  options = {};

  config = lib.mkIf (osConfig.systemSettings.desktop.enable == "hyprland") {
    wayland.windowManager.hyprland.settings = {
      input = {
        kb_layout = "se";
        kb_variant = "us";
        follow_mouse = 1;
        sensitivity = 0;
        accel_profile = "flat";

        touchpad = {
          natural_scroll = true;
        };
      };
    };
  };

}