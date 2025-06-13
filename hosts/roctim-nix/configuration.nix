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
    gaming.enable = true;
    personal.enable = true;
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
