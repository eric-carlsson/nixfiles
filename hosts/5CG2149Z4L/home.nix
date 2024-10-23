{pkgs, ...}: {
  imports = [
    ../../modules/home-manager/default.nix
  ];

  config = {
    home.username = "ecarls18";
    home.homeDirectory = "/home/ecarls18";
    home.stateVersion = "24.05";

    home.packages = with pkgs; [
      gnome-extension-manager
      kubelogin
      kubernetes-helm
      kubectl
      slack
      k9s
      (azure-cli.withExtensions [azure-cli.extensions.aks-preview azure-cli.extensions.k8s-extension])
      terraform
      fluxcd
      crossplane-cli
      drawio
      xournalpp
      kind
      clusterctl
      jdk21_headless
      act
      velero
    ];

    home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
      size = 24;
    };

    programs.bash = {
      shellAliases = {
        t = "terraform";
        k = "kubectl";
        d = "docker";
      };

      sessionVariables = {
        KUBE_EDITOR = "nvim";
      };

      initExtra = ''
        # Enable completion for kubectl (and "k" alias)
        source <(kubectl completion bash)
        complete -o default -F __start_kubectl k

        # Enable completion for docker  (and "d" alias)
        source <(docker completion bash)
        complete -o default -F __start_docker d

        # make less more friendly for non-text input files, see lesspipe(1)
        [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

        # set variable identifying the chroot you work in (used in the prompt below)
        if [ -z "''${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
            debian_chroot=$(cat /etc/debian_chroot)
        fi

        # set a fancy prompt (non-color, unless we know we "want" color)
        case "$TERM" in
            xterm-color|*-256color) color_prompt=yes;;
        esac

        # uncomment for a colored prompt, if the terminal has the capability; turned
        # off by default to not distract the user: the focus in a terminal window
        # should be on the output of commands, not on the prompt
        #force_color_prompt=yes

        if [ -n "$force_color_prompt" ]; then
            if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
          # We have color support; assume it's compliant with Ecma-48
          # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
          # a case would tend to support setf rather than setaf.)
          color_prompt=yes
            else
          color_prompt=
            fi
        fi

        if [ "$color_prompt" = yes ]; then
            PS1="''${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
        else
            PS1="''${debian_chroot:+($debian_chroot)}\u@\h:\w\$ "
        fi
        unset color_prompt force_color_prompt

        # If this is an xterm set the title to user@host:dir
        case "$TERM" in
        xterm*|rxvt*)
            PS1="\[\e]0;''${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
            ;;
        *)
            ;;
        esac

        # enable color support of ls and also add handy aliases
        if [ -x /usr/bin/dircolors ]; then
            test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
            alias ls='ls --color=auto'
            #alias dir='dir --color=auto'
            #alias vdir='vdir --color=auto'

            alias grep='grep --color=auto'
            alias fgrep='fgrep --color=auto'
            alias egrep='egrep --color=auto'
        fi
      '';
    };

    dconf.settings = {
      # Customizations to Ubuntu flavoured dash-to-dock
      "org/gnome/shell/extensions/dash-to-dock" = {
        show-trash = false;
        dock-position = "BOTTOM";
        extend-height = false;
        dock-fixed = false;
        multi-monitor = true;
        show-show-apps-button = false;
      };

      "org/gnome/shell".disabled-extensions = [
        # DING is enabled by default on Ubuntu and conflicts with popshell
        "ding@rastersoft.com"
        # Tiling assistant/enhancing tiling is new to Ubuntu 24.04 and conflicts with popshell
        "tiling-assistant@ubuntu.com"
      ];

      "org/gnome/settings-daemon/plugins/media-keys" = {
        terminal = ["<Super>t"];
      };
    };
  };
}
