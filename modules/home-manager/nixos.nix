{
  config,
  lib,
  pkgs,
  ...
}: {
  options.nixos.enable = lib.mkEnableOption "Enable NixOS-specific home configuration";

  config = lib.mkIf config.nixos.enable {
    home = {
      packages = with pkgs; [
        gnomeExtensions.dash-to-dock
      ];

      file.".local/share/backgrounds/wallpaper.png" = {
        source = ./wallpaper.png;
        recursive = true;
      };
    };

    dconf = {
      enable = true;
      settings = {
        "org/gnome/shell".enabled-extensions = [
          "dash-to-dock@micxgx.gmail.com"
        ];

        "org/gnome/shell/extensions/dash-to-dock" = {
          show-trash = false;
          click-action = "focus-or-previews";
          multi-monitor = true;
          show-show-apps-button = false;
          disable-overview-on-startup = true;
          apply-custom-theme = true;
        };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
          binding = "<Super>t";
          command = "kgx";
          name = "GNOME console";
        };

        "org/gnome/settings-daemon/plugins/media-keys" = {
          custom-keybindings = [
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
          ];
        };

        "org/gnome/desktop/background" = {
          picture-uri = "file:///home/eric/.local/share/backgrounds/wallpaper.png";
          picture-uri-dark = "file:///home/eric/.local/share/backgrounds/wallpaper.png";
          picture-options = "zoom";
          color-shading-type = "solid";
          primary-color = "#000000000000";
          secondary-color = "#000000000000";
        };

        "org/gnome/desktop/screensaver" = {
          picture-uri = "file:///home/eric/.local/share/backgrounds/wallpaper.png";
          primary-color = "#000000000000";
          secondary-color = "#000000000000";
        };
      };
    };
  };
}
