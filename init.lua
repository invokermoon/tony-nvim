require "user.options"
require "user.keymaps"
require "user.plugins"

require "user.colorscheme"
require "user.utils"

require "user.conf"
require "user.lsp"
require "user.dap"
require "user.tags"

-- This code will ensure there is no err: packer_plgins table is nil
local util = require('packer/util')
compile_path = util.join_paths(vim.fn.stdpath('config'), 'packer_compiled.vim')
if vim.fn.filereadable(compile_path) == 0 then
    require("packer").compile()
    return;
end
vim.api.nvim_command("source " .. compile_path)
