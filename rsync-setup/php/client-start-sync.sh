# initial sync
source  `dirname $0`/../../.env
sync_list_conf="$PWD/"`dirname $0`"/sync_list.conf"

for directory in `cat $sync_list_conf`
do

rsync -avP ./$WEB_ROOT/$directory --delete --chmod=oug+rwx  \
--no-o --no-g --no-perms  rsync://localhost:${PHP_SYNC_PORT}/example/

#docker cp $WEB_ROOT/$directory ${PROJECT_NAME}_php:/var/www/html/$directory

done

if [ -f '.env*' ] ; then
rsync -avP ./$WEB_ROOT/.env* --delete --chmod=oug+rwx  \
--no-o --no-g --no-perms  rsync://localhost:${PHP_STNC_PORT}/example/

fi

docker exec --user root -i ${PROJECT_NAME}_php chmod -R 777 /var/www/html
