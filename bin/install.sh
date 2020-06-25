#! /bin/bash

# install.sh {
# Author : Austin Burt
# Email  : austin@burt.us.com
# Date   : 04/06/20
#
# Custom Install Script To Create My Basic Setup
# }

[[ -z $PROGRAM ]] && declare -r PROGRAM=$(basename $0)

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

# Set Up Config Files
dir_configs=$homedir/.config
# }

# Create And Download Repositories If Needed {
mkdir -vp $dir_githome
cd $dir_githome
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

# make sure vim directories are set {
vim=$homedir/.vim
mkdir -pv $vim/{personal,artifacts,bundle}
cd $vim/personal
[[ ! -d ./git_scripts ]] && ln -sv $dir_git_vimscripts ./git_scripts
# }

# link the config files to appropriate directory {
linkconfdir aliases ranger mpv zathura zshvibindings
linkhomedir zshrc bashrc fortuneCookies gitconfig helpful_commands.md helpful_vim tmux.conf vimrc Xresources
linkvimscriptsdir
# }

# Install Programs {
sudo apt-get install -y ffmpegthumbnailer fzf lynx mpv pandoc ranger tmux tree w3m-img xterm vim-athena zathura zsh
# }

# install Oh-My-Zsh Setup and Plugins {
[[ ! -d $homedir/.oh-my-zsh/ ]] && sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ZSH_PLUGINS="$homedir/.oh-my-zsh/plugins/"
mkdir -p $ZSH_PLUGINS

git clone https://github.com/zsh-users/zsh-autosuggestions.git \
    $ZSH_PLUGINS/zsh-autosuggestions 2>/dev/null

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    $ZSH_PLUGINS/zsh-syntax-highlighting 2>/dev/null
# }

# Vundle for Vim plugins {
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim 2>/dev/null \
    && vim +PluginInstall +qall

# Command-t {2
if [[ ! -f ~/.vim/bundle/command-t/ruby/command-t/ext/command-t/ext.so ]]
then
    # the executable is missing but command-t is installed so compile it
    if [[ -d ~/.vim/bundle/command-t ]];then
        echo "compiling: command-t, may need to get ruby-dev package."
        cd ~/.vim/bundle/command-t/ruby/command-t/ext/command-t
        ruby extconf.rb || sudo apt install -y ruby-dev && ruby extconf.rb
        make
        cd - >/dev/null
    fi
fi
# }2

# }

exit 0

# Modeline{
# vim: set foldmarker={,} foldlevel=0 foldmethod=marker:}
