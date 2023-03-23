return {
	'jay-babu/mason-null-ls.nvim',
	name = 'mason-null-ls',
	dependencies = { 'mason' },
	config = {
		automatic_setup = true,
		ensure_installed = {
			-- formatters
			'autopep8',
			'isort',
			'trim_newlines',
			'black',
			'prettierd',
			'stylua',
			'taplo',
			'shfmt',

			-- diagnostics
			'shellcheck',
			'curlylint',
			'tidy',
			'flake8',
			'cmake_lint',
			'trail_space',
			'gitlint',

			-- linters
			'luacheck',

			-- code actions
			'refactoring',
			'proselint',
			'eslint_d',
			'gitsigns',
			'gitrebase',
		},
	},
}
