{ config, lib, pkgs, ... }:

{
  options = {};

  config = {
    virtualisation.docker.enable = true;
  };
}