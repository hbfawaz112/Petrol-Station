<?php

require  'Access.php';
require 'db_connect.php';

date_default_timezone_set('Asia/Beirut');

$data=null;
$id=$_POST["id"];
$value=$_POST["value"];
$date=$_POST["date"];

if ($date == date("Y-m-d"))
    $date = date("Y-m-d H:i:s");

$query = "insert into transaction (CUSTOMERID,TRANSACTIONVALUE,TRANSACTIONID,TRANSACTIONDATE) VALUES ('$id','$value',NULL,'$date')";
$result=mysqli_query($connect, $query);
echo $result;

