{ config, lib, pkgs, ... }:

{
  options = {
    systemSettings.hardware.gpu.nvidia = {
      open = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to use the open kernel drivers for nvidia. (Turing and newer)";
      };

      power-management.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enables experimental power management for nvidia. Might fix graphical corruptions after suspend.";
      };

      betaDriver.enable = lib.mkEnableOption "Enables the beta driver for Nvidia systems.";
    };
  };

  config = lib.mkIf (config.systemSettings.hardware.gpu.vendor == "nvidia") {
    hardware.graphics.enable = true;

    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = config.systemSettings.hardware.gpu.nvidia.power-management.enable; # If graphical corruptions after susped, try enabling this.
      powerManagement.finegrained = false; # Experimental, and only works on Turing and newer.

      # Enables the open source drivers for nvidia. Not noveau.
      open = config.systemSettings.hardware.gpu.nvidia.open;

      nvidiaSettings = true;
      package = if config.systemSettings.hardware.gpu.nvidia.betaDriver.enable
      	then config.boot.kernelPackages.nvidiaPackages.beta
      	else config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
