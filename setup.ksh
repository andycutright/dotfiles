#!/usr/local/bin/ksh
BLD_ROOT=/vobs/WEB/build
TARC_CMD="tar cvf"
TARX_CMD="tar xvf"
MV_CMD=mv
ID_CMD=id

## grep
GREP_CMD=grep
WHOLE_WORD_FLAG=-w
## end grep

### rm cmds
RM_CMD=rm
DASH_R=-r
DASH_F=-f
RM_DASH_F="$RM_CMD $DASH_F"
RM_DASH_RF="$RM_CMD $DASH_R $DASH_F"

### ln
LN_SOFT='ln -s'


### tmp file generation
ARG0=$(whence $0)
# if ARGO is unset or null expand $0, otherwise expand ARGO
ARG0=${ARG0:-$0}
# trim the command to it's tail, e.g. if invoked as /opt/proj/some.ksh
# CMD will be some.ksh. this is a 'largest prefix pattern removal'. 
CMD=${ARG0##*/}
CMDDIR=${ARG0%/$CMD}

# the parameter '$' is the process number the shell. this creates
# a file name with the process number as its extension. 
TMP1=/tmp/$CMD.1.$$
### end tmp file generation

# create a string with the current date in the format
# YYYYMMDDHHMMSS
CUR_DATE=`date +"%Y%m%d%I%M%S"`


case `uname -s` in
SunOS)
        OS=solaris
        ;;
AIX)
        OS=aix
        ;;
HP-UX)
        OS=hp
        ;;
Linux)
        OS=linux
        ;;
FreeBSD)
        OS=linux
        ;;
CYGINW_NT-5.1)
       OS=windows
       ;;
*)
        echo "Unsupported platform (`uname -s`)"
        exit 1
        ;;
esac


## this demonstrates a 'here document'
usage()
{
        while read usageLine
        do
                echo $usageLine
        done<<EOF
-user_root = <where to install dotfiles>
-git_root = <the dotfiles github directory>
$CMD is a template
EOF
}

VIM_DIR=$GIT_ROOT/vim

make_backups()
{
    if test -e $USR_ROOT/.vimrc
    then 
        mv $USR_ROOT/.vimrc $USR_ROOT/.vimrc.backup
    fi
}

soft_link()
{
    link_vim
}


link_vim()
{
    $LN_SOFT $GIT_ROOT/$VIM_DIR/.vimrc $USR_ROOT/.vimrc
}

check_args()
{
    if test $USR_ROOT
    then
        echo "${USR_ROOT} = " $USR_ROOT
    else
        echo  "USR_ROOT not defined"
        usage
        exit
    fi 

    if test $GIT_ROOT
    then
        echo "${GIT_ROOT} = " $GIT_ROOT 
    else
        echo  "GIT_ROOT not defined"
        usage
        exit
    fi
}

someFunction()
{
## control constructs
if [ $SOME_VARIABLE = "SOMETING" ]
then
   echo "one"
elif [ $ANOTHER = "NOBDS" ]
then
   echo "two"
else
   echo "three"
fi
}

iteratingOverArgumentsFunction()
{
   index=1
   ### for loop assumes parameter list
   for ELEMENT
   do

      ### an arithmetic expressions enclosed in double parens
      ### and preceeded by a dollar sign is replaced by the value
      ### of the arithmetic expression. 

      index=$(($index+1))
      echo "at $index ELEMENT $ELEMENT"

   done
}

## this examples reads from the tmp file
## grep'ing for 'vbver' within the file
readingAFile()
{
   if [ -s $TMP1 ]
   then
      while read -r ENTRY
      do
         if [[ $ENTRY = @(*vbver) ]]
         then
            ## test for file/ executable, etc..
            if [ -x $ENTRY ]
            then
               VBVER=$ENTRY
               break
            fi
         fi
      done <$TMP1
   fi
}

## what's eval for? here i'm assembling a command line containing
## variables. the variables must not be substituted until i'm 
## ready to execute the command. 

