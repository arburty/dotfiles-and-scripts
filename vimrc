" vimrc
" Austin Burt
" austin@burt.us.com

" General {{

    set background=dark         " Assume a dark background

    " this will override other Settings. Best to be set asap.
    set nocompatible              " be iMproved

    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    scriptencoding utf-8

    " Always switch to the current file directory
    augroup auto_switch_dir
        autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
        autocmd!
    augroup END

    set shortmess=filmnrxoOtT           " Abbrev. of messages (avoids 'hit enter')
    set shortmess+=c                    " don't show completion messages
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore             " Allow for cursor beyond last character
    set history=1000                    " Store a ton of history (default is 20)
    set nospell                         " Spell checking
    set complete+=kspell                " autocomplete dictionary words when spell is on
    set hidden                          " Allow buffer switching without saving
    set iskeyword-=.                    " '.' is an end of word designator
    set iskeyword-=#                    " '#' is an end of word designator
    set iskeyword-=-                    " '-' is an end of word designator
    set keywordprg=:Man
    set wildignore+=*/windows_home/*

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

    highlight clear SignColumn      " SignColumn should match background

    set ruler                   " Show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
    set showcmd                 " Show partial commands in status line and
    			    " Selected characters/lines in visual mode

    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winheight=8                 " Windows can be 0 line high
    set winminheight=5              " Windows can be 0 line high
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

    set formatoptions=roqlj         " no auto-wrapping, comment friendly. Default:tcq
    set nowrap                      " Do not wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    "set matchpairs+=<:>            " Match, to be used with %
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)

    " filetype autocmds from spf13 {{
    augroup strip_trailing_whitespace
        autocmd!
        autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> call StripTrailingWhitespace()
        autocmd FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
        autocmd BufNewFile,BufRead *.coffee set filetype=coffee
    augroup END

    " Workaround vim-commentary for Haskell
    " Workaround broken colour highlighting in Haskell
    augroup haskell
        autocmd FileType haskell setlocal commentstring=--\ %s
        autocmd FileType haskell,rust setlocal nospell
    augroup END
    " }}

" }}

" Vundle {{1
    " Settings {{2
        " requires 'set nocompatible'.  Set at top of vimrc
        filetype off                  " required

        " set the runtime path to include Vundle and initialize
        set rtp+=~/.vim/bundle/Vundle.vim
    " }}2

    call vundle#begin() " {{2
        Plugin 'VundleVim/Vundle.vim'

        " plugin on GitHub repo
        Plugin 'airblade/vim-gitgutter'
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
        Plugin 'tpope/vim-repeat'
        Plugin 'tpope/vim-surround'
        "Plugin 'Valloric/YouCompleteMe'
        Plugin 'vim-scripts/sessionman.vim'
        Plugin 'vim-syntastic/syntastic.git'
        Plugin 'da-x/name-assign.vim'
        " removed because of conflicts with coc
        " Plugin 'vim-scripts/AutoComplPop'
        "Plugin 'wellle/context.vim'
        Plugin 'romainl/vim-cool'
        "Plugin 'neoclide/coc.nvim', {'branch': 'release'}
        Plugin 'justinmk/vim-sneak'
        Plugin 'zef/vim-cycle'
        Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
        Plugin 'junegunn/fzf.vim'
        Plugin 'AndrewRadev/sideways.vim'
        Plugin 'davidhalter/jedi'
        Plugin 'SkyLeach/pudb.vim'
        Plugin 'tpope/vim-unimpaired'
        Plugin 'tpope/vim-dadbod'
        Plugin 'kristijanhusak/vim-dadbod-ui'
        Plugin 'fatih/vim-go'
        Plugin 'JamshedVesuna/vim-markdown-preview'

        " Fugitive and it's plugins. {{3
            Plugin 'tpope/vim-fugitive'
            Plugin 'idanarye/vim-merginal'
            " Plugins for talking to different providers.
            Plugin 'tpope/vim-rhubarb' " GitHub
            "Plugin 'shumphrey/fugitive-gitlab.vim' " GitLab
            "Plugin 'tommcdo/vim-fubitive' " BitBucket
        " }}3

        "Colorschemes {{3
            Plugin 'arcticicestudio/nord-vim'
            Plugin 'ayu-theme/ayu-vim' " or other package manager
            Plugin 'challenger-deep-theme/vim', { 'name': 'challenger-deep' }
            Plugin 'embark-theme/vim', { 'name': 'embark' }
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
            Plugin 'bignimbus/pop-punk.vim'
            Plugin 'https://gitlab.com/protesilaos/tempus-themes-vim.git'
            Plugin 'edersonferreira/dalton-vim'
            Plugin 'ulwlu/elly.vim'
            Plugin 'joshdick/onedark.vim'
            " TODO: tomorrow theme not showing up.  needs some attention.
            Plugin 'chriskempson/tomorrow-theme', { 'name': 'tomorrow-night' }
            Plugin 'Pocco81/Catppuccino.nvim'

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
    set number                      " Line numbers on
    set relativenumber              " Obvious
    set numberwidth=5
    highlight clear LineNr          " Current line number row will have same background color in relative mode
    highlight clear CursorLineNr    " Remove highlight color from current line number
    set cursorline                   " also set in pick_schemes sometimes

    set termguicolors
    " Pick a scheme with my modifications
    " If pick_scheme exists use it to define the coloscheme.
    " Otherwise use badwolf, or fall back to torte as a last resort.
    function! SetScheme(scheme)
        if filereadable(expand("~/.vim/personal/pick_scheme.vim"))
            source ~/.vim/personal/pick_scheme.vim
            call Pickscheme(a:scheme)
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
    endfunction
    call SetScheme("pop-punk")
" }}1

" Mods {{1
    let mapleader = ","
    let maplocalleader = "\\"

    nnoremap <left> :SidewaysLeft<cr>
    nnoremap <right> :SidewaysRight<cr>

    " to fix my habit of doing VJ which is very different
    nnoremap <space> Vj
    vnoremap <space> }

    map <C-J> <C-W>j
    map <C-K> <C-W>k
    map <C-L> <C-W>l
    map <C-H> <C-W>h

    noremap j gj
    noremap k gk

    " make the search pattern the current cursor column
    " thought it was cool so I snagged it, not enabled though.
    xnoremap \k ?\%<C-R>=virtcol(".")<CR>v\S<CR>
    xnoremap \j /\%<C-R>=virtcol(".")<CR>v\S<CR>
    nnoremap \k ?\%<C-R>=virtcol(".")<CR>v\S<CR>
    nnoremap \j /\%<C-R>=virtcol(".")<CR>v\S<CR>
    " \K was something I didn't recognize for :call <SNR>9_PreGetPage(0)<cr>
    silent! unmap \K
    nmap \K \kN<C-v>{N
    nmap \J \jN<C-v>}N
    xmap \K \kN<C-v>{N
    xmap \J \jN<C-v>}N

    inoremap kj <esc>

    cnoremap <C-G> <ESC>

    " alt-h,alt-l in xterm
    "map è gT
    "map ì gt
    "nmap <A-p> gT
    "nmap <A-n> gt

    " All text after column 80 is highlighted
    highlight rightMargin term=bold ctermfg=blue guifg=orange
    nnoremap <localleader>h :match rightMargin /.\%>81v/
    nnoremap <localleader>H :match none<cr>

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
        noremap <silent> $ :call WrapRelativeMotion("$")<CR>
        noremap <silent> <End> :call WrapRelativeMotion("$")<CR>
        noremap <silent> 0 :call WrapRelativeMotion("0")<CR>
        noremap <silent> <Home> :call WrapRelativeMotion("0")<CR>
        noremap <silent> ^ :call WrapRelativeMotion("^")<CR>
        " Overwrite the operator pending $/<End> mappings from above
        " to force inclusive motion with :execute normal!
        onoremap <silent> $ v:call WrapRelativeMotion("$")<CR>
        onoremap <silent> <End> v:call WrapRelativeMotion("$")<CR>
        " Overwrite the Visual+select mode mappings from above
        " to ensure the correct vis_sel flag is passed to function
        vnoremap <silent> $ :<C-U>call WrapRelativeMotion("$", 1)<CR>
        vnoremap <silent> <End> :<C-U>call WrapRelativeMotion("$", 1)<CR>
        vnoremap <silent> 0 :<C-U>call WrapRelativeMotion("0", 1)<CR>
        vnoremap <silent> <Home> :<C-U>call WrapRelativeMotion("0", 1)<CR>
        vnoremap <silent> ^ :<C-U>call WrapRelativeMotion("^", 1)<CR>
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

        " Select pasted text
        nnoremap gpv `[v`]

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

" onoremaps {{1

    " 'inside', 'around' and 'to' fold markers
    onoremap if :<c-u>exe "norm! ]zkV[zj"<cr>
    onoremap af :<c-u>exe "norm! ]zV[z"<cr>
    onoremap Tf :<c-u>exe "norm! V[zj"<cr>
    onoremap tf :<c-u>exe "norm! V]zk"<cr>

    " omaps for '(i)nside/(a)round (n)ext/(l)ast (,),{,},[,],'," {{2
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

        onoremap in< :<c-u>normal! f<vi<<cr>
        onoremap in> :<c-u>normal! f>vi><cr>
        onoremap il< :<c-u>normal! F<vi<<cr>
        onoremap il> :<c-u>normal! F>vi><cr>

        onoremap in' :<c-u>normal! f'vi'<cr>
        onoremap il' :<c-u>normal! F'vi'<cr>

        onoremap in" :<c-u>normal! f"vi"<cr>
        onoremap il" :<c-u>normal! F"vi"<cr>

        onoremap an( :<c-u>normal! f(va(<cr>
        onoremap an) :<c-u>normal! f)va)<cr>
        onoremap al( :<c-u>normal! F(va(<cr>
        onoremap al) :<c-u>normal! F)va)<cr>

        onoremap an{ :<c-u>normal! f{va{<cr>
        onoremap an} :<c-u>normal! f}va}<cr>
        onoremap al{ :<c-u>normal! F{va{<cr>
        onoremap al} :<c-u>normal! F}va}<cr>

        onoremap an[ :<c-u>normal! f[va[<cr>
        onoremap an] :<c-u>normal! f]va]<cr>
        onoremap al[ :<c-u>normal! F[va[<cr>
        onoremap al] :<c-u>normal! F]va]<cr>

        onoremap an< :<c-u>normal! f<va<<cr>
        onoremap an> :<c-u>normal! f>va><cr>
        onoremap al< :<c-u>normal! F<va<<cr>
        onoremap al> :<c-u>normal! F>va><cr>

        onoremap an' :<c-u>normal! f'va'<cr>
        onoremap al' :<c-u>normal! F'va'<cr>

        onoremap an" :<c-u>normal! f"va"<cr>
        onoremap al" :<c-u>normal! F"va"<cr>
    " }}2
" }}1

" Plugin key-remapping{{1
    " coc.vim {{2
    if 0 "disable coc
    if isdirectory("~/.vim/bundle/coc.nvim/")
        " https://vimawesome.com/plugin/coc-snippets
        " under Examples

        " Use <C-j> for select text for visual placeholder of snippet.
        vnoremap <C-j> <Plug>(coc-snippets-select)
        "
        " Use <C-j> for jump to next placeholder, it's default of coc.nvim
        let g:coc_snippet_next = '<c-j>'

        " Use <C-k> for jump to previous placeholder, it's default of
        " coc.nvim
        let g:coc_snippet_prev = '<c-k>'

        " Use <C-j> for both expand and jump (make expand higher priority.)
        imap <C-j> <Plug>(coc-snippets-expand-jump)
    endif
    endif
    " }}2

    "}}2

    " vim-go{{2
        if isdirectory('~/.vim/bundle/vim-go')
            let g:go_term_enabled=1
        endif
    "}}2

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
            nmap <Leader>a# :Tabularize /#<CR>
            vmap <Leader>a# :Tabularize /#<CR>
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
            " Git Yank: Copy URL to current line(s)
            nnoremap <silent> <leader>gy :.GBrowse!<cr>
            xnoremap <silent> <leader>gy :'<,'>GBrowse!<cr>
        endif
    " }}2

    " Merginal {{2
        if isdirectory(expand("~/.vim/bundle/vim-merginal/"))
            nnoremap <silent> <leader>gB :MerginalToggle<cr>
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
            let g:goyo_width=90
            "let g:goyo_linenr=1
            set number
            set relativenumber
            call SetScheme('pencil')
        endfunction
        function! s:goyo_leave()
            silent !tmux set status on
            "silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
            set showmode
            set showcmd
            set scrolloff=3
            call SetScheme("pop-punk")
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

    " CommandT {{2
        let g:CommandTScanDotDirectories = 1
        let g:CommandTSuppressMaxFilesWarning = 1
        let g:CommandTWildIgnore=&wildignore        . ",*.pdf"
        let g:CommandTWildIgnore=CommandTWildIgnore . ",*.odt"
        let g:CommandTWildIgnore=CommandTWildIgnore . ",*.odg"
        let g:CommandTWildIgnore=CommandTWildIgnore . ",*.xcf"
        let g:CommandTWildIgnore=CommandTWildIgnore . ",*.jpg"
        let g:CommandTWildIgnore=CommandTWildIgnore . ",*.jpeg"
        let g:CommandTWildIgnore=CommandTWildIgnore . ",*.png"
        let g:CommandTWildIgnore=CommandTWildIgnore . ",*.mp4"
        let g:CommandTWildIgnore=CommandTWildIgnore . ",*.webm"

        nmap <silent> <Leader>B <Plug>(CommandTBuffer)
        nmap <silent> <Leader>h <Plug>(CommandTHelp)
        nnoremap <Leader>ct :CommandT
        nmap <silent> <Leader>t<space> <Plug>(CommandT)
        "nmap <silent> <Leader>t <Plug>(CommandT) "already a default
        "nmap <silent> <Leader>j <Plug>(CommandTJump) "already a default
    "}}2

    " name-assign {{2
        let g:name_assign_mode_maps = { "up" : ["k"],  "down" : ["j"] }
    " }}2

    " Merginal {{2
        if isdirectory(expand("~/.vim/bundle/vim-merginal/"))
            nnoremap ,m :Merginal<cr>
        endif
    " }}

    " vim-markdown-preview {{2
        if isdirectory(expand("~/.vim/bundle/vim-markdown-preview/"))
            let vim_markdown_preview_toggle=0
            let vim_markdown_preview_hotkey='<C-m>'
            "let vim_markdown_preview_browser='Google Chrome'
            "let vim_markdown_preview_browser='Qutebrowser'
            " vim_markdown_preview_github uses grip
            let vim_markdown_preview_github=1
            " uses pandoc
            "let vim_markdown_preview_pandoc=1
            " Default is see, this makes it use xdg_open
            "let vim_markdown_preview_use_xdg_open=1
        endif
    " }}2

" }}1

" Abbreviations {{1
    iabbrev @@ austin@burt.us.com
    iabbrev shceme scheme
    iabbrev colorshceme colorscheme
    iabbrev Tnanks Thanks
    iabbrev tnanks thanks

    cabbrev hlep help
" }}1

" Custom Leader Mappings {{1
    " Map leader set in Mods
    nnoremap <leader>ev :Vimrc<cr>
    nnoremap <leader>rv :Reddit<cr>
    nnoremap <leader>U :Udemy<cr>
    nnoremap <leader>sv :so $MYVIMRC<cr>
    nnoremap <leader>s :w<cr>
    inoremap <leader>s <esc>:w<cr>
    nnoremap <leader>tc :tag /
    nnoremap <leader>tC :!ctags -R --exclude=.git<cr>

     "noremap <leader>q :q!<cr>
     " Changed to call function that allows for leaving term pages and not exit
     " vim.
    nnoremap <silent> <leader>q :call <SID>Quit()<cr>
     noremap <leader>; q:
    nnoremap <leader>ps :call Pickscheme("?")<cr>:PickScheme<space>
    nnoremap <silent><leader>lb :execute "rightbelow vsplit " . bufname("#")<cr>
    nnoremap <leader>d. :call DeleteFileAndCloseBuffer()
    nnoremap <leader>F :call <SID>FoldColumnToggle()<cr>
    nnoremap <leader>Q :call <SID>QuickfixToggle()<cr>
    nnoremap <localleader>S :set spell!<cr>
    "nnoremap <silent><leader>p :exe "norm 0dw\"+Pld2F "<cr>
    " needs work but a better version of the above.
    "nnoremap <leader>p :g/^\d\{3,9}p\?_/exe "s//" . substitute(@+, " - \\a*\\.com", "","") . "_/"<cr>
    "nnoremap <leader>pt :%s/\v\zs.*\ze[.-](mp4\|(\d{2,4}:))/\=substitute(@+, " \\(\\d\\{2}\\.\\)\\{2}\\d\\{2}$", "", "")/<cr>:silent noh<cr>
    "nnoremap <leader>pt :CleanupTitles<cr>
    " TODO: currently does the mapping creatioon in the script,
    " should instead create plugs I map from vimrc

    " highlight the current line
    nnoremap <leader>l :call matchadd('LineHighlight', '\%'.line('.').'l')<cr>
    vnoremap <leader>l :<c-u>call HiglightVisualLines()<cr>
    " clear all the highlighted lines
    nnoremap <leader>c :call clearmatches()<cr>

    nnoremap <leader>H :bp<cr>
    nnoremap <leader>L :bn<cr>

    " refresh the cursor, remove highlighting and stop visual selection
    nnoremap <silent><leader><space> :noh<cr>a<esc>
        vmap <silent><leader><space> <esc>,<space>
    nnoremap <silent> <c-\> :set hlsearch!<cr>

    " ,o doesn't work with [count] for some reason but ,O does
    nnoremap <silent><leader>o :exe "normal! mmo\e`m'"<cr>
    nnoremap <silent><leader>O :normal! O<esc>j
    nnoremap <silent><leader>O :exe "normal! mmO\e`m"<cr>

    " This uses tpope's unimpaired to help.
    nmap _o :<c-u>norm <c-r>=v:count . "[ " . v:count . "] "<cr><cr>
    vmap _o :<c-u>norm <c-r>="'<" . v:count . "[ '>" . v:count . "] "<cr><cr>
    "nnoremap                _o new lines above and below -- under Local Leader

    nnoremap <leader>D oecho "" #DEBUG<esc>F"i

    " Capitalize First Letter of Words
    nnoremap <silent><leader>C :s/[^']\zs\<.\ze/\u&/g<cr>:noh<cr>``
    vnoremap <silent><leader>C :s/\%V[^']\zs\<.\ze/\u&/g<cr>:noh<cr>``

    " Useful
    nnoremap <leader>d :r !date "+\%m/\%d/\%y \%H:\%M"<cr>k:join<cr>$BB
    nnoremap <leader>M :20messages<cr>
    nnoremap <leader>b :set filetype=sh
    nnoremap <leader>bh "_
    vnoremap <leader>bh "_

    " Tmux clipping
    vnoremap <leader>y "zy:<c-u>call <SID>SaveSelectionToFileAndTmuxClip()<cr>
    nnoremap <leader>y :<c-u>call <SID>SaveSelectionToFileAndTmuxClip()<cr>
    nnoremap <leader>Y :let @z=@" <bar> call <SID>SaveSelectionToFileAndTmuxClip()<cr>

    nnoremap <leader>~ :s;/home/vladislav;\~;g<cr>

    nnoremap <Plug>figletTitle :exe "r! figlet " . expand('%:t')<cr>
    nmap ,fig 2] j<Plug>figletTitlekVip,cl

    " terminal mappings {{2
        if has("terminal")
            augroup terminal
                au!
                autocmd FileType terminal tnoremap <buffer> <leader>q <C-W>N:bd!<cr>
                autocmd FileType terminal tnoremap <buffer> <leader><Esc> <C-\><C-n>
            augroup END
        endif
    "}} 2


    " Local Leader {{2
        "nnoremap <silent><localleader>o O<Esc>jo<Esc>k
    " }}2
" }}1

" Custom Commnads {{1
    command! Vimrc :vs $MYVIMRC
    command! Alias :vs ~/.config/aliases
    command! Dotfiles :tabnew ~/git/dotfiles-and-scripts/ | Gstatus
    command! Reddit :call system("firefox reddit.com/r/vim > /dev/null 2>&1 &")
    command! Udemy :call system("firefox udemy.com/course/python-the-complete-python-developer-course/learn/ > /dev/null 2>&1 &")
    command! Markd :silent exe "!tmux split-window -h" | silent exe "!tmux send -t 1 'markd ". expand("%") ."' C-M"
    command! -complete=color -nargs=1 PickScheme :call Pickscheme("<args>")

    command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor
" }}1

" Functions {{1

    " Sourced {{
        source ~/.vim/personal/redir_messages.vim
        " maps v and n <leader>G
        source ~/.vim/personal/grep-operator.vim
        " maps <leader>p commands
        source ~/.vim/personal/rename-torrents.vim

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
    function! Inc(...)
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

" SaveSelectionToFileAndTmuxClip {{2
" used to sync vim on wsl to the clipboard
    function! s:SaveSelectionToFileAndTmuxClip()
        silent! exe "!(~/bin/usetmuxtoclip.exe.sh " . trim(shellescape(getreg('z'), 1)). " &)"
        redraw!
    endfunction
" }}2

    " DeleteFileAndCloseBuffer {{2
    " Expands filename and confirms you want to delete it.
    " https://stackoverflow.com/questions/16678661/how-can-i-delete-the-current-file-in-vim
    " By: joelostblom.
    " Modified to say the filename and use 'bd!' instead of 'q!'
        fun! DeleteFileAndCloseBuffer()
            let file = expand('%:p')
            let choice = confirm("Delete file " . file . " and close buffer?", "&Do it!\n&Nonono", 1)
            if choice == 1 | call delete(file) | bd! | endif
        endfun
    " }}2

    " FoldColumnToggle {{2
        function! s:FoldColumnToggle()
            if &foldcolumn
                setlocal foldcolumn=0
            else
                setlocal foldcolumn=4
            endif
        endfunction
    " }}2

    " QuickfixToggle {{2
        let s:quickfix_is_open = 0
        function! s:QuickfixToggle()
            if s:quickfix_is_open
                cclose
                let s:quickfix_is_open = 0
                execute s:quickfix_return_to_window . "wincmd w"
            else
                let s:quickfix_return_to_window = winnr()
                copen
                let s:quickfix_is_open = 1
            endif
        endfunction
    " }}2
    
    " Quit mapping {{2
    " Used to quit buffers as usual. If buffer is a term window, then go to
    " alternate buffer, and delete the term window.
    " TODO: reset the alternate buffer.  currently after closing the term
    " window there is no alternate buffer.
    "   Probably have to get the current alt buff before opening the term
    "   somehow.
    function! s:Quit()
        if !empty(expand('%')) && split(expand('%').":", ':')[0] ==# "term"
            echom 'Closing Terminal'
            " Switch to last buffer and delete the terminal.
            b #
            bd! #
        else
            " Normal quit.
            q!
        endif
    endfunction
    " }}2

    " SetPersonalHeader {{2
        function! SetPersonalHeader()
            "set 'z' mark, go to top and make a new line
            norm! mzggO
            read ~/Templates/basic-header.txt
            " delete top line since read goes below cursor, replace TITLE with filename
            exe "norm! kddcw\<c-r>%"
            exe "norm! /Date\e"
            " call my date binding, delete the hour/minute, join lines
            exe "norm ,d\e$dF xkJ"
            " comment out lines, add space between comment and word, add two more commented lines
            exe "norm jjVgg,c l\<c-v>3jI \e3j,o.`z"
        endfunction
    " }}2

    " Java_compile {{2
    function! Java_compile()
        # Assuming structure is Projectroot/MyFile.java
        let s:main=expand("%:p:h:t:r") . "." . expand("%:t:r")
        exe "cd " . expand("%:p:h") . "/.."

        silent make
        cwindow
        let s:qf=empty(filter(range(1, winnr('$')), 'getwinvar(v:val, "&ft") == "qf"'))

        " the quickfix window is not opened e.g. no errors
        if s:qf
            exe "Shell java " . s:main
        endif
        redraw!
    endfunction
    " }}2

    " Config_h_compile {{2
    function! Config_h_compile()
        exe 'cd ' . fnameescape(expand('%:h')).'/'

        silent make
        cwindow
        let s:qf=empty(filter(range(1, winnr('$')), 'getwinvar(v:val, "&ft") == "qf"'))
        if s:qf && expand('%:p:h:t') == 'st'
            silent !~/git/st/st &
        endif

        redraw!
    endfunction
    " }}2

    " OpenURLUnderCursor() {{2
    " Open URL's workaround
        function! OpenURLUnderCursor()
            let s:uri = expand('<cWORD>')
            let s:uri = substitute(s:uri, '?', '\\?', '')
            let s:uri = shellescape(s:uri, 1)
            if s:uri != ''
                silent exec "!gio open '".s:uri."' >/dev/null 2>&1"
                :redraw!
            endif
        endfunction
        let g:netrw_browsex_viewer= "gio open"
        nnoremap gx :call OpenURLUnderCursor()<CR>
    " 2}}

    " HiglightVisualLines() {{2
    " define line highlight color: a blue
    highlight LineHighlight ctermbg=100 guibg=#374090

    " loop throough visually selected lines and give them highlighting
    function! HiglightVisualLines()
        for i in range(line('v'),line("'>"))
            call matchadd('LineHighlight', '\%'.i.'l')
        endfor
    endfunction
    " 2}}

    " {{2
    " Used to translate the quickcix list to the args list
    " to be able to operate on the files in the quickfix list
    " through the args list.
    " VimTricks: Copy from Quickfix to the Args list
    command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
    function! QuickfixFilenames()
        let buffer_numbers = {}
        for quickfix_item in getqflist()
            let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
        endfor
        return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
    endfunction
    " }}2



" }}1

" Custom Augroups/cmd's {{1
    augroup filetype_html
        autocmd!
        autocmd FileType html let @l = "<li>placeholder</li>"
        " make a new line, paste the li tag, justify, blackhole change in tag.
        autocmd FileType html nnoremap <buffer> <leader>l o<esc>"lp=="_cit
        autocmd Filetype html nnoremap <buffer> <localleader>z :Markd<cr>
    augroup END

    augroup vimsource
        au!
        au FileType vim nmap <buffer> <leader>z :w<cr>:source <c-r>%<cr>
    augroup END

    augroup Xresources
        au!
        autocmd BufWritePost .Xresources echom "xrdb -merge ~/.Xresources"
        autocmd BufWritePost .Xresources silent execute "!xrdb -merge ~/.Xresources"
        autocmd FileType c,cpp nnoremap <buffer> <localleader>z :call Config_h_compile()<cr>
    augroup END

    augroup java
        au!
        " https://stackoverflow.com/questions/6411979/compiling-java-code-in-vim-more-efficiently/14727153#14727153
        " source I pulled the next block from originally
        autocmd Filetype java set makeprg=javac\ %
        autocmd Filetype java set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
        autocmd Filetype java nnoremap <buffer> <F9> :make<cr>:copen<cr>
        autocmd Filetype java nnoremap <buffer> <F10> :cprevious<cr>
        autocmd Filetype java nnoremap <buffer> <F11> :cnext<cr>

        " settings that are all me
        autocmd Filetype java set foldmethod=syntax foldlevel=1
        autocmd FileType java nnoremap <buffer> <localleader>z :call Java_compile()<cr>

        " https://github.com/neoclide/coc.nvim
        autocmd Filetype java nnoremap <silent> gd <Plug>(coc-definition)
        autocmd Filetype java nnoremap <silent> gy <Plug>(coc-type-definition)
        autocmd Filetype java nnoremap <silent> gi <Plug>(coc-implementation)
        autocmd Filetype java nnoremap <silent> gr <Plug>(coc-references)
    augroup END

    augroup markdown
        au!
        autocmd Filetype markdown nnoremap <buffer> <localleader>z :Markd<cr>
        autocmd Filetype markdown let g:markdown_fenced_languages = ['html', 'python', 'ruby', 'vim', 'java', 'awk', 'sed', 'bash']
    augroup END

    " TODO: move to a filetype file python.vim
    augroup python
        au!
        "autocmd Filetype python tnoremap <silent><buffer> <leader>q <c-\><c-n>,q
        autocmd Filetype python nnoremap <silent><buffer> <localleader>z :term python3 %<cr>
    augroup END
" }}1

" Helpful Links I Have Used {{1
    " This vimrc was heavily changed using spf-13 as
    " a starting point:
    " https://github.com/spf13/spf13-vim

    " https://sherif.io/2016/05/30/favorite-vim-plugins.html
    " https://www.hillelwayne.com/post/intermediate-vim/
    " http://vimcasts.org/
    "
    " An EXCELLENT resource for learning vimscript:
    " https://learnvimscriptthehardway.stevelosh.com/
" }}1

" Space to put 'temporary' mappings that will survive closing vim. {{1

nnoremap <localleader>a za
nnoremap <silent><localleader>v :vs /home/vladislav/tmp/vim.backup/bundle<CR>
nnoremap <silent><localleader>e :e /home/vladislav/tmp/vim.backup/bundle<CR>
nnoremap <silent><leader>r :lcd %:p:h<cr>/readme<cr>:e <c-r><c-f><cr>
nnoremap <localleader>s :so /home/vladislav/.vim/personal/pick_scheme.vim<cr>
nnoremap <localleader>d :DronePhotoContest<CR>

function! DronePhotoContestFunc() 
    let var=substitute(@+, "\\(\"\\|”\\|“\\)", "", "g") 
    s/-\d\{1,2}// 
    exe "norm I=var\<cr>a-2021\<ESC>eaphotocontest"
endfunction
command! DronePhotoContest :call DronePhotoContestFunc()

"execut "set <M-h>=\eh"
"execut "set <M-l>=\el"
"execut "set <M-j>=\ej"
"execut "set <M-k>=\ek"

"nnoremap <M-l> gt
"nnoremap <M-h> gT
"nnoremap <M-j> :m .+1<cr>==
"nnoremap <M-k> :m .-2<cr>==
"vnoremap <M-j> :m '>+1<CR>gv=gv
"vnoremap <M-k> :m '<-2<CR>gv=gv

"}}1

" Modeline{{
" vim: set foldmarker={{,}} foldlevel=0 foldmethod=marker:}}
