{ config, lib, pkgs, ... }:

{
  options = {
    systemSettings.desktop.kde.enable = lib.mkEnableOption "Enable KDE desktop";
  };

  config = lib.mkIf (config.systemSettings.desktop.kde.enable) {
    services.xserver.enable = true;
    services.desktopManager.plasma6.enable = true;

    environment.plasma6.excludePackages = with pkgs.kdePackages; [ 
      konsole
    ];
  };
}