set encoding=utf-8
scriptencoding utf-8
set nocompatible " vi互換モード廃止

" 文字コード
set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される
set ambiwidth=double " 全角記号

" タブ・インデント
set expandtab " タブをスペースに展開
set tabstop=4 " 画面上でタブ文字が占める幅
set softtabstop=4 "連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent " 自動でインデント
set smartindent " 新しい行を開始したときに、新しい行のインデントを現在行と同じ量にする
set shiftwidth=4 " smartindentで増減する幅

" 文字列検索
set incsearch " インクリメンタルサーチ（1文字入力毎に検索を行う）
set ignorecase " 検索時に大文字小文字を区別しない
set smartcase " 検索文字に大文字がある場合は大文字小文字を区別
set hlsearch " 検索結果をハイライト（消すときは :nohl）

" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><ESC><ESC> :<C-u>set nohlsearch!<CR>

" カーソル
set whichwrap=b,s,h,l,<,>,[,],~ " カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set number " 行番号を表示
"set cursorline " カーソルラインをハイライト

" 行が折り返し表示されていた場合、行単位ではなく表示単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

" バックスペースキーの有効化
set backspace=indent,eol,start " バックスペースでいろいろ消す

" カッコ・タグジャンプ
set showmatch " 括弧の対応をハイライト
source $VIMRUNTIME/macros/matchit.vim " vimの「%」を拡張する

" コマンド補完
set wildmenu " コマンドモードの補完
set history=5000 " 保存するコマンド履歴の数

" タブ、行末スペース、改行を可視化
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set background=dark

" スワップファイル・バックアップ
set nowritebackup
set noswapfile " スワップファイルを作らない
set nobackup " バックアップ取らない

" 未分類
set laststatus=2 " ステータスラインを常に表示
set t_Co=256 " 256色使う
set matchtime=3 " 対応括弧のハイライトを3秒にする
set formatoptions=lmoq " テキスト整形オプション、マルチバイト系を追加
set scrolloff=5 " スクロール時の余白確保
set infercase " 補完時に大文字小文字を区別しない
set hidden " バッファを閉じる代わりに隠す
set switchbuf=useopen " 新しく開く代わりにすでに開いてあるバッファを開く


filetype off


function! s:meet_neocomplete_requirements()
  return has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
endfunction



" NeoBundle ------------------------------------------------
" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
 if &compatible
   set nocompatible               " Be iMproved
 endif

 " Required:
 set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/unite.vim'
if s:meet_neocomplete_requirements()
  NeoBundle 'Shougo/neocomplete'
  NeoBundleFetch 'Shougo/neocomplcache.vim'
else
  NeoBundleFetch 'Shougo/neocomplete'
  NeoBundle 'Shougo/neocomplcache.vim'
endif
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimshell'
" cyginでは `apt-cyg install make gcc-core` しておく
NeoBundle 'Shougo/vimproc', {
  \ 'build': {
  \ 'windows': 'make -f make_mingw32.mak',
  \ 'cygwin': 'make -f make_cygwin.mak',
  \ 'mac': 'make -f make_mac.mak',
  \ 'unix': 'make -f make_unix.mak',
  \ }
\}
" スニペット
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
" シンタックスをチェックする
NeoBundle 'scrooloose/syntastic'
" ステータスラインをかっこよくする
NeoBundle 'bling/vim-airline'
" カラースキーム
NeoBundle 'tomasr/molokai'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'morhetz/gruvbox'
" 一括置換を視覚的にわかりやすくする（:OverCommandLine）
NeoBundle 'osyo-manga/vim-over'
" インデントを見やすくする
NeoBundle 'nathanaelkane/vim-indent-guides'
" javascriptの賢いインデント
NeoBundle 'jiangmiao/simple-javascript-indenter'
" javascriptのシンタックスハイライト
NeoBundle 'jelera/vim-javascript-syntax'
" emmet (<C-y>,)
NeoBundle 'mattn/emmet-vim'
" vim力計測
NeoBundle 'thinca/vim-scouter'
" coffeescript
NeoBundle 'kchmck/vim-coffee-script'
" tagbar
NeoBundle 'majutsushi/tagbar'
" quickrun
NeoBundle 'thinca/vim-quickrun'
" pythonの補完
NeoBundle 'davidhalter/jedi-vim'
" pep8
NeoBundle 'hynek/vim-python-pep8-indent'
" html5
NeoBundle 'othree/html5.vim'
" blade
NeoBundle 'xsbeats/vim-blade'
" twig
NeoBundle 'evidens/vim-twig'
" surround
NeoBundle 'tpope/vim-surround'
" vim-ref {{{
NeoBundle 'thinca/vim-ref'
let g:ref_cache_dir=$HOME.'/.vim/vim-ref/cache'
let g:ref_phpmanual_path=$HOME.'/.vim/vim-ref/php-chunked-xhtml'
" }}}
" vim-symfony
NeoBundle 'qbbr/vim-symfony'
" jsonのダブルクオーテーションが消える問題を解消
NeoBundle 'elzr/vim-json'
" nginxのconfファイルのシンタックス
NeoBundle 'vim-scripts/nginx.vim'
" es2015のシンタックスハイライト
NeoBundle 'othree/yajs.vim'
" nginxのシンタックスハイライト
NeoBundle 'nginx.vim'

