{
  config,
  osConfig,
  pkgs,
  lib,
  ...
}:

{

  options = { };

  config = {
    programs.fastfetch = {
      enable = true;
    };
  };
}
