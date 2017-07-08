" TODO: 2017.7.9
" 実行成功時にquickfixを閉じる設定を追加する
" 参考: http://d.hatena.ne.jp/osyo-manga/20120919/1348054752

" [leader] + rでlatexmkを使ってtexファイルをコンパイル
" さらにpdfビューアでpdfファイルをオープン
let g:quickrun_config = {
      \'tex': {
        \ "runner" : "vimproc",
        \ 'outputter' : 'error',
        \ 'outputter/error/success' : 'buffer',
        \ 'outputter/error/error'   : 'quickfix',
        \'command': 'latexmk',
        \'outputter/buffer/split': ':vsplit 8sp',
        \'exec': ['%c -gg -pdfdvi %s', 'open %s:r.pdf']
        \},
\}

let g:quickrun_no_default_key_mappings = 1
