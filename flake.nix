{
	description = "Flake of SuperGamer1337";

	outputs = inputs@{ nixpkgs, ... }:
	let
		system = "x86_64-linux";
		lib = nixpkgs.lib;

		# To remove duplication between configurations
		specialArgs = {
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

			tapo-nix = lib.nixosSystem {
				inherit system;
				inherit specialArgs;
				modules = [ 
					./hosts/tapo-nix/configuration.nix
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
