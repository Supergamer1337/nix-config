{ osConfig, pkgs, lib, ... }:

{

  options = {};

  config = lib.mkIf (osConfig.systemSettings.desktop.enable == "hyprland") {  
    stylix.targets.waybar.enable = false;

    programs.waybar = {
      enable = true;

      settings = {
        mainBar = {
          #### General Options ####
          layer = "top";
          position = "top";

          #### Left Modules ####
          modules-left = [
            "hyprland/workspaces"
            "hyprland/window"
          ];

          #### Center Modules ####
          modules-center = [
            "clock"
          ];

          clock = {
            interval = 1;
            format = "  {:%H:%M %d/%m/%Y}";
          };

          #### Right Modules ####
          modules-right = [
            "tray"
          ];

          tray = {
            icon-size = 15;
            spacing = 10;
          };
        };
      };

      style = let
        colors = osConfig.lib.stylix.colors;

        text = "#${colors.base05}";
        altText = "#${colors.base04}";

        background = "#${colors.base00}";
        altBackground = "#${colors.base01}";

        selection = "#${colors.base02}";

        # Highlights
        highlight1 = "#${colors.base0D}";
      in ''
        * {
          font-family: JetBrainsMono Nerd Font;
          font-size: 13px;
          min-height: 0;
        }

        #waybar {
          background: transparent;
          color: ${text};
        }

        #window,
        #clock,
        #tray {
          background-color: ${background};
          padding: 0.5rem 0.75rem;
          margin: 5px 0;
        }

        /* --- Left Modules --- */
        #workspaces {
          border-radius: 1rem 0 0 1rem;

          margin: 5px 0 5px 5px;
          padding-left: 0.3rem;
          background-color: ${background};
        }

        #workspaces button {
          color: ${altText};
          background-color: transparent;
          border-radius: 2rem;
          padding: 0.25rem;
          margin: 0.3rem 0;

          transition: color 0.5s, background-color 0.5s;
        }

        #workspaces button.active {
          color: ${highlight1};
          background-color: ${altBackground};
        }

        #workspaces button:hover {
          color: ${text};
          background-color: ${selection};
        }

        #window {
          border-radius: 0 1rem 1rem 0;
          background-color: ${background};
          margin-right: 1rem;
        }

        /* --- Center Modules --- */
        #clock {
          border-radius: 1rem;
          color: ${highlight1}; 
        }

        /* --- Right Modules --- */
        #tray {
          border-radius: 1rem;
          margin: 5px 5px 5px 0;
        }
      '';
    };
  };

}