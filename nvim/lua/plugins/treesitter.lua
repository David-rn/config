return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs', -- Sets main module to use for opts
  -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

  config = function()
    require('nvim-treesitter.configs').setup {
      -- Ensure you install parsers for your languages
      -- :TSInstall {language}
      ensure_installed = { 'bash', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'vim', 'vimdoc', 'python', 'yaml' },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      folds = {
        enable = true, -- Enable Tree-sitter based folding
        -- Optional: you can customize the fold expression here if needed,
        -- but the default is usually fine.
        -- disable = { "python" }, -- Example: disable treesitter folds for Python
      },
    }

    -- Set foldmethod to 'expr' and foldexpr to use Treesitter's function
    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

    -- Optional: Disable automatic folding on file open (start with everything open)
    vim.opt.foldenable = false

    -- Optional: Set a very high foldlevel to prevent unwanted auto-folding
    -- when foldenable is true. This ensures only explicit folding commands work.
    vim.opt.foldlevel = 99
  end,
}
