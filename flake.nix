{
	description = "Flake of SuperGamer1337";

	outputs = inputs@{ nixpkgs, home-manager, ... }:
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

		pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
		system = "x86_64-linux";

	in {
		nixosConfigurations = {
			roctim-nix = lib.nixosSystem {
				inherit system;
				modules = [ 
					./hosts/roctim-nix/configuration.nix
					inputs.grub2-themes.nixosModules.default
				];
				specialArgs = {
					inherit pkgs;
					inherit lib;
					inherit inputs;
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
	};
}
