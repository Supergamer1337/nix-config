{
  osConfig,
  pkgs,
  lib,
  ...
}:

{

  options = { };

  config = {
    services.swaync = lib.mkIf (osConfig.systemSettings.desktop.hyprland.enable) {
      enable = lib.mkDefault true;
      package = pkgs.swaynotificationcenter;
    };
  };

}
