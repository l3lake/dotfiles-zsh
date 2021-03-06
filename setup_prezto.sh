#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

# dotfiles directory
dir=~/.dotfiles-zsh

# old dotfiles backup directory
olddir=~/.dotfiles-zsh-old

# list of files/folders to symlink in homedir
files="zpreztorc zshrc vimrc.after vimrc.before gitconfig gitignore_global"

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
  echo "Moving any existing dotfiles from ~ to $olddir"
  mv ~/.$file ~/$olddir
  echo "Creating symlink to $file in home directory."
  ln -s $dir/$file ~/.$file
done

install_zsh () {
  # Test to see if zshell is installed.  If it is:
  if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    if [[ ! -d ${ZDOTDIR:-$HOME}/.zprezto ]]; then
      # Clone Prezto
      git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
      # Link Prezto default configuration files
      ln -s ~/.zprezto/runcoms/zlogin ~/.zlogin
      ln -s ~/.zprezto/runcoms/zlogout ~/.zlogout
      ln -s ~/.zprezto/runcoms/zprofile ~/.zprofile
      ln -s ~/.zprezto/runcoms/zshenv ~/.zshenv
    fi
    # Set the default shell to zsh if it isn't currently set to zsh
    if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
      chsh -s $(which zsh)
    fi
  else
    # If zsh isn't installed, get the platform of the current machine
    platform=$(uname);
    # If the platform is Linux, try an apt-get to install zsh and then recurse
    if [[ $platform == 'Linux' ]]; then
      sudo apt-get -y install zsh
      install_zsh
      # If the platform is OS X, tell the user to install zsh :)
    elif [[ $platform == 'Darwin' ]]; then
      echo "Please install zsh, then re-run this script!"
      exit
    fi
  fi
}

install_zsh
