{ config, osConfig, pkgs, lib, ... }:

{
  imports = [
    ./desktop
    ./terminal
    ./essential
  ];

  options = {};

  config = {
    home.packages = with pkgs; lib.mkMerge [ 
      [
        # Essentials
        neovim
        brave
        fastfetch
        zip
        unzip
        bat
        btop

        # Communication
        slack
        whatsapp-for-linux
        caprine-bin
        vesktop # Discord, modded.
        signal-desktop

        # Media
        plex-desktop
	      netflix

        # Development
        vscode-fhs
        nil # Nix LSP
        nixd # Alternative LSP
      ]

      # Work profile
      (lib.mkIf (osConfig.profiles.work.enable) [
        jetbrains.pycharm-professional
      ])

      # Dev profile
      (lib.mkIf (osConfig.profiles.dev.enable) [
        jetbrains.rust-rover 
        jetbrains.goland
        dbeaver-bin
      ])
    ];
  };
}
