# get the ssh client IP
CLIENT_IP=`echo $SSH_CLIENT|awk '{print $1}'`
# useful for tunneling
alias tunnelme="ssh -R 8080:andy.portal.pws.bz:8080  -R 8081:andy.admin.pws.bz:8081 andy@${CLIENT_IP}"
alias killsmith='/bin/kill `ps -U andy -o pid=`'
alias proddb='mysql --user=root -p portal_db_prd'
alias devdb='mysql --user=root -p portal_db_prd_nightly_clone'
alias drbenv="export PATH=$(echo ${PATH} | awk -v RS=: -v ORS=: '/rbenv/ {next} {print}' | sed 's/:*$//')"

