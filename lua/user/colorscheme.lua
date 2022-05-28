-- cursor color: #61AFEF
-- local colorscheme = "catppuccin"
local colorscheme = "onedark"
-- local colorscheme = "tokyonight"
-- local colorscheme = "ayu"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end

if colorscheme == "ayu" then
    vim.cmd [[set termguicolors]]
    vim.g.ayucolor = "light" -- dark|light|mirage
    -- vim.cmd ([[colorscheme ayu]])
elseif colorscheme == "tokyonight" then
    vim.g.tokyonight_style = "night" --storm|night|light
    -- vim.cmd ([[colorscheme tokyonight]])
end
