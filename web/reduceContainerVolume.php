<?php

require  'Access.php';

require 'db_connect.php';
if(isset($_POST['litters']) && isset($_POST['cid'])) {
    $query = "update container set Volume0 = Volume0-".$_POST['litters']." where CONTAINER_ID ='" . $_POST['cid']."'";
    $result = mysqli_query($connect, $query);
    if ($result) {
        echo 1;
    }
}
