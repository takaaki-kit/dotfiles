"-----------------------------------------------------------------------------"
"NEOBUNDLE
"-----------------------------------------------------------------------------"

if has('vim_starting')
set nocompatible               " Be iMproved

" Required:
set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'

" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=gray
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgray
let g:indent_guides_color_change_percent = 30
let g:indent_guides_guide_size = 1

NeoBundle 'https://github.com/cohama/lexima.vim' 
NeoBundle 'mattn/emmet-vim'

call neobundle#end()

    " Required:
    filetype plugin indent on

    " If there are uninstalled bundles found on startup,
    " this will conveniently prompt you to install them.
    NeoBundleCheck

"NERD TREE起動ショートカット
nnoremap <silent><C-e> :NERDTreeToggle<CR>

"-----------------------------------------------------------------------------"
"set
"-----------------------------------------------------------------------------"
    "Vim7.4でbackspaceを有効化する"
    set backspace=2

    "カラーリング"
    syntax on
    colorscheme molokai

    "補完候補を表示する
    set wildmenu
    set wildmode=list:longest,full

    " 検索で途中までマッチしているものをハイライト
    set incsearch

    " Insertモード、ReplaceモードまたはVisualモードで最終行にメッセージを表示する
    set showmode

    " クリップボードを利用する
    set clipboard=unnamed,autoselect

    " すべてのモードでマウスが有効
    set mouse=a

    "カレント行をハイライト"
    set cursorline
    "アンダーラインを引く"
    highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE

    "ステータスラインを表示"
    set laststatus=2
    set statusline=%F[%p]

    "新しい行のインデントを現在行と同じにする
    set autoindent 

    "クリップボードをWindowsと連携する
    set clipboard=unnamed

    "vi互換をオフする
    set nocompatible


    "タブの代わりに空白文字を指定する
    set expandtab

    "変更中のファイルでも、保存しないで他のファイルを表示する
    set hidden

    "インクリメンタルサーチを行う
    set incsearch

    "バックアップファイルは作成しない"
    set nobackup

    "行番号を表示する
    set number

    "閉括弧が入力された時、対応する括弧を強調する
    set showmatch

    "新しい行を作った時に高度な自動インデントを行う
    set tabstop=2
    set autoindent
    set expandtab
    set shiftwidth=2

    " grep検索を設定する
    set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m,%f
    set grepprg=grep\ -nh

    " 検索結果のハイライトをEsc連打でクリアする
    nnoremap <ESC><ESC> :nohlsearch<CR>
