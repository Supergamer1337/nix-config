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
      ];
    };
  };
}