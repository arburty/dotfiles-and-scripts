# ZSHRC
# Austin Burt
# austin@burt.us.com

# General setup. Themes, Paths, and plugins. {{{1
export TERM="xterm-256color"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export JDK_HOME=/usr/lib/jvm/jdk-11.0.7/
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

# ZSH_THEME
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE="nerdfont-complete"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Preferred Vim editor for local and remote sessions
export EDITOR='nvim'
#if [[ -n $SSH_CONNECTION ]]; then
    #export EDITOR='vim'
#else
    #export EDITOR='vi'
#fi

# Setup for personalizing the colors and prompt
# https://github.com/Powerlevel9k/powerlevel9k/wiki/Stylizing-Your-Prompt was quite helpful
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true

# Directory colors
POWERLEVEL9K_DIR_HOME_FOREGROUND='green'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='245'
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='yellow'
POWERLEVEL9K_DIR_ETC_FOREGROUND='009' # a red

# VCS colors
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='green'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='232' # a dark grey
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='yellow'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='238' # a light grey

# Add a space in the first prompt
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%f" # Visual customisation of the second prompt line
local user_symbol="$"
if [[ $(print -P "%#") =~ "#" ]]; then
    user_symbol = "#"
fi
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%{%B%F{black}%K{yellow}%} $user_symbol%{%b%f%k%F{yellow}%} %{%f%}"

# Enable 'O' in Vi mode to edit current command in Vim editor
# source: https://nuclearsquid.com/writings/edit-long-commands/
autoload -U edit-command-line
# Vi style:
zle -N edit-command-line
bindkey -M vicmd O edit-command-line

# }}}1

# Personal {{{1
# Set PATH Variable {{{2
# Tmux sessions were appending several of these paths
# printCustomPaths prints the custom paths ($HOME/bin, ./)
# if not already set
PATH="$PATH"$(echo $PATH | $HOME/bin/printCustomPaths)

# yarn wanted these. out here causin me problems.
[[ $(which yarn) ]] && export PATH="$PATH:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin"

export PATH=$PATH:/usr/local/go/bin
# }}}2

tabs -4

[[ ! $(ps -e | grep "wallpaper_slide") ]] \
    && echo "start the show!" \
    && ~/bin/wallpaper_slideshow &

# Custom Alias's Variables and Functions {{{2
badSource() { # Used to send a message to std out in red if theres a problem with sourcing a file
    >&2 echo "${RED}Problem sourcing $*${NC}"
}

pL10k="$ZSH/custom/themes/powerlevel10k/powerlevel10k.zsh-theme"
[ -f $HOME/bin/colorValues ] && source $HOME/bin/colorValues         || badSource colorValues file
[ -f $HOME/.config/aliases ] && . $HOME/.config/aliases              || badSource aliases file
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh                       || badSource fzf.zsh file
[ -f $HOME/.config/zshvibindings ] && . $HOME/.config/zshvibindings  || badSource vi bindings for zsh
[ -f $pL10k ] && . $pL10k                                            || badSource $pL10k

# TMUX is love. TMUX is life {{{3
if [[ $(tmux ls 2&> /dev/null) ]]
then # a tmux session exists
    if [[ -z $(tmux ls | grep -e "(attached)$") && -z "$TMUX" ]]
    then # not attached to a session, and not a session being created
        echo "A TMUX server is running. Attaching"
        sleep 2
        tmux attach
    fi
else # create new session
    if [[ $(which tmstart) ]]
    then
        tmstart -w
    else
        tmux new-session -s workin
    fi
fi


# }}}3
# }}}2
# }}}1
