{ config, pkgs, lib, ... }:

{
  imports = [
    ./desktop
    ./terminal
    ./essential
  ];

  options = {
    profiles.work.enable = lib.mkEnableOption "Enable work additions";
    profiles.dev.enable = lib.mkEnableOption "Enable dev additions";

    # User settings
    userSettings.username = lib.mkOption {
      type = lib.types.str;
      default = "felbjar";
      description = "The username of the user";
    };

    userSettings.name = lib.mkOption {
      type = lib.types.str;
      default = "Felix Bjerhem Aronsson";
      description = "The full name of the user";
    };

    userSettings.email = lib.mkOption {
      type = lib.types.str;
      default = "felix.b.aronsson@gmail.com";
      description = "The email of the user";
    };
  };

  config = {
    home.packages = with pkgs; lib.mkMerge [ 
      [
        # Essentials
        neovim
        brave
        fastfetch

        # Communication
        slack
        whatsapp-for-linux
        caprine-bin
        vesktop # Discord, modded.
        signal-desktop

        # Media
        plex-desktop

        # Development
        vscode-fhs
        nil # Nix LSP
        nixd # Alternative LSP
      ]

      # Work profile
      (lib.mkIf (config.profiles.work.enable) [
        jetbrains.pycharm-professional
      ])

      # Dev profile
      (lib.mkIf (config.profiles.dev.enable) [
        dbeaver-bin
      ])
    ];
  };
}