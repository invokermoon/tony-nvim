local opts = { noremap = true, silent = false}
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

local function leader_map()
    -- default leader key is "\"
    vim.g.mapleader = ","
    vim.api.nvim_set_keymap("n", " ", "", { noremap = true })
    vim.api.nvim_set_keymap("x", " ", "", { noremap = true })
end

-- 	 normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t"
--   command_mode = "c",

local function exploer_map()
    -- remap macro record key
    keymap("n", "Q", "q", opts)
    keymap("n", "q", "<Nop>", opts)

    -- Better window navigation
    keymap("",  "<C-w>", "<C-w>w", opts)
    keymap("n", "<C-h>", "<C-w>h", opts)
    keymap("n", "<C-j>", "<C-w>j", opts)
    keymap("n", "<C-k>", "<C-w>k", opts)
    keymap("n", "<C-l>", "<C-w>l", opts)
    -- exit cur window
    keymap("n", "<leader>q", ":q<cr>", opts)
    -- Resize with arrows
    -- keymap("n", "<C-Up>", ":resize -2<CR>", opts)
    -- keymap("n", "<C-Down>", ":resize +2<CR>", opts)
    -- keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
    -- keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

    -- file tree
    keymap("n", "<F3>", ":NvimTreeToggle<cr>", opts);

    -- buffer expoler map
    -- Local Navigate buffers
    -- keymap("n", "R", ":bnext<CR>", opts)
    -- keymap("n", "E", ":bprevious<CR>", opts)

    -- NOTE: E/R navigation needs  'bufferline' plugin
    keymap("n", "bn", ":BufferLineCycleNext<CR>", opts);
    keymap("n", "bp", ":BufferLineCyclePrev<CR>", opts);
    keymap("n", "<leader>bw", ":Telescope buffers<CR>", opts);
    keymap("n", "<leader>be", ":Telescope buffers<CR>", opts);
end

local function lsp_map()
    -- see dir lsp
    -- Do Nothing
end

-- Need to align with which-key.lua
local function telescope_map()
    keymap("", "<leader>F", "<cmd>Telescope<cr>", opts)
    -- Using Telescope command-line sugar.
    keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
    keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
    keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
    keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)

    -- Using Lua functions
    keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files<cr>", opts)
    keymap("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep<cr>", opts)
    keymap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers<cr>", opts)
    keymap("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags<cr>", opts)
end

local function debug_map()
    -- debug
    keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
    keymap("n", "<leader>dB", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", opts)
    -- keymap("n", "<leader>dr", "lua require'dap'.repl.open()<cr>", opts)
    -- keymap("n", "<leader>dl", "lua require'dap'.run_last()<cr>", opts)
    keymap('n', '<F10>', '<cmd>lua require"user.dap.dap-util".reload_continue()<CR>', opts)
    keymap("n", "<F4>", "<cmd>lua require'dap'.terminate()<cr>", opts)
    keymap("n", "<F5>", "<cmd>lua require'dap'.continue()<cr>", opts)
    keymap("n", "<F6>", "<cmd>lua require'dap'.step_over()<cr>", opts)
    -- keymap("n", "<F7>", "<cmd>lua require'dap'.step_into()<cr>", opts)
    -- keymap("n", "<F8>", "<cmd>lua require'dap'.step_out()<cr>", opts)
    -- keymap("n", "K", "<cmd>lua require'dapui'.eval()<cr>", opts)
    -- keymap("n", "<leader>dt", "<cmd>lua require'dapui'.toggle()<cr>", opts)
    -- keymap("n", "<leader>dx", "<cmd>lua require'dap'.terminate()<cr>", opts)
end

local function tools_map()
    -- comment
    keymap("n", "gcf", "<cmd>Dox<cr>", opts)

    telescope_map()
end

local function gtags_map()
    -- find functions calling this function
    keymap("n", "<leader>Gr", ":lua require('user.utils').GtagsRefernce()<cr>", opts)
    -- find definition
    keymap("n", "<leader>Gt", ":lua require('user.utils').GtagsText()<cr>", opts)
end

local function  others_map()
    -- no highlight
    keymap("n", "<leader>l", ":nohl<cr>", opts)
    -- remap macro record key
    keymap("n", "Q", "q", opts)
    -- cancel q
    keymap("n", "q", "<Nop>", opts)

    -- center cursor
    keymap("n", "n", "nzzzv", opts)
    keymap("n", "N", "Nzzzv", opts)
    keymap("n", "J", "mzJ`z", opts)
    -- keymap("n", "j", "jzz", opts)
    -- keymap("n", "k", "kzz", opts)

    -- Move text up and down
    keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
    keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

    -- Visual --
    -- Stay in indent mode
    keymap("v", "<", "<gv", opts)
    keymap("v", ">", ">gv", opts)

    -- Move text up and down
    -- keymap("v", "<A-j>", ":m .+1<CR>==", opts)
    -- keymap("v", "<A-k>", ":m .-2<CR>==", opts)
    keymap("v", "p", '"_dP', opts)
end


--leader_map()
exploer_map()
lsp_map()
debug_map()
tools_map()
--others_map()
