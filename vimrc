" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

"------------------------------
" Load plugin shipped with vim
"------------------------------

filetype plugin on

" https://vim.fandom.com/wiki/Maximize_or_set_initial_window_size
if exists("+lines")
set lines=50
endif
if exists("+columns")
set columns=84
endif

" https://www.zhihu.com/question/60367881
" https://github.com/vim/vim/issues/2049#issuecomment-494923065
set maxmempattern=5000
"------------------
" Load vim-plug
"------------------

" Plugins will be downloaded under the specified directory.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" Add other plugins here.

" 2020-01-13 10:45 https://github.com/aymericbeaumet/vim-symlink
" https://github.com/tpope/vim-fugitive/issues/147#issuecomment-506960242
Plug 'moll/vim-bbye' " optional dependency
Plug 'aymericbeaumet/vim-symlink'

Plug '907th/vim-auto-save'
let g:auto_save = 1  " enable AutoSave on Vim startup
"let g:auto_save_silent = 1  " do not display the auto-save notification

Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
" Trigger configuration. Do not use <tab> if you use Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-tab>"
" begin: https://castel.dev/post/lecture-notes-1/
let g:UltiSnipsJumpForwardTrigger="<tab>" " default <c-b>
let g:UltiSnipsJumpBackwardTrigger="<s-tab>" " default <c-z>
" end: https://castel.dev/post/lecture-notes-1/
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" To use python version 3.x: >
let g:UltiSnipsUsePythonVersion = 3

Plug 'airblade/vim-gitgutter'
Plug 'altercation/solarized'
Plug 'metakirby5/codi.vim'
Plug 'davidhalter/jedi-vim'
" " ganx: revise default <leader>r to <leader>rn
let g:jedi#rename_command = "<leader>rn"
Plug 'flazz/vim-colorschemes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/gv.vim'
Plug 'lervag/vimtex'
let g:tex_flavor = 'latex'
" Use this option to disable/enable vimtex improved syntax highlighting.
" Default value: 1
let g:vimtex_syntax_enabled=1
" Remove warning message: Can't use callbacks without +clientserver · Issue #507 · lervag/vimtex
let g:vimtex_compiler_latexmk = {'callback' : 0}
" https://github.com/lervag/vimtex/issues/1369
" The following is default setting in vimtex.
" let g:vimtex_compiler_latexmk_engines = {
"     \ '_'                : '-pdf',
"     \ 'pdflatex'         : '-pdf',
"     \ 'dvipdfex'         : '-pdfdvi',
"     \ 'lualatex'         : '-lualatex',
"     \ 'xelatex'          : '-xelatex',
"     \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
"     \ 'context (luatex)' : '-pdf -pdflatex=context',
"     \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
" \}
" The default setting is changed to the following:
let g:vimtex_compiler_latexmk_engines = {
    \ '_'                : '-pdf',
    \ 'xelatex'          : '-xelatex',
    \ 'pdflatex'         : '-pdf',
    \ 'dvipdfex'         : '-pdfdvi',
    \ 'lualatex'         : '-lualatex',
    \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
    \ 'context (luatex)' : '-pdf -pdflatex=context',
    \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
\}
" Select pdf viewer
let g:vimtex_view_method = 'zathura'
" https://castel.dev/post/lecture-notes-1/
" https://app.yinxiang.com/shard/s22/nl/4928451/de0f809b-c0bc-4774-b459-683696356703
" let g:vimtex_quickfix_mode=0
" set conceallevel=1
" let g:tex_conceal='abdmg'
" Disable overfull/underfull \hbox.
let g:vimtex_quickfix_latexlog = {
        \ 'overfull' : 0,
        \ 'underfull' : 0,
        \}
let g:vimtex_quickfix_ignore_filters = [
        \ 'FandolSong-Regular',
        \ 'FandolHei-Regular',
        \ 'FandolKai-Regular',
        \ 'FandolFang-Regular',
        \ 'Package Fancyhdr Warning',
        \ 'Package etex Warning',
        \ 'Empty bibliography',
        \]

