{
  config,
  osConfig,
  pkgs,
  lib,
  ...
}:
{
  imports = [
  ];

  options = { };

  config = lib.mkIf (osConfig.systemSettings.desktop.cosimc.enable) {
    services.gnome-keyring = {
      enable = true;
      components = [
        "pkcs11"
        "secrets"
        "ssh"
      ];
    };

    xdg.configFile."autostart/dbus-display-env.desktop".text = ''
      [Desktop Entry]
      Name=DBUS Display Env
      Comment=Fixes dbus display env for gnome keyring password prompt to work on cosmic
      GenericName=Fix
      Exec=dbus-update-activation-environment --systemd DISPLAY
      Type=Application
      StartupNotify=True
    '';
  };
}
