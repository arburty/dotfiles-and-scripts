#! /bin/bash

# install.sh
# Author : Austin Burt
# Email  : austin@burt.us.com
# Date   : 04/06/20
#
# Custom Install Script To Create My Basic Setup

[[ -z $PROGRAM ]] && declare -r PROGRAM=$(basename $0)

# Initialize Variables
# used to change the root directory
#homedir=$HOME
homedir=$HOME/tmp # for testing purposes

gitdir=$homedir/git
dotdir=$gitdir/dotfiles-and-scripts
gitdotfiles=https://github.com/arburty/dotfiles-and-scripts.git

# Create And Download Repository If Needed
cd $homedir
mkdir -vp $gitdir
cd $gitdir
[[ ! -d $gitdir/dotfiles-and-scripts ]] && git clone $gitdotfiles


# Set Up Scripts
# set up and go to bin directory
mkdir -p $homedir/bin
cd $homedir/bin

# create gitBin for shorter symlink paths
[[ -d $dotdir/bin && ! -d ./gitBin ]] && ln -sv $dotdir/bin ./gitBin

# create symlinks for each script through gitBin
for file in $(ls gitBin); do
    [[ ! -f $file ]] && ln -sv gitBin/$file ./
done

# Set Up Config Files
confdir=$homedir/.config

linkconfdir() {
    cd $confdir
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

# set up .config directory
mkdir -p $confdir

# create df for shorter links
cd $confdir
[[ ! -d ./df ]] && ln -sv $dotdir ./df

# link the config files to appropriate directory
linkconfdir aliases ranger mpv zathura zshvibindings
linkhomedir zshrc bashrc fortuneCookies gitconfig helpful_commands.md tmux.conf vimrc.local Xresources

# Install Programs
sudo apt-get install -y fzf lynx pandoc ranger tmux tree xterm zathura

exit 0
