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

gitrepo_sxiv='https://github.com/muennich/sxiv'
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
sudo apt-get install -y \
dmenu \
espeak \
ffmpegthumbnailer \
fzf \
lastpass-cli \
lynx \
mpv \
neovim \
pandoc \
qutebrowser \
ranger \
tmux \
tree \
vim-athena \
w3m-img \
xterm \
zathura \
zsh

# Install dev packages {2
sudo apt-get install -y \
libimlib2-dev \
libxft-dev \
libexif-dev \
ruby-dev
# }2

# }

# install NerdFonts {
mkdir -p $homedir/local/share/fonts
cd $homedir/local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" \
    https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
# }

# install Oh-My-Zsh Setup and Plugins {
if [[ ! -d $homedir/.oh-my-zsh/ ]] ;then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    rm $homedir/.zshrc
    linkhomedir zshrc
fi

ZSH_PLUGINS="$homedir/.oh-my-zsh/plugins/"
mkdir -p $ZSH_PLUGINS

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    ${ZSH_CUSTOM:-$homedir/.oh-my-zsh/custom}/themes/powerlevel10k

git clone https://github.com/zsh-users/zsh-autosuggestions.git \
    $ZSH_PLUGINS/zsh-autosuggestions 2>/dev/null

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    $ZSH_PLUGINS/zsh-syntax-highlighting 2>/dev/null
# }

# Vundle for Vim plugins {
git clone https://github.com/VundleVim/Vundle.vim.git $homedir/vim/bundle/Vundle.vim 2>/dev/null \
    && sudo gem install neovim \
    && vim +PluginInstall +'CocInstall coc-java coc-snippets' +qall


# Command-t {2
if [[ ! -f $homedir/vim/bundle/command-t/ruby/command-t/ext/command-t/ext.so ]]
then
    # the executable is missing but command-t is installed so compile it
    if [[ -d $homedir/vim/bundle/command-t ]];then
        echo "compiling: command-t, may need to get ruby-dev package."
        cd $homedir/vim/bundle/command-t/ruby/command-t/ext/command-t
        ruby extconf.rb || sudo apt install -y ruby-dev && ruby extconf.rb
        make
        cd - >/dev/null
    fi
fi
# }2

# }

# Install sxiv {
if [[ ! -d $dir_githome/sxiv ]] ; then
    cd $dir_githome
    git clone $gitrepo_sxiv 2>/dev/null
    cd sxiv
    make
    sudo make install
    cd $homedir
fi
# }1

exit 0

# Modeline{
# vim: set foldmarker={,} foldlevel=0 foldmethod=marker:}
