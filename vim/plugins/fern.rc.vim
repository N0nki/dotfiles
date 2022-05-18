" fern

let g:fern#disable_default_mappings = 1
let g:fern#renderer = 'nerdfont'

autocmd FileType fern call s:fern_my_settings()
function! s:fern_my_settings() abort
  nmap <buffer> . <Plug>(fern-action-hidden:toggle)
  nmap <buffer> <CR> <Plug>(fern-action-open-or-expand)
  nmap <buffer> <expr> o fern#smart#leaf(
      \ '<Plug>(fern-action-open)',
      \ '<Plug>(fern-action-expand)',
      \ '<Plug>(fern-action-collapse)'
      \ )
  nmap <buffer> <Plug>(fern-my-open-and-tcd)
        \ <Plug>(fern-action-open-or-enter)
        \ <Plug>(fern-wait)
        \ <Plug>(fern-action-tcd:root)
  nmap <buffer> <Plug>(fern-my-leave-and-tcd)
        \ <Plug>(fern-action-leave)
        \ <Plug>(fern-wait)
        \ <Plug>(fern-action-tcd:root)
  nmap <buffer> l <Plug>(fern-my-open-and-tcd)
  nmap <buffer> h <Plug>(fern-my-leave-and-tcd)
  nmap <buffer> s <Plug>(fern-action-open:select)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
  nmap <buffer> t <Plug>(fern-action-open:tabedit)
  nmap <buffer> c <Plug>(fern-action-clipboard-copy)
  nmap <buffer> m <Plug>(fern-action-clipboard-move)
  nmap <buffer> p <Plug>(fern-action-clipboard-paste)
  nmap <buffer> K <Plug>(fern-action-new-dir)
  nmap <buffer> N <Plug>(fern-action-new-file)
  nmap <buffer> d <Plug>(fern-action-trash)
  nmap <buffer> r <Plug>(fern-action-rename)
  nmap <buffer> x <Plug>(fern-action-open:system)
  nmap <buffer> yy <Plug>(fern-action-yank:path)
  nnoremap <Plug>(fern-jump-home) :<C-u>Fern ~ -drawer -stay -width=40<CR>
  nmap <buffer> ~ <Plug>(fern-jump-home)
  nnoremap <Plug>(fern-close-drawer) :<C-u>FernDo close -drawer -stay<CR>
  nmap <buffer> <Space> <Plug>(fern-action-mark:toggle)
  vmap <buffer> <Space> <Plug>(fern-action-mark:toggle)
  nmap <buffer> q <Plug>(fern-close-drawer)
  nmap <buffer> <C-l> <Plug>(fern-action-reload)
  nmap <buffer> i <Plug>(fern-action-reveal)
  nmap <buffer> ? <Plug>(fern-action-help)
endfunction

if !argc()
  autocmd VimEnter * ++nested Fern %:h -drawer -width=40
endif

nnoremap <silent> <Leader>e :<C-u>Fern %:h -drawer -width=40<CR>
