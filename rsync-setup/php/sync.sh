source `dirname $0`/../../.env

if [ -f `dirname $0`/../../containerSync ] ; then
exit
fi

if [ -f `dirname $0`/../../$WEB_ROOT/inotifywait.lockfile ] ; then
echo "Not syncing because of lockfile"
exit 0
fi

rel=`echo $1 | sed "s@$PWD/$WEB_ROOT@@" `
sync_list_conf="$PWD/"`dirname $0`"/sync_list.conf"
sync_list_exclude_conf="$PWD/"`dirname $0`"/sync_list_exclude.conf"

for sync_item in `cat $sync_list_exclude_conf`
do

check=`echo $rel | grep '^\/'$sync_item`

if [ "X$check" != "X" ]  ; then
exit
fi

done

for sync_item in `cat $sync_list_conf`
do

check=`echo $rel | grep '^\/'$sync_item`
if [  "X$check" != "X" ] ; then
echo "syncing"
rsync -avP ./$WEB_ROOT/$sync_item --delete --chmod=oug+rwx  \
--no-o --no-g --no-perms  rsync://localhost:${PHP_SYNC_PORT}/example

exit
fi


done
