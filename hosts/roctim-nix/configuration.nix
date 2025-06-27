{ config, lib, pkgs, inputs, ...}:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/system
    ];

  # System settings 
  systemSettings = {
    name = "roctim-nix"; 
    theme = "catppuccin";

    desktop.hyprland.enable = true;

    hardware = {
      cpu.vendor = "intel";
      gpu.vendor = "nvidia";
      laptop = {
        enable = true;
        busIds = {
          intel = "PCI:0:2:0";
          nvidia = "PCI:1:0:0";
        };
      };
    };
  };

  time.timeZone = "Europe/Stockholm";

  # User settings
  userSettings = {
    name = "Felix Bjerhem Aronsson";
    username = "felbjar";
    email = "felix.b.aronsson@gmail.com";
    image = ../../resources/user/images/doge-transparent.png;
  };

  # Profiles
  profiles = {
    work.enable = true;
    dev.enable = true;
    gaming.enable = false;
    personal.enable = true;
  };

  # Specialisations
  specialisation = {
    work-setup.configuration = {
      systemSettings.desktop.hyprland = {
        monitors = [
          "eDP-1, 1920x1080@60, 0x1080, 1"
          "DP-3, 1920x1080@60, 0x0, 1"
          "DP-4, 1920x1080@60, 1920x0, 1"
        ];

        workspaces = [
          ### LAPTOP MONITOR ###
          "7, monitor:eDP-1,persistent:true,default:true"
          "8, monitor:eDP-1,persistent:true"
          "9, monitor:eDP-1,persistent:true"
          "10, monitor:eDP-1,persistent:true"

          ### MIDDLE WORK MONITOR ###
          "1,monitor:DP-3,persistent:true,default:true"
          "2,monitor:DP-3,persistent:true"
          "3,monitor:DP-3,persistent:true"

          ### RIGHT WORK MONITOR ###
          "4,monitor:DP-4,persistent:true,default:true"
          "5,monitor:DP-4,persistent:true"
          "6,monitor:DP-4,persistent:true"
        ];
      };
    };
  };

  services.flatpak.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  # Home manager state version
  home.initialStateVersion = "24.05";
}
