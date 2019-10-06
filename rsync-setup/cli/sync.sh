source `dirname $0`/../../.env
rel=`echo $1 | sed "s@$PWD/jisc-collections-symfony@@" `
sync_list_conf="$PWD/"`dirname $0`"/sync_list.conf"
for sync_item in `cat $sync_list_conf`
do

check=`echo $rel | grep '^\/'$sync_item`
if [  "X$check" != "X" ] ; then
echo "syncing"
rsync -avP ./jisc-collections-symfony/$sync_item --delete --chmod=oug+rwx  \
--no-o --no-g --no-perms  rsync://localhost:${CLI_SYNC_PORT}/example

exit
fi


done
