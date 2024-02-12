local g = vim.g
local cmd = vim.cmd

-- VIM-GO settings
cmd([[
function! s:build_go_files()
    let l:file = expand('%')
    if l:file =~# '^\f\+_test\.go$'
        call go#test#Test(0,1)
    elseif l:file =~# '^\f\+\.go$'
        call go#cmd#Build(0)
    endif
endfunction
]])
cmd('augroup go')
cmd('    autocmd FileType go nmap <Leader>b :<C-u>call <SID>build_go_files()<CR>')
cmd('    autocmd FileType go nmap <Leader>g <Plug>(go-run)')
cmd('    autocmd FileType go nmap <Leader>t <Plug>(go-test)')
cmd('    autocmd FileType go nmap <Leader>s <Plug>(go-alternate-vertical)')
cmd('    autocmd FileType go nmap <Leader>d <Plug>(go-doc-vertical)')
cmd('    autocmd FileType go nmap <Leader>db <Plug>(go-doc-browser)')
cmd('    autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)')
cmd('    autocmd FileType go nmap <Leader>i :GoImpl<CR>')
cmd('    autocmd FileType go nmap <Leader>r <Plug>(go-rename)')
cmd('    autocmd FileType go vmap <Leader>f <Plug>(go-freevars)')
cmd('augroup END')

g.go_list_type = 'quickfix'
g.go_fmt_command = 'goimports'
g.go_autodetect_gopath = 1
g.go_version_warning = 0
g.go_metalinter_autosave = 1
g.go_auto_sameids = 1
