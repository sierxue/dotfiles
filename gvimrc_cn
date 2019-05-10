" stackoverflow VIM initial settings: change background color for line number on the left side?
"highlight LineNr ctermfg=grey ctermbg=white

autocmd BufWritePost .vimrc source % source ~/.gvimrc
autocmd BufWritePost .gvimrc source %

"" Settings of outlooks
" 设置初始界面位置
winpos 1 100

" 设置初始界面大小
set lines=55 columns=84

" gvim内部编码
"set encoding=utf-8

" 终端编码
"set termencoding=utf-8

" 当前编辑文件的编码
set fileencoding=utf-8
" fonts of gui
command! Bigger  :let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)+1', '')
command! Smaller :let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)-1', '')

" gvim打开支持编码的文件
set fileencodings=ucs-bom,utf-8,gbk,cp936,gb2312,big5,euc-jp,euc-kr,latin1

if has("win32")
    set fileencoding=chinese
else
    set fileencoding=utf-8
endif

set guifont=Monospace\ 13

" 防止特殊符号无法正常显示
set ambiwidth=double

" vim菜单乱码解决
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" 下划线不能正常显示：https://blog.csdn.net/aboboo5200/article/details/54424836
set linespace=4
