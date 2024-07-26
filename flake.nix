{
	description = "Flake of SuperGamer1337";

	outputs = inputs@{ nixpkgs, home-manager, ... }:
	let
		lib = nixpkgs.lib; # Needed for... Something.
		pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
		system = "x86_64-linux";

	in {
		nixosConfigurations = {
			roctim-nix = lib.nixosSystem {
				inherit system;
				modules = [ 
					./hosts/roctim-nix/configuration.nix
					inputs.home-manager.nixosModules.home-manager
					inputs.grub2-themes.nixosModules.default
				];
				specialArgs = {
					inherit pkgs;
					inherit lib;
					inherit inputs;
				};
			};
		};

		homeManagerModules.default = import ./modules/home;
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
