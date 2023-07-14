#! /bin/bash

# saveArgsToTmuxAndClip.sh
# Author : Austin Burt
# Email  : austin@burt.us.com
# Date   : 01/07/22 15:58
#
# Original use was in vim running shell commands poorly.
# This is so much more efficient.

# Paths
path="$HOME/.local/share/tmux"
tmuxbuffer="$path/vim-selection.txt"

# Strip newlines from end.
content=$(echo -En "$@" | sed '$s/\n//g')

# Ensure path exists
[ ! -d $path ] && mkdir -p $path

# Load the tmux buffer
echo -En "$content" > $tmuxbuffer
tmux load-buffer -b clipped $tmuxbuffer

# Store in system clipboard.
# The real powerhouse here
case "$machine" in
  Linux)  clipcommand="xclip -in -selection clipboard";;
  Mac)    clipcommand="pbcopy";;
  WSL)    exit 1;;
  *)      exit 2;;
esac

echo -En "$content" | $clipcommand


######### Vim function for reference. ############################

#" Tmux clipping
# vnoremap <leader>y "zy:<c-u>call <SID>SaveSelectionToFileAndTmuxClip()<cr>
# nnoremap <leader>y :<c-u>call <SID>SaveSelectionToFileAndTmuxClip()<cr>
# nnoremap <leader>Y :let @z=@" <bar> call <SID>SaveSelectionToFileAndTmuxClip()<cr>

#" SaveSelectionToFileAndTmuxClip {{2
#" used to sync vim on wsl to the clipboard
#    function! s:SaveSelectionToFileAndTmuxClip()
#        silent! exe "!(~/bin/usetmuxtoclip.exe.sh " . trim(shellescape(getreg('z'), 1)). " &)"
#        redraw!
#    endfunction
#" }}2
