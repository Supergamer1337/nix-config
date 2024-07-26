{
	description = "Flake of SuperGamer1337";

	outputs = inputs@{ self, nixpkgs, home-manager, python36NixPackages, grub2-themes, ... }:
	let
		lib = nixpkgs.lib; # Needed for... Something.

		profiles = ["work"]; # Available are "work"

		systemSettings = {
			system = "x86_64-linux";
			hostname = "roctim-nix";	
			configDir = "/home/${userSettings.username}/.nix-config";
		};

		userSettings = {
			username = "felbjar"; # User account name
			name = "Felix Bjerhem Aronsson"; # Identifier/real name
		};

		pkgs = nixpkgs.legacyPackages.${systemSettings.system};
		python36NixPkgs = python36NixPackages.legacyPackages.${systemSettings.system};

	in {
		nixosConfigurations = {
			roctim-nix = lib.nixosSystem {
				system = systemSettings.system;
				modules = [ 
					./hosts/roctim-nix/configuration.nix
					grub2-themes.nixosModules.default
				];
				specialArgs = {
					inherit profiles;
					inherit python36NixPkgs;
					inherit userSettings;
					inherit systemSettings;
				};
			};
		};

		# TODO: This should probably be replaced with a NixOS module
		# instead of being a standalone home-manager install.
		homeConfigurations = {
			felbjar = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				modules = [ ./hosts/roctim-nix/home.nix ]; 
				extraSpecialArgs = {
					inherit profiles;
					inherit userSettings;
					inherit systemSettings;
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

		grub2-themes.url = "github:vinceliuice/grub2-themes";
		python36NixPackages.url = "nixpkgs/407f8825b321617a38b86a4d9be11fd76d513da2";
	};
}
