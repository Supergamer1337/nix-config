{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./sound.nix
    ./docker.nix
    ./tailscale.nix
    ./zram-swap.nix
  ];

  options = { };

  config = {
    services.joycond.enable = config.profiles.gaming.enable;
  };
}
