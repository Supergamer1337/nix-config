{ osConfig, lib, pkgs, ... }:

{

  options = {};

  config = lib.mkIf (osConfig.systemSettings.desktop.enable == "hyprland") {
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

        input-field = {
          monitor = "";
          fade_on_empty = true;
        };
      };
    };
  };

}