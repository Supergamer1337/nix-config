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

      laptop = {
        enable = lib.mkEnableOption "Enables laptop mode for the system";
        battery.enable = lib.mkEnableOption "Enables battery mode for the system";
        busIds = {
          intel = lib.mkOption {
            type = lib.types.str;
            description = "The bus ID of intel graphics";
          };
          nvidia = lib.mkOption {
            type = lib.types.str;
            description = "The bus ID of the Nvidia graphics card";
          };
        };
      };
    };
  };

  config = {
    hardware.xone.enable = false;
  };
}
