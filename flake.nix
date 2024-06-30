{
	description = "Flake of SuperGamer1337";

	outputs = inputs@{ self, nixpkgs, home-manager, nixpkgs-python, ... }:
	let
		profiles = ["work"]; # "work"
		lib = nixpkgs.lib;
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};
	in {
		homeConfigurations = {
			felbjar = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				modules = [ ./users/felbjar/home.nix ];
				extraSpecialArgs = {
					inherit profiles;
				};
			};
		};

		nixosConfigurations = {
			roctim-nix = lib.nixosSystem {
				inherit system;
				modules = [ ./configuration.nix ];
				specialArgs = {
					inherit profiles;
					inherit nixpkgs-python;
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

		nixpkgs-python.url = "github:cachix/nixpkgs-python";
	};
}
