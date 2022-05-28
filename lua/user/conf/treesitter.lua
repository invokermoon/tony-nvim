local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    vim.notify("treesitter not found!")
    return
end

configs.setup {
    ensure_installed = { "cpp", "c", "python", "markdown", "json", "rust", },
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
    ignore_install = { "" }, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "" }, -- list of language that will be disabled
        additional_vim_regex_highlighting = false,
    },
    -- indent = { enable = false, disable = { "yaml" } },
    context_commentstring = {
        enable = true,
        config = {
            -- Languages that have a single comment style
            typescript = "// %s",
            css = "/* %s */",
            scss = "/* %s */",
            html = "<!-- %s -->",
            svelte = "<!-- %s -->",
            vue = "<!-- %s -->",
            json = "",
        },
    },
    -- textobjects extension settings
    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    textobjects = {
        swap = {
            enable = false,
        },
        select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = false, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]]"] = "@function.outer",
                -- ["]["] = "@function.outer",
            },
            goto_next_end = {
                ["]["] = "@function.outer",
                -- ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[["] = "@function.outer",
                -- ["[]"] = "@function.outer",
            },
            goto_previous_end = {
                ["[]"] = "@function.outer",
                -- ["[]"] = "@class.outer",
            },
        },
    },
    rainbow = {
        enable = false,
        extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
        max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
    },
    autotag = { enable = false },
}
