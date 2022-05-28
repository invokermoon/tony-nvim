vim.cmd [[
  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
  augroup end

  " augroup _auto_resize
  "   autocmd!
  "   autocmd VimResized * tabdo wincmd = 
  " augroup end
]]
