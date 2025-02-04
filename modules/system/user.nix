{ config, pkgs, lib, inputs, ...}:

{
  options = {
    # User settings
    userSettings.name = lib.mkOption {
      type = lib.types.str;
      default = "Felix Bjerhem Aronsson";
      description = "The full name of the user account.";
    };

    userSettings.username = lib.mkOption {
      type = lib.types.str;
      default = "felbjar";
      description = "The username fo the user account.";
    };

    userSettings.email = lib.mkOption {
      type = lib.types.str;
      default = "felix.b.aronsson@gmail.com";
      description = "The email address of the user account.";
    };

    # Home manager options
    home.initialStateVersion = lib.mkOption {
      type = lib.types.str;
      description = "The state version of Home Manager used at initial setup. Avoid changing this.";
    };
  };

  config = {
    users.users.${config.userSettings.username} = {
      isNormalUser = true;
      description = config.userSettings.name;
      extraGroups = lib.mkMerge [
        [ "networkmanager" "wheel" ] 
        (lib.mkIf (config.profiles.dev.enable && config.virtualisation.docker.enable) [ "docker" ])
      ];
    };

    # Change default shell
    users.defaultUserShell = pkgs.zsh;
    programs.zsh.enable = true;

    # Home manager setup
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;

    home-manager.sharedModules = [
      inputs.self.homeManagerModules.default
    ];

    home-manager = {
      extraSpecialArgs = { inherit inputs pkgs; osConfig = config; };
      users.${config.userSettings.username} = { config, osConfig, pkgs, lib, ...  } : {
        home.username = osConfig.userSettings.username;
        home.homeDirectory = "/home/" + osConfig.userSettings.username;

        # Let Home Manager install and manage itself.
        programs.home-manager.enable = true;

        home.stateVersion = osConfig.home.initialStateVersion;
      };
    };

  };
}