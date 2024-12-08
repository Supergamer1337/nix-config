# This is the default configuration for the system
# It can be used as a template for other configurations
# The setup script will remove the #% comments and replace the variables
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
    name = "%MACHINE_NAME%"; 
    theme = "None";

    # hardware = {
    #   cpu.vendor = "%CPU_VENDOR%"; # intel or amd
    #   gpu.vendor = "%GPU_VENDOR%"; # nvidia or amd or intel
    # };
  };

  userSettings = {
    name = "%FULL_NAME%";
    username = "%USERNAME%";
    email = "%EMAIL%";
  };

  profiles = {
    personal.enable = true;
    dev.enable = false;
    gaming.enable = false;
    work.enable = false;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "%STATE_VERSION%"; # Did you read the comment?

  # Home manager state version
  home.initialStateVersion = "%STATE_VERSION%";
}
