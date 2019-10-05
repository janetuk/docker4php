# initial sync
sync_list_conf="$PWD/"`dirname $0`"/sync_list.conf"

for directory in `cat $sync_list_conf`
do

rsync -avP ./jisc-collections-symfony/$directory --delete --chmod=oug+rwx  \
--no-o --no-g --no-perms  rsync://localhost:10873/example/

done

rsync -avP ./jisc-collections-symfony/.env* --delete --chmod=oug+rwx  \
--no-o --no-g --no-perms  rsync://localhost:10873/example/
