{ config, lib, pkgs, ... }:

{

  options = {
    desktops.hyprland = {
      enable = lib.mkEnableOption "Enable Hyprland desktop";
    };
  };

  config = lib.mkIf config.desktops.hyprland.enable {
    programs.hyprland.enable = true;
    environment.sessionVariables.NIXOS_OZONE_WL = 1;
  };

}