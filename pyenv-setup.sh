#!/bin/bash
sudo apt-get update

# install dependencies, not sure these are all needed  
sudo apt-get install make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
xz-utils libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev


git clone https://github.com/pyenv/pyenv.git ~/.pyenv

# the sed invocation inserts the lines at the start of the file
# after any initial comment lines
sed -Ei -e '/^([^#]|$)/ {a \
export PYENV_ROOT="$HOME/.pyenv"
a \
export PATH="$PYENV_ROOT/bin:$PATH"
a \
' -e ':a' -e '$!{n;ba};}' ~/.profile
echo 'eval "$(pyenv init --path)"' >>~/.profile

echo 'eval "$(pyenv init -)"' >> ~/.bashrc

echo 'pyenv set up complete. You may need to logout/ login'
echo 'or restart your system to get the shell to recgnize pyenv' 
echo ''
echo 'Usage:'
echo 'pyenv install 3.10.0' 
