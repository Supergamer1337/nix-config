{ config, pkgs, lib, ...}:

{
  imports = [
    ./sound.nix
    ./docker.nix
  ];

  options = {};

  config = {
    services.sound.enable = lib.mkDefault true;
  };
}