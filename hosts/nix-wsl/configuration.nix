# This is the default configuration for the system
# It can be used as a template for other configurations
# The setup script will remove the #% comments and replace the variables
# with the actual values

# It can be used as it is right now, but it's recommended to use the setup script
{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
rec {
  imports = [
    ../../modules/system
  ];

  systemSettings = {
    name = "nix-wsl";
    theme = "catppuccin";

    networking = {
      resolved.enable = false;
    };
  };

  userSettings = {
    name = "Feilx Bjerhem Aronsson";
    username = "supergamer1337";
    email = "felix.b.aronsson@gmail.com";
  };

  profiles = {
    personal.enable = true;
    dev.enable = true;
    gaming.enable = false;
    work.enable = true;
  };

  # WSL Specific settings
  wsl = {
    enable = true;
    defaultUser = userSettings.username;
    docker-desktop.enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = false;

  environment.sessionVariables = {
    CUDA_PATH = "${pkgs.cudatoolkit}";
    EXTRA_LDFLAGS = "-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib";
    EXTRA_CCFLAGS = "-I/usr/include";
    LD_LIBRARY_PATH = [
      "/usr/lib/wsl/lib"
      "${pkgs.linuxPackages.nvidia_x11}/lib"
      "${pkgs.ncurses5}/lib"
    ];
    MESA_D3D12_DEFAULT_ADAPTER_NAME = "Nvidia";
  };

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
