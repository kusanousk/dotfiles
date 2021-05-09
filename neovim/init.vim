"--------------------------------------
" 基本設定
"--------------------------------------
set encoding=utf-8
scriptencoding utf-8
set nocompatible " vi互換モード廃止

" 文字コード
set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される
"set ambiwidth=double " 全角記号

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

set number " 行番号を表示

" 行が折り返し表示されていた場合、行単位ではなく表示単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

" バックスペースキーの有効化
set backspace=indent,eol,start " バックスペースでいろいろ消す

" コマンド補完
set wildmenu " コマンドモードの補完
set history=5000 " 保存するコマンド履歴の数

" タブ、行末スペース、改行を可視化
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

" スワップファイル・バックアップ
set nowritebackup
set noswapfile " スワップファイルを作らない
set nobackup " バックアップ取らない

set laststatus=2 " ステータスラインを常に表示
set t_Co=256 " 256色使う
set showmatch " 括弧の対応をハイライト
set matchtime=3 " 対応括弧のハイライトを3秒にする
set formatoptions=lmoq " テキスト整形オプション、マルチバイト系を追加
set scrolloff=5 " スクロール時の余白確保
set infercase " 補完時に大文字小文字を区別しない
set hidden " バッファを閉じる代わりに隠す
set switchbuf=useopen " 新しく開く代わりにすでに開いてあるバッファを開く

"--------------------------------------
" キー設定
"--------------------------------------
let mapleader="\<space>"
let maplocalleader=","

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
inoremap /**<CR> /**<CR><CR>/<ESC>kV=A<SPACE>
inoremap (*<Space> (*  *)<ESC>hhi

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>o :only<CR>
nnoremap <Leader>x :only<CR>:q<CR>
nnoremap <Leader>t :tabe<CR>

"------------------------------------
" phpの設定
"------------------------------------
function! InitPhp()
  " @で$this->を入力
  function! s:at()
    let syntax = synstack(line('.'), col('.'))
    let name = empty(syntax) ? '' : synIDattr(syntax[-1], "name")
    return name =~# 'String\|Comment\|None' ? '@' : '$this->'
  endfunction
  inoremap <expr> <buffer> @ <SID>at()

endfunction
autocmd BufEnter * if &filetype == 'php' | call InitPhp() | endif

"--------------------------------------
" プラグイン
"--------------------------------------
call plug#begin('~/.local/share/nvim/plugged')

Plug 'Shougo/denite.nvim'
Plug 'scrooloose/nerdtree'
Plug 'morhetz/gruvbox'
Plug 'thinca/vim-quickrun'
Plug 'editorconfig/editorconfig-vim'
Plug 'mhartington/nvim-typescript' , {'for': 'typescript', 'do': './install.sh' }
Plug 'leafgarland/typescript-vim'
Plug 'Shougo/deoplete.nvim'
Plug 'mattn/emmet-vim'
Plug 'neovim/nvim-lsp'
Plug 'Shougo/deoplete-lsp'

call plug#end()

filetype plugin indent on
syntax enable

" Denite
nnoremap <silent> <Leader><Leader> :Denite file/rec<CR>
nnoremap <silent> <Leader>g :Denite grep<CR>

" Deniteでsilver searcherを使う
if executable('ag')
  " The Silver Searcher
  call denite#custom#var('file/rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

  " Setup ignore patterns in your .agignore file!
  " https://github.com/ggreer/the_silver_searcher/wiki/Advanced-Usage

  call denite#custom#var('grep', 'command', ['ag'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', [])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opts', [])
  call denite#custom#var('grep', 'default_opts',
    \ [ '--skip-vcs-ignores', '--vimgrep', '--smart-case', '--hidden' ])
endif

" Define mappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
  endfunction

"--------------------------------------
" deoplete
"--------------------------------------
if has('nvim')
  let g:deoplete#enable_at_startup = 1

  "inoremap <expr><C-h> deoplete#smart_close_popup()."<C-h>"
  "inoremap <expr><BS> deoplete#smart_close_popup()."<C-h>"

  call deoplete#custom#option({
      \ 'auto_complete': v:true,
      \ 'min_pattern_length': 2,
      \ 'auto_complete_delay': 0,
      \ 'auto_refresh_delay': 20,
      \ 'refresh_always': v:true,
      \ 'smart_case': v:true,
      \ 'camel_case': v:true,
      \ })
endif

"--------------------------------------
" NERDTree
"--------------------------------------
nnoremap <silent><Leader>e :NERDTreeToggle<CR>
let g:NERDTreeShowHidden=1
let g:NERDTreeIgnore=['\.git$']

"--------------------------------------
" python lsp設定
"--------------------------------------
if (executable('pyls'))
    lua require'nvim_lsp'.pyls.setup{}

    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif

"--------------------------------------
" colorscheme
"--------------------------------------
"set background=dark
colorscheme gruvbox
