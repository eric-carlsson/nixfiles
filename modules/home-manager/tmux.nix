{
  config,
  lib,
  pkgs,
  ...
}: {
  options.tmux.enable = lib.mkEnableOption "Enable tmux";

  config = lib.mkIf config.tmux.enable {
    home.packages = with pkgs; [
      compact-git-status
    ];

    programs.tmux = {
      enable = true;
      baseIndex = 1; # Makes it easier to switch panels and windows
      clock24 = true;
      keyMode = "vi";
      mouse = true;
      prefix = "C-Space";
      terminal = "xterm-256color";
      plugins = with pkgs; [
        tmuxPlugins.yank
      ];
      extraConfig = ''
        set -as terminal-features ",xterm*:RGB"
        set -g status-style bg=#181818,fg=default
        set -g status-right "#( compact-git-status --path #{pane_current_path} )"

        # split window into cwd
        bind '"' split-window -v -c "#{pane_current_path}"
        bind % split-window -h -c "#{pane_current_path}"
      '';
    };
  };
}
