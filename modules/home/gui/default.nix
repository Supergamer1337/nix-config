{ config, osConfig, pkgs, lib, inputs, ... }:

{
  imports = [
    ./alacritty.nix
  ];

  options = {};

  config = lib.mkIf (!osConfig.systemSettings.desktop.headless) {
    home.packages = with pkgs; lib.mkMerge [
      # Always enabled
      [
      	# Essentials 
        inputs.zen-browser.packages."${system}".default
        protonvpn-gui

	      # Development
        unstable.vscode

        # Utils
        bitwarden-desktop
        obsidian
        ticktick
        nextcloud-client

        # One school project
        unityhub
      ]
        
      # Work profile
      (lib.mkIf (osConfig.profiles.work.enable) [
        dbeaver-bin
        whatsapp-for-linux

        # Office suite
        libreoffice
      ])

      # Dev profile
      (lib.mkIf (osConfig.profiles.dev.enable) [
        dbeaver-bin
        jetbrains-toolbox
      ])

      # Personal profile
      (lib.mkIf (osConfig.profiles.personal.enable) [
        # Communication
        slack
        caprine-bin
        vesktop # Discord, modded.
        signal-desktop
        whatsapp-for-linux

        # Media
        unstable.plex-desktop
        #nur.repos.nltch.spotify-adblock - Hash mismatch
        youtube-music

        # Remote access windows machines
        parsec-bin
      ])

      # Gaming profile
      (lib.mkIf (osConfig.profiles.gaming.enable) [
        # unstable.torzu - Taken down due to legal issues.
        cemu

        (retroarch.withCores (cores: with cores; [
            # Wii/Gamecube
            dolphin

            # Gameboy
            vba-m    
        ]))
      ])
    ];
  };
}
