{ config, osConfig, pkgs, lib, ... }:

{
  options = {};

  config = lib.mkIf (osConfig.systemSettings.desktop.hyprland.enable) {
    programs.alacritty = {
      enable = true;
      settings = {
        window.startup_mode = "Maximized";
      };
    };
    # Fix for alacritty creating weird errors when sshing
    programs.zsh.shellAliases."ssh" = "TERM=xterm-256color ssh";
  };
}