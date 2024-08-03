{ config, lib, pkgs, ... }:

{

  options = {
    systemSettings.desktop.hyprland = {
      enable = lib.mkEnableOption "Enable Hyprland desktop";
    };
  };

  config = lib.mkIf (config.systemSettings.desktop.hyprland.enable) {
    programs.hyprland.enable = true;
    environment.sessionVariables.NIXOS_OZONE_WL = 1;

    environment.systemPackages = with pkgs; [
    	hyprpaper
    ];
  };

}
