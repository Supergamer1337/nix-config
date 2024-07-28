{ config, lib, pkgs, ... }:

{
  options = {
    systemSettings.hardware.gpu.nvidia = {
      open = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to use the open kernel drivers for nvidia. (Turing and newer)";
      };
    };
  };

  config = lib.mkIf (config.systemSettings.hardware.gpu.vendor == "nvidia") {
    hardware.opengl.enable = true;

    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false; # If graphical corruptions after susped, try enabling this.
      powerManagement.finegrained = false; # Experimental, and only works on Turing and newer.

      # Enables the open source drivers for nvidia. Not noveau.
      open = config.systemSettings.hardware.gpu.nvidia.open;

      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}