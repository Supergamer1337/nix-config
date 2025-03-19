{ osConfig, lib, pkgs, ... }:

{

  options = {};

  config = lib.mkIf (osConfig.systemSettings.desktop.hyprland.enable) {
    services.hypridle = {
      enable = true;

      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };

        listener = let
          fadeOutTime = 150; # 2.5min
          lockTime = 300; # 5min
          suspendTime = 1800; # 30min
        in [
          {
            timeout = fadeOutTime;
            on-timeout = "brightnessctl -s set 10";
            on-resume = "brightnessctl -r";
          }
          {
            timeout = fadeOutTime;
            on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0"; 
            on-resume = "brightnessctl -rd rgb:kbd_backlight";
          }
          {
            timeout = lockTime;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = lockTime + 30; # 30 seconds after locking
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            timeout = suspendTime;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };
  };
}