NeoBundle 'editorconfig/editorconfig-vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"-----------------------------------------------------------



" タブ -----------------------------------------------------
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
"-----------------------------------------------------------



"------------------------------------
" vim-indent-guides
"------------------------------------
let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=black



"------------------------------------
" neocomplete | neocomplcache
"------------------------------------
if s:meet_neocomplete_requirements()
  "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
  " Disable AutoComplPop.
  let g:acp_enableAtStartup = 0
  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1
  " Use smartcase.
  let g:neocomplete#enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
  " Plugin key-mappings.
  inoremap <expr><C-g>     neocomplete#undo_completion()
  inoremap <expr><C-l>     neocomplete#complete_common_string()

  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    " return neocomplete#close_popup() . "\<CR>"
    " For no inserting <CR> key.
    return pumvisible() ? neocomplete#close_popup() : "\<CR>"
  endfunction
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplete#close_popup()
  inoremap <expr><C-e>  neocomplete#cancel_popup()
  " Close popup by <Space>.
  noremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

else

  "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
  " Disable AutoComplPop.
  let g:acp_enableAtStartup = 0
  " Use neocomplcache.
  let g:neocomplcache_enable_at_startup = 1
  " Use smartcase.
  let g:neocomplcache_enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplcache_min_syntax_length = 3
  let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

  " Enable heavy features.
  " Use camel case completion.
  "let g:neocomplcache_enable_camel_case_completion = 1
  " Use underbar completion.
  "let g:neocomplcache_enable_underbar_completion = 1

  " Define dictionary.
  let g:neocomplcache_dictionary_filetype_lists = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

  " Define keyword.
  if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
  endif
  let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

  " Plugin key-mappings.
  inoremap <expr><C-g>     neocomplcache#undo_completion()
  inoremap <expr><C-l>     neocomplcache#complete_common_string()

  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return neocomplcache#smart_close_popup() . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
  endfunction
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplcache#close_popup()
  inoremap <expr><C-e>  neocomplcache#cancel_popup()
  " Close popup by <Space>.
  "inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

  " For cursor moving in insert mode(Not recommended)
  "inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
  "inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
  "inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
  "inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
  " Or set this.
  "let g:neocomplcache_enable_cursor_hold_i = 1
  " Or set this.
  "let g:neocomplcache_enable_insert_char_pre = 1

  " AutoComplPop like behavior.
  "let g:neocomplcache_enable_auto_select = 1

  " Shell like behavior(not recommended).
  "set completeopt+=longest
  "let g:neocomplcache_enable_auto_select = 1
  "let g:neocomplcache_disable_auto_complete = 1
  "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

  " Enable heavy omni completion.
  if !exists('g:neocomplcache_force_omni_patterns')
    let g:neocomplcache_force_omni_patterns = {}
  endif
  let g:neocomplcache_force_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
  let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
  let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

  " For perlomni.vim setting.
  " https://github.com/c9s/perlomni.vim
  let g:neocomplcache_force_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

  let g:neocomplcache_force_overwrite_completefunc=1
endif



"------------------------------------
" neosnippet
"------------------------------------
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif



"------------------------------------
" neocompleteとjedi-vimを併用するための設定
"------------------------------------
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0

if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'



"------------------------------------
" syntastic
"------------------------------------
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 1
let g:syntasitc_auto_loc_list = 2



"------------------------------------
" javascript-simple-indenter
"------------------------------------
let g:SimpleJsIndenter_BriefMode = 1
let g:SimpleJsIndenter_CaseIndentLevel = -1




"------------------------------------
" その他
"------------------------------------
" netrwをVimFilerExplorerにする
let g:vimfiler_as_default_explorer = 1

".pycで終わるファイルを表示しない"
let g:vimfiler_ignore_pattern = "\.pyc$"

" vimfilerのsafe modeをオフ
let g:vimfiler_safe_mode_by_default = 0


"------------------------------------
" pythonの設定
"------------------------------------
function! InitPython()
  setl cinwords=if,elif,else,for,while,try,except,finally,def,class
  setl tabstop=4 shiftwidth=4 softtabstop=4 expandtab
  setl ruler
  setl colorcolumn=79

  " jedi-vimとneocompleteを併用するための設定
  setl omnifunc=jedi#completions

  " jedi-vimのdocstring表示を切る
  setl completeopt-=preview

  " IndentGuidesEnable " インデントを見やすくする
endfunction
autocmd BufEnter * if &filetype == "python" | call InitPython() | endif



"------------------------------------
" rubyの設定
"------------------------------------
function! InitRuby()
  setl tabstop=2 shiftwidth=2 softtabstop=2 expandtab smartindent
endfunction
autocmd BufEnter * if &filetype == 'ruby' | call InitRuby() | endif



