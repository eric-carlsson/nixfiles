{
  config,
  lib,
  ...
}: {
  options.git.enable = lib.mkEnableOption "Enable git";

  config.programs.git = lib.mkIf config.git.enable {
    enable = true;
    userName = "Eric Carlsson";
    userEmail = "97894605+eric-carlsson@users.noreply.github.com";

    aliases = {
      "pu" = "push -u origin HEAD";
      "pf" = "push --force-with-lease";
      "fm" = "fetch origin main:main";
      "rbm" = "rebase main";
      "rbma" = "rebase main --autosquash";
      "cf" = "commit --fixup HEAD";
    };

    extraConfig = {
      "credential \"https://github.com\"".helper = "!gh auth git-credential";
      core.editor = "nvim";
      init.defaultBranch = "main";
    };
  };
}
