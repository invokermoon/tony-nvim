local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local setup = {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
        },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    operators = { gc = "Comments" },
    key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<cr>"] = "RET",
        -- ["<tab>"] = "TAB",
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
        border = "rounded", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 4, -- spacing between columns
        align = "left", -- align columns left, center or right
    },
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
    },
}

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<Leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

function cclsCreate()
    local ccls_cfg = vim.fn.stdpath('config') .. '/lua/user/lsp/ccls.config'
    infile = io.open(ccls_cfg, "r")
    instr = infile:read("*a")
    infile:close()

    outfile = io.open(".ccls", "w")
    outfile:write(instr)
    outfile:close()
    print("Auto Create .ccls file in current dir")
end

local mappings = {
    ["0"] = { "<cmd>Telescope keymaps<cr>", "All Keymaps" },
    ["1"] = { "<cmd>lua cclsCreate()<cr>", "Create lsp .ccls" },
    ["2"] = { "<cmd>%bd|e#<CR>", "Close Other Buffers" },
    ["9"] = { "<cmd>AerialToggle<CR>", "Aerial: Funcs List" },

    t = {
        -- Refer to lsp config
        name = "Diagnostic",
        o = { "<cmd>lua vim.diagnostic.open_float()<CR>", "open diagnostic tips"},
        t = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "toggle diagnostic quickfix win"},
    },

    S = {
        name = "Session Manager",
        s = { "<cmd>SessionManager load_session<cr>", "Load Sessions" },
        c = { "<cmd>SessionManager save_current_session<cr>", "Save current session" },
        d = { "<cmd>SessionManager delete_session<cr>", "Delete sessions" },
    },

    p = {
        name = "Project Manager",
        f = {"<cmd>lua require'telescope'.extensions.project.project{}<cr>",
        "Tele Project Manage: c: create | d:delete | r: rename | f: search file | w: change project dir" },
    },

    f = {
        name = "Telescope find",
        f = {"<cmd>Telescope find_files<cr>", "Find files",},
        g = {"<cmd>Telescope live_grep<cr>", "Find live_grep",},
        b = {"<cmd>Telescope buffers<cr>", "Find buffers",},
        c = {"<cmd>Telescope colorscheme<cr>",  "Find Colorscheme" },
        h = {"<cmd>Telescope help_tags<cr>",    "Find Help" },
        M = {"<cmd>Telescope man_pages<cr>",    "Man Pages" },
        R = {"<cmd>Telescope registers<cr>",    "Find Registers" },
        C = {"<cmd>Telescope commands<cr>",     "Find Commands" },

        p = {"<cmd>Telescope project<cr>", "Manager Project"},
        r = {"<cmd>lua require('telescope').extensions.frecency.frecency{}<cr>", "Find ext frencency"},
    },

    C = {
        name = "CMake",
        g = {"<cmd>CMake configure<CR>",            "Configure"},
        b = {"<cmd>CMake build<CR>",                "BuildTarget"},
        a = {"<cmd>CMake build_all<CR>",            "BuildAll"},
        r = {"<cmd>CMake build_and_run<CR>",        "Run"},
        d = {"<cmd>CMake build_and_debug<CR>",      "DebugTarget"},
        c = {"<cmd>CMake cancel<CR>",               "Cancel"},
        t = {"<cmd>CMake select_target<CR>",        "SelectTarget"},
        T = {"<cmd>CMake select_build_type<CR>",    "SelectBuildType"},
        s = {"<cmd>CMake set_target_args<CR>",      "SetArg"},
    },

    D = {
        name = "Debug",
        R = { "<cmd>lua require'dap'.run_to_cursor()<cr>",                          "Run to Cursor" },
        E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>",   "Evaluate Input" },
        X = { "<cmd>lua require'dap'.terminate()<cr>",                              "Terminate" },
        T = { "<cmd>lua require'dapui'.toggle('sidebar')<cr>",                      "Toggle Sidebar" },
        p = { "<cmd>lua require'dap'.pause()<cr>",                                  "Pause" },
        r = { "<cmd>lua require'dap'.repl.toggle()<cr>",                            "Toggle Repl" },
        q = { "<cmd>lua require'dap'.close()<cr>",                                  "Quit" },

        -- C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
        -- b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
        -- c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
        -- d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
        -- e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
        -- g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
        -- h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
        -- S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
        -- i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
        -- o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
        -- t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
        -- u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
    },

    L = {
        name = "LSP",
        f = { "<cmd>lua vim.lsp.buf.formatting()<cr>",              "Lsp Format" },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>",                  "Rename" },
        i = { "<cmd>lua vim.lsp.buf.incoming_calls()<cr>",          "Incoming calls" },
        o = { "<cmd>lua vim.lsp.buf.outgoing_calls()<cr>",          "Outgoing calls" },
    },
}

which_key.setup(setup)
which_key.register(mappings, opts)
