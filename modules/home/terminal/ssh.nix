{ config, osConfig, pkgs, lib, ... }:

{
  options = {};

  config = {
    programs.ssh = let
      standardFile = "~/.ssh/id_ed25519";
      roctimFile = "~/.ssh/roctim_git";
      eloquentServerFile = "~/.ssh/eloquent_server";
    in {
      enable = true;

      addKeysToAgent = "yes";

      matchBlocks = {
        "github.com" = {
          hostname = "github.com";
          identityFile = standardFile;
        };

        "skyraid" = lib.mkIf (osConfig.systemSettings.services.tailscale.enable && osConfig.profiles.personal.enable) {
          hostname = "10.69.69.69";
          user = "root";
          identityFile = standardFile;
        };
        
        "eloquent-server" = {
          hostname = "79.76.49.90";
          user = "root";
          identityFile = eloquentServerFile;
        };

        ###### Work profile ######

        "github-roctim" = lib.mkIf (osConfig.profiles.work.enable) {
          hostname = "github.com";
          identityFile = roctimFile;
        };

        "roctim-beta" = lib.mkIf (osConfig.profiles.work.enable) {
          hostname = "165.227.3.78";
          user = "root";
          identityFile = standardFile;
        };

        "roctim-prod" = lib.mkIf (osConfig.profiles.work.enable) {
          hostname = "167.99.171.160";
          user = "root";
          identityFile = standardFile;
        };

      };
    };
  };
}