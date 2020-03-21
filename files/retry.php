<?php
system ('sudo /root/sync >& /dev/null');
sleep (1);
header('Location: http://' . $_SERVER['HTTP_HOST'] . '/' . $_GET['q'] . '?' . $_GET['a']); 
exit;

