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
            "custom/notifications"
          ];

          tray = {
            icon-size = 15;
            spacing = 10;
          };

          "custom/notifications" = {
            tooltip = false;
            format = "{} {icon}";
            format-icons = {
              notification = "󱅫";
              none = "";
              dnd-notification = " ";
              dnd-none = "󰂛";
              inhibited-notification = " ";
              inhibited-none = "";
              dnd-inhibited-notification = " ";
              dnd-inhibited-none = " ";
            };
            return-type = "json";
            exec-if = "which swaync-client";
            exec = "swaync-client -swb";
            on-click = "sleep 0.1 && swaync-client -t -sw";
            on-click-right = "sleep 0.1 && swaync-client -d -sw";
            escape = true;
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
        highlight2 = "#${colors.base0E}";
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
        #tray,
        #custom-notifications {
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
          color: ${highlight2};
          background-color: transparent;
          border-radius: 2rem;
          padding: 0.25rem;
          margin: 0.3rem 0;

          transition: color 0.5s, background-color 0.5s;
        }

        #workspaces button.empty {
          color: ${altText};
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

        #custom-notifications {
          border-radius: 1rem;
          margin: 5px 5px 5px 0;
        }
      '';
    };
  };

}