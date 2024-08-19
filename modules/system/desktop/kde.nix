{ config, lib, pkgs, ... }:

{
  options = {};

  config = lib.mkIf (config.systemSettings.desktop.enable == "kde") {
    services.xserver.enable = true;
    services.desktopManager.plasma6.enable = true;

    environment.plasma6.excludePackages = with pkgs.kdePackages; [ 
      konsole
    ];
  };
}