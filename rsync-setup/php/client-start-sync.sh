# initial sync
for directory in translations bin filestore public vendor config src templates composer.json
do

rsync -avP ./jisc-collections-symfony/$directory --delete --chmod=oug+rwx  \
--no-o --no-g --no-perms  rsync://localhost:10873/example/

done

rsync -avP ./jisc-collections-symfony/.env* --delete --chmod=oug+rwx  \
--no-o --no-g --no-perms  rsync://localhost:10873/example/
# \ #--no-o --no-g --no-perms
# sync on change


for directory in translations bin filestore public vendor config src templates composer.json
do

fswatch -0 ./jisc-collections/$directory  | xargs -0 -n 1 -I {} rsync -avP ./jisc-collections-symfony/$directory  --delete rsync://localhost:10873/example/

done
