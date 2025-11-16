{
  config,
  osConfig,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./git.nix
    ./ssh.nix
    ./zsh.nix
  ];

  options = { };

  config = {
    home.packages =
      with pkgs;
      lib.mkMerge [
        # Terminal Applications
        [
          # Essentials
          neovim
          fastfetch
          zip
          unzip
          bat
          btop
          wget

          # Development
          nixd # Nix LSP
          nixfmt-rfc-style # Nix formatter
        ]

        # Work profile
        (lib.mkIf (osConfig.profiles.work.enable) [
          nodejs_22 # Required for copilot in JetBrains... Apparently
        ])

        # Dev profile
        (lib.mkIf (osConfig.profiles.dev.enable) [
          nodejs_22 # Required for copilot in JetBrains... Apparently
        ])
      ];

    programs.zoxide.enable = true;
  };
}
