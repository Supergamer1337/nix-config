{ config, lib, pkgs, ... }:

{
  imports = [
    ./openrgb.nix
    ./nvidia.nix
    ./intel.nix
  ];

  options = {
    systemSettings.hardware = {
      bluetooth.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enables bluetooth support";
      };

      cpu.vendor = lib.mkOption {
        type = lib.types.enum [ "intel" "amd" "unknown" ];
        default = "unknown";
        description = "The vendor of the CPU";
      };

      gpu.vendor = lib.mkOption {
        type = lib.types.enum [ "nvidia" "amd" "intel" "unknown" ];
        default = "unknown";
        description = "The vendor of the GPU";
      };

      laptop = {
        enable = lib.mkEnableOption "Enables laptop mode for the system";
        battery.enable = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Enables battery saving features for the laptop";
        }; 
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
    hardware = {
      bluetooth.enable = config.systemSettings.hardware.bluetooth.enable;
      xone.enable = config.profiles.gaming.enable;
    };

    services.blueman.enable = (config.systemSettings.desktop.hyprland.enable && config.systemSettings.hardware.bluetooth.enable);
  };
}
