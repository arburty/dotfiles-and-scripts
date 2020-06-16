# Dotfiles
These are some of my dotfiles for my own reference, and anyone else
who cares to look to see what I have.

## If you're are me, and want your 'essentials'
`bash < <(curl -sL https://raw.githubusercontent.com/arburty/dotfiles-and-scripts/master/bin/install.sh)`
: call my install script off of github

## helpful_commands.md
The helpful_commands file are just commands I've found helpful along the way.
I made it a markdown file to read it in a more pretty way using two tools
1. pandoc
2. lynx  

and adding the function  

`md() {pandoc $1 | lynx && clear; }`  

to my ~/.bashrc.  pandoc converts the markdown to html and lynx is a terminal browser.
