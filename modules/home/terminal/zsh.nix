{ config, osConfig, pkgs, lib, ... }:

{
  options = {};

  config = {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = 
        {
          ll = "ls -l";
        }
        # Work aliases
        // lib.optionalAttrs (osConfig.profiles.work.enable) {
          "ssh-roctim-prod" = "ssh root@167.99.171.160";
          "ssh-roctim-beta" = "ssh root@165.227.3.78";
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

      initExtra = ''
        fastfetch
      '';
    };
  };
}