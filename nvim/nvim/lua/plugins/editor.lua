return {
  {
    'altermo/ultimate-autopair.nvim',
    enabled=true,
    branch = "v0.6",
    event={'InsertEnter', 'CmdlineEnter'},
    config=function ()
      require('ultimate-autopair').setup({
        --Config goes here
      })
    end
  },
  {
    'kylechui/nvim-surround',
    event = 'VeryLazy',
    keys = { n = { 'ds', 'cs' }, x = { 'S' } },
    config = function ()
      require('nvim-surround').setup()
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    config = function()
      require("treesitter-context").setup()
    end,
  },
	{
		"mbbill/undotree",
		cmd = { "UndotreeShow", "UndotreeToggle", "UndotreeHide", "UndotreeFocus" },
	},
}
