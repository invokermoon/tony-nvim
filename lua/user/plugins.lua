local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

local util = require('packer/util')
-- Have packer use a popup window
packer.init {
    compile_path = util.join_paths(vim.fn.stdpath('config'), 'packer_compiled.vim'),
    git = { clone_timeout = 120, default_url_format = "git@github.com:%s" },
    max_jobs = 10,
    display = {
        open_fn = function()
            return require("packer.util").float { border = "single" }
        end,
    },
}

-- usage
-- use {{{{
--   "myusername/example",        -- The plugin location string
--   -- The following keys are all optional
--   disable = boolean,           -- Mark a plugin as inactive
--   as = string,                 -- Specifies an alias under which to install the plugin
--   installer = function,        -- Specifies custom installer. See "custom installers" below.
--   updater = function,          -- Specifies custom updater. See "custom installers" below.
--   after = string or list,      -- Specifies plugins to load before this plugin. See "sequencing" below
--   rtp = string,                -- Specifies a subdirectory of the plugin to add to runtimepath.
--   opt = boolean,               -- Manually marks a plugin as optional.
--   branch = string,             -- Specifies a git branch to use
--   tag = string,                -- Specifies a git tag to use. Supports "*" for "latest tag"
--   commit = string,             -- Specifies a git commit to use
--   lock = boolean,              -- Skip updating this plugin in updates/syncs. Still cleans.
--   run = string, function, or table, -- Post-update/install hook. See "update/install hooks".
--   requires = string or list,   -- Specifies plugin dependencies. See "dependencies".
--   rocks = string or list,      -- Specifies Luarocks dependencies for the plugin
--   config = string or function, -- Specifies code to run after this plugin is loaded.
--   -- The setup key implies opt = true
--   setup = string or function,  -- Specifies code to run before this plugin is loaded.
--   -- The following keys all imply lazy-loading and imply opt = true
--   cmd = string or list,        -- Specifies commands which load this plugin. Can be an autocmd pattern.
--   ft = string or list,         -- Specifies filetypes which load this plugin.
--   keys = string or list,       -- Specifies maps which load this plugin. See "Keybindings".
--   event = string or list,      -- Specifies autocommand events which load this plugin.
--   fn = string or list          -- Specifies functions which load this plugin.
--   cond = string, function, or list of strings/functions,   -- Specifies a conditional test to load this plugin
--   module = string or list      -- Specifies Lua module names for require. When requiring a string which starts
--                                -- with one of these module names, the plugin will be loaded.
--   module_pattern = string/list -- Specifies Lua pattern of Lua module names for require. When
--   requiring a string which matches one of these patterns, the plugin will be loaded.
-- }}}}
--
--
local function window_buffer_view_plugins(use)
    -- file explore
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icon
        },
        -- tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

    -- status lines
    use "nvim-lualine/lualine.nvim" -- better status line
    use {
        "SmiteshP/nvim-gps", -- statusline shows class structure
        requires = { "nvim-treesitter/nvim-treesitter", commit = "44b7c8100269161e20d585f24bce322f6dcdf8d2"},
    }

    -- window
    use "rcarriga/nvim-notify" -- notify
    use "kevinhwang91/nvim-bqf" -- better quick fix window

    -- buffer
    use "akinsho/bufferline.nvim"

    -- taglist/funcslist
    use "stevearc/aerial.nvim" --taglist functions
    use "simrat39/symbols-outline.nvim" -- taglist outline

    -- litee family
    use "ldelossa/litee.nvim"
    use "ldelossa/litee-calltree.nvim"
end


local function UI_plugins(use)
    -- Colorschemes
    use({"catppuccin/nvim", as = "catppuccin" })
    use "navarasu/onedark.nvim" --3.4k
    use "cocopon/iceberg.vim" --1.8k
    use "sonph/onehalf" -- 1.4k
    use "ayu-theme/ayu-vim" --1.4k
    use "folke/tokyonight.nvim" --1.4k

    -- common
    use {
        'goolord/alpha-nvim', -- welcome page
        requires = { 'kyazdani42/nvim-web-devicons' },
    }
    use "folke/todo-comments.nvim" -- todo comments
    use "RRethy/vim-illuminate" -- highlight undercursor word
    use "norcalli/nvim-colorizer.lua" -- show color
    use "andymass/vim-matchup"
    use "mtdl9/vim-log-highlighting"
    use "Pocco81/HighStr.nvim"

    window_buffer_view_plugins(use)

    --use "sindrets/winshift.nvim" -- rerange window layout
end

local function projectPlugins(use)
    --use "ahmedkhalf/project.nvim"
    use { "nvim-telescope/telescope-project.nvim", opt = true }
end

local function telescopePlugins(use)
    use {
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/plenary.nvim",    -- Useful lua functions used ny lots of plugins
            "nvim-lua/popup.nvim",      -- An implementation of the Popup API from vim in Neovim
            "kyazdani42/nvim-web-devicons",
        },
    }
    use "nvim-telescope/telescope-ui-select.nvim"
    use { "nvim-telescope/telescope-fzf-native.nvim", opt = true, run = "make", after = "telescope.nvim"}
    use {
        "nvim-telescope/telescope-frecency.nvim",
        opt = true,
        after = "telescope.nvim",
        requires = {{ "tami5/sqlite.lua", opt = true }},
    }
    use {
        "tom-anders/telescope-vim-bookmarks.nvim",
        opt = true,
        after = "telescope.nvim",
        requires = {{ "MattesGroeger/vim-bookmarks", opt = true }},
    }
    -- use { "sharkdp/fd", opt = false, after = "telescope.nvim"} -- For private data, disable this feature that scans pc files
