{ config, lib, pkgs, ... }:

{
  imports = [
    ./openrgb.nix
  ];

  options = {
    systemSettings.hardware = {
      cpu.vendor = lib.mkOption {
        type = lib.types.enum [ "intel" "amd" ];
        description = "The vendor of the CPU";
      };
    };
  };

  config = {
  };
}