#!/bin/bash 
cd `dirname $0`
parent_dir=`dirname $PWD`
grandparent_dir=`dirname $parent_dir`
fswatch $grandparent_dir/jisc-collections-symfony  | while read f ; do ./sync.sh $f ;done


