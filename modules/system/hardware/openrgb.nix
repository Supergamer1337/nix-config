{ config, lib, pkgs, ... }:

{
  options = {
    systemSettings.hardware.openrgb.enable = lib.mkEnableOption "Enable OpenRGB";
  };

  config = lib.mkIf config.systemSettings.hardware.openrgb.enable {
    environment.systemPackages = [ pkgs.openrgb-with-all-plugins ];

    services.hardware.openrgb = {
      enable = true;
      package = pkgs.openrgb-with-all-plugins;
    };
  };
}