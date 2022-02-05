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
					name = "Declaration",
					fun = vim.lsp.buf.declaration,
				},
				{
					name = "Definition",
					fun = require("telescope.builtin").lsp_definitions,
				},
				{
					name = "Hover doc",
					fun = require("lspsaga.hover").render_hover_doc,
				},
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
