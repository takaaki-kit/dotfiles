set nocompatible              " be iMproved, required
filetype off                  " required

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" status line
"-------------------------------------------------------------------------------
set laststatus=2 " 常にステータスラインを表示
set statusline=%<%F\ %r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%4v(ASCII=%03.3b,HEX=%02.2B)\ %l/%L(%P)%m

" basic
"-------------------------------------------------------------------------------
let mapleader = ","			" キーマップリーダー
set scrolloff=5				" スクロール時の余白確保
set textwidth=0				" 一行に長い文章を書いていても自動折り返しをしない
set nobackup				   " バックアップ取らない
set autoread				   " 他で書き換えられたら自動で読み直す
set noswapfile				 " スワップファイル作らない
set hidden					 " 編集中でも他のファイルを開けるようにする
set backspace=indent,eol,start " バックスペースでなんでも消せるように
set formatoptions=lmoq		 " テキスト整形オプション，マルチバイト系を追加
set vb t_vb=				   " ビープをならさない
set browsedir=buffer		   " Exploreの初期ディレクトリ
"set whichwrap=b,s,h,l,<,>,[,]  " カーソルを行頭、行末で止まらないようにする
set showcmd					" コマンドをステータス行に表示
"filetype indent on			" ファイルタイプによるインデント
filetype plugin on			" ファイルタイプごとのプラグイン

" display
"-------------------------------------------------------------------------------
set showmatch		 " 括弧の対応をハイライト
set showcmd		   " 入力中のコマンドを表示
set number			" 行番号表示
set list			  " 不可視文字表示
set listchars=tab:>.,trail:_,extends:>,precedes:<" 不可視文字の表示形式
set display=uhex	  " 印字不可能文字を16進数で表示
" 全角スペースをハイライト
if has("syntax")
  syntax on
  function! ActivateInvisibleIndicator()
    syntax match InvisibleJISX0208Space "　" display containedin=ALL
    highlight InvisibleJISX0208Space term=underline ctermbg=Cyan guibg=Cyan
    "		syntax match InvisibleTrailedSpace "[ \t]\+$" display containedin=ALL
    "		highlight InvisibleTrailedSpace term=underline ctermbg=Red guibg=Red
    "		syntax match InvisibleTab "\t" display containedin=ALL
    "		highlight InvisibleTab term=underline ctermbg=Cyan guibg=Cyan
  endf
  augroup invisible
    autocmd! invisible
    autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
  augroup END
endif
" カレントウィンドウにのみ罫線を引く
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

" indent
"-------------------------------------------------------------------------------
set autoindent
set smartindent
"set cindent
" softtabstopはTabキー押し下げ時の挿入される空白の量，0の場合はtabstopと同じ，BSにも影響する
set tabstop=2 shiftwidth=2 softtabstop=2
"set noexpandtab " タブをスペースに展開しない
set expandtab
augroup vimrc
  autocmd! FileType perl setlocal shiftwidth=4 tabstop=4 softtabstop=4
  autocmd! FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
  autocmd! FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2
  autocmd! FileType php setlocal shiftwidth=4 tabstop=4 softtabstop=4
  autocmd! FileType java setlocal shiftwidth=4 tabstop=4 softtabstop=4
augroup END

" autocomplete and history
"-------------------------------------------------------------------------------
set wildmenu		   " コマンド補完を強化
set wildchar=<tab>	 " コマンド補完を開始するキー
set wildmode=list:full " リスト表示，最長マッチ
set history=1000	   " コマンド・検索パターンの履歴数
set complete+=k		" 補完に辞書ファイル追加

" search
"-------------------------------------------------------------------------------
set wrapscan   " 最後まで検索したら先頭へ戻る
set ignorecase " 大文字小文字無視
set smartcase  " 大文字ではじめたら大文字小文字無視しない
set incsearch  " インクリメンタルサーチ
set hlsearch   " 検索文字をハイライト
"選択した文字列を検索
vnoremap <silent> // y/<C-R>=escape(@", '\\/.*$^~[]'")<CR><CR>
"選択した文字列を置換
vnoremap /r "xy:%s/<C-R>=escape(@x, '\\/.*$^~[]')<CR>//gc<Left><Left><Left>

