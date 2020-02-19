source `dirname $0`/../../.env

# initial sync
sync_list_conf="$PWD/"`dirname $0`"/sync_list.conf"

for directory in `cat $sync_list_conf`
do

rsync -avP ./$WEB_ROOT/$directory --delete --chmod=oug+rwx  \
--no-o --no-g --no-perms  rsync://localhost:${CLI_SYNC_PORT}/example/

done

rsync -avP ./$WEB_ROOT/.env* --delete --chmod=oug+rwx  \
--no-o --no-g --no-perms  rsync://localhost:${CLI_SYNC_PORT}/example/
