{ osConfig, lib, pkgs, ... }:

{
  options = {};

  config = lib.mkIf (osConfig.systemSettings.desktop.enable == "kde") {
    programs.plasma = {
      enable = true;
    };
  };
}