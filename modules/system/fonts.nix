{ config, pkgs, lib, ...}:

{
  options = {};

  config = {
    # Fonts
    fonts.packages = with pkgs; [
      corefonts
    ];
  };
}