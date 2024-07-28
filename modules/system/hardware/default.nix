{ config, lib, pkgs, ... }:

{
  imports = [
    ./openrgb.nix
    ./nvidia.nix
  ];

  options = {
    systemSettings.hardware = {
      cpu.vendor = lib.mkOption {
        type = lib.types.enum [ "intel" "amd" ];
        description = "The vendor of the CPU";
      };

      gpu.vendor = lib.mkOption {
        type = lib.types.enum [ "nvidia" "amd" "intel" ];
        description = "The vendor of the GPU";
      };
    };
  };

  config = {};
}