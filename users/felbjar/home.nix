{ config, pkgs, profiles, ... }:

{
  imports = [
    ./desktops/gnome/module.nix

    # Install work packages
    ({pkgs, profiles, ...}:{
      home.packages = if builtins.elem "work" profiles then with pkgs; [
        jetbrains.pycharm-professional
	      dbeaver-bin
      ] else [];
    })
  ];

  nixpkgs.config.allowUnfree = true;

  home.username = "felbjar";
  home.homeDirectory = "/home/felbjar";


  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # Essentials
    neovim 
    brave
    fastfetch

    # Movies and stuff
    plex-media-player

    # Communication
    slack
    whatsapp-for-linux
    caprine-bin
    discord
    signal-desktop
  ];

  programs.vscode = {
  	enable = true;
	  extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      bbenoist.nix
    ];
  };

  programs.git = {
    enable = true;
    userEmail = "felix.b.aronsson@gmail.com";
    userName = "Felix Bjerhem Aronsson";
  };

  programs.alacritty = {
    enable = true;
    settings = {
      window.startup_mode = "Maximized";
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      ssh-roctim-prod = "ssh root@167.99.171.160";
      ssh-roctim-beta = "ssh root@165.227.3.78";
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "direnv" ];
      theme = "robbyrussell";
    };
  };

  # Setup SSH for work
  
  programs.ssh = if builtins.elem "work" profiles then {
    enable = true;
    matchBlocks = {
      "github-roctim" = {
        hostname = "github.com";
        identityFile = "~/.ssh/roctim_git";
      };

      "github" = {
      	hostname = "github.com";
	identityFile = "~/.ssh/id_ed25519";
      };
    };
  } else {};


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.
}
