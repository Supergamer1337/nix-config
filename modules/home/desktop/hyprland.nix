{ osConfig, lib, pkgs, ... }:

{

  options = {};

  config = lib.mkIf (osConfig.systemSettings.desktop.enable == "hyprland") {
    wayland.windowManager.hyprland.enable = true;
    
    # Enable hyprpaper
    services.hyprpaper.enable = true;

    # Enable extra programs for hyprland
    programs.wofi.enable = true;
    services.swaync.enable = true;

    # Configure hyprland
    wayland.windowManager.hyprland.settings = let
			mainMod = "SUPER";
			additionalMod = "SHIFT";
    in {
      exec-once = [ "hyprpaper" "swaync" ];
      "$mainMod" = "${mainMod}";
      "$mainAddMod" = "${mainMod} ${additionalMod}"; 

      # Keybinds
      bind = [
        "$mainMod, Return, exec, alacritty" # Should make this independent of actual terminal
        "$mainMod, W, killactive"
        "$mainAddMod, W, exec, brave" # Should make this independant of actual terminal
				"$mainAddMod, E, exit"
				"$mainMod, F, toggleFloating"
				"$mainAddMod, S, toggleSplit"
				"$mainMod, Space, exec, wofi --show drun --allow-images"
				
				# Move focus using vim like keybinds
				"$mainMod, h, moveFocus, l"
				"$mainMod, l, moveFocus, r"
				"$mainMod, k, moveFocus, u"
				"$mainMod, j, moveFocus, d"

				# Move window using vim like hotkeys
				"$mainAddMod, h, moveWindow, l"
				"$mainAddMod, l, moveWindow, r"
				"$mainAddMod, k, moveWindow, u"
				"$mainAddMod, j, moveWindow, d"

				# Scroll through workspaces
				"$mainMod, mouse_down, workspace, e+1"
				"$mainMod, mouse_up, workspace, e-1"
      ] ++ (
				# Configure workspaces
				builtins.concatLists (builtins.genList (
					x: let
						ws = let
							c = (x + 1) / 10;
						in
							builtins.toString (x + 1 - (c * 10));
					in [
						"$mainMod, ${ws}, workspace, ${toString (x + 1)}"
						"$mainAddMod, ${ws}, movetoworkspace, ${toString (x + 1)}"
					]
				)
        10)
       );

    # Mouse binds
    bindm = [
			"$mainMod, mouse:272, movewindow"
			"$mainMod, mouse:273, resizewindow"
    ];

    general = {
			gaps_in = 5;
			gaps_out = 20;

			border_size = 2;
			
			resize_on_border = false;

			# Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
			allow_tearing = false;

			layout = "dwindle";
    };

    decoration = {
			rounding = 10;

			drop_shadow = true;
			shadow_range = 4;
			shadow_render_power = 3;

			blur = {
							enabled = true;
				size = 3;
				passes = 1;

				vibrancy = 0.1696;
			};
    };

    animations = {
			enabled = true;
			
			# Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more.
			bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

			animation = [ 
				"windows, 1, 7, myBezier"
				"windowsOut, 1, 7, default, popin 80%"
				"border, 1, 10, default"
				"borderangle, 1, 8, default"
				"fade, 1, 7, default"
				"workspaces, 1, 6, default"
			];
    };

      dwindle = {
        pseudotile = true;
	preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      misc = {
	force_default_wallpaper = 0;
	disable_hyprland_logo = true;
      };

      ###### Input stuffs ######
      # Should depend on other config options in future
      input = {
	kb_layout = "se";
	kb_variant = "us";
	follow_mouse = 1;
	sensitivity = 0;
	accel_profile = "flat";

	touchpad = {
	  natural_scroll = true;
	};
      };

      gestures = {
        workspace_swipe = true;
      };

      windowrulev2 = [
      	"suppressevent maximize, class:.*" # You'll probably like this
      ];

      monitor = osConfig.systemSettings.desktop.hyprland.monitors;
      workspace = osConfig.systemSettings.desktop.hyprland.workspaces;

    };
  };

}
