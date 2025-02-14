{ config, pkgs, lib, ...}:

{
  options = {};

  config = {
    # Fonts
    fonts.packages = with pkgs; [
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      corefonts
      jetbrains-mono
    ];
  };
}