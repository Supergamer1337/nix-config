{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./locales.nix
    ./bootloader.nix
    ./networking.nix
  ];

  options = { };

  config = { };
}
