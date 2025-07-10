return {
	{ -- Highlight, edit, and navigate code
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
	},
	{
		'nvim-treesitter/nvim-treesitter-textobjects',
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
		},
		config = function()
			local ts_textobjects = require 'nvim-treesitter.configs'
			ts_textobjects.setup {
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							['af'] = { query = '@function.outer', desc = 'outer function' },
							['if'] = { query = '@function.inner', desc = 'inner function' },

							['ac'] = { query = '@class.outer', desc = 'outer class' },
							['ic'] = { query = '@class.inner', desc = 'inner class' },

							['ao'] = { query = '@loop.outer', desc = 'outer loop' },
							['io'] = { query = '@loop.inner', desc = 'inner loop' },
						},
					},
					move = {
						enable = true,
						set_jumpts = true,
						goto_next_start = {
							[']f'] = { query = '@function.outer', desc = 'outer function' },
							[']c'] = { query = '@class.outer', desc = 'outer class' },
							[']o'] = { query = '@loop.outer', desc = 'outer loop' },
							[']k'] = { query = '@block.outer', desc = 'outer block' },
							[']l'] = { query = '@call.outer', desc = 'outer call' },
							[']r'] = { query = '@parameter.outer', desc = 'outer parameter' },
							[']d'] = { query = '@conditional.outer', desc = 'outer conditional' },
							[']a'] = { query = '@assignment.outer', desc = 'outer assignment' },
						},
						goto_next_end = {
							[']F'] = { query = '@function.outer', desc = 'outer function' },
							[']C'] = { query = '@class.outer', desc = 'outer class' },
							[']O'] = { query = '@loop.outer', desc = 'outer loop' },
							[']K'] = { query = '@block.outer', desc = 'outer block' },
							[']L'] = { query = '@call.outer', desc = 'outer call' },
							[']R'] = { query = '@parameter.outer', desc = 'outer parameter' },
							[']D'] = { query = '@conditional.outer', desc = 'outer conditional' },
							[']A'] = { query = '@assignment.outer', desc = 'outer assignment' },
						},
						goto_previous_start = {
							['[f'] = { query = '@function.outer', desc = 'outer function' },
							['[c'] = { query = '@class.outer', desc = 'outer class' },
							['[o'] = { query = '@loop.outer', desc = 'outer loop' },
							['[k'] = { query = '@block.outer', desc = 'outer block' },
							['[l'] = { query = '@call.outer', desc = 'outer call' },
							['[r'] = { query = '@parameter.outer', desc = 'outer parameter' },
							['[d'] = { query = '@conditional.outer', desc = 'outer conditional' },
							['[a'] = { query = '@assignment.outer', desc = 'outer assignment' },
						},
						goto_previous_end = {
							['[F'] = { query = '@function.outer', desc = 'outer function' },
							['[C'] = { query = '@class.outer', desc = 'outer class' },
							['[O'] = { query = '@loop.outer', desc = 'outer loop' },
							['[K'] = { query = '@block.outer', desc = 'outer block' },
							['[L'] = { query = '@call.outer', desc = 'outer call' },
							['[R'] = { query = '@parameter.outer', desc = 'outer parameter' },
							['[D'] = { query = '@conditional.outer', desc = 'outer conditional' },
							['[A'] = { query = '@assignment.outer', desc = 'outer assignment' },
						},
					},
				},
			}

			local ts_repeat_move = require 'nvim-treesitter.textobjects.repeatable_move'
			-- Repeat movement with ; and ,
			-- ensure ; goes forward and , goes backward regardless of the last direction
			-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
			-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

			-- vim way: ; goes to the direction you were moving.
			vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move)
			vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_opposite)

			-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
			vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
			vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
			vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
			vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })
		end,
	},
}
