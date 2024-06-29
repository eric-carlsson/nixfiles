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
    extraConfig = {
      "credential \"https://github.com\"".helper = "!gh auth git-credential";
      core.editor = "nvim";
      init.defaultBranch = "main";
    };
  };
}
