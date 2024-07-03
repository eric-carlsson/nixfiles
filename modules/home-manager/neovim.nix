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
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            {name = "nvim_lsp";}
          ];
          mapping = {
            "<S-d>" = "cmp.mapping.scroll_docs(-4)";
            "<S-f>" = "cmp.mapping.scroll_docs(4)";
            "<S-e>" = "cmp.mapping.close()";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          };
        };
      };
      comment.enable = true;
      indent-blankline = {
        enable = true;
        settings = {
          indent = {
            char = "▏";
          };
          scope = {
            char = "▎";
            show_end = false;
            show_exact_scope = true;
            show_start = false;
          };
        };
      };
      lsp = {
        enable = true;
        servers = {
          nil-ls = {
            enable = true;
            settings.formatting.command = ["alejandra"];
          };
          yamlls.enable = true;
          bashls.enable = true;
        };
      };
      lsp-format.enable = true;
      nvim-autopairs.enable = true;
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
