# SuperGamer1337's Nix-config

A noob's journey to NixOS configuration.
Contains the all the configurations files for my NixOS configurations.

## Uses

The configuration currently uses these awesome tools (some may also be undocumented):

- NixOS
- Nix Flakes
- Home Manager
- Stylix

# Structure

The structure of the configuration is as follows:

```
nix-config
├── flake.nix # The main flake file
├── themes # Contains the different themes available, as well as their resources (i.e. wallpapers) 
├── hosts
│   ├── TEMPLATE # The template for used by the install script
│   │   ├── configuration.nix # The configuration for the machine
│   └── example-machine # An example machine
│       ├── configuration.nix # The configuration for the machine
│       ├── hardware-configuration.nix # The hardware configuration for the machine
└── modules
    ├── system # System level configuration modules
    └── home # Home level configuration modules
```

Then there are various scripts and other files at the top level (i.e. install.sh) that do not directly relate to the configuration.

## Installation

If you want to install a new system, first use the normal NixOS installation then you can run the install script with the following command:

```sh
curl https://raw.githubusercontent.com/SuperGamer1337/nix-config/main/install.sh && chmod 777 install.sh && sudo ./install.sh
```
