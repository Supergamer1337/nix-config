{ config, pkgs, lib, ...}:

{
  imports = [
    ./essential
    ./services
    ./users
    ./desktops
  ];

  options = {
    # Profiles
    profiles.work.enable = lib.mkEnableOption "Enable work additions";
    profiles.dev.enable = lib.mkEnableOption "Enable dev additions";

    # System/host settings (using host to avoid conflicts with builtin system options)
    host.name = lib.mkOption {
      type = lib.types.str;
      default = "NixOS";
      description = "The name of the machine as it will appear in the network, and identified by flakes.";
    };
  };

  config = {

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Change default shell
    users.defaultUserShell = pkgs.zsh;
    programs.zsh.enable = true;

    programs.direnv.enable = true;

    programs.nh = {
      enable = true;
      flake = "/home/felbjar/.nix-config"; # Location of the configuration flake

      # Automatic cleanup, essentially nix.gc
      clean.enable = true;
      clean.extraArgs = "--keep-since 7d --keep 3";
    };

    environment.systemPackages = with pkgs; [
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    ];

    # Fonts
    fonts.packages = with pkgs; [
      corefonts
    ];

    # Some apps (e.g. Plex) needs this to login/click on links.
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
    };
  };
}