"Vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'mattn/emmet-vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'godlygeek/tabular'
Plugin 'scopium/php-doc'
Plugin 'uguu-org/vim-matrix-screensaver'


call vundle#end()
filetype plugin indent on

"General
set nobackup
set noswapfile
set history=1024
set autochdir
set whichwrap=b,s,<,>,[,]
set nobomb
set clipboard+=unnamed
set expandtab

"Lang & Encoding
set fileencodings=utf-8,gbk2312,gbk,gbk18030,cp936
set encoding=utf-8
set langmenu=zh_CN
let $LANG='en_US.UTF-8'
"Gui

"colorscheme Tomorrow-Night
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
set showmatch
set softtabstop=4
set foldmethod=indent
syntax on


let mapleader=","
let maplocalleader="\\"
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
"单词操作
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
inoremap <C-d> <esc>bdei

inoremap jk <esc>
inoremap <sec> <nop>

"tab切换
nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>tc :tabclose<cr>
nnoremap <leader>th :tabp<cr>
nnoremap <leader>tl :tabn<cr>

"移动分割窗口
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

"插入模式移动光标
inoremap <M-j> <down>
inoremap <M-k> <up>
inoremap <M-h> <left>
inoremap <M-l> <right>

"注释当前行
augroup phpcomment
        autocmd!
        autocmd FileType php nnoremap <buffer> <localleader>c I//<esc>
augroup END

"NERDTree toggle
map <F2> :NERDTreeToggle<CR>

"PDV
inoremap <leader>d <ESC>:call PhpDocSingle()<CR>i
nnoremap <leader>d :call PhpDocSingle()<CR>
vnoremap <leader>d :call PhpDocRange()<CR>

    " PHP options
function! PhpDocLoad()
       source $HOME/.vim/php-doc.vim
       inoremap <C-P><ESC> :call PhpDocSingle()<CR>i
       nnoremap <C-P> :call PhpDocSingle()<CR>
       vnoremap <C-P> :call PhpDocRange()<CR>
       inoremap ( ()<Left>
endfunction

""""""""""""""""""""""""""""""
" Tag list (ctags)
""""""""""""""""""""""""""""""
map <F3> :silent! Tlist<CR> 
let Tlist_Show_One_File = 1            "不同时显示多个文件的tag只显示当前文件的
let Tlist_Exit_OnlyWindow = 1          "如果taglist窗口是最后一个窗口则退出vim
let Tlist_Use_Right_Window = 1         "在右侧窗口中显示taglist窗口


