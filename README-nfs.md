To get nfs and db sessions to work:

Preliminary: 

Clone jisc-collections-symfony into the same directory as this README.

run 

```
./scipts/setup_native_nfs_on_osx.sh
```

run composer inside the container:

```
make shell
composer install
```

oustide the container run this:

```
yarn install
yarn run encore dev
```

NB site uses localhost rather than php.docker.localhost

Take a db dump of your  current setup  and make it available to your
new site as eg /var/www/html/dump.sql

Import the db dump when you have set up in your new site.

1.   Copy files/doctrine.yaml to config/packages/dev/doctrine.yaml
in jisc-collections-symfony

2.   Copy files/services_dev.yaml  config/services_dev.yaml

3.   Update .env in docker4php so that you are using S4_ROOT
to point to the directory above the jisc-collections-symfony folder

NB you need to have a folder called 'jisc-collections-symfony'

If not then modify docker-compose.yml directly.

4. cp files/create_sess.sql to jisc-collections-symfony

5. 
```
   sudo chown -R 999:999 data/mariadb
   sudo chmod -R 777 data/mariadb
```

6. start the containers

```
make
```

7.

```
make shell 
```

In the container do the folloowing:

Import your db dump
mysql -uroot -ppassword -hmariadb php < /var/www/html/dump.sql
mysql -uroot -ppassword  -hmariadb php < /var/www/html/create_sess.sql

8.  Visit your site using port 9000 - localhost:9000 -  ( diffferent from 8000 so that you can have the old one running
if you need to ).
