return {
	"MunifTanjim/nui.nvim",
	"nvim-lua/plenary.nvim",
	"folke/neodev.nvim",
	"williamboman/mason-lspconfig.nvim",
  "folke/which-key.nvim",
	{
		'kyazdani42/nvim-web-devicons',
		config = function ()
			require('nvim-web-devicons').setup()
		end
	},
  "rlch/github-notifications.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
	{ "EdenEast/nightfox.nvim", event = "VeryLazy" },
	{
		"mbbill/undotree",
		cmd = { "UndotreeShow", "UndotreeToggle", "UndotreeHide", "UndotreeFocus" },
	},
	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		config = function()
			require("inc_rename").setup()
		end,
	},
	{
		'RRethy/nvim-treesitter-endwise',
		event = 'InsertEnter',
	},
	{
		"ojroques/vim-oscyank",
		cmd = { "OSCYank", "OSCYankReg" },
	},
	{ "NvChad/nvim-colorizer.lua", ft = { "css" } },
  { "stevearc/dressing.nvim", event = "VeryLazy" },
	{ 'p00f/nvim-ts-rainbow' },
  {
    "ThePrimeagen/refactoring.nvim",
    init = function()
      -- prompt for a refactor to apply when the remap is triggered
      vim.keymap.set("v", "<leader>r", function()
        require("refactoring").select_refactor()
      end, { noremap = true, silent = true, expr = false })
    end,
    config = function()
      require("refactoring").setup({})
    end,
  },

  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    init = function()
      vim.keymap.set("n", "<leader>cs", "<cmd>SymbolsOutline<cr>", { desc = "Symbols Outline" })
    end,
    config = function()
      require("symbols-outline").setup()
    end,
  },

  {
    "m-demare/hlargs.nvim",
    event = "VeryLazy",
    enabled = false,
    config = function()
      require("hlargs").setup({
        excluded_argnames = {
          usages = {
            lua = { "self", "use" },
          },
        },
      })
    end,
  },

  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    config = function()
      require("trouble").setup({
        auto_open = false,
        use_diagnostic_signs = true, -- en
      })
    end,
  },
  {
    "cshuaimin/ssr.nvim",
    -- Calling setup is optional.
    init = function()
      vim.keymap.set({ "n", "x" }, "<leader>cR", function()
        require("ssr").open()
      end, { desc = "Structural Replace" })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    config = function()
      require("treesitter-context").setup()
    end,
  },

  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
    end,
  },
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		config = function()
			vim.g.startuptime_tries = 10
		end,
	},
	{
		'lewis6991/satellite.nvim',
		event = 'VimEnter',
		after = { 'nvim-lspconfig' },
		config=function ()
			require('satellite').setup()
		end
	}
}
-- End of File
