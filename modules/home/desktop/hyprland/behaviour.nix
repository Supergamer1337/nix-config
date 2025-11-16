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
      general = {
        resize_on_border = false;

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false;

        layout = "dwindle";
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      gestures = {
        workspace_swipe = true;
      };

      windowrulev2 = [
        "suppressevent maximize, class:.*" # You'll probably like this
      ];
    };
  };

}
