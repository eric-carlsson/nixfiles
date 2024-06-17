{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  home.username = "eric";
  home.homeDirectory = "/home/eric";

  home.packages = with pkgs; [
    alejandra
    dnsutils
    fzf
    gh
    gnomeExtensions.dash-to-dock
    gnomeExtensions.pop-shell
    jq
    kubectl
    tree
    unzip
    vscode
    wget
    zip
    nil
  ];

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

  programs.bash = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      k = "kubectl";
      v = "nvim";
    };
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

  dconf = {
    enable = true;
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
        disable-overview-on-startup = true;
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        ];
        www = ["<Super>b"];
        home = ["<Super>f"];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Super>t";
        command = "kgx";
        name = "GNOME Console";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        binding = "<Super>c";
        command = "code";
        name = "VS Code";
      };
    };
  };

  programs.home-manager.enable = true;

  home.stateVersion = "24.05";
}
