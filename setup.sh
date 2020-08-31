#!/bin/bash
DOTFILE_ROOT=~/workspace/dotfiles
GCP='git@github.com:'

check_ssh_agent() {
  if env | grep --quiet SSH_AUTH_SOCK ; then
    echo SSH agent is running
  else
    GCP='https://github.com/'
    echo SSH agent is _not running. Reconfiguring GCP
  fi
}

config_ctags() {
  if [ ! -e ~/.ctags ]; then
    echo "No .ctags"
    cp ~/workspace/dotfiles/ctags/.ctags ~/.ctags
  else
    echo ".ctags exists. Not copying"
  fi
}

config_vim() {

  if [ ! -d ~/.vim/autoload ]; then
    cd ~/workspace && git clone ${GCP}tpope/vim-pathogen.git
    mkdir -p ~/.vim/autoload
    cp ~/workspace/vim-pathogen/autoload/pathogen.vim ~/.vim/autoload/pathogen.vim
    echo No autoload directory
  else
    echo Autoload directory exists
  fi

  if [ ! -e  ~/.vimrc ]; then
    echo "There's no vimrc"
    cp ~/workspace/dotfiles/vim/.vimrc ~/.vimrc
  else
    echo "vimrc exists"
  fi

  if [ ! -d  ~/.vim/bundle ]; then
    echo No bundle directory
    mkdir -p ~/.vim/bundle
    ## for ruby dev, needs gem install gem-ctags
    cd ~/.vim/bundle && git clone ${GCP}tpope/vim-bundler.git
    ###TODO update the fugitive help file 
    cd ~/.vim/bundle && git clone ${GCP}tpope/vim-fugitive.git
    cd ~/.vim/bundle && git clone ${GCP}scrooloose/nerdtree.git
    ##HAML indentation 
    cd ~/.vim/bundle && git clone ${GCP}nathanaelkane/vim-indent-guides.git
    cd ~/.vim/bundle && git clone ${GCP}tpope/vim-rails.git
  else
    echo Bundle directory exists
  fi
}

config_git() {
  if [ ! -e ~/.gitconfig ]; then
    echo "No .gitconfig"
    cp ~/workspace/dotfiles/git/.gitconfig ~/.gitconfig
    git config --global user.name $NAME
    git config --global user.email $EMAIL
    git config --global core.editor "vim"
  else
    echo ".gitconfig exists, not copying"
  fi

  if [ ! -d ~/.git_template ]; then
    echo No template directory
    cp -r ~/workspace/dotfiles/git/.git_template ~
  else
    echo git template directory exists
  fi
}

config_screen() {
  cp ~/workspace/dotfiles/screen/.screenrc ~
}

check_args()
{
  if test $NAME
  then
    echo NAME = $NAME
  else
    echo  "NAME not defined"
    exit
  fi 

  if test $EMAIL
  then
    echo EMAIL = $EMAIL
  else
    echo  "EMAIL not defined"
    exit
  fi
}

while [ $# -ne 0 ] ; do
  case "$1" in
  test)
    echo "testing"
    ;;
  -name)
    NAME=$2
    shift
    ;;
  -email)
    EMAIL=$2
    shift
    ;;
  *)
    echo "unknown argument: $1"
    usage
    exit 1
  esac
  shift
done

echo 
check_args
echo
check_ssh_agent
config_git
config_vim
config_ctags
config_screen
