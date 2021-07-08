<?php

require  'Access.php';

require 'db_connect.php';

if (isset($_POST["delete"]) && isset($_POST["trID"]) )
{
    deleteTransaction($connect,$_POST["trID"]);
}

else if (isset($_POST["delete"]) && isset($_POST["voID"]) )
{
    deleteVoucher($connect,$_POST["voID"]);
}

else if (isset($_POST["newName"]) && isset($_POST["newPhone"]) && isset($_POST["newEmail"]) && isset($_POST["id"])) {
    updateCustomer($connect,$_POST["newName"],$_POST["newPhone"],$_POST["newEmail"],$_POST["id"]);
}

if (isset($_POST["customer_name"]) && isset($_POST["customer_phone"]) && isset($_POST["customer_email"])) {
    insertCustomer($connect,$_POST["customer_name"],$_POST["customer_phone"],$_POST["customer_email"]);
}

function insertCustomer($connection, $name,$phone,$email)
{
    $query =  "INSERT INTO customer (CUSTOMERID, CUSTOMERNAME, CUSTOMERPHONE , CUSTOMEREMAIL) VALUES (NULL, '$name', '$phone' , '$email')";
    $data["done"] = mysqli_query($connection, $query);
    $data["pid"]=mysqli_insert_id($connection);
    echo json_encode($data);
}

function updateCustomer($connection, $name,$phone,$email,$id)
{
    $query = "update customer set CUSTOMERNAME = '".$name."' , CUSTOMERPHONE = '".$phone."', CUSTOMEREMAIL = '".$email."' where CUSTOMERID ='" . $id."'";
    $result = mysqli_query($connection, $query);
    if ($result)
    {
        echo 1;
    }
}

function deleteTransaction($connection,$trid)
{
    $data["done"] =-1;
    $query = "Delete from transaction where TRANSACTIONID ='" .$trid."'";
    $result = mysqli_query($connection, $query);
    if($result){
        $data["done"] =1;

    }
    echo json_encode($data);

}

function deleteVoucher($connection,$void)
{
    $data["done"] =-1;
    $query = "Delete from voucher where VOUCHERID ='" .$void."'";
    $result = mysqli_query($connection, $query);
    if($result){
        $data["done"] =1;

    }
    echo json_encode($data);

}
