#!/bin/bash



cd `dirname $0`

source ../../.env

if [ -f ../../containerSync ] ; then
exit
fi

if [ -f ../../$SYNC_ROOT/inotifywait.lockfile ] ; then
echo "Not syncing because of lockfile"
exit 0
fi

rel=`echo $1 | sed "s@.*/drupal-umami@@" `
sync_list_conf="$PWD/sync_list.conf"
sync_list_exclude_conf="$PWD/sync_list_exclude.conf"


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
rsync -avP ../..//$WEB_ROOT/$sync_item --delete --chmod=oug+rwx  \
--no-o --no-g --no-perms  rsync://localhost:${PHP_SYNC_PORT}/example

exit
fi


done
