{
	description = "Flake of SuperGamer1337";

	outputs = inputs@{ self, nixpkgs, home-manager, python36NixPackages, ... }:
	let
		profiles = ["work"]; # Available are "work"
		lib = nixpkgs.lib;
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};
		python36NixPkgs = python36NixPackages.legacyPackages.${system};

		userSettings = {
			username = "felbjar"; # User account name
			name = "Felix Bjerhem Aronsson"; # Identifier/real name
		};
	in {
		homeConfigurations = {
			user = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				modules = [ ./user/home.nix ];
				extraSpecialArgs = {
					inherit profiles;
					inherit userSettings;
				};
			};
		};

		nixosConfigurations = {
			roctim-nix = lib.nixosSystem {
				inherit system;
				modules = [ ./configuration.nix ];
				specialArgs = {
					inherit profiles;
					inherit python36NixPkgs;
					inherit userSettings;
				};
			};
		};
	};

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager/master";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		python36NixPackages.url = "nixpkgs/407f8825b321617a38b86a4d9be11fd76d513da2";
	};
}
