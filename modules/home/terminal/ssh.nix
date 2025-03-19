{ config, osConfig, pkgs, lib, ... }:

{
  options = {};

  config = {
    programs.ssh = let
      standardFile = "~/.ssh/id_ed25519";
      roctimFile = "~/.ssh/roctim_git";
    in {
      enable = true;

      addKeysToAgent = "yes";

      matchBlocks = lib.mkIf (osConfig.profiles.work.enable) {
        "github-roctim" = {
          hostname = "github.com";
          identityFile = roctimFile;
        };

        "github.com" = {
          hostname = "github.com";
          identityFile = standardFile;
        };

        "roctim-beta" = {
          hostname = "165.227.3.78";
          user = "root";
          identityFile = standardFile;
        };

        "roctim-prod" = {
          hostname = "167.99.171.160";
          user = "root";
          identityFile = standardFile;
        };
      };
    };
  };
}