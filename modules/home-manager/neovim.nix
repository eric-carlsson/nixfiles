{
  config,
  lib,
  ...
}: {
  options.neovim.enable = lib.mkEnableOption "Enable nixvim";

  config.programs.nixvim = lib.mkIf config.neovim.enable {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    colorschemes.vscode.enable = true;

    opts = {
      number = true;
      incsearch = true;
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      termguicolors = true;
      smartcase = true;
    };

    plugins = {
      lsp = {
        enable = true;
        servers = {
          nil-ls = {
            enable = true;
            settings.formatting.command = ["alejandra"];
          };
        };
      };
      lsp-format.enable = true;
    };
  };
}
