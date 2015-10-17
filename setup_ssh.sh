#!/bin/sh

check_ssh_agent() {
  if env | grep --quiet SSH_AUTH_SOCK ; then
    echo SSH agent is running
  else
    echo SSH agent is _not running. I refuse to continue
    exit 1
  fi
}

check_args()
{
  if test $DEST
  then
    echo DEST = $DEST
  else
    echo  "DEST not defined"
    exit
  fi 
  
  if test $SSH_USER
  then
    echo SSH_USER = $SSH_USER
  else
    echo  "SSH_USER not defined"
    exit
  fi 
}

while [ $# -ne 0 ] ; do
  case "$1" in
  test)
    echo "testing"
    ;;
  -dest)
    DEST=$2
    shift
    ;;
  -ssh_user)
    SSH_USER=$2
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
