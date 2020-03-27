#!/bin/bash

clone_rbenv() {
  if [ ! -d ~/.rbenv ]; then
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    cd ~/.rbenv && src/configure && make -C src
  fi
}

clone_rbenv_build() {
  if [ ! -d ~/.rbenv/plugins/ruby-build ]; then
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
  fi
}

validate() {
  ~/.rbenv/bin/rbenv init
}

clone_rbenv
clone_rbenv_build

echo 'rbenv & rbenv-build have been cloned'
echo 'Follow these instructions to complete your configuration:'
validate
echo ''
echo 'You might need to logout & login to have the changes to take effect'

echo 'Manual stuff you MUST DO:'
echo '  1. Install a ruby, e.g. rbenv install 2.6.5'
echo '  2. Edit ~/.rbenv/version to ensure you are using that version, or use rbenv global to select a version'
echo '  3. Rbenv rehash after those steps'
echo '  4. Install a local copy of bundle, e.g. gem bundle install'