"------------------------------------
" phpの設定
"------------------------------------
function! InitPhp()
  setl tabstop=4 shiftwidth=4 softtabstop=4 smartindent

  " @で$this->を入力
  function! s:at()
    let syntax = synstack(line('.'), col('.'))
    let name = empty(syntax) ? '' : synIDattr(syntax[-1], "name")
    return name =~# 'String\|Comment\|None' ? '@' : '$this->'
  endfunction
  inoremap <expr> <buffer> @ <SID>at()

endfunction
autocmd BufEnter * if &filetype == 'php' | call InitPhp() | endif



"------------------------------------
" htmlの設定
"------------------------------------
function! InitHtml()
  setl tabstop=2 shiftwidth=2 softtabstop=2 expandtab
endfunction
autocmd BufEnter * if &filetype == 'html' || &filetype == 'htmldjango' || &filetype == 'eruby' || &filetype == 'tag' | call InitHtml() | endif



"------------------------------------
" javascriptの設定
"------------------------------------
"function! InitJavascript()
"  setl tabstop=2 shiftwidth=2 softtabstop=2 expandtab
"endfunction
"autocmd BufEnter * if &filetype == 'javascript' | call InitJavascript() | endif



"------------------------------------
" coffeescriptの設定
"------------------------------------
au BufRead,BufNewFile,BufReadPre *.coffee set filetype=coffee
function! InitCoffee()
  setl tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  " IndentGuidesEnable " インデントを見やすくする
endfunction
autocmd BufEnter * if &filetype == 'coffee' | call InitCoffee() | endif



"------------------------------------
" cssの設定
"------------------------------------
function! InitCss()
  setl tabstop=2 shiftwidth=2 softtabstop=2 expandtab
endfunction
autocmd BufEnter * if &filetype == 'css' || &filetype == 'scss' | call InitCss() | endif



"------------------------------------
" tag(riot.js)の設定
"------------------------------------
au BufRead,BufNewFile,BufReadPre *.tag set filetype=html



" vim
autocmd FileType vim setl tabstop=2 shiftwidth=2 softtabstop=2 expandtab

" markdown
au BufRead,BufNewFile,BufReadPre *.md set filetype=markdown

" jinja2
au BufRead,BufNewFile,BufReadPre *.jinja2 set filetype=htmldjango



"------------------------------------
" 保存時に行末のスペースを削除（markdownを除く）
"------------------------------------
function! RTrim()
  let s:cursor = getpos(".")
  if &filetype == "markdown"
    %s/\s\+\(\s\{2}\)$/\1/e
    match Underlined /\s\{2}/
  else
    %s/\s\+$//e
  endif
  call setpos(".", s:cursor)
endfunction
autocmd BufWritePre * call RTrim()



"------------------------------------
" 全角スペースをハイライト
"------------------------------------
augroup highlightDoubleByteSpace
  autocmd!
  autocmd VimEnter,Colorscheme * highlight DoubleByteSpace term=underline ctermbg=LightMagenta guibg=LightMagenta
  autocmd VimEnter,WinEnter,BufRead * match DoubleByteSpace /　/
augroup END



"------------------------------------
" emmetの設定
"------------------------------------
let g:user_emmet_settings = {'variables': {'lang': 'ja'}}



"------------------------------------
" quickrnの設定
"------------------------------------
let g:quickrun_config={'*': {'split': ''}}
set splitbelow



"------------------------------------
" json
"------------------------------------
let g:vim_json_syntax_conceal = 0



"------------------------------------
" nginx.vim
"------------------------------------
au BufRead,BufNewFile /etc/nginx/* set ft=nginx



"------------------------------------
" キー設定
"------------------------------------
let mapleader = "\<Space>"

" jkをESCに割り当てる
inoremap jk <ESC>

inoremap {<CR> {<CR>}<ESC>O
inoremap {{ {{  }}<ESC>hhi
inoremap {% {%  %}<ESC>hhi
inoremap <% <%  %><ESC>hhi
inoremap {%eb {% endblock %}<ESC>
inoremap {%ef {% endfor %}<ESC>
inoremap {%ei {% endif %}<ESC>
inoremap <?= <?=  ?><ESC>hhi
inoremap {!! {!!  !!}<ESC>hhhi
inoremap /**<Space> /**  */<ESC>hhi

" tagsジャンプの時に一覧表示
nnoremap <C-]> g<C-]>

nnoremap <Leader>e :VimFilerExplorer -toggle -find -no-quit<CR>
nnoremap <Leader>s :VimShellCreate<CR>
nnoremap <Leader>t :Tagbar<CR>
nnoremap <Leader>r :QuickRun<CR>
nnoremap <Leader>o :only<CR>
nnoremap <Leader>x :only<CR>:q<CR>
nnoremap <Leader>h :call InitHtml()<CR>
nnoremap <silent> <Leader><Leader> :Unite file_rec<CR>

nnoremap <F3> :<C-u>tab stj <C-R>=expand('<cword>')<CR><CR>

" 無効にする
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>



" シンタックスハイライト
syntax on

" カラースキーム
" colorscheme jellybeans
colorscheme gruvbox
