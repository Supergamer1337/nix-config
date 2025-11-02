{ config, lib, pkgs, ... }:

{
  options = {};

  config = let 
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "8.8.8.8" 
      "8.4.4.8"
    ];
  in {
    # Enable networking
    networking = {
      hostName = config.systemSettings.name; # The hostname should be set in systemSettings
      networkmanager.enable = true; # Enable NetworkManager for managing network connections

      nameservers = lib.mkIf (!config.wsl.enable) nameservers;

      hosts = lib.mkIf (config.profiles.work.enable) {
        "127.0.0.1" = [ "roctim-local.com" ];
      };
    };

    # Use resolved for DNS
    services.resolved = {
      enable = lib.mkIf (!config.wsl.enable) true;
      dnssec = "true"; # Use DNSSEC for security
      dnsovertls = "true"; # Use DNS over TLS 
      fallbackDns = nameservers; # Set fallback DNS servers
    };
  };
}
