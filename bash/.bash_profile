# MacPorts Installer addition on 2011-03-07_at_20:04:36: adding an appropriate PATH variable for use with MacPorts.
#export PATH=/opt/local/bin:/opt/local/sbin:$PATH:/opt/local/lib/postgresql90/bin
# Finished adapting your PATH environment variable for use with MacPorts.

# corlorize ls
export CLICOLOR=true

# Brew mods (made by andy) put brew on the path before /usr/bin
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

alias netflix='open /Applications/Google\ Chrome.app --args -user-agent="Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_3; en-us) AppleWebKit/525.19 (KHTML, like Gecko) Version/3.2.1 Safari/525.19"'
alias togglespaces='osascript ~/Documents/scripts/toggle.spaces.scpt'
alias resafari='osascript ~/Documents/scripts/reset.safari.scpt'
alias esafari='open ~/Documents/scripts/reset.safari.scpt'
alias scure='env |grep SSH_AGENT_PID && ssh-add -l'
alias sycli='/usr/local/bin/synergy/synergyc --name chewbarktop anysocial'
alias rmine='open /Applications/RubyMine.app'
alias ensafen='ssh-add ~/.ssh/id_dsa_batur ~/.ssh/anythingsocial_new'
alias ti='open /Applications/Titanium\ Studio/TitaniumStudio.app'
alias gobatur='ssh batur'

#iPhone / Xcode
alias simulator='open /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone\ Simulator.app'
alias resimulator='rm /Users/andy/Library/Application\ Support/iPhone\ Simulator/6.0/Library/Cookies/Cookies.binarycookies /Users/andy/Library/Application\ Support/iPhone\ Simulator/7.0/Library/Cookies/Cookies.binarycookies'

# launchctl stuff
alias rememc='launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.memcached.plist ; launchctl load ~/Library/LaunchAgents/homebrew.mxcl.memcached.plist'
alias remongo='launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist ; launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist'

# general process / ruby stuff
alias init_log='shug ; tail -f log/* | grep DEV'
alias testdb='RAILS_ENV=test rails db'

#heroku
alias ku='heroku'

#android development
export PATH=$PATH:/Users/andy/android-sdk-macosx/tools:/Users/andy/android-sdk-macosx/platform-tools

#titanium

#play 
#export PATH=/Users/andy/opt/play-2.0.2:$PATH

#postgres
export DBUSER=andy

#functions
function tabname {
  printf "\e]1;$1\a"
}
 

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
