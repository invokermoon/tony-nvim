local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    vim.notify("telescope not found!")
    return
end

local deps = {
    "sqlite.lua",
    "telescope-fzf-native.nvim",
    "telescope-project.nvim",
--    "project.nvim",
    "telescope-frecency.nvim",
}

for _, pk in pairs(deps) do
    local sts, _ = pcall(vim.cmd, "packadd " .. pk)
    if not sts then
        vim.notify("Telescope Failed packadd " .. pk, "warn")
    end
end

local telescope_actions = require("telescope.actions.set")
local fixfolds = {
    hidden = true,
    attach_mappings = function(_)
        telescope_actions.select:enhance({
            post = function()
                vim.cmd(":normal! zx")
            end,
        })
        return true
    end,
}

require("telescope").setup({
    defaults = {
        initial_mode = "normal",
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = " ",
        scroll_strategy = "limit",
        results_title = false,
        layout_strategy = "horizontal",
        path_display = { "absolute" },
        file_ignore_patterns = {},
        layout_config = {
            prompt_position = "bottom",
            horizontal = {
                preview_width = 0.4,
            },
        },
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    },
    extensions = {
        fzf = {
            fuzzy = false,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
        frecency = {
            show_scores = true,
            show_unindexed = true,
            ignore_patterns = { "*.git/*", "*/tmp/*" },
        },
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {
                -- even more opts
            }
        },
    },
    --[[
    pickers = {
        buffers = fixfolds,
        find_files = fixfolds,
        git_files = fixfolds,
        grep_string = fixfolds,
        live_grep = fixfolds,
        oldfiles = fixfolds,
    },
	]]
})

local extensions = {
    "fzf",
    "project",      --Project Manager telescope-project
    --"projects",   --Project Manager project.nvim
    "frecency",
    "ui-select",    -- This is very important, other plugins will use tele floating window to display something
}

for _, ext in pairs(extensions) do
    local sts, _ = pcall(telescope.load_extension, ext)
    if not sts then
        vim.notify("Telescope is Failed loading " .. ext, "warn")
    end
end
