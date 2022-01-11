#! /bin/bash

# install.sh {
# Author : Austin Burt
# Email  : austin@burt.us.com
# Date   : 04/06/20
#
# Custom Install Script To Create My Basic Setup
# }

[[ -z $PROGRAM ]] && declare -r PROGRAM=$(basename $0)

# Determind Mac, or Linux. {
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac
echo "This machine is a : ${machine}"

case "${machine}" in
    Linux)     packageInstall="apt-get install -y";;
    Mac)       packageInstall="brew install";;
    *)         echo "$PROGRAM: Error: Script not designed for ${machine}" >&2 && exit 1;;
esac
# }

# Initialize Variables {
# used to change the root directory
homedir=$HOME
[[ $1 == '-D' ]] && homedir=$HOME/tmp && shift # for testing purposes
[[ $homedir == $HOME/tmp && ! -d $homedir ]] && mkdir -pv $homedir

dir_githome=$homedir/git
dir_git_dotfiles=$dir_githome/dotfiles-and-scripts
gitrepo_dotfiles=https://github.com/arburty/dotfiles-and-scripts.git

dir_git_vimscripts=$dir_githome/vimscripts
dir_vimscripts=$homedir/.vim/personal/
gitrepo_vimscripts=https://github.com/arburty/vimscripts.git

gitrepo_sxiv='https://github.com/muennich/sxiv'
# Set Up Config Files
dir_configs=$homedir/.config
# }

# Create And Download Repositories If Needed {
mkdir -vp $dir_githome
cd $dir_githome
echo "$PROGRAM: Info: Currently using https, you will want to set up ssh keys"
[[ ! -d $dir_git_dotfiles ]] && git clone $gitrepo_dotfiles
[[ ! -d $dir_git_vimscripts ]] && git clone $gitrepo_vimscripts
# }

# Set Up bin Scripts {
# set up and go to bin directory
mkdir -p $homedir/bin
cd $homedir/bin

# create gitBin for shorter symlink paths
[[ -d $dir_git_dotfiles/bin && ! -d ./gitBin ]] && ln -sv $dir_git_dotfiles/bin ./gitBin

# create symlinks for each script through gitBin
for file in $(ls gitBin); do
    [[ ! -f $file ]] && ln -sv gitBin/$file ./
done
# }

