" pick_scheme.vim {
" Author : Austin Burt
" Email  : austin@burt.us.com
" Date   : 05/12/20
"
" Pick color schemes and adjust them to my liking.
" }

function Default_folded() " {1
    hi Folded term=standout cterm=italic ctermfg=White ctermbg=236 gui=italic guifg=#a0a8b0 guibg=#384048
endfunction " }1

function Default_linecolors() "{1
    set cursorline
    hi LineNr term=bold cterm=NONE ctermfg=Cyan ctermbg=NONE gui=NONE guifg=Cyan guibg=NONE
    hi LineNrBelow ctermbg=NONE guifg=Green
    hi CursorLineNr term=bold ctermbg=NONE gui=bold guibg=NONE guifg=Yellow
endfunction
" }1

function! Pickscheme(scheme) " {

    if a:scheme == 'badwolf' " {
        let g:badwolf_tabline=3
        colorscheme badwolf
        hi Comment cterm=italic
        hi Normal guibg=black guifg=white
        call Default_folded()
        call Default_linecolors()
        " }

    elseif a:scheme == 'pencil' " {
        " line mubers and comments could be brighter
        " tabline could use some changes
        colorscheme pencil
        hi Normal guibg=black guifg=white
        call Default_folded()
        call Default_linecolors()
        " }

    elseif a:scheme == 'jellybeans' " {
        let g:jellybeans_use_term_italics = 1
        let g:jellybeans_overrides = { 'background' : { 'guibg': '000000' }, }
        colorscheme jellybeans
        " }

    elseif a:scheme == 'ayu' " {
        "needs new number colors
        "check colors for directories in :e ./
        let ayucolor="mirage" " for mirage version of theme
        let ayucolor="dark"    " for dark version of theme
        colorscheme ayu
        call Default_folded()
        call Default_linecolors()
        " }

    elseif a:scheme == 'seoul256' " {
        " split color needs fixing, tabline is too bright
        " nice grey numbres, may want to borrow
        let g:seoul256_background = 233
        colorscheme seoul256
        " }

    elseif a:scheme == 'space-vim-dark' " {
        let g:space_vim_dark_background = 233
        colorscheme space-vim-dark
        hi Normal guibg=black guifg=white
        hi Comment cterm=italic
        call Default_folded()
        call Default_linecolors()
        " }

    elseif a:scheme == 'gruvbox-material' " {
        " small tabline fix needed
        " vert split coult be brighter
        " weird background effect
        let g:gruvbox_material_background = 'hard'
        let g:gruvbox_material_visual = 'reverse'
        let g:gruvbox_material_palette = 'material'
        colorscheme gruvbox-material
        hi Normal guibg=black guifg=white
        call Default_folded()
        " }

    elseif a:scheme == 'pop-punk' " {
        colorscheme pop-punk
        " a softer Visual Select. Defualt bright white
        hi Visual ctermfg=148 ctermbg=240 guifg=#afdf00 guibg=#585858
        " a red highlight
        hi IncSearch ctermfg=15 ctermbg=161 guifg=#ffffff guibg=#d70061
        call Default_folded()
        " }
        
    elseif a:scheme == 'embark' " {
        colorscheme embark
        "call Default_folded()
        
    " made for color blindness.  Nice code colors
    " Needs new comment colors though

    elseif a:scheme == 'dalton' " {
        colorscheme dalton
        call Default_folded()
        call Default_linecolors()

    elseif a:scheme == 'challenger_deep' " {
        colorscheme challenger_deep
        call Default_folded()

    elseif a:scheme == 'spaceduck' " {
        colorscheme spaceduck
        call Default_linecolors()
        call Default_folded()
        hi Comment cterm=italic

    elseif a:scheme == 'elly' " {
        colorscheme elly
        call Default_folded()

    elseif a:scheme == '?' " {
        echom "Available schemes are:"
        echom "  ayu"
        echom "  badwolf"
        echom "  gruvbox-material"
        echom "  jellybeans"
        echom "  pencil"
        echom "  pop-punk"
        echom "  seoul256"
        echom "  space-vim-dark"
        echom "  challenger_deep"
        echom "  embark"
        echom "  dalton"
        echom "  spaceduck"
        echom "  elly"
        " }

    else
        echom a:scheme . " is not a pre-defined scheme"
    endif
endfunction
" }1

" My old colorscheme solarized8_dark_high had a lot of color fixes. {1
" These are the remnants of those changes.
" Change individual colors around. For solarized8_dark_high
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

" Tab Colors {{2
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
" }}2

" }1

" Modeline{
" vim: set foldmarker={,} foldlevel=0 foldmethod=marker:}
