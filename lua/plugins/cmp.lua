return {
  {
    'L3MON4D3/LuaSnip',
    keys = function()
      return {}
    end,
  },
  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'rafamadriz/friendly-snippets',
      'onsails/lspkind.nvim',
      'hrsh7th/cmp-path',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      local lspkind = require 'lspkind'
      require('luasnip.loaders.from_vscode').lazy_load()
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert,noselect' },

        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          -- Tab Completion
          ['<Tab>'] = cmp.mapping.confirm { select = false },
          -- Enter Completion on selected items
          ['<CR>'] = function(fallback)
            if cmp.get_active_entry() then
              cmp.confirm { select = false }
            else
              fallback()
            end
          end,
          -- Escape from auto completion
          ['<Esc>'] = function(fallback)
            if cmp.get_active_entry() then
              cmp.close()
              vim.cmd 'startinsert'
            else
              fallback()
            end
          end,
        },

        sources = {
          { name = 'copilot' },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },

        formatting = {
          format = lspkind.cmp_format {
            maxwidth = 50,
            ellipsis_char = '...',
          },
        },

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      }
    end,
  },
}
