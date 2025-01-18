{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/nixos
  ];

  config = {
    system.stateVersion = "24.11";

    networking.hostName = "zeus";

    boot.kernelPackages = pkgs.linuxPackages_6_12;

    # blacklist nvidia gpu usb-c kernel module since card has none
    boot.blacklistedKernelModules = ["i2c_nvidia_gpu"];

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

    services.pipewire.extraConfig.pipewire-pulse."92-low-latency" = {
      context.modules = [
        {
          name = "libpipewire-module-protocol-pulse";
          args = {
            pulse.min.req = "512/48000";
            pulse.default.req = "512/48000";
            pulse.max.req = "512/48000";
            pulse.min.quantum = "512/48000";
            pulse.max.quantum = "512/48000";
          };
        }
      ];
      stream.properties = {
        node.latency = "512/48000";
        resample.quality = 1;
      };
    };
  };
}
