local M = {}

-- local starts_with = require("user.utils").starts_with
local ends_with = require("user.utils").ends_with

M.setup = function()
    local config_dir = vim.fn.stdpath('config') .. '/lua/user/conf'
    -- plugins do not need to load, NOTE: no .lua suffix required
    local unload_plugins = {
        "init", -- we don't need to load init again
        "nvim-spectre", --不需要这个花里胡哨的替换插件
        "nvim-hlslens",
        "tabout",	--花里胡哨的，单纯为了扩充tab的乱七八糟功能
        "hlargs",
        "tabnine",
        "nvim-neoclip",
        "nvim-biscuits",
        "nvim_context_vt",
        "filetype",
        "sniprun",
        "gen_tags",
        "undotree",
        "specs",
        "nvim-lightbulb",
        "autocommands",
        "trouble",  -- 这个完全可以用vim自带的和lsp自带的来代替
        "auto-session", -- I think neovim-session-manager is better
        "neovim-cmake", -- use vim-cmake
        "cmp", -- use nvim-cmp. A clean setting
    }

    local helper_set = {}
    for _, v in pairs(unload_plugins) do
        helper_set[v] = true
    end
    for _, fname in pairs(vim.fn.readdir(config_dir)) do
        if ends_with(fname, ".lua") then
            local cut_suffix_fname = fname:sub(1, #fname - #'.lua')
            if helper_set[cut_suffix_fname] == nil then
                local file = "user.conf." .. cut_suffix_fname
                local status_ok, _ = pcall(require, file)
                if not status_ok then
                    vim.notify('Failed loading ' .. fname, 'error')
                end
            end
        end
    end
end

M.setup()
