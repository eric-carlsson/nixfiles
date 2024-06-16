{ pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-0c2d4121-e87f-4744-86a3-0e85a001e43d".device = "/dev/disk/by-uuid/0c2d4121-e87f-4744-86a3-0e85a001e43d";

  networking.hostName = "hades";
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
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.xkb.layout = "se";
  services.xserver.excludePackages = [ pkgs.xterm ];

  # Configure console keymap
  console.keyMap = "sv-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.eric = {
    isNormalUser = true;
    description = "Eric Carlsson";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Install firefox.
  programs.firefox.enable = true;
  programs.neovim.enable = true;
  programs.git.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vscode
    tree
    wget
    gh
    alejandra
    gnomeExtensions.pop-shell
    gnomeExtensions.dash-to-dock
  ];

  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
    gnome-user-docs
    gnome-connections
  ]) ++ (with pkgs.gnome; [
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
  ]);

  programs.dconf = {
    enable = true;

    profiles.user.databases = [{
      settings = {
        "org/gnome/desktop/interface" = {
          enable-hot-corners = false;
          color-scheme = "prefer-dark";
          show-battery-percentage = true;
        };

        "org/gnome/desktop/wm/preferences".button-layout = ":minimize,close";

        "org/gnome/mutter" = {
          dynamic-workspaces = true;
          workspaces-only-on-primary = true;
        };

        "org/gnome/shell".enabled-extensions = [
          "pop-shell@system76.com"
          "dash-to-dock@micxgx.gmail.com"
        ];

        "org/gnome/shell/extensions/dash-to-dock" = {
          click-action = "focus-or-previews";
          multi-monitor = true;
          show-show-apps-button = false;
        };

        "org/gnome/settings-daemon/plugins/media-keys" = {
          custom-keybindings = [
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          ];
          www = [ "<Super>b" ];
          home = [ "<Super>f" ];
        };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          binding = "<Super>t";
          command = "kgx";
          name = "GNOME Console";
        };
      };
    }];
  };

  documentation.nixos.enable = false;

  system.stateVersion = "24.05";
}
