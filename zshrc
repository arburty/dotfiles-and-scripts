# ZSHRC
# Austin Burt
# austin@burt.us.com

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

unameNodeName="$(uname -n)"
case "${unameNodeName}" in
  pop-os*)          localmachine=pop-os ;;
  Austins-MacBook*) localmachine=WorkMac ;;
  *BURTAR*)          localmachine=WSL ;;
  *)                localmachine="UNKNOWN:${unameNodeName}"
esac

export machine
export localmachine

# General setup. Themes, Paths, and plugins. {{{1
export TERM="xterm-256color"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

if [[ $machine == "Mac" ]]
then
    export JAVA_HOME=$(/usr/libexec/java_home -v 11)
    [ -d /usr/local/opt/tomcat@9/bin ] && PATH="$PATH:/usr/local/opt/tomcat@9/bin"
elif [[ $machine == "Linux" ]]
then
    export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
    export JDK_HOME=/usr/lib/jvm/openjdk-11
fi


# This block is for nvm, so that npm works.
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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
[ $(command -v nvim) ] && export EDITOR='nvim' || export EDITOR='vim'
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
secondPrompt='black'

case ${localmachine} in
  "pop-os")   secondPrompt='red' ;;
  "WorkMac")  secondPrompt='yellow' ;;
  "WSL")      secondPrompt='magenta' ;;
esac
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%{%B%F{black}%K{${secondPrompt}}%} $user_symbol%{%b%f%k%F{${secondPrompt}}%} %{%f%}"

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
#[ -f $HOME/bin/printCustomPaths ] && PATH="$PATH"$(echo $PATH | $HOME/bin/printCustomPaths) || PATH="$PATH:$HOME/bin"
[ -d $HOME/bin ] && PATH="$HOME/bin:$PATH"
[ -d $HOME/.local/bin ] && PATH="$PATH:$HOME/.local/bin"

# yarn wanted these. out here causin me problems.
# using `npm install --global yarn` it went into ~/.nvm/versions/node/v17.2.0/bin/
# ^this path was already in my PATH
#[[ $(which yarn) ]] && export PATH="$PATH:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin"
#[ -d $HOME/.yarn ] && PATH="$PATH:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin"

[ -d /usr/local/go/bin ] && PATH=$PATH:/usr/local/go/bin
[ -d $HOME/go/bin ] && PATH=$PATH:$HOME/go/bin
[ -d $HOME/go/bin/ ] && export GOPATH=$HOME/go/bin
# This awk command removes duplicates for my sanity.
#   https://www.linuxjournal.com/content/removing-duplicate-path-entries
export PATH=$(echo -n $PATH | awk -v RS=: \
    '!($0 in a) {a[$0]; printf("%s%s", length(a) > 1 ? ":" : "", $0)}')
# }}}2

tabs -4

if [[ $machine == "Linux" ]]
then
    [[ ! $(ps -e | grep "wallpaper_slide") ]] \
        && echo "start the show!" \
        && ~/bin/wallpaper_slideshow &
fi

# Custom Alias's Variables and Functions {{{2
badSource() { # Used to send a message to std out in red if theres a problem with sourcing a file
    >&2 echo "${RED}Problem sourcing $*${NC}"
}

pL10k="$ZSH/custom/themes/powerlevel10k/powerlevel10k.zsh-theme"
[ -f $HOME/bin/colorValues ] && source $HOME/bin/colorValues         || badSource colorValues file
[ -f $HOME/.config/aliases ] && . $HOME/.config/aliases              || badSource aliases file
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

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

