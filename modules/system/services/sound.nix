{ config, lib, pkgs, ... }:

{
  options = {
    services.sound.enable = lib.mkOption {
      type = lib.types.bool;
      default = if !config.systemSettings.desktop.headless then true else false;
      description = "Enable sound";
    };
  };

  config = lib.mkIf (config.services.sound.enable) {
    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };
  };
}