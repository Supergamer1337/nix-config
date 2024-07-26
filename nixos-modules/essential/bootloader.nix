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

    # Customize bootloader
    boot.loader.grub2-theme = {
      enable = true;
      theme = "tela";
      footer = true;
    };
  };
}