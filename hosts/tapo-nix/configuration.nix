# This is the default configuration for the system
# It can be used as a template for other configurations
# The setup script will remove the  comments and replace the variables
# with the actual values

# It can be used as it is right now, but it's recommended to use the setup script
{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/system
  ];

  systemSettings = {
    name = "tapo-nix";
    theme = "catppuccin";

    # desktop.hyprland = {
    #   enable = lib.mkDefault true;
    #   monitors = [
    #     "eDP-1,2880x1800@120,0x0hw,1.5"
    #   ];
    # };

    desktop.cosmic.enable = lib.mkDefault true;

    hardware = {
      cpu.vendor = "intel"; # intel or amd
      gpu.vendor = "intel"; # nvidia or amd or intel

      laptop = {
        enable = true;
      };
    };

    networking = {
      nameservers = {
        enable = true;
      };
    };
  };

  # Dynamically set timezone, as it is a laptop
  services.automatic-timezoned.enable = true;

  userSettings = {
    name = "Felix Bjerhem Aronsson";
    username = "felbjar";
    email = "felix.b.aronsson@gmail.com";
    image = ../../resources/user/images/doge-transparent.png;
  };

  profiles = {
    personal.enable = true;
    dev.enable = true;
    gaming.enable = true;
    work.enable = true;
  };

  programs.adb.enable = true;
  users.users.felbjar.extraGroups = [ "adbusers" ];
  services.udev.packages = [
    pkgs.android-udev-rules
  ];

  environment.sessionVariables.ALSA_CONFIG_UCM2 =
    let
      # Updated version to hopefully fix issues with sound
      alsa-ucm-conf = pkgs.fetchFromGitHub {
        owner = "alsa-project";
        repo = "alsa-ucm-conf";
        rev = "b4e9b243d0de6cea31432670530136f6f47af6a7";
        sha256 = "sha256-nuSzPtQclOM9sLbrj+bJSUUhkUat6k1mTX5656IJfpo=";
      };
    in
    "${alsa-ucm-conf}/ucm2";

  specialisation = {
    work-setup.configuration = {
      systemSettings.desktop.hyprland = {
        monitors = [
          "eDP-1,2880x1800@120,0x0hw,1.5"
          "DP-1,3440x1440@100,1920x0,1"
        ];

        workspaces = [
          ### LAPTOP MONITOR ###
          "7, monitor:eDP-1,persistent:true,default:true"
          "8, monitor:eDP-1,persistent:true"
          "9, monitor:eDP-1,persistent:true"
          "10, monitor:eDP-1,persistent:true"

          ### ULTRAWIDE MONITOR ###
          "1,monitor:DP-1,persistent:true,default:true"
          "2,monitor:DP-1,persistent:true"
          "3,monitor:DP-1,persistent:true"
          "4,monitor:DP-1,persistent:true,default:true"
          "5,monitor:DP-1,persistent:true"
          "6,monitor:DP-1,persistent:true"
        ];
      };

    };

    gnome.configuration = {
      systemSettings = {
        desktop = {
          hyprland.enable = lib.mkForce false;
          cosmic.enable = lib.mkForce false;
          gnome.enable = true;
        };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [
    8000
    6001
    80
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  # Home manager state version
  home.initialStateVersion = "25.05";
}
