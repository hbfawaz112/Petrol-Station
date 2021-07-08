<?php

require  'Access.php';
require 'db_connect.php';

$result = null;

date_default_timezone_set('Asia/Beirut');
$date = date("Y-m-d H:i:s");


if(isset($_POST["newName"]))
{
    $id = $_POST["id"];
    $newName = $_POST["newName"];
    $query = "update fuel_types set TYPENAME = '".$newName."' where FUELTYPEID ='" . $id."'";
    $result = mysqli_query($connect, $query);
    if ($result)
    {
        echo 1;
    }
}

else
{
    $type = $_POST['type'];
    $price = $_POST['price'];
    $profit = $_POST['profit'];


    $query = "insert into fuel_types (FUELTYPEID,TYPENAME) VALUES (NULL,'$type')";
    $result=mysqli_query($connect, $query);
    $id=mysqli_insert_id($connect);

    $query = "insert into prices (PRICEID,FUELTYPEID,OFFICALPRICE,PRICEDATE) VALUES (NULL,'$id','$price','$date')";
    $result=mysqli_query($connect, $query);

    $query = "insert into profits (PROFITID,FUELTYPEID,PROFITVALUE,PROFITDATE) VALUES (NULL,'$id','$profit','$date')";
    $result=mysqli_query($connect, $query);


    echo $id;
}




