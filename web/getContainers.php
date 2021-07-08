<?php

require  'Access.php';
require 'db_connect.php';

$data = null;
$where = "";
$b=false;


if(isset($_POST['fueltype'])) {
    $where = $where . " FROM container where container.FUELTYPEID=" . $_POST["fueltype"];
}

else if(isset($_POST['containerId']))
{
    $where = $where . ",TYPENAME FROM container join fuel_types on container.FUELTYPEID = fuel_types.FUELTYPEID where container.CONTAINER_ID=" . $_POST["containerId"];
    $b=true;
}


$query = "SELECT CONTAINER_ID,CONTAINERNAME,CAPACITY ".$where;
$result = mysqli_query($connect, $query);
$i=0;
while ($row = mysqli_fetch_array($result)) {
    $data["containers"][$i]["CONTAINER_ID"] = $row["CONTAINER_ID"];
    $data["containers"][$i]["CONTAINERNAME"] = $row["CONTAINERNAME"];
    $data["containers"][$i]["CAPACITY"] = $row["CAPACITY"];
    if($b==true) {
        $data["containers"][$i]["type"] = $row["TYPENAME"];
    }

    $query =" CALL getContainerCurrentVolume(".$row["CONTAINER_ID"].", @p1)";
    $value = mysqli_query($connect, $query);
    $query="SELECT @p1 AS `Volume`;";
    $value = mysqli_query($connect, $query);
    $value_row = mysqli_fetch_array($value);
    $data["containers"][$i]["Max"]=$row["CAPACITY"]-$value_row["Volume"];
    $data["containers"][$i]["Volume"]=$value_row["Volume"];


    $i+=1;

}
if($data!=null)
    echo json_encode($data);
else {

    echo 1;
}
