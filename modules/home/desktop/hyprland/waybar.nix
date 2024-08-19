{ osConfig, pkgs, lib, ... }:

{

  options = {};

  config = lib.mkIf (osConfig.systemSettings.desktop.enable == "hyprland") {  
    programs.waybar = {
      enable = true;
    };
  };

}