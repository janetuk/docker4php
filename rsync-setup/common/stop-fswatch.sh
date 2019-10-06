lsof | grep $PWD | grep fswa | awk '{ print $2 }' | xargs kill -9 >& /dev/null

