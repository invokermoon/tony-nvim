local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
    return
end

-- How to understand listchars
-- https://github.com/lukas-reineke/indent-blankline.nvim/issues/241

vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

vim.opt.list = true
vim.opt.listchars = {
    --tab = "> ",
    --trail = "-",
    --nbsp = "+",
    tab = "◑ ",
    trail = " ",
    nbsp = "◒",
}

-- option 1
--[[
--vim.g.indent_blankline_char = "║"
vim.g.indent_blankline_char = "█"
--vim.g.indent_blankline_char = ""

vim.g.indent_blankline_context_patterns = {'^if'}
require("indent_blankline").setup {
    space_char_blankline = " ",

    show_current_context = true,
    show_current_context_start = true,
}
]]

-- Option 2
-- This couldn't setting before vim.opt.listchars, or we can't see the vim.opt.listchars sysmols.
--vim.cmd [[highlight IndentBlanklineIndent1 guibg=#1f1f1f gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent1 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guibg=#131313 gui=nocombine]]

require("indent_blankline").setup {
    char = "",
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
    },
    space_char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
    },
    -- show_current_context = true,
    show_trailing_blankline_indent = false,
}
