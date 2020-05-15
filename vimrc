" vimrc
" Austin Burt
" austin@burt.us.com

" General {{

    set background=dark         " Assume a dark background

    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    scriptencoding utf-8
     
    " Always switch to the current file directory
    augroup auto_switch_dir
        autocmd!
        autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
    augroup END

    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore             " Allow for cursor beyond last character
    set history=1000                    " Store a ton of history (default is 20)
    set nospell                         " Spell checking
    set hidden                          " Allow buffer switching without saving
    set iskeyword-=.                    " '.' is an end of word designator
    set iskeyword-=#                    " '#' is an end of word designator
    set iskeyword-=-                    " '-' is an end of word designator

    " http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
    " Restore cursor to file position in previous editing session
    function! ResCur()
        if line("'\"") <= line("$")
    	silent! normal! g`"
    	return 1
        endif
    endfunction

    augroup cursor_position
        autocmd!
        autocmd BufWinEnter * call ResCur()
        au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
    augroup END

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
    set numberwidth=5
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

" }}

" Formatting {{

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

    " filetype autocmds from spf13 {{
    augroup strip_trailing_whitespace
        autocmd!
        autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> call StripTrailingWhitespace()
        autocmd FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
        autocmd BufNewFile,BufRead *.coffee set filetype=coffee
    augroup END

    " Workaround vim-commentary for Haskell
    autocmd FileType haskell setlocal commentstring=--\ %s
    " Workaround broken colour highlighting in Haskell
    autocmd FileType haskell,rust setlocal nospell
    " }}

" }}

" Vundle {{1
    " Settings {{2
        set nocompatible              " be iMproved, required
        filetype off                  " required

        " set the runtime path to include Vundle and initialize
        set rtp+=~/.vim/bundle/Vundle.vim
    "}}2

    call vundle#begin()" {{2
        Plugin 'VundleVim/Vundle.vim'

        " plugin on GitHub repo
        Plugin 'airblade/vim-gitgutter'
        Plugin 'christoomey/vim-system-copy'
        Plugin 'ctrlpvim/ctrlp.vim'
        Plugin 'dhruvasagar/vim-table-mode'
        Plugin 'easymotion/vim-easymotion'
        Plugin 'godlygeek/tabular'
        Plugin 'itchyny/lightline.vim'
        Plugin 'jiangmiao/auto-pairs'
        Plugin 'junegunn/goyo.vim'
        Plugin 'mbbill/undotree'
        Plugin 'nathanaelkane/vim-indent-guides'
        Plugin 'rhysd/conflict-marker.vim'
        Plugin 'scrooloose/nerdcommenter'
        Plugin 'tpope/vim-abolish'
        Plugin 'tpope/vim-fugitive'
        Plugin 'tpope/vim-pathogen'
        Plugin 'tpope/vim-repeat'
        Plugin 'tpope/vim-surround'
        "Plugin 'Valloric/YouCompleteMe'
        Plugin 'vim-scripts/sessionman.vim'
        Plugin 'vim-syntastic/syntastic.git'

        "Colorschemes {{3
            Plugin 'arcticicestudio/nord-vim'
            Plugin 'ayu-theme/ayu-vim' " or other package manager
            Plugin 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
            Plugin 'crusoexia/vim-monokai'
            Plugin 'dracula/vim', { 'name': 'dracula' }
            "Plugin 'ethanschoonover/vim-solarized'
            Plugin 'junegunn/seoul256.vim'
            Plugin 'lifepillar/vim-solarized8'
            Plugin 'liuchengxu/space-vim-dark'
            Plugin 'nanotech/jellybeans.vim'
            Plugin 'reedes/vim-colors-pencil'
            Plugin 'romainl/Apprentice'
            Plugin 'sainnhe/gruvbox-material'
            Plugin 'sheerun/vim-polyglot'
            Plugin 'sjl/badwolf'
            Plugin 'xero/sourcerer.vim'
            Plugin 'alirezabashyri/molokai-italic'
            Plugin 'yassinebridi/vim-purpura'
        " }}3

        " plugin from http://vim-scripts.org/vim/scripts.html
        " Plugin 'L9'
        " Git plugin not hosted on GitHub
        Plugin 'git://git.wincent.com/command-t.git'

        " git repos on your local machine (i.e. when working on your own
        " plugin) Plugin 'file:///home/gmarik/path/to/plugin' The sparkup vim
        " script is in a subdirectory of this repo called vim. Pass the path
        " to set the runtimepath properly.
        Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

        call vundle#end()            " required
    " }}2

    " Vundle Notes {{2
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
    " }}2

    packadd! matchit
" }}1

" Visual Setup {{1
    set termguicolors

    " Pick a scheme with my modifications
    " If pick_scheme exists use it to define the coloscheme.
    " Otherwise use badwolf, or fall back to torte as a last resort.
    if filereadable(expand("~/.vim/personal/pick_scheme.vim"))
        source ~/.vim/personal/pick_scheme.vim
        call Pickscheme("badwolf")
    else
        if isdirectory(expand("~/.vim/bundle/badwolf")) let g:badwolf_tabline=3
            colorscheme badwolf
            hi Comment cterm=italic
            hi Normal guibg=black guifg=white
            hi Folded term=standout cterm=italic ctermfg=14 ctermbg=236 gui=italic guifg=#a0a8b0 guibg=#384048
        else
            color torte
            hi Folded term=standout cterm=italic ctermfg=14 ctermbg=236 gui=italic guifg=#a0a8b0 guibg=#384048
            hi clear SignColumn      " SignColumn should match background
        endif
    endif
" }}1

" Mods {{1
    let mapleader = ","
    let maplocalleader = "\\"

    nnoremap <left> ,
    nnoremap <right> ;
    " could be better but fine for now
    nnoremap <up> N
    nnoremap <down> n

    " to fix my habit of doing VJ which is very different
    nnoremap <space> Vj
    vnoremap <space> }

    map <C-J> <C-W>j
    map <C-K> <C-W>k
    map <C-L> <C-W>l
    map <C-H> <C-W>h

    noremap j gj
    noremap k gk

    inoremap kj <esc>

    " alt-h,alt-l in xterm
    map è gT
    map ì gt

    " omaps for 'inside/around next/last' (,),{,},[,] }}2
        onoremap in( :<c-u>normal! f(vi(<cr>
        onoremap in) :<c-u>normal! f)vi)<cr>
        onoremap il( :<c-u>normal! F(vi(<cr>
        onoremap il) :<c-u>normal! F)vi)<cr>

        onoremap in{ :<c-u>normal! f{vi{<cr>
        onoremap in} :<c-u>normal! f}vi}<cr>
        onoremap il{ :<c-u>normal! F{vi{<cr>
        onoremap il} :<c-u>normal! F}vi}<cr>

        onoremap in[ :<c-u>normal! f[vi[<cr>
        onoremap in] :<c-u>normal! f]vi]<cr>
        onoremap il[ :<c-u>normal! F[vi[<cr>
        onoremap il] :<c-u>normal! F]vi]<cr>

        onoremap an( :<c-u>normal! f(vi(<cr>
        onoremap an) :<c-u>normal! f)vi)<cr>
        onoremap al( :<c-u>normal! F(vi(<cr>
        onoremap al) :<c-u>normal! F)vi)<cr>

        onoremap an{ :<c-u>normal! f{vi{<cr>
        onoremap an} :<c-u>normal! f}vi}<cr>
        onoremap al{ :<c-u>normal! F{vi{<cr>
        onoremap al} :<c-u>normal! F}vi}<cr>

        onoremap an[ :<c-u>normal! f[vi[<cr>
        onoremap an] :<c-u>normal! f]vi]<cr>
        onoremap al[ :<c-u>normal! F[vi[<cr>
        onoremap al] :<c-u>normal! F]vi]<cr>
    " }}2

    " Wrap Relative Motion {{2
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
    " }}2

    " foldlevel mappings{{2
        nnoremap <leader>f0 :set foldlevel=0<CR>
        nnoremap <leader>f1 :set foldlevel=1<CR>
        nnoremap <leader>f2 :set foldlevel=2<CR>
        nnoremap <leader>f3 :set foldlevel=3<CR>
        nnoremap <leader>f4 :set foldlevel=4<CR>
        nnoremap <leader>f5 :set foldlevel=5<CR>
        nnoremap <leader>f6 :set foldlevel=6<CR>
        nnoremap <leader>f7 :set foldlevel=7<CR>
        nnoremap <leader>f8 :set foldlevel=8<CR>
        nnoremap <leader>f9 :set foldlevel=9<CR>
    "}}2

    " Find merge conflict markers
    " this line does weird folding {{3
        map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>
    " }}3


    " Shortcuts {{2
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
        " <leader>vs used by 'edit vimrc'
        map <leader>evs :vsp %%
        map <leader>et :tabe %%

        " Adjust viewports to the same size
        map <Leader>= <C-w>=

        nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

        " Easier horizontal scrolling
        map zl zL
        map zh zH

        " Easier formatting
        nnoremap <silent> <localleader>q gwip

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
    " }}2

" }}1

" Plugin key-remapping{{1

    " Tabularize {{2
        if isdirectory(expand("~/.vim/bundle/tabular"))
            nmap <Leader>a& :Tabularize /&<CR>
            vmap <Leader>a& :Tabularize /&<CR>
            nmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
            vmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
            nmap <Leader>a=> :Tabularize /=><CR>
            vmap <Leader>a=> :Tabularize /=><CR>
            nmap <Leader>a: :Tabularize /:<CR>
            vmap <Leader>a: :Tabularize /:<CR>
            nmap <Leader>a:: :Tabularize /:\zs<CR>
            vmap <Leader>a:: :Tabularize /:\zs<CR>
            nmap <Leader>a, :Tabularize /,<CR>
            vmap <Leader>a, :Tabularize /,<CR>
            nmap <Leader>a,, :Tabularize /,\zs<CR>
            vmap <Leader>a,, :Tabularize /,\zs<CR>
            nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
            vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
        endif
    " }}2

    " Session List {{2
        set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
        if isdirectory(expand("~/.vim/bundle/sessionman.vim/"))
            nmap <leader>sl :SessionList<CR>
            nmap <leader>ss :SessionSave<CR>
            nmap <leader>sc :SessionClose<CR>
        endif
    " }}2

    " Fugitive {{2
        if isdirectory(expand("~/.vim/bundle/vim-fugitive/"))
            nnoremap <silent> <leader>gs :Gstatus<CR>
            nnoremap <silent> <leader>gd :Gdiff<CR>
            nnoremap <silent> <leader>gc :Gcommit<CR>
            nnoremap <silent> <leader>gb :Gblame<CR>
            nnoremap <silent> <leader>gl :Glog<CR>
            nnoremap <silent> <leader>gp :Git push<CR>
            nnoremap <silent> <leader>gr :Gread<CR>
            nnoremap <silent> <leader>gw :Gwrite<CR>
            nnoremap <silent> <leader>ge :Gedit<CR>
            " Mnemonic _i_nteractive
            nnoremap <silent> <leader>gi :Git add -p %<CR>
            nnoremap <silent> <leader>gg :SignifyToggle<CR>
        endif
    " }}2

    " UndoTree {{
        if isdirectory(expand("~/.vim/bundle/undotree/"))
            nnoremap <Leader>u :UndotreeToggle<CR>
            " If undotree is opened, it is likely one wants to interact with it.
            let g:undotree_SetFocusWhenToggle=1
        endif
    " }}

    " Goyo {{2
        nmap <localleader>g :Goyo<cr>
        function! s:goyo_enter()
            silent !tmux set status off
            set noshowmode
            set noshowcmd
            set scrolloff=6
            colorscheme pencil
            hi Normal guibg=black guifg=white
            hi Folded term=standout cterm=italic ctermfg=14 ctermbg=236 gui=italic guifg=#a0a8b0 guibg=#384048
            set number
            set relativenumber
        endfunction
        function! s:goyo_leave()
            silent !tmux set status on
            "silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
            set showmode
            set showcmd
            set scrolloff=3
            let g:badwolf_tabline=3
            colorscheme badwolf
            hi Comment cterm=italic
            hi Normal guibg=black guifg=white
            hi Folded term=standout cterm=italic ctermfg=14 ctermbg=236 gui=italic guifg=#a0a8b0 guibg=#384048
        endfunction

        autocmd! User GoyoEnter nested call <SID>goyo_enter()
        autocmd! User GoyoLeave nested call <SID>goyo_leave()
    " }}2

    " indent_guides {{
        if isdirectory(expand("~/.vim/bundle/vim-indent-guides/"))
            let g:indent_guides_start_level = 2
            let g:indent_guides_guide_size = 1
            let g:indent_guides_enable_on_vim_startup = 1
            let g:indent_guides_color_change_percent = 3
        endif
    " }}

    " JSON {{2
        nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
        let g:vim_json_syntax_conceal = 0
    " }}2

" }}1

" Abbreviations {{1
    iabbrev @@ austin@burt.us.com
    iabbrev shceme scheme
    iabbrev colorshceme colorscheme

    cabbrev hlep help
" }}1

" Custom Leader Mappings {{1
    " Map leader set in Mods
    nnoremap <leader>ev :Vimrc<cr>
    nnoremap <leader>sv :so $MYVIMRC<cr>
    nnoremap <leader>s :w<cr>
    inoremap <leader>s <esc>:w<cr>
     noremap <leader>q :q!<cr>
     noremap <leader>; q:
    nnoremap <leader>ps :call Pickscheme("?")<cr>:call Pickscheme("")<left><left>

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

    " FileType {{2
        augroup filetype_html
            autocmd!
            autocmd FileType html let @l = "<li>placeholder</li>"
            autocmd FileType html nnoremap <leader>l o<esc>"lp==cit
        augroup END
    " }}2

    " Local Leader {{2
        nnoremap <silent><localleader>o O<Esc>jo<Esc>k
    " }}2
" }}1

" Custom Commnads {{1
    command! Vimrc :vs $MYVIMRC
    command! Alias :vs ~/.config/aliases
    command! Dotfiles :tabnew ~/git/dotfiles-and-scripts/ | Gstatus

    command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor
" }}1

" Functions {{1

    " Sourced {{
        source ~/.vim/personal/redir_messages.vim
        " Pickscheme() sourced from Visual Setup
    " }}

    " Set directories for backups, views, swaps, and undos {{2
        " They will live under $HOME/.vim/artifacts/
        function! InitializeDirectories()
            let parent = $HOME . "/" . ".vim" . "/" . "artifacts"
            let prefix = 'vim'
            let dir_list = {
                        \ 'backup': 'backupdir',
                        \ 'views': 'viewdir',
                        \ 'swap': 'directory',
                        \ 'undo': 'undodir' }
            let common_dir = parent . '/' . prefix
            " common_dir= ~/.vim/artifacts/vim

            for [dirname, settingname] in items(dir_list)
                let directory = common_dir . dirname . '/'
                if exists("*mkdir")
                    if !isdirectory(directory)
                        call mkdir(directory)
                    endif
                endif
                if !isdirectory(directory)
                    echo "Warning: Unable to create backup directory: " . directory
                    echo "Try: mkdir -p " . directory
                else
                    let directory = substitute(directory, " ", "\\\\ ", "g")
                    exec "set " . settingname . "=" . directory
                endif
            endfor
        endfunction
        call InitializeDirectories()
    " }}2

    " Redraw The Cursor {{2
        " to have a line cursor in insert and a block cursor in normal: added 12/27/19
        if has("autocmd")
            augroup cursor_change
                autocmd!
                au VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
                au InsertEnter,InsertChange *
                            \ if v:insertmode == 'i' |
                            \   silent execute '!echo -ne "\e[6 q"' | redraw! |
                            \ elseif v:insertmode == 'r' |
                            \   silent execute '!echo -ne "\e[4 q"' | redraw! |
                            \ endif
                au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
            augroup END
        endif
    " }}2

" Inc() - Allow for Increasing numbers {{2
    ""    :let i=1 | s/abc/\='xyz_'. Inc(5)/g
    " Add argument (can be negative, default 1) to global variable i.
    " Return value of i before the change.
    function Inc(...)
      let result = g:i
      let g:i += a:0 > 0 ? a:1 : 1
      return result
    endfunction
" }}2

    " Strip whitespace {{
        function! StripTrailingWhitespace()
            " Preparation: save last search, and cursor position.
            let _s=@/
            let l = line(".")
            let c = col(".")
            " do the business:
            %s/\s\+$//e
            " clean up: restore previous search history, and cursor position
            let @/=_s
            call cursor(l, c)
        endfunction
    " }}

    " Shell command {{
        function! s:RunShellCommand(cmdline)
            botright new

            setlocal buftype=nofile
            setlocal bufhidden=delete
            setlocal nobuflisted
            setlocal noswapfile
            setlocal nowrap
            setlocal filetype=shell
            setlocal syntax=shell

            call setline(1, a:cmdline)
            call setline(2, substitute(a:cmdline, '.', '=', 'g'))
            execute 'silent $read !' . escape(a:cmdline, '%#')
            setlocal nomodifiable
            1
        endfunction

        command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)
        " e.g. Grep current file for <search_term>: Shell grep -Hn <search_term> %
    " }}

    " ExpandFilenameAndExecute {{2
        function! s:ExpandFilenameAndExecute(command, file)
            execute a:command . " " . expand(a:file, ":p")
        endfunction
    " }}2

" }}1

" Helpful Links I Have Used {{1
    " Much of this vimrc was borrowed from:
    "   https://github.com/spf13/spf13-vim

    " https://sherif.io/2016/05/30/favorite-vim-plugins.html
    " https://www.hillelwayne.com/post/intermediate-vim/
    " http://vimcasts.org/
    " https://learnvimscriptthehardway.stevelosh.com/
" }}1

" Space to put 'temporary' mappings that will survive closing vim. {{1

nnoremap <localleader>a za
nnoremap <silent><localleader>v :vs /home/vladislav/tmp/vim.backup/bundle<CR>
nnoremap <silent><localleader>e :e /home/vladislav/tmp/vim.backup/bundle<CR>
nnoremap <silent><leader>r :lcd %:p:h<cr>/readme<cr>:e <c-r><c-f><cr>
nnoremap <localleader>s :so /home/vladislav/.vim/personal/pick_scheme.vim<cr>

"}}1

" Modeline{{
" vim: set foldmarker={{,}} foldlevel=0 foldmethod=marker:}}
