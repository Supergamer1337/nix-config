{ config, lib, pkgs, ... }:

{
  options = {};

  config = {
    # Bootloader.
    boot.loader.grub = {
      enable = true;
      useOSProber = true;
      device = "nodev";
      efiSupport = true;
    };
    boot.loader.efi.canTouchEfiVariables = true;
  };
}