## this function iterates over a list of file names. 
## take a look at the '$$index'. that initially becomes a positional
## parameter reference, like '"$4"'. 

## eval does what the shell normally does to variables and expressions. the 
## variables are replaced with actual values according to the standard evaluation 
## evalution rules. '$FINDCMD' is replaced with the value 'find' (defined elsewhere). 
## all well and good, you say. however, the function itself has been passed a 
## list of file names. the variable $FIXUP contains a list of positional parameter 
## references encased in quotes. these positional parameter references are now evaluated in this
## context, and then replaced with the appropriate values, the actual file names. 

## eval lets you assemble a complex command line with a bunch symbols that would otherwise
## be replaced before you want them evaulated. 

## this technique could also be used to build a variable name conditionally. 
usingEval()
{
        cd $WORKING_DIRECTORY
        index=1
        LEFT_PAREN='\('
        RIGHT_PAREN='\)'
        for ELEMENT 
        do
                if [ $index = 1 ]
                then
                        FIXUP[index]=' \( -name'" \$$index "'\) '
                else
                        FIXUP[index]=' -o \( -name'" \$$index "'\) '
                fi
		## incrementing an integer variable
                index=$(($index+1))
        done
        eval $FINDCMD \. ${XDEV} $LEFT_PAREN ${FIXUP[*]} $RIGHT_PAREN -print >>  $TMP1   
}

# the system return code from the last command is examined
# here it is grep. '0' indicates a normal return code, or success
checkingCmdReturnCodes()
{
        $ID_CMD | $GREP_CMD $WHOLE_WORD_FLAG root > /dev/null
        if [ $? != 0 ]
        then
                echo ""
                echo "######"
                echo "WARNING: $CMD should be run as user root"
                echo "######"
                echo ""
        fi
}

getPID() 
{
	sleep 30 &
	print "pid is $!"
}

## Take a unix style path like '/opt/CRS/something' and
## make it look like '\/opt\/CRS\/something'. This is 
## useful when the path needs to be used for replacing magic cookies 
## in files within a perl regular expression.

# For some reason, the extra '\' are necessary to protect the
# backslashes to get passed to echo. Not clear why. 

backslashify_unix_path() 
{
	 PATH_WITH_ESCAPES=`echo "$1" | sed 's/\//\\\\\//g'`
}



## IFS is a variable containing the 'internal field separator' characters, 
## whitespace that's used to separate one field from the next.
## This generally includes a space character, which can be a problem
## for file names that include spaces. This example lets me read
## a directory that contains spaces.
mod_ifs() 
{

	TEMP_ITUNES_ROOT="/Users/someone/jnk/iTunes Music"
    PERM_ITUNES_ROOT="/Users/someone/Music/iTunes"

        # Reset the internal field separator to allow spaces
        ORIGINAL_IFS=$IFS
        IFS=$'\n'$'\t'$'\r'
        if [ -d ${TEMP_ITUNES_ROOT} ] ; then
                echo "${TEMP_ITUNES_ROOT} exists and is a directory"
        fi      

        if [ -d ${PERM_ITUNES_ROOT} ] ; then
                echo "${PERM_ITUNES_ROOT} exists and is a directory"
        fi 

	## Restore
	IFS=$ORIGINAL_IFS
}




### checking for at least one argument
# the parameter '#' is automatically set by the shell and 
# and indicates the number of positional parameters in decimal
if [ $# -eq 0 ]; then
  usage
  exit 1
fi


while [ $# -ne 0 ] ; do
    case "$1" in
		test)
		  echo "testing"
		  ;;
    -user_root)
      USR_ROOT=$2
      shift
      ;;
    -git_root)
      GIT_ROOT=$2
      shift
      ;;
    -test)
 	## don't do anything ... 
      ;;
    -restore)
        RESTORE=true
        ;;
    *)
      echo "unknown argument: $1"
      usage
      exit 1
    esac
    shift
done
check_args
echo "USR_ROOT = $USR_ROOT"
echo "GIT_ROOT = $GIT_ROOT"

make_backups
soft_link

echo "$0 exiting"
