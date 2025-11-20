{
  description = "Flake of SuperGamer1337";

  outputs =
    inputs@{ nixpkgs, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;

      # Find relevant host names by checking for existing configuration.nix files
      # in the hosts/ directory.
      hostNames = builtins.filter (name: builtins.pathExists ./hosts/${name}/configuration.nix) (
        builtins.attrNames (builtins.readDir ./hosts)
      );

      # Modules to use for a given host, with host-specific extras.
      modulesForHost =
        host:
        lib.concatLists [
          (if host == "nix-wsl" && inputs ? wsl then [ inputs.wsl.nixosModules.default ] else [ ])

          # Common modules
          [
            inputs.home-manager.nixosModules.home-manager
            inputs.stylix.nixosModules.stylix
            inputs.nur.modules.nixos.default
          ]

          # Host-specific configuration
          [ ./hosts/${host}/configuration.nix ]
        ];
    in
    {
      nixosConfigurations = lib.genAttrs hostNames (
        host:
        lib.nixosSystem {
          inherit system;
          specialArgs = { inherit lib inputs; };
          modules = modulesForHost host;
        }
      );

      homeManagerModules.default = import ./modules/home;
    };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    unstable.url = "nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Theme the entire system
    stylix.url = "github:danth/stylix/release-25.05";

    # For WSL
    wsl.url = "github:nix-community/NixOS-WSL/main";

    # For Zen browser
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    # NUR - Nix User Repository
    nur = {
      # Pinned for this version to fix an issue with spotify-adblock
      url = "github:nix-community/NUR/a096d1fd69e90b41dff339a54338b6ee45cc94ee";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
