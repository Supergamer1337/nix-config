{ config, pkgs, lib, ... }:

{
  options = {};

  config = {
    programs.git = {
      enable = true;
      userEmail = config.userSettings.email;
      userName = config.userSettings.name;
    };
  };
}