{ config, pkgs, lib, ...}:

{
  imports = [
    # Themes
    ../../themes

    # System
    ./essential
    ./services
    ./desktop
    ./hardware
    ./fonts.nix
    ./programs.nix
    ./user.nix
  ];

  options = {
    # Profiles
    profiles.work.enable = lib.mkEnableOption "Enable work additions";
    profiles.dev.enable = lib.mkEnableOption "Enable dev additions";

    # System/host settings (using host to avoid conflicts with builtin system options)
    systemSettings.name = lib.mkOption {
      type = lib.types.str;
      default = "NixOS";
      description = "The name of the machine as it will appear in the network, and identified by flakes.";
    };

    systemSettings.configDir = lib.mkOption {
      type = lib.types.str;
      default = "/home/${config.userSettings.username}/.nix-config";
      description = "The directory where the flake configuration is stored.";
    };

    systemSettings.dualBoot.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Fix common issues when dual booting Linux and Windows (i.e. time)";
    };
  };

  config = {
    # Enable CUPS to print documents.
    services.printing.enable = true;

    time.hardwareClockInLocalTime = config.systemSettings.dualBoot.enable;

    nix.settings.auto-optimise-store = true;
  };
}
