{config, ...}: {
  imports = [
    ../../modules/nixos
  ];

  config = {
    system.stateVersion = "24.11";

    networking.hostName = "zeus";

    # disable apst for kingston nvme
    boot.kernelParams = ["nvme_core.default_ps_max_latency_us=0"];

    # workaround for issue with suspend when kvm is enabled
    # see https://github.com/NixOS/nixpkgs/issues/369376
    systemd.services.systemd-suspend.environment.SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";

    # Graphics drivers
    hardware.graphics.enable = true;
    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    # User account
    users.users.eric = {
      isNormalUser = true;
      description = "Eric Carlsson";
      extraGroups = ["networkmanager" "wheel"];
    };

    programs.steam.enable = true;
  };
}
