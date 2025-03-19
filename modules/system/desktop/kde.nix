{ config, lib, pkgs, ... }:

{
  options = {
    systemSettings.desktop.kde = {
      enable = lib.mkEnableOption "Enable KDE desktop";
    };
  };

  config = lib.mkIf (config.systemSettings.desktop.kde.enable) {
    systemSettings.desktop.headless = false;
    services.xserver.enable = true;
    services.desktopManager.plasma6.enable = true;

    # Display manager
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    environment.plasma6.excludePackages = with pkgs.kdePackages; [ 
      konsole
    ];
  };
}