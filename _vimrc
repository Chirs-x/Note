set nocompatible
filetype off
set rtp+=%HOME%/vimfiles/bundle/Vundle.vim/
call vundle#begin('%USERPROFILE%/vimfiles/bundle/')

Plugin 'VundleVim/Vundle.vim'

"Plugin on GitHub repo
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'godlygeek/tabular'
Plugin 'scopium/php-doc'
Plugin 'uguu-org/vim-matrix-screensaver'



call vundle#end()
filetype plugin indent on

" Lang & Encoding
set fileencodings=utf-8,gbk2312,gbk,gb18030,cp936 
set encoding=utf-8 
set langmenu=zh_CN 
let $LANG = 'en_US.UTF-8'
set helplang=cn

"General
set nobackup
set noswapfile
set history=1024
set autochdir
set nobomb
set whichwrap=b,s,<,>,[,]
set clipboard+=unnamed
set winaltkeys=no
set backspace=indent,eol,start whichwrap+=<,>,[,]

"Gui
colorscheme Tomorrow-Night
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
set cursorline
set hlsearch
set number 
set lines=35 columns=140
set splitright
set splitbelow

set guioptions-=T
set guioptions-=m
set guioptions-=L
set guioptions-=r
set guioptions-=b
set guioptions-=e
set nolist

"Format
set autoindent
set smartindent
set tabstop=4
set expandtab
set softtabstop=4
set foldmethod=indent
syntax on
set guifont=Ubuntu\ Mono:h12

"Auto source
"autocmd! bufwritepost _vimrc source %USERPROFILE%/_vimrc



let mapleader=","
let maplocalleader="\\"
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
"给单词添加单引号
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel

inoremap jk <esc>
inoremap <sec> <nop>

"注释当前行
augroup phpcomment
        autocmd!
        autocmd FileType php nnoremap <buffer> <localleader>c I//<esc>
augroup END
