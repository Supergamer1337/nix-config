{ config, pkgs, lib, ...}:

{
  options = {
    # User settings
    user.name = lib.mkOption {
      type = lib.types.str;
      default = "Felix Bjerhem Aronsson";
      description = "The full name of the user account.";
    };

    user.username = lib.mkOption {
      type = lib.types.str;
      default = "felbjar";
      description = "The username fo the user account.";
    };
  };

  config = {
    users.users.${config.user.username} = {
      isNormalUser = true;
      description = config.user.name;
      extraGroups = lib.mkMerge [
        [ "networkmanager" "wheel" ] 
        (lib.mkIf (config.profiles.dev.enable && config.virtualisation.docker.enable) [ "docker" ])
      ];
    };
  };
}