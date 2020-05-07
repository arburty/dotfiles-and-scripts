" vimrc
" Austin Burt
" austin@burt.us.com

" General {

	set background=dark         " Assume a dark background

	filetype plugin indent on   " Automatically detect file types.
	syntax on                   " Syntax highlighting
	set mouse=a                 " Automatically enable mouse usage
	set mousehide               " Hide the mouse cursor while typing
	scriptencoding utf-8
	 
	" Always switch to the current file directory
	autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

	set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
	set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
	set virtualedit=onemore             " Allow for cursor beyond last character
	set history=1000                    " Store a ton of history (default is 20)
	set spell                           " Spell checking on
	set hidden                          " Allow buffer switching without saving
	set iskeyword-=.                    " '.' is an end of word designator
	set iskeyword-=#                    " '#' is an end of word designator
	set iskeyword-=-                    " '-' is an end of word designator

	au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

	" http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
	" Restore cursor to file position in previous editing session
	function! ResCur()
	    if line("'\"") <= line("$")
		silent! normal! g`"
		return 1
	    endif
	endfunction

	set backup                  " Backups are nice ...
	set undofile                " So is persistent undo ...
	set undolevels=1000         " Maximum number of changes that can be undone
	set undoreload=10000        " Maximum number lines to save for undo on a buffer reload

	set tabpagemax=15               " Only show 15 tabs
	set showmode                    " Display the current mode
	"set cursorline                  " Highlight current line

	highlight clear SignColumn      " SignColumn should match background
	highlight clear LineNr          " Current line number row will have same background color in relative mode
	"highlight clear CursorLineNr    " Remove highlight color from current line number

	set ruler                   " Show the ruler
	set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
	set showcmd                 " Show partial commands in status line and
				    " Selected characters/lines in visual mode

	set backspace=indent,eol,start  " Backspace for dummies
	set linespace=0                 " No extra spaces between rows
	set number                      " Line numbers on
	set relativenumber              " Obvious
	set showmatch                   " Show matching brackets/parenthesis
	set incsearch                   " Find as you type search
	set hlsearch                    " Highlight search terms
	set winminheight=0              " Windows can be 0 line high
	set ignorecase                  " Case insensitive search
	set smartcase                   " Case sensitive when uc present
	set wildmenu                    " Show list instead of just completing
	set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
	set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
	set scrolljump=1                " Lines to scroll when cursor leaves screen was 5
	set scrolloff=3                 " Minimum lines to keep above and below cursor
	set foldenable                  " Auto fold code
	set list
	set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
	set lazyredraw
	runtime! ftplugin/man.vim

" }

" Formatting {

    set nowrap                      " Do not wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    "set matchpairs+=<:>             " Match, to be used with %
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)

    " filetype autocmds from spf13 {
"	autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> call StripTrailingWhitespace()
    autocmd FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
    autocmd BufNewFile,BufRead *.coffee set filetype=coffee

    " Workaround vim-commentary for Haskell
    autocmd FileType haskell setlocal commentstring=--\ %s
    " Workaround broken colour highlighting in Haskell
    autocmd FileType haskell,rust setlocal nospell
    " }

" }

" Vundle {1
" Settings {2
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim "}2

call vundle#begin() " {2
Plugin 'VundleVim/Vundle.vim'

" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'christoomey/vim-system-copy'
Plugin 'godlygeek/tabular'
Plugin 'scrooloose/nerdcommenter'
Plugin 'jiangmiao/auto-pairs'
Plugin 'mbbill/undotree'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-pathogen'
Plugin 'lifepillar/vim-solarized8'
"Plugin 'ethanschoonover/vim-solarized'
Plugin 'junegunn/goyo.vim'
Plugin 'sainnhe/gruvbox-material'
Plugin 'sheerun/vim-polyglot'
Plugin 'dracula/vim', { 'name': 'dracula' }
Plugin 'ayu-theme/ayu-vim' " or other package manager
Plugin 'junegunn/seoul256.vim'
Plugin 'arcticicestudio/nord-vim'
Plugin 'crusoexia/vim-monokai'
Plugin 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plugin 'xero/sourcerer.vim'
Plugin 'liuchengxu/space-vim-dark'
Plugin 'nanotech/jellybeans.vim'

" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'

" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

call vundle#end()            " required
" }2

" Vundle Notes {2
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" }2

packadd! matchit
" }1

" Visual Setup {1
set termguicolors
let g:jellybeans_use_term_italics = 1
color jellybeans
let g:jellybeans_overrides = { 'background': { 'guibg': 'black' }, }
"hi Comment cterm=italic
"let g:space_vim_dark_background = 233
"colorscheme space-vim-dark
"let g:seoul256_background = 233
"colorscheme seoul256
"let ayucolor="mirage" " for mirage version of theme
""let ayucolor=dark"   " for dark version of theme
"colorscheme ayu
"let g:gruvbox_material_background = 'hard'
"let g:gruvbox_material_visual = 'reverse'
"let g:gruvbox_material_palette = 'material'
"colorscheme gruvbox-material
"colorscheme torte
" elflord was nice.
" desert was alright.
" koehler was close. bad statusline
" industry was close. ì
"colorscheme solarized8_dark_high

" Change individual colors around {2
" change identifier and DiffText to bright yellow
"hi Identifier term=bold cterm=bold ctermfg=3 gui=bold guifg=#b58900
"hi DiffText   term=bold cterm=bold ctermfg=3 gui=bold guifg=#b58900

"" change Visual to a green highlight
"hi Visual term=bold ctermfg=2 ctermbg=0 guifg=#0000FF guibg=#00FF00

"" a more readable red
"hi DiffDelete term=standout cterm=bold ctermfg=9 gui=bold guifg=#cb4b16

"" change to a readable darkblue
"" most of these were a darker blue I couldn't read
"hi vimHiLink          ctermfg=12 guifg=#839496
"hi vimHiGroup         ctermfg=12 guifg=#839496
"hi helpHyperTextJump  ctermfg=12 guifg=#839496
"hi helpHyperTextJump  ctermfg=12 guifg=#839496
"hi directory          ctermfg=12 guifg=#839496
"hi MoreMsg            ctermfg=12 guifg=#839496
"hi ModeMsg            ctermfg=12 guifg=#839496
"hi directory          ctermfg=12 guifg=#839496
"hi MoreMsg            ctermfg=12 guifg=#839496
"hi ModeMsg            ctermfg=12 guifg=#839496

" }2

" Tab Colors {2
" changer vertical split color
"highlight VertSplit guibg=Orange guifg=Black ctermbg=9 ctermfg=0
"
"" make actice tab green with black text
"hi tablinesel ctermfg=DarkGreen ctermbg=Black
"
"" other tabs are black w/ yellow text
"hi tabline ctermfg=Black ctermbg=Yellow
"
"" gray tab bar
"hi tablinefill ctermfg=DarkGray ctermbg=White
" }2
" }1

" Mods {1
let mapleader = ","
let localleader = "_"

map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l
map <C-H> <C-W>h

noremap j gj
noremap k gk

" alt-h,alt-l in xterm
map è gT
map ì gt

" Wrap Relative Motion {2
        function! WrapRelativeMotion(key, ...)
            let vis_sel=""
            if a:0
                let vis_sel="gv"
            endif
            if &wrap
                execute "normal!" vis_sel . "g" . a:key
            else
                execute "normal!" vis_sel . a:key
            endif
        endfunction

        " Map g* keys in Normal, Operator-pending, and Visual+select
        noremap $ :call WrapRelativeMotion("$")<CR>
        noremap <End> :call WrapRelativeMotion("$")<CR>
        noremap 0 :call WrapRelativeMotion("0")<CR>
        noremap <Home> :call WrapRelativeMotion("0")<CR>
        noremap ^ :call WrapRelativeMotion("^")<CR>
        " Overwrite the operator pending $/<End> mappings from above
        " to force inclusive motion with :execute normal!
        onoremap $ v:call WrapRelativeMotion("$")<CR>
        onoremap <End> v:call WrapRelativeMotion("$")<CR>
        " Overwrite the Visual+select mode mappings from above
        " to ensure the correct vis_sel flag is passed to function
        vnoremap $ :<C-U>call WrapRelativeMotion("$", 1)<CR>
        vnoremap <End> :<C-U>call WrapRelativeMotion("$", 1)<CR>
        vnoremap 0 :<C-U>call WrapRelativeMotion("0", 1)<CR>
        vnoremap <Home> :<C-U>call WrapRelativeMotion("0", 1)<CR>
        vnoremap ^ :<C-U>call WrapRelativeMotion("^", 1)<CR>
" }2

" foldlevel mappings{2
nmap <leader>f0 :set foldlevel=0<CR>
nmap <leader>f1 :set foldlevel=1<CR>
nmap <leader>f2 :set foldlevel=2<CR>
nmap <leader>f3 :set foldlevel=3<CR>
nmap <leader>f4 :set foldlevel=4<CR>
nmap <leader>f5 :set foldlevel=5<CR>
nmap <leader>f6 :set foldlevel=6<CR>
nmap <leader>f7 :set foldlevel=7<CR>
nmap <leader>f8 :set foldlevel=8<CR>
nmap <leader>f9 :set foldlevel=9<CR>
"}2

" Find merge conflict markers
" this line does weird folding {3
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>
" }3


" Shortcuts {2
" Change Working Directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Adjust viewports to the same size
map <Leader>= <C-w>=

nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" Easier horizontal scrolling
map zl zL
map zh zH

" Easier formatting
nnoremap <silent> <leader>q gwip

nnoremap Q @q
nnoremap Y y$

" copy line to current position
" g=line number, j=line down, k=line up
nnoremap _g ggY``p
nnoremap _j jY``p
nnoremap _k kY``p
" this will work if i can add count as '5'
"   :+5t.

vnoremap <Esc> <Esc>gV
 noremap <leader>; q:
" }2
" }1

" Custom Leader Mappings {1
" Map leader set in Mods
nnoremap <leader>ev :Vimrc
nnoremap <leader>sv :so $MYVIMRC<cr>
nnoremap <leader>s :w<cr>
inoremap <leader>s <esc>:w<cr>
 noremap <leader>q :q!<cr>

nnoremap <leader>H :bp<cr>
nnoremap <leader>L :bn<cr>
nnoremap <silent><leader><space> :noh<cr>
nnoremap <silent> <c-\> :set hlsearch!<cr>

" ,o doesn't work with [count] for some reason but ,O does
nnoremap <silent><leader>o :normal! o<esc>k
nnoremap <silent><leader>O :normal! O<esc>j
"nnoremap                _o new lines above and below -- under Local Leader

nnoremap <leader>D oecho "" #DEBUG<esc>F"i

" Capitalize First Letter of Words
nnoremap <silent><leader>C :s/\<./\u&/g<cr>:noh<cr>``
vnoremap <silent><leader>C :s/\%V\<./\u&/g<cr>:noh<cr>``

" Useful
nnoremap <leader>d :r !date "+\%m/\%d/\%y \%H:\%M"
nnoremap <leader>M :20messages<cr>
nnoremap <leader>b :set filetype=sh

" FileType {2
autocmd FileType html let @l = "<li>placeholder</li>"
autocmd FileType html nnoremap <leader>l o<esc>"lp==cit
" }2

" Local Leader {2
nnoremap <silent><localleader>o O<Esc>jo<Esc>k
" }2
" }1

" Custom Commnads {1
command! Vimrc :vs $MYVIMRC
command! Alias :vs ~/.config/aliases
command! Dotfiles :tabnew ~/git/dotfiles-and-scripts/ | Gstatus

command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor
" }1

" Functions {1
source ~/.vim/personal/redir_messages.vim

" Redraw The Cursor {2
" to have a line cursor in insert and a block cursor in normal: added 12/27/19
if has("autocmd")
  au VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
  au InsertEnter,InsertChange *
\ if v:insertmode == 'i' |
\   silent execute '!echo -ne "\e[6 q"' | redraw! |
\ elseif v:insertmode == 'r' |
\   silent execute '!echo -ne "\e[4 q"' | redraw! |
\ endif
au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
endif
" }2

" Inc() - Allow for Increasing numbers {2
""    :let i=1 | s/abc/\='xyz_'. Inc(5)/g
" Add argument (can be negative, default 1) to global variable i.
" Return value of i before the change.
function Inc(...)
  let result = g:i
  let g:i += a:0 > 0 ? a:1 : 1
  return result
endfunction
" }2
" }1

" Helpful Links I Have Used {
" https://www.hillelwayne.com/post/intermediate-vim/
" http://vimcasts.org/
" }


" Modeline{
" vim: set foldmarker={,} foldlevel=0 foldmethod=marker:}