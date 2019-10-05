fswatch ./jisc-collections-symfony  | while read f ; do `dirname $0`/sync.sh $f  ;done



#; rsync  -av -e 'ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p 2222' ../puppet/* root@localhost:/etc/puppetlabs/code/environments/production;  done
