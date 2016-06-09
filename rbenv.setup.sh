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

echo 'Manual stuff you need to do:'
echo 'Install a ruby, e.g. rbenv installl2.2.1'
echo 'and edit ~/.rbenv/version to ensure you are using that version'
echo 'rbenv rehash after those steps, and finally, install a local copy'
echo 'of bundle, e.g. gem bundle install'
