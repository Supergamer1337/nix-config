{ config, lib, pkgs, ... }:

{
  options = {};

  config = {
    virtualisation.docker.enable = lib.mkDefault true;
  };
}