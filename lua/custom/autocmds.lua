local autocmd = vim.api.nvim_create_autocmd

autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
    vim.fn.setpos("'>", { 0 })
  end,
})

autocmd("FileType", {
    pattern = "dap-float",
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>close!<CR>", { noremap = true, silent = true })
    end
})

autocmd('BufEnter', {
  desc = 'Turn off automatic commenting on next lines',
  group = vim.api.nvim_create_augroup('disable-automatic-commenting', { clear = true }),
  callback = function()
    vim.opt.formatoptions:remove { 'c', 'r', 'o' }
  end,
})

autocmd('BufReadPre', {
  desc = 'Set Conceallevel to 2 and enable wrapping on markdown files ',
  group = vim.api.nvim_create_augroup('conceallevel-md', { clear = true }),
  pattern = { '*.md' },
  callback = function()
    vim.opt.wrap = true
  end,
})

autocmd('BufReadPre', {
  desc = 'Set tabs to 4 spaces in .rs files',
  group = vim.api.nvim_create_augroup('4-spaces-rust', { clear = true }),
  pattern = { '*.rs' },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

autocmd('BufReadPre', {
  desc = 'Set tabs to 2 spaces in .lua files',
  group = vim.api.nvim_create_augroup('2-spaces-lua', { clear = true }),
  pattern = { '*.lua' },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})
