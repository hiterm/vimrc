-- Setup nvim-cmp.
local cmp = require("cmp")

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
		end,
	},
	mapping = {
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp", priority = 100 },
		{ name = "buffer", priority = 80 },
		{ name = "path", priority = 50 },
		{ name = "dictionary", keyword_length = 2, priority = 10 },
	}),
	formatting = {
		format = require("lspkind").cmp_format({
			mode = "symbol", -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
		}),
	},
})

require("cmp").setup.cmdline(":", {
	sources = {
		{ name = "cmdline" },
	},
})

require("cmp").setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})

require("cmp_dictionary").setup({
	dic = {
		["*"] = { "/usr/share/dict/words" },
	},
	first_case_insensitive = true,
})

-- nvim-lsp

-- installation
local lsp_installer = require("nvim-lsp-installer")

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions

-- The prefix key.
vim.api.nvim_set_keymap("n", "[nvimlsp]", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Space>l", "[nvimlsp]", {})

local keymap_opts = { noremap = true, silent = true }
-- stylua: ignore start
vim.api.nvim_set_keymap("n", "[nvimlsp]e", "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>", keymap_opts)
vim.api.nvim_set_keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", keymap_opts)
vim.api.nvim_set_keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", keymap_opts)
vim.api.nvim_set_keymap("n", "[nvimlsp]q", "<cmd>lua vim.diagnostic.setloclist()<CR>", keymap_opts)
vim.api.nvim_set_keymap("n", "[nvimlsp]f", "<cmd>lua vim.lsp.buf.formatting()<CR>", keymap_opts)
-- stylua: ignore end

-- local lsp_status = require("lsp-status")
-- Register the progress handler
-- lsp_status.register_progress()

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	-- stylua: ignore start
	vim.api.nvim_buf_set_keymap(bufnr, "n", "[nvimlsp]D", "<cmd>lua vim.lsp.buf.declaration()<CR>", keymap_opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "[nvimlsp]d", '<cmd>lua require"telescope.builtin".lsp_definitions{}<CR>', keymap_opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "[nvimlsp]F", '<cmd>lua require"lspsaga.provider".lsp_finder()<CR>', keymap_opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "K", '<cmd>lua require("lspsaga.hover").render_hover_doc()<CR>', keymap_opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "[nvimlsp]i", '<cmd>lua require"telescope.builtin".lsp_implementations{}<CR>', keymap_opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", '<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>', keymap_opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "[nvimlsp]td", '<cmd>lua require"telescope.builtin".lsp_type_definitions{}<CR>', keymap_opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "[nvimlsp]rn", '<cmd>lua require("lspsaga.rename").rename()<CR>', keymap_opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "[nvimlsp]a", '<cmd>lua require("lspsaga.codeaction").code_action()<CR>', keymap_opts)
	vim.api.nvim_buf_set_keymap(bufnr, "v", "[nvimlsp]a", ':<C-U>lua require("lspsaga.codeaction").range_code_action()<CR>', keymap_opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "[nvimlsp]rf", '<cmd>lua require"telescope.builtin".lsp_references{}<CR>', keymap_opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "[nvimlsp]hd", '<cmd>lua require"telescope.builtin".diagnostics{}<CR>', keymap_opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "[nvimlsp]g", '<cmd>lua require"telescope.builtin".lsp_workspace_symbols{}<CR>', keymap_opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "[nvimlsp]wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", keymap_opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "[nvimlsp]wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", keymap_opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "[nvimlsp]wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", keymap_opts)
	-- stylua: ignore end
end

-- option for lua
local runtime_path = vim.split(package.path, ";")
local lua_opts = {
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
}

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- capabilities = vim.tbl_extend("keep", capabilities, lsp_status.capabilities)

-- for lsp_installer lsps
lsp_installer.on_server_ready(function(server)
	local opts = {
		capabilities = capabilities,
		on_attach = on_attach,
	}

	-- (optional) Customize the options passed to the server
	if server.name == "sumneko_lua" then
		table.insert(runtime_path, "lua/?.lua")
		table.insert(runtime_path, "lua/?/init.lua")

		opts = vim.tbl_extend("keep", opts, lua_opts)
	end

	-- This setup() function will take the provided server configuration and decorate it with the necessary properties
	-- before passing it onwards to lspconfig.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local manually_installed_servers = { "hls" }
for _, lsp in pairs(manually_installed_servers) do
	require("lspconfig")[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

-- null-ls
require("null-ls").setup({
	sources = {
		require("null-ls").builtins.formatting.stylua,
	},
})
