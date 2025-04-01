local map = vim.keymap.set

map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', '<leader>hl', '<cmd>set hlsearch<CR>')

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Move cursor in insert mode
-- map('i', '<C-h>', '<Left>', { desc = 'Move cursor left in insert mode' })
-- map('i', '<C-j>', '<Down>', { desc = 'Move cursor down in insert mode' })
-- map('i', '<C-k>', '<Up>', { desc = 'Move cursor up in insert mode' })
-- map('i', '<C-l>', '<Right>', { desc = 'Move cursor right in insert mode' })

map('n', '<C-c>', '<cmd> %y+ <CR>', { desc = 'Copy whole file' })
map('n', '<leader>nl', 'i<CR><Esc>', { desc = 'Creates a new line at the cursor'})

-- Quickfix list commands
map('n', '<leader>cn', '<cmd>cnext<CR>', { desc = 'Go to next reference in Quickfix list' })
map('n', '<leader>cp', '<cmd>cprev<CR>', { desc = 'Go to previous reference in Quickfix list' })

-- Window resizing
map('n', '<C-Left>', '<cmd>vertical resize -2<CR>', { desc = 'Shrink window horizontally' })
map('n', '<C-Right>', '<cmd>vertical resize +2<CR>', { desc = 'Expand window horizontally' })
map('n', '<C-Up>', '<cmd>resize -2<CR>', { desc = 'Shring window vertically' })
map('n', '<C-Down>', '<cmd>resize +2<CR>', { desc = 'Expand window vertically' })

map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map('t', '<A-i>', '<cmd>ToggleTermToggleAll<CR>', { desc = 'Toggle terminal' })

map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

map('n', 'k', 'gk', { desc = 'Move cursor up respecting wrap' })
map('n', 'j', 'gj', { desc = 'Move cursor down respecting wrap' })
map('n', '<C-b>', 'ge', { desc = 'Move cursor by a word to the left leaving the cursor at the last word char.' })

-- Better paste (duh)
map('v', 'p', '"_dP', { desc = 'Better paste' })

map('n', '<leader>xb', '<cmd>bd<CR>', { desc = 'Close current buffer' })
map('n', '<leader>x', vim.api.nvim_win_close, { desc = 'Close current window' })

map('v', '<', '<gv', { desc = 'Tab right and stay in indent mode' })
map('v', '>', '>gv', { desc = 'Tab left and stay in indent mode' })

map('n', 'n', 'nzzzv', { desc = 'Go to next occurence and center window' })
map('n', 'N', 'Nzzzv', { desc = 'Go to prev occurence and center window' })
