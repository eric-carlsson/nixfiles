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

    globals.mapleader = ",";

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
      which-key.enable = true;
      telescope = {
        enable = true;
        extensions = {
          fzf-native = {
            enable = true;
          };
        };
        keymaps = {
          "<leader>ff" = {
            action = "find_files";
            options.desc = "Find files with telescope";
          };
          "<leader>fw" = {
            action = "live_grep";
            options.desc = "Find text with telescope";
          };
        };
      };
      treesitter.enable = true;
    };
  };
}