linkconfdir() {
    cd $dir_configs
    while [[ $# -gt 0 ]]; do
        [[ ! -f ./$1 && ! -d ./$1 ]] && ln -sv df/$1 ./
        shift
    done
    cd - > /dev/null
}

linkhomedir() {
    cd $homedir
    while [[ $# -gt 0 ]]; do
        [[ ! -f ./.$1 ]] && ln -sv .config/df/$1 ./.$1
        shift
    done
    cd - > /dev/null
}

linkvimscriptsdir() {
    cd $vim/personal

    while read script
    do
        script=$(basename $script)
        [[ ! -f ./$script ]] && ln -sv git_scripts/$script ./
    done < <(ls git_scripts/*.vim)
    cd - > /dev/null
}

# Set up .config directory {
mkdir -p $dir_configs

# create $homedir/.config/df for shorter sym links
cd $dir_configs
[[ ! -d ./df ]] && ln -sv $dir_git_dotfiles ./df
# }

# Set up .config directory {
mkdir -p $dir_configs

# create $homedir/.config/df for shorter sym links
cd $dir_configs
[[ ! -d ./df ]] && ln -sv $dir_git_dotfiles ./df
# }

# make sure vim directories are set {
vim=$homedir/.vim
mkdir -pv $vim/{personal,artifacts,bundle}
cd $vim/personal
[[ ! -d ./git_scripts ]] && ln -sv $dir_git_vimscripts ./git_scripts
# }

# link the config files to appropriate directory {
linkconfdir aliases nvim ranger mpv qutebrowser zathura zshvibindings
linkhomedir zshrc bashrc fortuneCookies gitconfig helpful_commands.md helpful_vim tmux.conf vimrc Xresources
linkvimscriptsdir
# }

# Install Programs {
addPackage() { # 1=machine 2=package 3?=commandname
    newpackage=$2
    commandName=${3:-`echo $newpackage`}
    [ $(command -v $commandName) ] && return

    case $1 in
        "Universal") var2use="programsUniversal"    ;;
        "Mac")       var2use="programsToBrew"       ;;
        "Linux")     var2use="programsLinuxUbuntu"  ;;
    esac


    if [[ -z "${!var2use}" ]]
    then
        newValue="$newpackage"
    else
        newValue="${!var2use} $newpackage"
    fi

    read "$var2use" <<< "${newValue}"
}
add2Universal() {
    addPackage "Universal" "$1" "$2"
}
add2Mac() {
    addPackage "Mac" "$1" "$2"
}
add2Linux() {
    addPackage "Linux" "$1" "$2"
}
# associated variables {
programsUniversal=""
programsToBrew=""
programsLinuxUbuntu=""
# }

# Universal packages {
# alphabetical, but tmux first
add2Universal tmux
add2Universal bpytop
add2Universal espeak
add2Universal fzf
add2Universal lastpass-cli lpass
add2Universal lynx
add2Universal neovim nvim
add2Universal pandoc
add2Universal tree
# }

# Install the universal packages {
echo "Using ${packageInstall} for Universal (none if empty):$programsUniversal"
[ -n "$programsUniversal" ] && $packageInstall $programsUniversal
# }

# Mac vs Linux {2
if [[ $machine == "Mac" ]]
then
    echo "Adding packages for $machine"
    [ -z $(command -v brew) ] && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    [ -z $(command -v ranger) ] \
        && ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" 2> /dev/null \
        && add2Mac ranger
    [ ! -d /Applications/iTerm.app/ ] && add2Mac iterm2

    # BREW INSTALL
    echo -e "$PROGRAM: Info: BREW INSTALL Mac Specific (none if empty):\n$programsToBrew"
    [ -n "$programsToBrew" ] && $packageInstall $programsToBrew
elif [[ $machine == "Linux" ]]
then
    # TODO: handle xterm and dev packages seperately
    echo "installs for $machine"
	add2Linux dmenu
	add2Linux ffmpegthumbnailer
	add2Linux mpv
	add2Linux qutebrowser
	add2Linux ranger
	#add2Linux vim-athena
	#add2Linux w3m-img
	add2Linux xterm
    add2Linux youtube-dl
	add2Linux zathura
	add2Linux zsh

    # Install dev packages {3
    #add2Linux libimlib2-dev
    #add2Linux libxft-dev
    #add2Linux libexif-dev
    #add2Linux ruby-dev
    # }3

    echo -e "$PROGRAM: Info: APT-GET INSTALL Linux Specific (none if empty):\n$programsLinuxUbuntu"
    [ -n "$programsLinuxUbuntu" ] && sudo $packageInstall $programsLinuxUbuntu
fi
# }2

# }

# install NerdFonts {
#ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" 2> /dev/null

#mkdir -p $homedir/.local/share/fonts
#cd $homedir/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" \
#   https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf

#}

# install Oh-My-Zsh Setup and Plugins {
if [[ ! -d $homedir/.oh-my-zsh/ ]] ;then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    rm $homedir/.zshrc
    linkhomedir zshrc

    ZSH_PLUGINS="$homedir/.oh-my-zsh/plugins/"
    mkdir -p $ZSH_PLUGINS

    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        ${ZSH_CUSTOM:-$homedir/.oh-my-zsh/custom}/themes/powerlevel10k

    git clone https://github.com/zsh-users/zsh-autosuggestions.git \
        $ZSH_PLUGINS/zsh-autosuggestions 2>/dev/null

    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        $ZSH_PLUGINS/zsh-syntax-highlighting 2>/dev/null
fi

# }

# Vundle for Vim plugins {
git clone https://github.com/VundleVim/Vundle.vim.git $homedir/.vim/bundle/Vundle.vim 2>/dev/null \
    && sudo gem install neovim \
    && vim +PluginInstall +qall
    #&& vim +PluginInstall +'CocInstall coc-java coc-snippets' +qall


# Command-t {2
if [[ ! -f $homedir/vim/bundle/command-t/ruby/command-t/ext/command-t/ext.so ]]
then
    # the executable is missing but command-t is installed so compile it
    if [[ -d $homedir/vim/bundle/command-t ]];then
        echo "compiling: command-t, may need to get ruby-dev package."
        cd $homedir/vim/bundle/command-t/ruby/command-t/ext/command-t
        #ruby extconf.rb || sudo apt install -y ruby-dev && ruby extconf.rb
        make
        cd - >/dev/null
    fi
fi
# }2

# }

# Install sxiv {
if [[ $machine == "Linux" && ! -d $dir_githome/sxiv && ! -z $DISPLAY ]] 
then
    cd $dir_githome
    git clone $gitrepo_sxiv 2>/dev/null
    cd sxiv
    make && sudo make install
    cd $homedir
    [ -d $dir_git_dotfiles/sxiv ] && linkhomedir sxiv
fi
# }1

exit 0

# Modeline{
# vim: set foldmarker={,} foldlevel=0 foldmethod=marker:}
