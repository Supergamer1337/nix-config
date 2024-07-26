{ config, pkgs, lib, ... }:

{
  options = {};

  config = {
    programs.alacritty = {
      enable = true;
      settings = {
        window.startup_mode = "Maximized";
      };
    };
  };
}