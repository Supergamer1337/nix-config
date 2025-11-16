{
  osConfig,
  lib,
  pkgs,
  ...
}:

{

  options = { };

  config = lib.mkIf (osConfig.systemSettings.desktop.hyprland.enable) {
    wayland.windowManager.hyprland.settings = {
      input = {
        kb_layout = "se";
        kb_variant = "us";
        follow_mouse = 1;
        sensitivity = 0;
        accel_profile = "flat";

        numlock_by_default = true;

        touchpad = {
          natural_scroll = true;
        };
      };
    };
  };

}
