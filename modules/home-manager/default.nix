{
  pkgs,
  pkgs-unstable,
  ...
}: {
  config = {
    fonts.fontconfig.enable = true;

    home.packages =
      (with pkgs; [
        alejandra # Nix formatter
        dnsutils
        gh
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
      ])
      ++ (with pkgs-unstable; [
        vscode # some extensions only work with up-to-date vscode
      ]);

    programs.firefox.enable = true;

    programs.git = {
      enable = true;
      userName = "Eric Carlsson";
      userEmail = "97894605+eric-carlsson@users.noreply.github.com";
      extraConfig = {
        "credential \"https://github.com\"".helper = "!gh auth git-credential";
        core.editor = "nvim";
        init.defaultBranch = "main";
      };
    };

    programs.fzf = {
      enable = true;
      enableBashIntegration = true;
    };

    programs.bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        v = "nvim";
      };
      sessionVariables = {
        KUBE_EDITOR = "nvim";
      };
      initExtra = ''
        # Enable completion for kubectl (and "k" alias)
        source <(kubectl completion bash)
        complete -o default -F __start_kubectl k

        # Create or attach to "main" tmux session by default
        if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
          exec tmux new-session -A -s main
        fi
      '';
    };

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      plugins = with pkgs.vimPlugins; [
        vim-code-dark
        autoclose-nvim
      ];
      extraLuaConfig = ''
        vim.cmd[[colorscheme codedark]]
        require("autoclose").setup()
      '';
    };

    programs.tmux = let
      tmux-dark-plus-theme =
        pkgs.tmuxPlugins.mkTmuxPlugin
        {
          pluginName = "dark-plus";
          version = "1";
          src = pkgs.fetchFromGitHub {
            owner = "khanghh";
            repo = "tmux-dark-plus-theme";
            rev = "3397e622a52c72e5ba92776f02d6ff560ef7bd2a";
            sha256 = "sha256-IqyJd6Sm95l4Gf0F54OIcBgOskeL2CqJvpopJJMsc1Q=";
          };
        };
    in {
      enable = true;
      baseIndex = 1; # Makes it easier to switch panels and windows
      clock24 = true;
      keyMode = "vi";
      mouse = true;
      prefix = "C-Space";
      terminal = "screen-256color";
      plugins = with pkgs; [
        tmuxPlugins.yank
        tmux-dark-plus-theme
      ];
      extraConfig = ''
        # split window into cwd
        bind '"' split-window -v -c "#{pane_current_path}"
        bind % split-window -h -c "#{pane_current_path}"
      '';
    };

    programs.home-manager.enable = true;

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
