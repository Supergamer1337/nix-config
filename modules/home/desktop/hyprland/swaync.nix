{ osConfig, pkgs, lib, ... }:

{

  options = {};

  config = {
    services.swaync = lib.mkIf (osConfig.systemSettings.desktop.enable == "hyprland") {
      enable = lib.mkDefault true;
      package = pkgs.swaynotificationcenter;

      style = let 
        colors = osConfig.lib.stylix.colors;

        text = "#${colors.base05}";

        background = "#${colors.base00}";
      in ''
        .control-center {
          background-color: ${background};
          color: ${text};
          margin: 0 5px 5px 0;
          box-shadow: 0px 0px 25px 0px rgba(0,0,0,0.15); 
        }
      '';
    };
  };

}