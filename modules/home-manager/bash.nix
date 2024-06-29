{
  config,
  lib,
  pkgs,
  ...
}: {
  options.bash.enable = lib.mkEnableOption "Enable bash";

  config = lib.mkIf config.bash.enable {
    home.file.".config/bash/bash-git-prompt" = {
      source = pkgs.fetchFromGitHub {
        owner = "magicmonty";
        repo = "bash-git-prompt";
        rev = "51080c22b2cebb63111379f4eacd22cda199684b";
        sha256 = "sha256-eKh0fNkKi3tLa98uVIsL70+1mA1NMgBwJ1AbtAIPK1o=";
      };
      recursive = true;
    };

    programs.bash = {
      enable = true;
      enableCompletion = true;

      shellAliases = lib.optionalAttrs config.neovim.enable {v = "nvim";};

      sessionVariables = {
        GIT_PROMPT_ONLY_IN_REPO = 1;
      };

      initExtra = ''
        # Add git prompt
        source ~/.config/bash/bash-git-prompt/gitprompt.sh

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
