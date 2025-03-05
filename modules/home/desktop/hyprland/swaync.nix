{ osConfig, pkgs, lib, ... }:

{

  options = {};

  config = {
    services.swaync = lib.mkIf (osConfig.systemSettings.desktop.enable == "hyprland") {
      enable = lib.mkDefault true;
      package = pkgs.swaynotificationcenter;
    };
  };

}