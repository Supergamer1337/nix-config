{
  config,
  pkgs,
  lib,
  ...
}:

{
  options = { };

  config = {
    # Fonts
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      corefonts
      jetbrains-mono
    ];
  };
}
