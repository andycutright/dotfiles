# andy edits: Fri Jan 30 10:30:07 PST 2015
# RVM generated this file

# this line is generating an error
# PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting 
# http://stackoverflow.com/questions/22650731/rvm-warning-path-is-not-properly-set-up
PATH=$GEM_HOME/bin:$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
# get the ssh client IP
CLIENT_IP=`echo $SSH_CLIENT|awk '{print $1}'`
# useful for tunneling
alias tunnelme="ssh -R 8080:andy.portal.pws.bz:8080  -R 8081:andy.admin.pws.bz:8081 andy@${CLIENT_IP}"
alias killsmith='/bin/kill `ps -U andy -o pid=`'
alias proddb='mysql --user=root -p portal_db_prd'
alias devdb='mysql --user=root -p portal_db_prd_nightly_clone''
