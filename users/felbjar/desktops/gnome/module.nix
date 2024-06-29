{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    dconf2nix
  ];

  # Use the generated dconf settings
  imports = [
    ./dconf.nix
  ];
}