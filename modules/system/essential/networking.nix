{ config, lib, pkgs, ... }:

{
  options = {};

  config = {
    networking.hostName = config.systemSettings.name;

    # Enable networking
    networking.networkmanager.enable = true;
    networking.hosts = lib.mkIf (config.profiles.work.enable) {
      "127.0.0.1" = [ "roctim-local.com" ];
    };
  };
}
