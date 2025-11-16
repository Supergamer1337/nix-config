{
  config,
  pkgs,
  lib,
  ...
}:

{
  options = { };

  config = lib.mkIf (config.profiles.gaming.enable && !config.systemSettings.desktop.headless) {
    environment.systemPackages = with pkgs; [
      steam
    ];

    programs.steam.enable = true;
  };
}
