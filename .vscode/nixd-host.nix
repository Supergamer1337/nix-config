let
  flake = builtins.getFlake (builtins.getEnv "NH_FLAKE");

  # Extract the current hostname without trailing newline
  # this is an impure operation, but since this is just for an LSP config, it's acceptable
  rawHostName = builtins.readFile /etc/hostname;
  len = builtins.stringLength rawHostName;
  host = builtins.substring 0 (len - 1) rawHostName;
in
{
  pkgs = flake.nixosConfigurations.${host}.pkgs;
  options = flake.nixosConfigurations.${host}.options;
  hmOptions = flake.nixosConfigurations.${host}.options.home-manager.users.type.getSubOptions [ ];
}
