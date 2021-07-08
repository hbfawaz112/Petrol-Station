<?php
require  'Access.php';

require 'db_connect.php';

if(isset($_POST['newname']) && isset($_POST['cid'])) {
    $query = "update container set CONTAINERNAME = '".$_POST['newname']."' where CONTAINER_ID ='" . $_POST['cid']."'";
    $result = mysqli_query($connect, $query);
    if ($result) {
        echo 1;
    }
    }

else {
    $name = $_POST['name'];
    $capacity = $_POST['capacity'];
    $fueltype = $_POST['fueltype'];
    $volume = $_POST['volume0'];
    $query = "insert into container (FUELTYPEID,CONTAINERNAME,CAPACITY,Volume0) VALUES ('$fueltype','$name','$capacity','$volume')";
    $result = mysqli_query($connect, $query);
    if ($result) {

        $last_id = mysqli_insert_id($connect);
        $data["cid"] = $last_id;
        $data["done"] = 1;

    }

    echo json_encode($data);
}




