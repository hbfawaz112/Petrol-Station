<?php

require  'Access.php';
require 'db_connect.php';

//$result = null;

date_default_timezone_set('Asia/Beirut');
$date = date("Y-m-d H:i:s");
$id = $_POST['id'];


$price = $_POST['price'];
$profit = $_POST['profit'];

$query = "insert into prices (PRICEID,FUELTYPEID,OFFICALPRICE,PRICEDATE) VALUES (NULL,'$id','$price','$date')";
$result[0]=mysqli_query($connect, $query);
$query = "insert into profits (PROFITID,FUELTYPEID,PROFITVALUE,PROFITDATE) VALUES (NULL,'$id','$profit','$date')";
$result[1]=mysqli_query($connect, $query);


echo $result;











