{ config, pkgs, lib, ...}:

{
  imports = [
    ./sound.nix
    ./docker.nix
    ./tailscale.nix
  ];

  options = {};

  config = {
  };
}