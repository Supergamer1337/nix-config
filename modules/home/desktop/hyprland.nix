{ osConfig, lib, pkgs, ... }:

{

  options = {};

  config = lib.mkIf osConfig.desktops.hyprland.enable {
    wayland.windowManager.hyprland.enable = true;

    wayland.windowManager.hyprland.settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, Return, exec, alacritty"
      ];
    };
  };

}