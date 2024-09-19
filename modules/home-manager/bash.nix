{
  config,
  lib,
  ...
}: {
  options.bash.enable = lib.mkEnableOption "Enable bash";

  config = lib.mkIf config.bash.enable {
    programs.bash = {
      enable = true;
      enableCompletion = true;

      shellAliases = lib.optionalAttrs config.neovim.enable {v = "nvim";};

      initExtra = ''
        # Create or attach to "main" tmux session by default
        if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
          exec tmux new-session -A -s main
        fi
      '';
    };

    programs.fzf = {
      enable = true;
      enableBashIntegration = true;
    };
  };
}
