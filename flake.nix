{
	description = "Flake of SuperGamer1337";

	outputs = inputs@{ self, nixpkgs, home-manager, ... }:
	let
		lib = nixpkgs.lib;
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};
	in {
		homeConfigurations = {
			felbjar = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				modules = [ ./users/felbjar/home.nix ];
			};
		};

		nixosConfigurations = {
			roctim-nix = lib.nixosSystem {
				inherit system;
				modules = [ ./configuration.nix ];
			};
		};
	};

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager/master";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};
}
