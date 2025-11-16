{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    systemSettings.services.tailscale.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable tailscale";
    };
  };

  config = lib.mkIf config.systemSettings.services.tailscale.enable {
    services.tailscale = {
      enable = true;
      useRoutingFeatures = "client"; # Use client routing features
    };
  };
}
