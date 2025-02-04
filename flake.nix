{
	description = "Flake of SuperGamer1337";

	outputs = inputs@{ nixpkgs, nur, ... }:
	let
		lib = nixpkgs.lib; # Needed for... Something.
		pkgs = import nixpkgs { inherit system; config.allowUnfree = true; overlays = [ nur.overlays.default ]; };
		system = "x86_64-linux";

		# To remove duplication between configurations
		specialArgs = {
			inherit pkgs;
			inherit lib;
			inherit inputs;
		};

		commonModules = [
			inputs.home-manager.nixosModules.home-manager
			inputs.stylix.nixosModules.stylix
			inputs.nur.modules.nixos.default
		];

	in {
		nixosConfigurations = {
			roctim-nix = lib.nixosSystem {
				inherit system;
				inherit specialArgs;
				modules = [ 
					./hosts/roctim-nix/configuration.nix
				] ++ commonModules;
			};

			SuperNix1337 = lib.nixosSystem {
				inherit system;
				inherit specialArgs;
				modules = [ 
					./hosts/SuperNix1337/configuration.nix
				] ++ commonModules;
			};

			nix-wsl = lib.nixosSystem {
				inherit system;
				inherit specialArgs;
				modules = [ 
					inputs.wsl.nixosModules.default
					./hosts/nix-wsl/configuration.nix
				] ++ commonModules;
			};

			TEMPLATE = lib.nixosSystem {
				inherit system;
				inherit specialArgs;
				modules = [ 
					./hosts/TEMPLATE/configuration.nix
				] ++ commonModules;
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

		# For WSL
		wsl.url = "github:nix-community/NixOS-WSL/main";

		# Theme the entire system
		stylix.url = "github:danth/stylix";

		# For Zen browser
		zen-browser.url = "github:0xc000022070/zen-browser-flake";

		# NUR - Nix User Repository
		nur = {
			url = "github:nix-community/NUR";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};
}
