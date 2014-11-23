# Dotfiles for zsh

## Getting Started

Clone this repo into your home directory `git clone https://github.com/l3lake/dotfiles-zsh.git .dotfiles-zsh`

Make the scripts executable `chmod +x .dotfiles-zsh/add*.sh .dotfiles-zsh/setup*.sh`

## Prezto Setup

1. Ensure variables in `vi .dotfiles-zsh/setup_prezto.sh` are correct
1. Run `./makesymlinks.sh`

## Ubuntu Setup

*Add user only*

1. Edit variables in `vi .dotfiles-zsh/adduser.sh`
2. Run `./.dotfiles-zsh/adduser.sh`

*The whole kaboodle*

1. Edit variables in `vi .dotfiles-zsh/setup_ubuntu.sh`
1. Run `./.dotfiles-zsh/setup_ubuntu.sh`
1. Logout and try logging into server as new user

## Docker Setup

1. Edit variable in `vi .dotfiles-zsh/add_user_docker.sh`
1. Run `./.dotfiles-zsh/add_user_docker.sh`
2. 1. Logout and login to server

## Vim Setup

1. Run `./.dotfiles-zsh/setup_vim.sh`
