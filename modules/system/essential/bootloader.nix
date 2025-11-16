{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = { };

  config = {
    # Bootloader.
    boot.loader.grub = {
      enable = lib.mkDefault true;
      useOSProber = true;
      device = "nodev";
      efiSupport = true;
    };
    boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;
    boot.plymouth.enable = false; # May turn on again if it plays well with Cosmic
  };
}
