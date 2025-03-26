{ config, osConfig, pkgs, lib, ... }:

{
  options = {};

  config = {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
          ll = "ls -l";
          la = "ls -la";
          cd = "z";
          nixc = "cd ${osConfig.systemSettings.configDir}"; 
      };

      history = {
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
      };

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "direnv" ];
      };
    };

    programs.oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      useTheme = "bubblesextra";
    };
  };
}
