return {
  {
    'akinsho/bufferline.nvim',
    version = '*',
    event = 'VeryLazy',
    keys = {
      { '<leader>bl', '<cmd>BufferLineCloseLeft<CR>', desc = 'Delete Buffers to the [L]eft' },
      { '<leader>br', '<cmd>BufferLineCloseRight<CR>', desc = 'Delete Buffers to the [R]ight' },
      { '<leader>bo', '<cmd>BufferLineCloseOthers<CR>', desc = 'Delete [O]ther Buffers' },
      { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
      { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      { '<leader>bn', '<cmd>enew<cr>', desc = '[N]ew File' },
    },
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      vim.opt.termguicolors = true
      require('bufferline').setup {
        options = {
          close_command = function(n)
            require('mini.bufremove').delete(n, false)
          end,
          right_mouse_command = function(n)
            require('mini.bufremove').delete(n, false)
          end,
          diagnostics = 'nvim_lsp',
          always_show_bufferline = false,
          diagnostics_indicator = function(_, _, diag)
            local icons = { Error = '󰅙', Info = '󰋼', Hint = '󰌵', Warn = '' }
            local ret = (diag.error and icons.Error .. diag.error .. ' ' or '') .. (diag.warning and icons.Warn .. diag.warning or '')
            return vim.trim(ret)
          end,
          offsets = {
            {
              filetype = 'neo-tree',
              text = 'Neo-Tree',
              highlight = 'Directory',
              text_align = 'left',
            },
          },
        },
      }
    end,
  },
  {
    'echasnovski/mini.bufremove',
    keys = {
      {
        '<leader>bd',
        function()
          local bd = require('mini.bufremove').delete
          if vim.bo.modified then
            local choice = vim.fn.confirm(('Save changes to %q?'):format(vim.fn.bufname()), '&Yes\n&No\n&Cancel')
            if choice == 1 then -- Yes
              vim.cmd.write()
              bd(0)
            elseif choice == 2 then -- No
              bd(0, true)
            end
          else
            bd(0)
          end
        end,
        desc = '[D]elete Buffer',
      },
    },
  },
}
