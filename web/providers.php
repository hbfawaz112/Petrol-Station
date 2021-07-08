<?php


require  'Access.php';
require 'db_connect.php';


if(isset($_POST["update_provider_name"]) && isset($_POST["update_provider_phone"]) && isset($_POST["providerId"]) && isset($_POST['functionId']) && $_POST['functionId']==1){
    UpdateProvider($connect,$_POST["providerId"],$_POST["update_provider_name"],$_POST["update_provider_phone"]);
    return;
}

if(isset($_POST["shipments"]) && $_POST["shipments"]=1 && isset($_POST['providerId'])){
    getProviderShipments($connect,$_POST['providerId']);
}
else if (isset($_POST["provider_name"]) && isset($_POST["provider_phone"])) {
    insertProvider($connect,$_POST["provider_name"],$_POST["provider_phone"]);
}

function insertProvider($connection, $name,$phone)
{
    $query =  "INSERT INTO `provider` (`PROVIDERID`, `PROVIDERNAME`, `phone`) VALUES (NULL, '$name', '$phone')";
    $data["done"] = mysqli_query($connection, $query);
    $data["pid"]=mysqli_insert_id($connection);
    echo json_encode($data);
}

function UpdateProvider($connection,$providerId,$name,$phone){
    $query = "UPDATE `provider` SET `phone` = '$phone',`PROVIDERNAME` = '$name' WHERE `provider`.`PROVIDERID` = $providerId;";
    $result = mysqli_query($connection, $query);
    $data["done"]=$result;
    echo json_encode($data);
}





/*
else {
    getformContenttoDisplay($connect);
}
function getformContenttoDisplay($connection)
{
    $query =  "SELECT `PROVIDERID`,`PROVIDERNAME`,`phone` FROM `provider`";
    $result = mysqli_query($connection, $query);
    $i = 0;
    while ($row = mysqli_fetch_array($result)) {

        $data["provider"][$i]["PROVIDERID"] = $row["PROVIDERID"];
        $data["provider"][$i]["providerName"] = $row["PROVIDERNAME"];
        $data["provider"][$i]["phone"] = $row["phone"];

        $i += 1;
    }
    echo json_encode($data);
}
*/

