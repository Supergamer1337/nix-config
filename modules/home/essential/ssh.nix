{ config, pkgs, lib, ... }:

{
  options = {};

  config = {
    programs.ssh = {
      enable = true;
      matchBlocks = lib.mkIf (config.profiles.work.enable) {
        "github-roctim" = {
          hostname = "github.com";
          identityFile = "~/.ssh/roctim_git";
        };

        "github.com" = {
          hostname = "github.com";
          identityFile = "~/.ssh/id_ed25519";
        };
      };
    };
  };
}