" Install coc.nvim:
" Make sure node and npm are installed. On ubuntu (>= 18.04)
" sudo apt install nodejs npm
" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Install coc-vimtex: In your vim/neovim, run command: :CocInstall coc-vimtex

Plug 'maralla/completor.vim'
" Trigger completion automatically (Disable auto trigger by setting 1 as 0)
let g:completor_auto_trigger = 1
" Use Tab to select a completion from candidates.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

Plug 'masawada/completor-dictionary'
autocmd FileType * execute 'setlocal dictionary='.expand($HOME.'/.vim/dict/'.&filetype.'.dict')

Plug 'mhinz/vim-startify'
let g:startify_custom_header = []

Plug 'nelstrom/vim-americanize'
Plug 'sillybun/zytutil'

Plug 'sillybun/vim-repl/'
let g:repl_program = {
    \   'python': 'ipython',
    \   'default': 'zsh',
    \   'r': 'R',
    \   'lua': 'lua',
    \   'vim': 'vim -e',
    \   }
let g:repl_predefine_python = {
    \   'numpy': 'import numpy as np',
    \   'matplotlib': 'from matplotlib import pyplot as plt'
    \   }
let g:repl_cursor_down = 1
let g:repl_python_automerge = 1
let g:repl_ipython_version = '7'
nnoremap <leader>r :REPLToggle<Cr>
autocmd Filetype python nnoremap <F12> <Esc>:REPLDebugStopAtCurrentLine<Cr>
autocmd Filetype python nnoremap <F10> <Esc>:REPLPDBN<Cr>
autocmd Filetype python nnoremap <F11> <Esc>:REPLPDBS<Cr>
let g:repl_position = 3
" " ganx: old setting.
" nnoremap <leader>r :REPLToggle<Cr>
" "let g:rep_width = None
" "let g:rep_height = None
" let g:sendtorepl_invoke_key = "<leader>w"
" let g:repl_position = 3
" let g:repl_stayatrepl_when_open = 0
" " ganx Revise python to python3, bash to zsh
" let g:repl_program = {
" 			\	"python": "python3",
" 			\	"default": "zsh"
" 			\	}
" let g:repl_exit_commands = {
" 			\	"python": "quit()",
" 			\	"bash": "exit",
" 			\	"zsh": "exit",
" 			\	"default": "exit",
" 			\	}

Plug 'skywind3000/asyncrun.vim'

