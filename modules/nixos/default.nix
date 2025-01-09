{pkgs, ...}: {
  config = {
    nix.settings.experimental-features = ["nix-command" "flakes"];

    boot = {
      loader = {
        systemd-boot = {
          enable = true;
          configurationLimit = 20;
        };
        efi.canTouchEfiVariables = true;
      };
    };

    networking.networkmanager.enable = true;

    # Timezone and locale
    time.timeZone = "Europe/Stockholm";
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "sv_SE.UTF-8";
      LC_IDENTIFICATION = "sv_SE.UTF-8";
      LC_MEASUREMENT = "sv_SE.UTF-8";
      LC_MONETARY = "sv_SE.UTF-8";
      LC_NAME = "sv_SE.UTF-8";
      LC_NUMERIC = "sv_SE.UTF-8";
      LC_PAPER = "sv_SE.UTF-8";
      LC_TELEPHONE = "sv_SE.UTF-8";
      LC_TIME = "sv_SE.UTF-8";
    };

    # Desktop
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      xkb.layout = "se";
      excludePackages = [pkgs.xterm];
    };

    environment.gnome.excludePackages = with pkgs; [
      gnome-tour
      gnome-user-docs
      gnome-connections
      gnome-backgrounds
      gnome-contacts
      gnome-music
      gnome-maps
      gnome-system-monitor
      totem # Video player
      epiphany # Web browser
      geary # Email reader
      yelp # Help reader
      simple-scan # Document scanner
      seahorse # Secret manager
    ];

    # Configure console keymap
    console.keyMap = "sv-latin1";

    # Enable sound with pipewire.
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    programs.dconf.enable = true;

    services.fwupd.enable = true;

    documentation.nixos.enable = false;
  };
}
