{ config, pkgs, lib, ...}:

{
  imports = [
    ./sound.nix
    ./docker.nix
    ./tailscale.nix
  ];

  options = {};

  config = {
    services.joycond.enable = config.profiles.gaming.enable;
  };
}