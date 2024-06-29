{
	description = "Flake of SuperGamer1337";

	outputs = inputs@{ self, nixpkgs, home-manager, ... }:
	let
		systemSettings = {
			system = "x86_64-linux";
			hostname = "roctim-nix";
			timezone = "Europe/Stockholm";
			locale = "en_US.UTF-8";
		};

		userSettings = {
			username = "felbjar";
			name = "Felix Bjerhem Aronsson";
		};


		lib = nixpkgs.lib;
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};
	in {
		homeConfigurations = {
			felbjar = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				modules = [ ./home.nix ];
				extraSpecialArgs = {
					inherit systemSettings;
					inherit userSettings;
				}
			};
		};

		nixosConfigurations = {
			roctim-nix = lib.nixosSystem {
				system = systemSettings.system;
				modules = [ ./configuration.nix ];
				extraSpecialArgs = {
					inherit systemSettings;
					inherit userSettings;
				}
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
