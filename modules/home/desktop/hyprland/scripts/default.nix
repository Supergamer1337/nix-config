{ osConfig, config, lib, pkgs, ... }:

{
  options = {
    scripts.hyprland = lib.mkOption {
      type = lib.types.attrs;
      description = "Scripts for hyprland";
    };
  };

  config = lib.mkIf (osConfig.systemSettings.desktop.hyprland.enable) {
    scripts.hyprland = {
      screenshot = pkgs.writeShellScript "hyprland-screenshot" ''
        ${pkgs.hyprshot}/bin/hyprshot -m region --raw | ${pkgs.swappy}/bin/swappy -f -
      '';
    };
  };
}