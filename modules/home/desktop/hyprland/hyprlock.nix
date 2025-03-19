{ osConfig, lib, pkgs, ... }:

{

  options = {};

  config = lib.mkIf (osConfig.systemSettings.desktop.hyprland.enable) {
    programs.hyprlock = {
      enable = true;

      # These settings can be found at https://wiki.hyprland.org/Hypr-Ecosystem/hyprlock/
      settings = {
        disable_loading_bar = false;
        hide_cursor = false;
        no_fade_in = false;
        no_fade_out = false;

        grace = 0;
        ignore_empty_input = false;
        immediate_render = false;
        text_trim = true;

        fractional_scale = 2;

        pam_module = "hyprlock";

        background = {
          monitor = "";
          path = "${osConfig.stylix.image}"; 

          blur_passes = 2;
          blur_size = 7;
          noise = 0.0117;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        };

        image = {
          monitor = "";
          path = "${osConfig.userSettings.image}";
          size = 150; # lesser side if not 1:1 ratio
          rounding = -1; # negative values mean circle
          border_size = 4;
          border_color = "rgb(0, 0, 0, 0)";
          rotate = 0; # degrees, counter-clockwise

          position = "0, 200";
          halign = "center";
          valign = "center";
        };

        label = [
          {
            monitor = "";
            text = "Welcome, ${osConfig.userSettings.username}!";
            text_align = "center";
            color = "rgba(255, 255, 255, 1.0)";
            font_size = 25;
            font_family = "${osConfig.stylix.fonts.sansSerif.name}";
            rotate = 0; # degrees, counter-clockwise

            position = "0, 80";
            halign = "center";
            valign = "center";
          }
          {
            monitor = "";
            text = "$TIME";
            text_align = "center";
            font_size = 20;
            font_family = "${osConfig.stylix.fonts.monospace.name}";
            rotate = 0; # degrees, counter-clockwise

            position = "0, 310";
            halign = "center";
            valign = "center";
          }
        ];

        input-field = {
          monitor = "";
          fade_on_empty = true;
        };
      };
    };
  };

}