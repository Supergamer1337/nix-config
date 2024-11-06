{ config, osConfig, pkgs, lib, inputs, ... }:

{
  imports = [
    ./desktop
    ./terminal
    ./essential
    ../../themes/home.nix
  ];

  options = {};

  config = {
    home.packages = with pkgs; lib.mkMerge [ 
      [
        # Essentials
        neovim
        inputs.zen-browser.packages."${system}".specific
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

        # Utils
        bitwarden-desktop
        obsidian
      ]

      # Work profile
      (lib.mkIf (osConfig.profiles.work.enable) [
        (jetbrains.plugins.addPlugins jetbrains.pycharm-professional ["github-copilot"])
        nodejs_22 # Required for copilot in JetBrains... Apparently
      ])

      # Dev profile
      (lib.mkIf (osConfig.profiles.dev.enable) [
        (jetbrains.plugins.addPlugins jetbrains.rust-rover ["github-copilot"])
        (jetbrains.plugins.addPlugins jetbrains.goland ["github-copilot"])
        (jetbrains.plugins.addPlugins jetbrains.clion ["github-copilot"])
        dbeaver-bin
        nodejs_22 # Required for copilot in JetBrains... Apparently
      ])
    ];
  };
}
