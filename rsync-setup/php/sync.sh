if [ -f `dirname $0`/../../jisc-collections-symfony/inotifywait.lockfile ] ; then
echo "Not syncing because of lockfile"
exit 0
fi

rel=`echo $1 | sed "s@$PWD/jisc-collections-symfony@@" `
sync_list_conf="$PWD/"`dirname $0`"/sync_list.conf"
sync_list_exclude_conf="$PWD/"`dirname $0`"/sync_list_exclude.conf"

for sync_item in `cat $sync_list_exclude_conf`
do

check=`echo $rel | grep '^\/'$sync_item`

if [ "X$check" != "X" ; then
exit
fi

done

for sync_item in `cat $sync_list_conf`
do

check=`echo $rel | grep '^\/'$sync_item`
if [  "X$check" != "X" ] ; then
echo "syncing"
rsync -avP ./jisc-collections-symfony/$sync_item --delete --chmod=oug+rwx  \
--no-o --no-g --no-perms  rsync://localhost:10873/example

exit
fi


done
