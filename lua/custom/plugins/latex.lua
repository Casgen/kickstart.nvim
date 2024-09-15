
return {
  -- Latex related stuff...
  {
    'lervag/vimtex',
    config = function()
      vim.keymap.set('n', '<leader>lc', '<cmd>VimtexCompile<CR>', { desc = 'Compiles the current tex file.' })
      vim.keymap.set('n', '<leader>lk', '<cmd>VimtexStop<CR>', { desc = 'Stop the compilation process' })
      vim.keymap.set('n', '<leader>lv', '<cmd>VimtexView<CR>', { desc = 'Show in the pdf viewer the file at the location under the cursor' })
      vim.keymap.set('n', '<leader>ltoc', '<cmd>VimtexTocToggle<CR>', { desc = 'Toggle the table of contents' })
      vim.keymap.set('n', '<leader>llp', '<cmd>LLPStartPreview<CR>', { desc = 'Launches a preview' })

      vim.g.vimtex_syntax_enabled = 1
      vim.g.vimtex_view_method = 'zathura'

      vim.api.nvim_create_autocmd('BufWinEnter', {
        pattern = { '*.tex', '*.md' },
        callback = function()
          vim.keymap.set('n', '$', 'g$')
          vim.keymap.set('n', '0', 'g0')
          vim.keymap.set('n', '_', 'g_')
        end,
      })

      vim.api.nvim_create_autocmd('BufWinLeave', {
        pattern = { '*.tex', '*.md' },
        callback = function()
          vim.keymap.del('n', '$')
          vim.keymap.del('n', '0')
          vim.keymap.del('n', '_')
        end,
      })

    end,
  },
  { 'xuhdev/vim-latex-live-preview', lazy = false },
}
