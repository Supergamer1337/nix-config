{ config, lib, inputs, pkgs, ...}:

{
  imports = [
    # Themes
    ../../themes

    # System
    ./essential
    ./services
    ./desktop
    ./hardware
    ./programs

    ./fonts.nix
    ./user.nix
    ./overlays.nix
  ];

  options = {
    # Profiles
    profiles = {
      work.enable = lib.mkEnableOption "Enable work additions";
      dev.enable = lib.mkEnableOption "Enable dev additions";
      gaming.enable = lib.mkEnableOption "Enable gaming additions";
      personal.enable = lib.mkEnableOption "Enable personal additions";
    };

    # System/host settings (using host to avoid conflicts with builtin system options)
    systemSettings.name = lib.mkOption {
      type = lib.types.str;
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
    services.printing.enable = lib.mkIf (!config.systemSettings.desktop.headless) true;

    time.hardwareClockInLocalTime = config.systemSettings.dualBoot.enable;

    nix.settings = {
      auto-optimise-store = true;

      trusted-users = [ config.userSettings.username ];

      # Enable cachix to speed up builds
      extra-substituters = [ "https://nix-community.cachix.org" ];
      extra-trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];

      # Enable flakes 
      experimental-features = [ "nix-command" "flakes" ];
    };

    # Configure nixpkgs
    nixpkgs = {
      # Allow proprietary software
      config.allowUnfree = true;
    };

    # Used to run dynamically linked binaries.
    programs.nix-ld = {
      enable = true;
      package = pkgs.nix-ld-rs;
    };

  };
}
