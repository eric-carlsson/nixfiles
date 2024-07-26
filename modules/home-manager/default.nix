{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./bash.nix
    ./git.nix
    ./neovim.nix
    ./tmux.nix
  ];

  config = {
    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      alejandra # Nix formatter
      dnsutils
      gh
      git-absorb
      jq
      tree
      unzip
      wget
      zip
      nil # Nix language server
      fira-code
      fira-code-symbols
      gimp
      xsel
      ripgrep
      fd
      go
      gotools
      golangci-lint
      vscode
      gnomeExtensions.pop-shell
    ];

    programs.firefox.enable = lib.mkDefault true;
    programs.home-manager.enable = lib.mkDefault true;

    bash.enable = lib.mkDefault true;
    git.enable = lib.mkDefault true;
    neovim.enable = lib.mkDefault true;
    tmux.enable = lib.mkDefault true;

    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/interface" = {
          enable-hot-corners = false;
          color-scheme = "prefer-dark";
          show-battery-percentage = true;
        };

        "org/gnome/desktop/wm/preferences".button-layout = ":minimize,close";

        "org/gnome/desktop/wm/keybindings".show-desktop = ["<Super>d"];

        "org/gnome/desktop/search-providers".disabled = [
          "org.gnome.Characters.desktop"
          "org.gnome.clocks.desktop"
        ];

        "org/gnome/mutter" = {
          dynamic-workspaces = true;
          workspaces-only-on-primary = true;
        };

        "org/gnome/mutter/wayland/keybindings".restore-shortcuts = [];

        "org/gnome/mutter/keybindings" = {
          toggle-tiled-left = [];
          toggle-tiled-right = [];
        };

        "org/gnome/shell" = {
          enabled-extensions = ["pop-shell@system76.com"];
          favorite-apps = [];
        };

        "org/gnome/shell/extensions/pop-shell" = {
          stacking-with-mouse = false;

          # Unbind interfering vim keys
          focus-left = ["<Super>Left" "<Super>KP_Left"];
          focus-down = ["<Super>Down" "<Super>KP_Down"];
          focus-right = ["<Super>Right" "<Super>KP_Right"];
          focus-up = ["<Super>Up" "<Super>KP_Up"];
        };

        "org/gnome/settings-daemon/plugins/media-keys" = {
          custom-keybindings = [
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          ];
          www = ["<Super>b"];
          home = ["<Super>f"];
          screensaver = ["<Super>Escape"];
        };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          binding = "<Super>c";
          command = "code";
          name = "VS Code";
        };

        # Custom terminal theme based on Gogh Vs Code Dark+
        "org/gnome/terminal/legacy/profiles:/:88e1f5a3-af7a-4521-9cef-f4ca99337758" = {
          visible-name = "Vs Code Dark+";
          font = "Fira Code 11";
          audible-bell = false;
          background-color = "#1E1E1E1E1E1E";
          foreground-color = "#CCCCCCCCCCCC";
          cursor-colors-set = true;
          cursor-background-color = "#CCCCCCCCCCCC";
          cursor-foreground-color = "#1E1E1E1E1E1E";
          bold-color = "#CCCCCCCCCCCC";
          bold-color-same-as-fg = true;
          use-theme-colors = false;
          use-theme-background = false;
          use-theme-transparency = false;
          scrollbar-policy = "never";
          palette = [
            "#6A6A78787A7A"
            "#E9E965653B3B"
            "#3939E9E9A8A8"
            "#E5E5B6B68484"
            "#4444AAAAE6E6"
            "#E1E175759999"
            "#3D3DD5D5E7E7"
            "#C3C3DDDDE1E1"
            "#595984848989"
            "#E6E650502929"
            "#0000FFFF9A9A"
            "#E8E894944040"
            "#00009A9AFBFB"
            "#FFFF57578F8F"
            "#5F5FFFFFFFFF"
            "#D9D9FBFBFFFF"
          ];
          allow-bold = true;
        };
        "org/gnome/terminal/legacy/profiles:" = {
          list = ["88e1f5a3-af7a-4521-9cef-f4ca99337758"];
          default = "88e1f5a3-af7a-4521-9cef-f4ca99337758";
        };
      };
    };
  };
}
