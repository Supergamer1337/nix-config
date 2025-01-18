{ config, lib, pkgs, ... }:

{
  options = {

  };

  config = lib.mkIf (config.systemSettings.hardware.cpu.vendor == "intel" && config.systemSettings.hardware.laptop.enable) {
    # Enable hardware acceleration for Intel graphics.
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-vaapi-driver
        libvdpau-va-gl
      ];
    };

    # Set the LIBVA_DRIVER_NAME environment variable to "iHD", so that it uses the integrated GPU.
    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
    };
  };
}