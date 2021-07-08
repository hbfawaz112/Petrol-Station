<?php


require  'Access.php';
require 'db_connect.php';



date_default_timezone_set('Asia/Beirut');

if(isset($_POST['value']) && isset($_POST['customer']) && isset($_POST['fueltype']))
{
    $value = $_POST['value'];
    $customer = $_POST['customer'];
    $date = $_POST['date'];
    $note = $_POST['note'];
    $fueltype = $_POST['fueltype'];

    if ($date == date("Y-m-d"))
        $date = date("Y-m-d H:i:s");
    $query = "insert into voucher (VOUCHERID,CUSTOMERID,FUELTYPEID,VOUCHERVALUE,VOUCHERDATE,NOTE) VALUES (NULL,'$customer','$fueltype','$value','$date','$note')";
    $result=mysqli_query($connect, $query);
    echo $result;

}
