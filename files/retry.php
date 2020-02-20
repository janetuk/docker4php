<?php
sleep (1);
header('Location: http://' . $_SERVER['HTTP_HOST'] . '/' . $_GET['q']); 
exit;

