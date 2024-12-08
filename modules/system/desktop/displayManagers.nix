{ config, pkgs, lib, ...}:

{
  options = {
    systemSettings.desktop.displayManager = lib.mkOption {
      type = if config.systemSettings.desktop.enable != "none" then lib.types.enum [ "gdm" "sddm" ] else lib.types.enum [ "none" ];
      default = "none";
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