" encoding
"-------------------------------------------------------------------------------
" 改行文字
set ffs=unix,dos,mac
" デフォルトエンコーディング
set encoding=utf-8

" key bindings
"-------------------------------------------------------------------------------
" 行単位で移動(1行が長い場合に便利)
nnoremap j gj
nnoremap k gk
" バッファ周り
nmap <silent> <C-l> :bnext<CR>
nmap <silent> <C-h> :bprevious<CR>
nmap <silent> ,l	:BufExplorer<CR>
" 検索などで飛んだらそこを真ん中に
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz
nmap G Gzz
"usキーボードで使いやすく
nmap ; :
" 検索中の文字列をハイライト
set hlsearch

" カーソル以下の文字列をハイライト
nmap ,w #*

" plugins
"-------------------------------------------------------------------------------
" rails.vim
au BufNewFile,BufRead *.rhtml set tabstop=2 shiftwidth=2 expandtab
au BufNewFile,BufRead *.rb set tabstop=2 shiftwidth=2 expandtab"

" character encoding
"-------------------------------------------------------------------------------
" 文字コードの自動認識
"if &encoding !=# 'utf-8'
"  set encoding=japan
"  set fileencoding=japan
"endif
"if has('iconv')
"  let s:enc_euc = 'euc-jp'
"  let s:enc_jis = 'iso-2022-jp'
"  " iconvがeucJP-msに対応しているかをチェック
"  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
"    let s:enc_euc = 'eucjp-ms'
"    let s:enc_jis = 'iso-2022-jp-3'
"  " iconvがJISX0213に対応しているかをチェック
"  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
"    let s:enc_euc = 'euc-jisx0213'
"    let s:enc_jis = 'iso-2022-jp-3'
"  endif
"  " fileencodingsを構築
"  if &encoding ==# 'utf-8'
"    let s:fileencodings_default = &fileencodings
"    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
"    let &fileencodings = &fileencodings .','. s:fileencodings_default
"    unlet s:fileencodings_default
"  else
"    let &fileencodings = &fileencodings .','. s:enc_jis
"    set fileencodings+=utf-8,ucs-2le,ucs-2
"    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
"      set fileencodings+=cp932
"      set fileencodings-=euc-jp
"      set fileencodings-=euc-jisx0213
"      set fileencodings-=eucjp-ms
"      let &encoding = s:enc_euc
"      let &fileencoding = s:enc_euc
"    else
"      let &fileencodings = &fileencodings .','. s:enc_euc
"    endif
"  endif
"  " 定数を処分
"  unlet s:enc_euc
"  unlet s:enc_jis
"endif
"" 日本語を含まない場合は fileencoding に encoding を使うようにする
"if has('autocmd')
"  function! AU_ReCheck_FENC()
"    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
"      let &fileencoding=&encoding
"    endif
"  endfunction
"  autocmd BufReadPost * call AU_ReCheck_FENC()
"endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

" filetype difinition
"-------------------------------------------------------------------------------
au BufRead,BufNewFile *.cgi	set filetype=perl

" bless
"-------------------------------------------------------------------------------
imap {} {}<Left>
imap [] []<Left>
imap () ()<Left>
imap “” “”<Left>
imap ” ”<Left>
imap <> <><Left>
imap “ “<Left>


colorscheme molokai
"カレント行をハイライト"
set cursorline
"アンダーラインを引く"
highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE


"ステータスラインを表示"
set laststatus=2
set statusline=%F[%p]


"---------------------------
" Start Neobundle Settings.
"---------------------------
" bundleで管理するディレクトリを指定
set runtimepath+=~/.vim/bundle/neobundle.vim/
 
" Required:
call neobundle#begin(expand('~/.vim/bundle/'))
 
" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'
 
" 今後このあたりに追加のプラグインをどんどん書いて行きます！！"
NeoBundle 'itchyny/lightline.vim'
 
" bufferexplorer"
NeoBundle 'jlanzarotta/bufexplorer'
call neobundle#end()
 
" Required:
filetype plugin indent on
 
" 未インストールのプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定
" 毎回聞かれると邪魔な場合もあるので、この設定は任意です。
NeoBundleCheck
 
"-------------------------
" End Neobundle Settings.
"-------------------------
