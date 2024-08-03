{ osConfig, lib, pkgs, ... }:

{
  options = {};

  config = lib.mkIf (osConfig.systemSettings.desktop.kde.enable) {
    programs.plasma = {
      enable = true;
    };
  };
}