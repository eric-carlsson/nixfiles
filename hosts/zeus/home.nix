{
  pkgs,
  nixvim,
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    sharedModules = [
      nixvim.homeManagerModules.nixvim
    ];

    users.eric = {
      imports = [
        ../../modules/home-manager/default.nix
      ];

      config = {
        home.stateVersion = "24.11";
        home.username = "eric";
        home.homeDirectory = "/home/eric";

        home.packages = with pkgs; [
          gnomeExtensions.dash-to-dock
        ];

        xdg.mimeApps = {
          enable = true;
          defaultApplications = {
            "x-scheme-handler/http" = "firefox.desktop";
            "text/html" = "firefox.desktop";
            "application/xhtml+xml" = "firefox.desktop";
            "x-scheme-handler/https" = "firefox.desktop";
            "image/jpeg" = "org.gnome.Loupe.desktop";
            "image/png" = "org.gnome.Loupe.desktop";
            "image/gif" = "org.gnome.Loupe.desktop";
            "image/webp" = "org.gnome.Loupe.desktop";
            "image/tiff" = "org.gnome.Loupe.desktop";
            "image/x-tga" = "org.gnome.Loupe.desktop";
            "image/vnd-ms.dds" = "org.gnome.Loupe.desktop";
            "image/x-dds" = "org.gnome.Loupe.desktop";
            "image/bmp" = "org.gnome.Loupe.desktop";
            "image/vnd.microsoft.icon" = "org.gnome.Loupe.desktop";
            "image/vnd.radiance" = "org.gnome.Loupe.desktop";
            "image/x-exr" = "org.gnome.Loupe.desktop";
            "image/x-portable-bitmap" = "org.gnome.Loupe.desktop";
            "image/x-portable-graymap" = "org.gnome.Loupe.desktop";
            "image/x-portable-pixmap" = "org.gnome.Loupe.desktop";
            "image/x-portable-anymap" = "org.gnome.Loupe.desktop";
            "image/x-qoi" = "org.gnome.Loupe.desktop";
            "image/svg+xml" = "org.gnome.Loupe.desktop";
            "image/svg+xml-compressed" = "org.gnome.Loupe.desktop";
            "image/avif" = "org.gnome.Loupe.desktop";
            "image/heic" = "org.gnome.Loupe.desktop";
            "image/jxl" = "org.gnome.Loupe.desktop";
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
          };
        };
      };
    };
  };
}
