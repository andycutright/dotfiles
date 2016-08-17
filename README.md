# dotfiles

* Assumes a directory named ~/workspace. Clone this repo into ~/workspace/dotfiles
* Assumes a recent-ish version of git is installed 
* Assumes an ssh-agent is running, but you can probably edit that out of setup.sh
* setup.sh is preferred installer method
    
    /> setup.sh -name "\<Name to use for commits\>" -email "\<email for git commits\>"
    
Read setup.sh, to see the vim plugins installed. Read the listed plugin repos to see how to use them

Set rbenv after running setup.sh. This script assumes you have the the appropriate dependencies installed

    # This will output instructions on updating your shell initialization scripts
    # Follow the instructions to ensure your environment is properly configured
    # after installing rbenv
    /> rbenv.setup.sh

This is tested on unixy boxes, and OS X. Not tested on cygwin 