end

-- highlighting
local function treesitterPlugins(use)
    use {'nvim-treesitter/nvim-treesitter', run = ":TSUpdate", commit = "44b7c8100269161e20d585f24bce322f6dcdf8d2"}
    use {"nvim-treesitter/nvim-treesitter-textobjects", commit = "c81382328ad47c154261d1528d7c921acad5eae5",} -- enhance texetobject selection
    use "romgrk/nvim-treesitter-context" -- show class/function at the top
end

local function lspPlugins(use)
    use {
        'creativenull/efmls-configs-nvim',
        tag = 'v0.1.2', -- tag is optional
        requires = { 'neovim/nvim-lspconfig' },
    }
    use "williamboman/nvim-lsp-installer" -- simple to use language server installer
    use "ray-x/lsp_signature.nvim" -- show function signature when typing
    use { "tami5/lspsaga.nvim", branch = 'nvim6.0', after = "nvim-lspconfig" }

    -- use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
    -- use "RishabhRD/nvim-lsputils"
end

local function completionPlugins(use)
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp", -- source from lsp server
            "hrsh7th/cmp-buffer", -- buffer completions
            "hrsh7th/cmp-path", -- path completions
            "hrsh7th/cmp-cmdline", -- cmdline completions
            "hrsh7th/cmp-nvim-lua",	--source from neovim Lua API
            "ray-x/cmp-treesitter",
            "lewis6991/spellsitter.nvim",
            --"f3fora/cmp-spell", -- spell check
            --"saadparwaiz1/cmp_luasnip", -- snippet completions
        }
    } -- The completion plugin
end

local function debugPlugins(use)
    use {
        "rcarriga/nvim-dap-ui",
        requires = {
            { "theHamsta/nvim-dap-virtual-text" },
            { "mfussenegger/nvim-dap" },
            {
                "Pocco81/dap-buddy.nvim", cmd = { "DIInstall", "DIUninstall", "DIList" },
                -- commit = "24923c3819a450a772bb8f675926d530e829665f",
            },
        }
    }
    -- use "mfussenegger/nvim-dap-python"    -- debug python
end

local function editPlugins(use)
    use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
    use "terrortylor/nvim-comment"

    use { "Shatur/neovim-session-manager", requires = { "nvim-telescope/telescope-ui-select.nvim"} }
    -- use { "rmagatti/auto-session", requires = { "nvim-telescope/telescope-ui-select.nvim"} }

    use "ethanholz/nvim-lastplace" -- auto return back to the last modified positon when open a file
    use "tpope/vim-repeat" --  . command enhance
    use "tpope/vim-surround" -- vim surround
    use "lukas-reineke/indent-blankline.nvim" -- indent blankline
    -- use "nvim-pack/nvim-spectre" -- search and replace pane
    -- use "github/copilot.vim"  -- Copilot setup,
    -- use "haringsrob/nvim_context_vt" -- show if, for, function... end as virtual text
    -- use "code-biscuits/nvim-biscuits" -- AST enhance, require treesitter
    -- use "terryma/vim-expand-region" -- expand/shrink region by +/-
end


local function toolPlugins(use)
    use "j-hui/fidget.nvim" -- show lsp progress
    use "folke/which-key.nvim" -- which  key
    use "phaazon/hop.nvim"  -- find something/postion more smart。说白了就是这个插件会在全屏打上零散的桩，让你快速跳过去
    use 'sindrets/diffview.nvim' --very usefully

    use {"akinsho/toggleterm.nvim", tag = 'v1.*', config = function()
        require("toggleterm").setup()
    end}
    -- use "nathom/filetype.nvim"

    -- snippets
    use "L3MON4D3/LuaSnip" --snippet engine
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

    use "cdelledonne/vim-cmake"
    -- use "Shatur/neovim-cmake"

    -- install without yarn or npm
    use { "iamcco/markdown-preview.nvim", run = function() vim.fn["mkdp#util#install"]() end,}

    --[[
    use {
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
        ft = { "markdown" },
    }
    ]]--

    use {"dstein64/vim-startuptime", opt = true, cmd = "StartupTime",}
    -- use { 'michaelb/sniprun', run = 'bash ./install.sh' }
    use "Pocco81/AutoSave.nvim"
    use "djoshea/vim-autoread"

    -- use "folke/trouble.nvim" -- about diagnostic, no useless, it can be instead by lsp+vim.diag
    -- use "kosayoda/nvim-lightbulb" -- code issues tips, no useless, and conflict with lsp+vim.diag
    --
    use 'vim-scripts/gtags.vim'
end


return packer.startup(function(use)
    use "wbthomason/packer.nvim" -- Have packer manage itself

    treesitterPlugins(use)
    editPlugins(use)
    lspPlugins(use)
    completionPlugins(use)
    toolPlugins(use)
    debugPlugins(use)
    UI_plugins(use)
    telescopePlugins(use)
    projectPlugins(use)

    --use "jsfaint/gen_tags.vim"


    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end);
