{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = { };

  config = {
    virtualisation.docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };
}
