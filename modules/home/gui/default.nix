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
        unstable.vscode-fhs

        # Utils
        bitwarden-desktop
        obsidian
      ]
        
      # Work profile
      (lib.mkIf (osConfig.profiles.work.enable) [
        (jetbrains.plugins.addPlugins jetbrains.pycharm-professional ["github-copilot"])
        dbeaver-bin
        whatsapp-for-linux

        # Office suite
        libreoffice
      ])

      # Dev profile
      (lib.mkIf (osConfig.profiles.dev.enable) [
        (jetbrains.plugins.addPlugins jetbrains.rust-rover ["github-copilot"])
        (jetbrains.plugins.addPlugins jetbrains.goland ["github-copilot"])
        (jetbrains.plugins.addPlugins jetbrains.clion ["github-copilot"])
        dbeaver-bin
      ])

      # Personal profile
      (lib.mkIf (osConfig.profiles.personal.enable) [
        # Communication
        slack
        caprine-bin
        vesktop # Discord, modded.
        signal-desktop

        # Media
        unstable.plex-desktop
        nur.repos.nltch.spotify-adblock

        # Remote access windows machines
        parsec-bin
      ])

      # Gaming profile
      (lib.mkIf (osConfig.profiles.gaming.enable) [
        unstable.torzu
	      unstable.dolphin-emu
        unstable.cemu
        unstable.retroarch-full
      ])
    ];
  };
}