Plug 'takac/vim-hardtime'
let g:hardtime_default_on = 1
let g:list_of_normal_keys = ["h", "j", "k", "l", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_visual_keys = ["h", "j", "k", "l", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_insert_keys = ["<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_disabled_keys = []
let g:hardtime_timeout = 100
let g:hardtime_showmsg = 1
let g:hardtime_ignore_buffer_patterns = [ "CustomPatt[ae]rn", "NERD.*" ]
let g:hardtime_ignore_quickfix = 1
let g:hardtime_allow_different_key = 1
let g:hardtime_maxcount = 2

" https://vim.fandom.com/wiki/Folding#Indent_folding_with_manual_folds
augroup vimrc
  au BufReadPre * setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END
Plug 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview=1
" https://stackoverflow.com/a/7425005/2400133
" https://www.cnblogs.com/heqiuyu/articles/5630167.html
set foldlevel=0
set foldnestmax=3
" Enable folding with the spacebar
nnoremap <space> za
" https://stackoverflow.com/a/360634/2400133
vnoremap <space> zf

Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'

Plug 'w0rp/ale'
" side bar display
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
let g:ale_enabled = 0
" icon definition
"let g:ale_sign_error = '✗'
"let g:ale_sign_warning = '⚡'
" ALE offers some commands with <Plug> keybinds for moving between
" warnings and errors quickly.
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
"<Leader>s toggle ale
nmap <Leader>a :ALEToggle<CR>
"<Leader>d Look up the details of an error/warning.
nmap <Leader>d :ALEDetail<CR>
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 0
let g:airline#extensions#ale#enabled = 1
let g:ale_python_pylint_options = "--init-hook='import sys; sys.path.append(\".\")'"

"Plug 'zhmars/vim-ibus', {'as': 'ibus'}
"let g:ibus#layout = 'xkb:us::eng'
"let g:ibus#engine = 'libpinyin'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

"" Settings for plugins shipped with vim

" netrw https://shapeshed.com/vim-netrw/
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
" augroup END

"------------------
" Autocmd
"------------------
" https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
" Using the autocmd method, you could customize when the directory change
" takes place. For example, to not change directory if the file is in /tmp:
autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Put these in an autocmd group, so that you can revert them with:
  " ":augroup vimStartup | au! | augroup END"
  augroup vimStartup
    au!
    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
  augroup END
endif " has("autocmd")

" Commands - automatic run

"Change vimrc with auto reload
autocmd! bufwritepost .vimrc source %

"---------------------
" Key mapping
"---------------------

" Neil - Practical Vim, Second Edition.pdf P. 85
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

nnoremap <F8> :Gw<CR>
nnoremap <F9> :!git clean -d -x -f<CR>

" - | reloading vimrc, sourcing it
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>sg :source $MYGVIMRC<CR>
"Remove all trailing whitespace by pressing F6
nnoremap <F6> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
" Mappings related to <Esc> https://news.ycombinator.com/item?id=13100718
"during insert, kj escapes, `^ is so that the cursor doesn't move.
inoremap kj <Esc>`^
"during insert, .kj escapes and go to the next line in insert mode.
inoremap lkj <Esc>`^o
" during insert, pkj escapes and go to the line after the next in insert mode.
inoremap pkj <Esc>`^o<CR>
" during insert, lkj escapes and saves
"inoremap lkj <Esc>`^:w<CR>
"during insert, lkj escapes and saves and QUITS
inoremap ;lkj <Esc>:wq<CR>
"" Settings for utilities
nnoremap <F5> :call CompileRunGcc()<cr>
func! CompileRunGcc()
          exec "w"
          if &filetype == 'python'
                  if search("@profile")
                          exec "AsyncRun kernprof -l -v %"
                          exec "copen"
                          exec "wincmd p"
                  elseif search("set_trace()")
                          exec "!python3 %"
                  else
                          exec "AsyncRun -raw python3 %"
                          exec "copen"
                          exec "wincmd p"
                  endif
        endif
endfunc

" Now you can just press F3 any time inside Vi/Vim and you'll get a
" timestamp like 2016-01-25 Mo 12:44 inserted at the cursor.
nmap <F3> i<C-R>=strftime("%Y-%m-%d %I:%M")<CR><Esc>
" nmap <F3> i<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>
imap <F3> <C-R>=strftime("%Y-%m-%d %I:%M")<CR>
" imap <F3> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>
"------------------
" Search
"------------------

" Do incremental searching when it's possible to timeout.
if has('reltime')
  set incsearch
endif
" highlight serach
set hlsearch
" https://vi.stackexchange.com/questions/184/how-can-i-clear-word-highlighting-in-the-current-document-e-g-such-as-after-se
nnoremap <Leader><space> :noh<cr>
" https://vim.fandom.com/wiki/Searching#Case_sensitivity
:set ignorecase
:set smartcase
:nnoremap * /\<<C-R>=expand('<cword>')<CR>\><CR>
:nnoremap # ?\<<C-R>=expand('<cword>')<CR>\><CR>
" http://vim.wikia.com/wiki/Search_across_multiple_lines?useskin=monobook
" Search for the ... arguments separated with whitespace (if no '!'),
" or with non-word characters (if '!' added to command).
function! SearchMultiLine(bang, ...)
  if a:0 > 0
    let sep = (a:bang) ? '\_W\+' : '\_s\+'
    let @/ = join(a:000, sep)
  endif
endfunction
command! -bang -nargs=* -complete=tag S call SearchMultiLine(<bang>0, <f-args>)|normal! /<C-R>/<CR>

"------------------
" Syntax and indent
"------------------
" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
" Revert with ":filetype off".
filetype indent on
" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
"if &t_Co > 2 || has("gui_running")
"   " Revert with ":syntax off".
"syntax on
"endif

set showmatch " show matching braces when text indicator is over them

"------------------
" Color scheme
"------------------

if (has("termguicolors"))
    set termguicolors
endif

" vim can autodetect this based on $TERM (e.g. 'xterm-256color')
" but it can be set to force 256 colors
" set t_Co=256
if has('gui_running')
    colorscheme solarized
    let g:lightline = {'colorscheme': 'solarized'}
elseif &t_Co < 256
    colorscheme default
    set nocursorline " looks bad in this mode
else
    set background=dark
    let g:solarized_termcolors=256 " instead of 16 color with mapping in terminal
    colorscheme solarized
    " customized colors
    highlight SignColumn ctermbg=234
    highlight StatusLine cterm=bold ctermfg=245 ctermbg=235
    highlight StatusLineNC cterm=bold ctermfg=245 ctermbg=235
    let g:lightline = {'colorscheme': 'dark'}
    highlight SpellBad cterm=underline
endif

"---------------------
" Basic editing config
"---------------------

" Solve the coding problem of the console
"language messages zh_CN.utf-8

set encoding=utf-8
" Terminal coding
set termencoding=utf-8
" The coding of current file
set fileencodings=ucs-bom,utf-8,gbk,cp936,gb2312,big5,euc-jp,euc-kr,latin1

set number
"https://stackoverflow.com/questions/1878974/redefine-tab-as-4-spaces
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having a width of 4.
set shiftwidth=4    " Indents will have a width of 4
set softtabstop=4   " Sets the number of columns for a TAB
set expandtab       " Expand TABs to spaces
" Set wrap
" https://stackoverflow.com/a/26284471/2400133
set columns=84
autocmd VimResized * if (&columns > 74) | set columns=74 | endif
set textwidth=74
set wrap
set linebreak
set showbreak=+

" Change the size of fonts of vim (ctrl and "-";　ctrl and "+")
" Note that this does not work in GVim!
" Reference https://github.com/wsdjeg/vim-galore-zh_cn
command! Bigger  :let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)+1', '')
command! Smaller :let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)-1', '')

" Spell settings
" https://www.ostechnix.com/use-spell-check-feature-vim-text-editor/
" http://thejakeharding.com/tutorial/2012/06/13/using-spell-check-in-vim.html
"set spell
set spelllang=en_us
set spellfile=~/.vim/spell/en.utf-8.add
" https://vi.stackexchange.com/a/5052/16763
for d in glob('~/.vim/spell/*.add', 1, 1)
    if filereadable(d) && (!filereadable(d . '.spl') || getftime(d) > getftime(d . '.spl'))
        exec 'mkspell! ' . fnameescape(d)
    endif
endfor


" Default settings

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start
set history=8192		" keep 8192 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set wildmenu		" display completion matches in a status line
set ttimeout		" time out for key codes
set ttimeoutlen=100	" wait up to 100ms after Esc for special key
" Show @@@ in the last line if it is truncated.
set display=truncate
" Show a few lines of context around the cursor.  Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5
" Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it
" confusing.
set nrformats-=octal
" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries.
if has('win32')
  set guioptions-=t
endif
" Don't use Ex mode, use Q for formatting.
" Revert with ":unmap Q".
map Q gq
" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>
" In many terminal emulators the mouse works just fine.  By enabling it you
" can position the cursor, Visually select and scroll with the mouse.
if has('mouse')
  set mouse=a
endif
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
if has('langmap') && exists('+langremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If set (default), this may break plugins (but it's backward
  " compatible).
  set nolangremap
endif

" .vimrc_customized keeps settings specific to a computer.
try
  source ~/.df/dotfiles-vm-u18/vimrc_customized
catch
  " No such file? No problem; just ignore it.
endtry

try
  source ~/.df/vimrc_customized
catch
  " No such file? No problem; just ignore it.
endtry

try
  source ~/.vimrc_customized
catch
  " No such file? No problem; just ignore it.
endtry
