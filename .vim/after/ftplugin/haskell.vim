let $PATH = $PATH . ':' . expand('~/Library/Haskell/bin/')

setlocal omnifunc=necoghc#omnifunc

autocmd BufWritePost *.hs GhcModCheckAndLintAsync

let g:syntastic_check_on_open = 1
let g:ycm_semantic_triggers = {'haskell' : ['.']}
let g:necoghc_enable_detailed_browse = 1

let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "active_filetypes": ["haskell"],
    \ "passive_filetypes": [] }


let g:tagbar_type_haskell = {
    \ 'ctagsbin' : 'lushtags',
    \ 'ctagsargs' : '--ignore-parse-error --',
    \ 'kinds' : [
        \ 'm:module:0',
        \ 'e:exports:1',
        \ 'i:imports:1',
        \ 't:declarations:0',
        \ 'd:declarations:1',
        \ 'n:declarations:1',
        \ 'f:functions:0',
        \ 'c:constructors:0'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 'd' : 'data',
        \ 'n' : 'newtype',
        \ 'c' : 'constructor',
        \ 't' : 'type'
    \ },
    \ 'scope2kind' : {
        \ 'data' : 'd',
        \ 'newtype' : 'n',
        \ 'constructor' : 'c',
        \ 'type' : 't'
    \ }
\ }


nnoremap <buffer> <F5>   :Unite haskellimport<CR>
nnoremap <buffer> <F6>   :Hoogle
nnoremap <buffer> <F7>   :TagbarToggle<CR>

nnoremap <buffer> <Space>ht :GhcModType<CR>
nnoremap <buffer> <Space>hc :GhcModTypeClear<CR>
nnoremap <buffer> <Space>hi :GhcModTypeInsert<CR>

