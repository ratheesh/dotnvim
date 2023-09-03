local M ={
	'altermo/ultimate-autopair.nvim',
	enabled=true,
	branch = "v0.6",
	event={'InsertEnter', 'CmdlineEnter'}
}

M.config=function ()
	require('ultimate-autopair').setup({
		--Config goes here
	})
end

return M

