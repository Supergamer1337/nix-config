{ config, osConfig, pkgs, lib, ... }:

{
  options = {};

  config = {
    programs.git = {
      enable = true;
      userEmail = osConfig.userSettings.email;
      userName = osConfig.userSettings.name;
    };
  };
}