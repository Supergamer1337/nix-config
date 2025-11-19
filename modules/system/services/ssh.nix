{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = { };

  config = {
    services.openssh = {
      enable = true;
    };
  };
}
