<?php

require  'Access.php';
require 'db_connect.php';

$query = "SELECT container.CONTAINER_ID,container.CONTAINERNAME,fuel_types.TYPENAME,container.CAPACITY
from container join fuel_types on fuel_types.FUELTYPEID=container.FUELTYPEID ORDER BY container.CONTAINER_ID ASC";

$result = mysqli_query($connect, $query);
$result_copy=$result;
$i=$j=$profits=$sell=0;
$max_pump_num=0;

while ($row = mysqli_fetch_array($result)) {
    $data["containers"][$i]["CONTAINER_ID"] = $row["CONTAINER_ID"];
    $data["containers"][$i]["CONTAINERNAME"] = $row["CONTAINERNAME"];
    $data["containers"][$i]["TYPENAME"] = $row["TYPENAME"];

    $data["containers"][$i]["CAPACITY"] = $row["CAPACITY"];

    $query =" CALL getContainerCurrentVolume(".$row["CONTAINER_ID"].", @p1)";
    $value = mysqli_query($connect, $query);
    $query="SELECT @p1 AS `Volume`;";
    $value = mysqli_query($connect, $query);
    $value_row = mysqli_fetch_array($value);

    $data["containers"][$i]["Value"]=$value_row["Volume"];




    $pumps_query = "SELECT pump.PUMPID,pump.PUMPNAME from pump where pump.CONTAINER_ID=".$row["CONTAINER_ID"]." ORDER BY pump.PUMPID ASC";
    $pumps_result = mysqli_query($connect, $pumps_query);
    $j=0;
    while ($pumps_row = mysqli_fetch_array($pumps_result)) {

        $data["containers"][$i]["PUMPS"][$j]["PUMPNAME"] = $pumps_row["PUMPNAME"];
        $data["containers"][$i]["PUMPS"][$j]["PUMPID"] = $pumps_row["PUMPID"];




        $j += 1;

    }
    if($j>$max_pump_num){
        $max_pump_num=$j;
    }
    $i+=1;
}

$data["max_pump_num"]=$max_pump_num;
echo json_encode($data,JSON_PRETTY_PRINT);










