#!/bin/bash
####################################################
# Smart Sprunge Bash Client - Shellz 2016
####################################################

# Turn on debug messages here
debug(){
return 1
#return 0
}
# Turn on verbose debug messages here
Verbose(){
return 0
#return 0
}

usage(){
echo -e "$0 'file' \n cmd|$0 \n $0 '<cmd'"
}

# Make sure we're in the right directory
cwd=$(pwd)
cd "$cwd"
cmd="$@"

# Display some help...
case "cmd" in
-h|--help)
usage
exit 1
;;
esac
# ...or process the input
if readlink /proc/$$/fd/0 | grep -q "^pipe:"; then
    Verbose && echo 'Pipe input (echo abc | spr)'
    cat </dev/stdin | curl -F 'sprunge=<-' http://sprunge.us
    exit
elif file $( readlink /proc/$$/fd/0 ) | grep -q "character special"; then
    Verbose && echo 'Terminal input (keyboard/spr file)'
   if [[ -d "$cmd" ]] ; then
     echo "Error, $cmd is a directory!"
     exit 1
   elif [[ -f "$cmd" ]]; then
     echo "Sprunging file $cmd"
     action="cat $cmd"
    elif ([[ ! -f "$cmd" ]] && [[ ! -z "$cmd" ]] && [[ ! -e "$cmd" ]]) ; then
      echo "Sprunging string $cmd"
      action="echo $cmd"
    fi

  uxt=$(date +%s)
  spr="/tmp/sprung-$uxt-out"
  $action 2>/dev/null >$spr
  if ([[ "$?" -ne "0" ]] || [[ -z "$spr" ]]) ; then
    echo 'Error: file is empty!';exit 1
  else
   debug &&\
   echo -e " \n################################\nSending : \n################################\n" &&\
   cat $spr && echo -e '################################\n'
   
   cat $spr | curl -F 'sprunge=<-' http://sprunge.us
   
  fi
  rm $spr


else
  Verbose && echo 'File input (spr < file.txt)'
  cat </dev/stdin | curl -F 'sprunge=<-' http://sprunge.us
  exit
fi


exit

