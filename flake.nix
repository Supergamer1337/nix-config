{
	description = "Flake of SuperGamer1337";

	outputs = inputs@{ self, nixpkgs, home-manager, python36NixPackages, grub2-themes, ... }:
	let
		lib = nixpkgs.lib; # Needed for... Something.

		profiles = ["work"]; # Available are "work"

		systemSettings = {
			system = "x86_64-linux";
			hostname = "roctim-nix";	
		};

		userSettings = {
			username = "felbjar"; # User account name
			name = "Felix Bjerhem Aronsson"; # Identifier/real name
		};

		pkgs = nixpkgs.legacyPackages.${systemSettings.system};
		python36NixPkgs = python36NixPackages.legacyPackages.${systemSettings.system};

	in {
		homeConfigurations = {
			user = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				modules = [ ./user/home.nix ];
				extraSpecialArgs = {
					inherit profiles;
					inherit userSettings;
					inherit systemSettings;
				};
			};
		};

		nixosConfigurations = {
			${systemSettings.hostname} = lib.nixosSystem {
				system = systemSettings.system;
				modules = [ 
					./configuration.nix
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
