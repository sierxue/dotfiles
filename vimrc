" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

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
Plug '907th/vim-auto-save'
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'altercation/solarized'
Plug 'davidhalter/jedi-vim'
Plug 'flazz/vim-colorschemes'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/gv.vim'
Plug 'lervag/vimtex'
Plug 'maralla/completor.vim'
Plug 'nelstrom/vim-americanize'
Plug 'sillybun/vim-repl/'
Plug 'skywind3000/asyncrun.vim'
Plug 'takac/vim-hardtime'
Plug 'tmhedberg/SimpylFold'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'w0rp/ale'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

"------------------
" Autocmd
"------------------

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

" Set wrap
autocmd VimResized * if (&columns > 76) | set columns=76 | endif

"Change vimrc with auto reload
autocmd! bufwritepost .vimrc source %

"---------------------
" Key mapping
"---------------------

" - | reloading vimrc, sourcing it
" https://stackoverflow.com/questions/1025762/cursor-disappears-in-vim-when-switching-windows-between-vertical-and-horizontal
nnoremap <leader>sv :source $MYVIMRC<CR>
"Remove all trailing whitespace by pressing F6
nnoremap <F6> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
" Mappings related to <Esc> https://news.ycombinator.com/item?id=13100718
"during insert, kj escapes, `^ is so that the cursor doesn't move.
inoremap kj <Esc>`^
"during insert, lkj escapes and saves
inoremap lkj <Esc>`^:w<CR>
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
filetype plugin indent on
" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
" if &t_Co > 2 || has("gui_running")
"   " Revert with ":syntax off".
syntax on

set showmatch " show matching braces when text indicator is over them

"------------------
" Color scheme
"------------------

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

"Solve the coding problem of the console
language messages zh_CN.utf-8

" Terminal coding
set termencoding=utf-8
" The coding of current file
set fileencoding=utf-8
set number
"https://stackoverflow.com/questions/1878974/redefine-tab-as-4-spaces
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having a width of 4.
set shiftwidth=4    " Indents will have a width of 4
set softtabstop=4   " Sets the number of columns for a TAB
set expandtab       " Expand TABs to spaces
" Set wrap
" https://stackoverflow.com/questions/989093/soft-wrap-at-80-characters-in-vim-in-window-of-arbitrary-width/989317
set textwidth=74
set columns=84
set wrap
set linebreak
set showbreak=+
" Spell settings
" https://www.ostechnix.com/use-spell-check-feature-vim-text-editor/
" http://thejakeharding.com/tutorial/2012/06/13/using-spell-check-in-vim.html
"set spell
set spelllang=en_us
set spellfile=~/.vim/spell/en.utf-8.add
" re-generate spl file for spell checking https://vi.stackexchange.com/questions/5050/how-to-share-vim-spellchecking-additions-between-multiple-machines
for d in glob('~/.vim/spell/*.add', 1, 1)
    if filereadable(d) && (!filereadable(d . '.spl') || getftime(d) > getftime(d . '.spl'))
        exec 'mkspell! ' . fnameescape(d)
    endif
endfor

"" Settings for plugins

" 907th/vim-auto-save configuration
let g:auto_save = 1  " enable AutoSave on Vim startup
"let g:auto_save_silent = 1  " do not display the auto-save notification

" SirVer/UltiSnips configuration
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

" lervag/vimtex configuration
let g:tex_flavor = 'latex'
" Remove warning message: Can't use callbacks without +clientserver · Issue #507 · lervag/vimtex
let g:vimtex_compiler_latexmk = {'callback' : 0}
" Select pdf viewer
let g:vimtex_view_method = 'zathura'
" https://castel.dev/post/lecture-notes-1/
" https://app.yinxiang.com/shard/s22/nl/4928451/de0f809b-c0bc-4774-b459-683696356703
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

" maralla/completor configuration
" https://github.com/maralla/completor.vim/issues/41
let g:completor_tex_omni_trigger =
        \   '\\(?:'
        \  .   '\w*cite\w*(?:\s*\[[^]]*\]){0,2}\s*{[^}]*'
        \  .  '|\w*ref(?:\s*\{[^}]*|range\s*\{[^,}]*(?:}{)?)'
        \  .  '|hyperref\s*\[[^]]*'
        \  .  '|includegraphics\*?(?:\s*\[[^]]*\]){0,2}\s*\{[^}]*'
        \  .  '|(?:include(?:only)?|input)\s*\{[^}]*'
        \  .')'
" Use Tab to select completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"
" Use Tab to trigger completion (disable auto trigger)
let g:completor_auto_trigger = 1
" inoremap <expr> <Tab> pumvisible() ? "<C-N>" : "<C-R>=completor#do('complete')<CR>"

" sillybun/vim-repl/ configuration
" ganx: revise default <leader>r to <leader>rt
nnoremap <leader>rt :REPLToggle<Cr>
"let g:rep_width = None
"let g:rep_height = None
let g:sendtorepl_invoke_key = "<leader>w"
let g:repl_position = 3
let g:repl_stayatrepl_when_open = 0
" ganx Revise python to python3, bash to zsh
let g:repl_program = {
			\	"python": "python3",
			\	"default": "zsh"
			\	}
let g:repl_exit_commands = {
			\	"python": "quit()",
			\	"bash": "exit",
			\	"zsh": "exit",
			\	"default": "exit",
			\	}

" vim-hardtime
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

" tmhedberg/SimpylFold configuration
let g:SimpylFold_docstring_preview=1

" w0rp/ale configuration
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

" trash_Can

"" Setting themes
" https://www.reddit.com/r/vim/comments/75zvux/why_is_vim_background_different_inside_tmux/
" let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
" let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
" set termguicolors
" set term=xterm-256color
"
"   " I like highlighting strings inside C comments.
"   " Revert with ":unlet c_comment_strings".
"   let c_comment_strings=1
" endif

" coding
"Plug 'metakirby5/codi.vim' "ganx looks like conflicts with tmux or
"something else. Problem: the cursor is always goes to the first line.

"180320 ctrl+C (copy) Looks it works in windows.
"vmap <C-c> "+y
"vnoremap <C-C> "+y
"vnoremap <C-Insert> "+y

"180320 ctrl+V or Shift+Insert (paste) Looks it works in windows.
"imap <C-v> "+gP
""vnoremap <BS> d
"imap <C-V>		"+gP
"map <S-Insert>		"+gP
"cmap <C-V>		<C-R>+
"cmap <S-Insert>		<C-R>+

" Plug 'christoomey/vim-tmux-navigator'
" vim-tmux-navigator configuration
" let g:tmux_navigator_no_mappings = 1
"
" nnoremap <silent> {Left-Mapping} :TmuxNavigateLeft<cr>
" nnoremap <silent> {Down-Mapping} :TmuxNavigateDown<cr>
" nnoremap <silent> {Up-Mapping} :TmuxNavigateUp<cr>
" nnoremap <silent> {Right-Mapping} :TmuxNavigateRight<cr>
" nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>
"
" " Write all buffers before navigating from Vim to tmux pane
" let g:tmux_navigator_save_on_switch = 2
"
" " Disable tmux navigator when zooming the Vim pane
" let g:tmux_navigator_disable_when_zoomed = 1

" Changing the leader key
"let mapleader = “,”

" https://stackoverflow.com/questions/13376822/vim-line-numbers-on-display-lines
"set fo=tcrwa textwidth=80

"let g:vimtex_view_general_viewer = 'okular'
"let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
"let g:vimtex_view_general_options_latexmk = '--unique'
