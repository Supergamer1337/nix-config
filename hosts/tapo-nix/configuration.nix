# This is the default configuration for the system
# It can be used as a template for other configurations
# The setup script will remove the  comments and replace the variables
# with the actual values

# It can be used as it is right now, but it's recommended to use the setup script
{ config, lib, pkgs, inputs, ...}:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/system
    ];

  systemSettings = {
    name = "tapo-nix"; 
    theme = "catppuccin";
    
    desktop.hyprland = {
      enable = true;
      monitors = [
        "eDP-1,2880x1800@120,0x0hw,2"
      ];
    };

    hardware = {
      cpu.vendor = "intel"; # intel or amd
      gpu.vendor = "intel"; # nvidia or amd or intel

      laptop = {
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
    gaming.enable = false;
    work.enable = true;
  };

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
