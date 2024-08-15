{ config, lib, pkgs, ... }:

{
  options = {
    systemSettings.services.tailscale.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable tailscale";
    };
  };

  config = lib.mkIf config.systemSettings.services.tailscale.enable {
    services.tailscale.enable = true;
    networking.hosts = lib.mkIf (config.profiles.dev.enable) {
      "100.123.248.62" = [ "blue-eyed" "traefik.blue-eyed" "whoami.blue-eyed" "auth.blue-eyed" ];
    };
  };
}

