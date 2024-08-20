{ osConfig, lib, pkgs, ... }:

{

  options = {};

  config = lib.mkIf (osConfig.systemSettings.desktop.enable == "hyprland") {
    wayland.windowManager.hyprland.settings = let 
      mainMod = "SUPER";
      additionalMod = "SHIFT";
    in {
      "$mainMod" = "${mainMod}";
      "$mainAddMod" = "${mainMod} ${additionalMod}";

      bind = [
        "$mainMod, Return, exec, alacritty" # Should make this independent of actual terminal
        "$mainMod, W, killactive"
				"$mainAddMod, E, exec, hyprlock"
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
    };
  };

}