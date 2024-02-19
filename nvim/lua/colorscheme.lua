
local cmd = vim.cmd
local o = vim.opt

o.background = 'dark'
local colorscheme = 'jellybeans'

local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not is_ok then
    vim.notify('colorscheme ' .. colorscheme .. ' not found!')
    return
end
