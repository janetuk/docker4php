
source  `dirname $0`/../../.env

fswatch ./$WEB_ROOT  | while read f ; do `dirname $0`/sync.sh $f  ;done
