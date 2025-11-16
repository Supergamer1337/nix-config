{
  osConfig,
  config,
  lib,
  pkgs,
  ...
}:

{
  options = { };

  config = {
    stylix.targets.wofi.enable = true;
  };

}
