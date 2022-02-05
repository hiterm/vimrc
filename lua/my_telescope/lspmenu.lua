local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local lspmenu = function(opts)
	opts = opts or {}
	pickers.new(opts, {
		prompt_title = "lspmenu",
		finder = finders.new_table({
			results = {
				{
					name = "Show line diagnostics",
					fun = require("lspsaga.diagnostic").show_line_diagnostics,
				},
				{
					name = "Diagnostics set loclist",
					fun = vim.diagnostic.setloclist,
				},
				{
					name = "Formatting",
					fun = vim.lsp.buf.formatting,
				},
				{
					name = "Declaration",
					fun = vim.lsp.buf.declaration,
				},
				{
					name = "Definitions",
					fun = require("telescope.builtin").lsp_definitions,
				},
				{
					name = "LSP finder (lspsaga)",
					fun = require("lspsaga.provider").lsp_finder,
				},
				{
					name = "Hover doc",
					fun = require("lspsaga.hover").render_hover_doc,
				},
				{
					name = "Implementation",
					fun = require("telescope.builtin").lsp_implementations,
				},
				{
					name = "Signature help",
					fun = require("lspsaga.signaturehelp").signature_help,
				},
				{
					name = "Type definitions",
					fun = require("telescope.builtin").lsp_type_definitions,
				},
				{
					name = "Rename",
					fun = require("lspsaga.rename").rename,
				},
				{
					name = "Code action",
					fun = require("lspsaga.codeaction").code_action,
				},
				{
					name = "References",
					fun = require("telescope.builtin").lsp_references,
				},
				{
					name = "Diagnostics (Telescope)",
					fun = require("telescope.builtin").diagnostics,
				},
				{
					name = "LSP workspace symbols (Telescope)",
					fun = require("telescope.builtin").lsp_workspace_symbols,
				},
			},
			entry_maker = function(entry)
				return {
					value = entry,
					display = entry["name"],
					ordinal = entry["name"],
				}
			end,
		}),
		sorter = conf.generic_sorter(opts),
		attach_mappings = function(prompt_bufnr, map)
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				local selection = action_state.get_selected_entry()
				-- print(vim.inspect(selection))
				selection["value"]["fun"]()
			end)
			return true
		end,
	}):find()
end

lspmenu()
