# ZSHRC
# Austin Burt
# austin@burt.us.com

# General setup. Themes, Paths, and plugins. {{{1
export TERM="xterm-256color"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# ZSH_THEME
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE="nerdfont-complete"

# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='vi'
fi

# Setup for personalizing the colors and prompt
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true

# Add a space in the first prompt
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%f" # Visual customisation of the second prompt line
local user_symbol="$"
if [[ $(print -P "%#") =~ "#" ]]; then
    user_symbol = "#"
fi
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%{%B%F{black}%K{yellow}%} $user_symbol%{%b%f%k%F{yellow}%} %{%f%}"
# }}}1

# Personal
PATH=$PATH:/home/vladislav/bin/
tabs -4

# Custom Alias's Variables and Functions {{{1
badSource() { # Used to send a message to std out in red if theres a problem with sourcing a file
    >&2 echo "${RED}Problem sourcing $*${NC}"
}

pL10k="$ZSH/custom/themes/powerlevel10k/powerlevel10k.zsh-theme"
zshSynHighlight="$ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
[ -f $HOME/bin/colorValues ] && source $HOME/bin/colorValues         || badSource colorValues file
[ -f $HOME/.config/aliases ] && . $HOME/.config/aliases              || badSource aliases file
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh                       || badSource fzf.zsh file
[ -f $HOME/.config/zshvibindings ] && . $HOME/.config/zshvibindings  || badSource vi bindings for zsh
[ -f $pL10k ] && . $pL10k                                            || badSource $pL10k
[ -f $zshSynHighlight ] && . $zshSynHighlight                        || badSource $zshSynHighlight
