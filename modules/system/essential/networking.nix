{ config, lib, pkgs, ... }:

{
  options = {
    systemSettings.networking = {
      resolved.enable = lib.mkEnableOption {
        default = true;
        description = "Enable systemd-resolved for DNS resolution.";
      };

      nameservers = {
        list = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ "1.1.1.1" "1.0.0.1" "8.8.8.8" "8.4.4.8" ];
        };
        
        enable = lib.mkEnableOption {
          default = false;
          description = "Enable custom DNS nameservers.";
        };
      };
    };
  };

  config = {
    # Enable networking
    networking = {
      hostName = config.systemSettings.name; # The hostname should be set in systemSettings
      networkmanager.enable = true; # Enable NetworkManager for managing network connections

      nameservers = lib.mkIf (config.systemSettings.networking.nameservers.enable) config.systemSettings.networking.nameservers.list;

      hosts = lib.mkIf (config.profiles.work.enable) {
        "127.0.0.1" = [ "roctim-local.com" ];
      };
    };

    # Use resolved for DNS
    services.resolved = {
      enable = config.systemSettings.networking.resolved.enable;
      dnssec = "true"; # Use DNSSEC for security
      dnsovertls = "true"; # Use DNS over TLS 
      fallbackDns = lib.mkIf (config.systemSettings.networking.nameservers.enable) config.systemSettings.networking.nameservers.list;
    };
  };
}
