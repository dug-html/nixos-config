{
  inputs,
  lib,
  ...
}: {
  imports = [inputs.nvf.nixosModules.default];
  programs.nvf = {
    enable = true;
    settings.vim = {
      options = {
        expandtab = true;
        shiftwidth = 4;
        tabstop = 4;
      };
      autocomplete.blink-cmp = {
        enable = true;
        friendly-snippets.enable = true;
        setupOpts = {
          snippets = {
            expand = lib.generators.mkLuaInline ''
              function(snippet)
                require('luasnip').lsp_expand(snippet)
              end
            '';
          };
        };
      };
      binds.whichKey.enable = true;
      clipboard.providers.wl-copy.enable = true;
      filetree.neo-tree.enable = true;
      git = {
        enable = true;
        gitsigns.enable = true;
      };
      languages = {
        bash.enable = true;
        enableExtraDiagnostics = true;
        enableFormat = true;
        enableTreesitter = true;
        fish.enable = true;
        java.enable = true;
        json = {
          enable = true;
          format.type = ["biome"];
        };
        lua.enable = true;
        markdown.enable = true;
        nix = {
          enable = true;
          format.type = ["alejandra" "injected"];
        };
        python.enable = true;
        rust.enable = true;
        xml.enable = true;
      };
      lsp = {
        enable = true;
        formatOnSave = true;
        lightbulb.enable = true;
        trouble.enable = true;
      };
      preventJunkFiles = true;
      searchCase = "smart";
      snippets.luasnip.enable = true;
      statusline.lualine.enable = true;
      tabline.nvimBufferline.enable = true;
      telescope.enable = true;
      theme = {
        enable = false;
        name = "catppuccin";
        style = "mocha";
        transparent = false;
      };
      treesitter = {
        enable = true;
        context.enable = true;
      };
      undoFile.enable = true;
      viAlias = true;
      vimAlias = true;
      notify.nvim-notify.enable = true;
      ui = {
        borders.enable = true;
        illuminate.enable = true;
        colorizer.enable = true;
        noice.enable = true;
      };
      notes = {
        todo-comments.enable = true;
      };
      navigation.harpoon.enable = true;
      terminal = {
        toggleterm = {
          enable = true;
          lazygit.enable = true;
          setupOpts.direction = "float";
        };
      };
      utility = {
        oil-nvim.enable = true;
        surround.enable = true;
      };
    };
  };
}
