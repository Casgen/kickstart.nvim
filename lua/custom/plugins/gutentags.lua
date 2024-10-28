return {
  'ludovicchabant/vim-gutentags',
  config = function()
	vim.g.gutentags_ctags_exclude_wildignore = 1
    vim.g.gutentags_ctags_exclude = {
      'node_modules',
      '_build',
      'build',
      'CMakeFiles',
      '.mypy_cache',
      'venv',
      '*.md',
      '*.tex',
      '*.css',
      '*.html',
      '*.json',
      '*.xml',
      '*.xmls',
      '*.ui',
    }
  end,
}
