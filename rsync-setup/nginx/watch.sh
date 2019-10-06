fswatch ./jisc-collections-symfony  | while read f ; do `dirname $0`/sync.sh $f  ;done
