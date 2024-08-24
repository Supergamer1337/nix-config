{ config, pkgs, lib, ...}:

{
  options = {};

  config = lib.mkIf config.profiles.gaming.enable {
    environment.systemPackages = with pkgs; [
      steam
    ];

    programs.steam.enable = true;
  };
}