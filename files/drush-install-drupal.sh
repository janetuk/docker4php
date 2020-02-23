#remove self.version from composer file if necessary

composer require drush/drush:^10
vendor/bin/drush site-install --db-url=mysql://root:password@mariadb:3306/php --yes
