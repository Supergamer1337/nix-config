{ config, pkgs, lib, ...}:

{
  options = {};

  config = {
    # System level packages
    environment.systemPackages = with pkgs; [
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    ];

    # Configured programs
    programs.nh = {
      enable = true;
      flake = config.systemSettings.configDir; # Location of the configuration flake

      # Automatic cleanup, essentially nix.gc
      clean.enable = true;
      clean.extraArgs = "--keep-since 7d --keep 3"; 
    };

    programs.direnv.enable = true;
  };
}