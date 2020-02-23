cat composer.json | sed "s/self.version/$1/" > /tmp/a
mv /tmp/a composer.json
