{ config, lib, pkgs, ... }:

{
  options = {};

  config = {
    networking.hostName = config.host.name;

    # Enable networking
    networking.networkmanager.enable = true;
    networking.extraHosts = lib.mkIf (config.profiles.work.enable) ''
      127.0.0.1 roctim-local.com
    '';
  };
}