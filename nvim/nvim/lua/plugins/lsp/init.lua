-- Copyright (c) 2023 Ratheesh <ratheeshreddy@gmail.com>
-- Author: Ratheesh S
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy of
-- this software and associated documentation files (the "Software"), to deal in
-- the Software without restriction, including without limitation the rights to
-- use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
-- the Software, and to permit persons to whom the Software is furnished to do so,
-- subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
-- FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
-- COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
-- IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
-- CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

return {
    {
        "neovim/nvim-lspconfig",
        event ={  "BufReadPre", "BufNewFile" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "williamboman/mason-lspconfig.nvim",
			{ 'ray-x/lsp_signature.nvim', event = 'InsertEnter' },
			{
				"roobert/action-hints.nvim",
				config = function()
					require("action-hints").setup({
						template = {
							definition = { text = " ⊛", color = "#add8e6" },
							references = { text = " ↱%s", color = "#ff6666" },
						},
						use_virtual_text = true,
					})
				end,
			},
			{
				'simrat39/symbols-outline.nvim',
				cmd = 'SymbolOutline',
				config = function()
					require("symbols-outline").setup()
				end,
		},
        },
        config = function(_, _)
            local utils = require("utils")
            local mason_lspconfig = require("mason-lspconfig")
            local lspconfig = require("lspconfig")
            local lsp_utils = require("plugins.lsp.lsp-utils")
            lsp_utils.setup()

            mason_lspconfig.setup({
                ensure_installed = utils.lsp_servers,
            })

            mason_lspconfig.setup_handlers({
                function(server_name)
                    lspconfig[server_name].setup({
                        on_attach = lsp_utils.on_attach,
                        capabilities = lsp_utils.capabilities,
                    })
                end,
                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup({
                        on_attach = lsp_utils.on_attach,
						capabilities = lsp_utils.capabilities,
						settings = {
							Lua = {
								workspace = {
									checkThirdParty = false,
								},
								completion = {
									workspaceWord = true,
									callSnippet = "Replace",
								},
								misc = {
									parameters = {
										"--log-level=trace",
									},
								},
								hint = {
									enable = true,
								},
								diagnostics = {
									-- enable = false,
									globals = { 'vim' },
									disable = {
										"missing-parameter",
										"cast-local-type",
										"param-type-mismatch",
										"assign-type-mismatch",
										"undefined-field",
										"redundant-parameter",
										"no-unknown"
									},
									groupSeverity = {
										strong = "Warning",
										strict = "Warning",
									},
									groupFileStatus = {
										["ambiguity"]  = "Opened",
										["await"]      = "Opened",
										["codestyle"]  = "None",
										["duplicate"]  = "Opened",
										["global"]     = "Opened",
										["luadoc"]     = "Opened",
										["redefined"]  = "Opened",
										["strict"]     = "Opened",
										["strong"]     = "Opened",
										["type-check"] = "Opened",
										["unbalanced"] = "Opened",
										["unused"]     = "Opened",
									},
									unusedLocalExclude = { "_*" },
								},
								format = {
									enable = false,
									defaultConfig = {
										indent_style = "space",
										indent_size  = "2",
										continuation_indent_size = "2",
									},
								},
							},
						},

					})
                end,
                ["pyright"] = function()
                    lspconfig.pyright.setup({
						on_attach = function(client)
							client.server_capabilities.completionProvider = false
							lsp_utils.on_attach(client)
						end,
                        capabilities = lsp_utils.capabilities,
                        settings = {
                            python = {
                                analysis = {
                                    typeCheckingMode = "off",
                                },
                            },
                        },
                    })
                end,
                ["clangd"] = function()
                    local capabilities_cpp = lsp_utils.capabilities
                    capabilities_cpp.offsetEncoding = { "uts-16" }
                    lspconfig.clangd.setup({
                        on_attach = lsp_utils.on_attach,
                        capabilities = capabilities_cpp,
                    })
                end,
                ["pylyzer"] = function()
                    local capabilities = lsp_utils.capabilities
                    capabilities.offsetEncoding = { "uts-16" }
                    lspconfig.pylyzer.setup({
                        on_attach = lsp_utils.on_attach,
                        capabilities = capabilities,
						settings = {
							inlayHints = true,
						}
                    })
                end,
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        opts = {
            pip = {
                upgrade_pip = true,
            },
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)
            local utils = require("utils")
            local mr = require("mason-registry")
            local packages = utils.mason_packages
            local function ensure_installed()
                for _, package in ipairs(packages) do
                    local p = mr.get_package(package)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end
            if mr.refresh then
                mr.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end,
    },
}
-- End of File
