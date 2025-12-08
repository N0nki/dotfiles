" vimtex

let g:vimtex_compiler_latexmk = {
            \ 'background': 1,
            \ 'build_dir': '',
            \ 'continuous': 1,
            \ 'callback': 1,
            \ 'options': [
            \   '-pdfdvi',
            \   '-verbose',
            \   '-file-line-error',
            \   '-synctex=1',
            \   '-interaction=nonstopmode',
            \ ]
            \ }

let g:vimtex_compiler_latexmk_engines = { '_' : '-pdfdvi' }
let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'
