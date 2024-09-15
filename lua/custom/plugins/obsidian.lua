
return {
'epwalsh/obsidian.nvim',
lazy = true,
event = {
  'BufReadPre /media/oem/MoreStuff/ObsidianVault/MyVault/**.md',
  'BufNewFile /media/oem/MoreStuff/ObsidianVault/MyVault/**.md',
},
dependencies = {
  'nvim-lua/plenary.nvim',
},
config = function()
  require('obsidian').setup {
	dir = '/media/oem/MoreStuff/ObsidianVault/MyVault',
	notes_subdir = 'Zettelkasten',
	completion = {
	  nvim_cmp = true,
	  min_chars = 2,
	},
	new_notes_location = 'notes_subdir',
	disable_frontmatter = true,
	templates = {
	  subdir = 'Templates',
	  date_format = '%Y-%m-%d',
	  time_format = '%H:%M:%S',
	},
	mappings = {},
	ui = {
	  enable = true,
	},
  }

  vim.keymap.set('n', '<leader>on', '<cmd>ObsidianNew<CR>', { desc = 'Obsidian: Create a new note' })
  vim.keymap.set('n', '<leader>ot', '<cmd>ObsidianTemplate<CR>', { desc = 'Obsidian: Insert a template into the nose using telescope.nvim' })
  vim.keymap.set('n', '<leader>of', '<cmd>ObsidianFollowLink<CR>', { desc = 'Obsidian: Follow a note reference under the cursor' })

end,
}
