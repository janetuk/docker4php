<?php
system ('/root/sync >& /dev/null');
sleep (1);
header('Location: http://' . $_SERVER['HTTP_HOST'] . '/' . $_GET['q']); 
exit;

