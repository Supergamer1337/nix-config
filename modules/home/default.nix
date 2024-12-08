{ config, osConfig, pkgs, lib, inputs, ... }:

{
  imports = [
    ./desktop
    ./terminal
    ./gui
    ../../themes/home.nix
  ];

  options = {};

  config = {};
}
