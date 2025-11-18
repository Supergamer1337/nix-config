{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    systemSettings.services.zramSwap.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable zram swap";
    };
  };

  config = lib.mkIf (config.systemSettings.services.zramSwap.enable) {
    zramSwap.enable = true;
    zramSwap.memoryPercent = 200;

    boot.kernel.sysctl = {
      "vm.swappiness" = 180;
      "vm.watermark_boost_factor" = 0;
      "vm.watermark_scale_factor" = 125;
      "vm.page-cluster" = 0;
    };
  };
}
