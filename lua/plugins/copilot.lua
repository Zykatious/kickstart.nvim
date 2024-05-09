return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'VeryLazy',
    config = function()
      require('copilot').setup {
        suggestion = { enabled = false },
        panel = { enabled = false },
      }
    end,
  },
  {
    'zbirenbaum/copilot-cmp',
    config = function()
      require('copilot_cmp').setup()
    end,
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
    },
    opts = {
      debug = false, -- Enable debugging
      -- See Configuration section for rest
    },
    init = function()
      vim.keymap.set('n', '<leader>cc', '<cmd>CopilotChat<cr>', { desc = 'Copilot [C]hat' })
      vim.keymap.set('v', '<leader>ce', '<cmd>CopilotChatExplain<cr>', { desc = 'Copilot [E]xplain' })
      vim.keymap.set('v', '<leader>co', '<cmd>CopilotChatOptimize<cr>', { desc = 'Copilot [O]ptimize' })
    end,
    -- See Commands section for default commands if you want to lazy load on them
  },
}
