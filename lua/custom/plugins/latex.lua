local switch_keyboard_layout = function()
  vim.schedule(function()
    os.execute 'xkb-switch -n'
  end)
end

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

      vim.g.vimtex_view_method = 'zathura'

      vim.api.nvim_create_autocmd('InsertEnter', {
        pattern = { '*.tex', '*.md' },
        callback = switch_keyboard_layout,
      })

      vim.api.nvim_create_autocmd('InsertLeave', {
        pattern = { '*.tex', '*.md' },
        callback = switch_keyboard_layout,
      })

      -- Used for autocompiling when saving the TeX file.
      vim.api.nvim_create_autocmd('BufWritePost', {
        pattern = { '*.tex' },
        callback = function()
          vim.cmd 'silent! VimtexCompileSS'
        end,
      })
    end,
  },
  { 'xuhdev/vim-latex-live-preview', lazy = false },
}
