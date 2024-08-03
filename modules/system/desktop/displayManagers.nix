{ config, pkgs, lib, ...}:

{
  options = {
    systemSettings.desktop.displayManager = lib.mkOption {
      type = lib.types.enum [ "gdm" "sddm" "none" ];
      default = "gdm";
      description = "The display manager to use.";
    };
  };

  config = {
    services.displayManager.sddm = lib.mkIf (config.systemSettings.desktop.displayManager == "ssdm") {
      enable = true;
      wayland.enable = true;
    };

    # If using gdm, enable xserver and gdm
    services.xserver = lib.mkIf (config.systemSettings.desktop.displayManager == "gdm") {
      enable = true;
      displayManager.gdm.enable = true;
    };
  };

}