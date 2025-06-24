return {
  { 'github/copilot.vim' },

  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
      { 'nvim-lua/plenary.nvim' },
      -- Test with blink.cmp
      {
        'saghen/blink.cmp',
        lazy = false,
        version = '*',
        opts = {
          keymap = {
            preset = 'enter',
            ['<S-Tab>'] = { 'select_prev', 'fallback' },
            ['<Tab>'] = { 'select_next', 'fallback' },
          },
          cmdline = { sources = { 'cmdline' } },
          sources = {
            default = { 'lsp', 'path', 'buffer', 'codecompanion' },
          },
        },
      },
    },
    opts = {
      --Refer to: https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
      strategies = {
        --NOTE: Change the adapter as required
        chat = { adapter = 'copilot' },
        inline = { adapter = 'copilot' },
        agents = { adapter = 'copilot' },
      },
      opts = {
        log_level = 'DEBUG',
      },
    },
  },
}
