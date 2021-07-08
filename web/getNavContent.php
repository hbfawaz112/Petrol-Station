<?php

require  'Access.php';
require 'db_connect.php';

$query = "SELECT pump.PUMPID,pump.PUMPNAME,Max(pumprecords.RECORD) as record,fuel_types.TYPENAME from container join fuel_types on container.FUELTYPEID=fuel_types.FUELTYPEID join pump on pump.CONTAINER_ID=container.CONTAINER_ID join pumprecords on pumprecords.PUMPID=pump.PUMPID GROUP BY(pump.PUMPID) ";
$result = mysqli_query($connect, $query);
$i=0;

while ($row = mysqli_fetch_array($result)) {
    $data["pumps"][$i]["PUMPID"] = $row["PUMPID"];
    $data["pumps"][$i]["PUMPNAME"] = $row["PUMPNAME"];
    $data["pumps"][$i]["record"] = $row["record"];
    $data["pumps"][$i]["fuelName"] = $row["TYPENAME"];

    $i+=1;

}


$query = "SELECT CONTAINER_ID,CONTAINERNAME,CAPACITY FROM container";
$result = mysqli_query($connect, $query);
$i=0;
while ($row = mysqli_fetch_array($result)) {

    $data["containers"][$i]["CONTAINER_ID"] = $row["CONTAINER_ID"];
    $data["containers"][$i]["CONTAINERNAME"] = $row["CONTAINERNAME"];
    $query =" CALL getContainerCurrentVolume(".$row["CONTAINER_ID"].", @p1)";
    $value = mysqli_query($connect, $query);
    $query="SELECT @p1 AS `Volume`;";
    $value = mysqli_query($connect, $query);
    $value_row = mysqli_fetch_array($value);
    $data["containers"][$i]["Max"]=$row["CAPACITY"]-$value_row["Volume"];
    $data["containers"][$i]["volume"]=$value_row["Volume"];

    $i+=1;

}


$query = "SELECT FUELTYPEID,TYPENAME FROM fuel_types";
$result = mysqli_query($connect, $query);
$i=0;
while ($row = mysqli_fetch_array($result)) {
    $data["fuel_types"][$i]["FUELTYPEID"] = $row["FUELTYPEID"];
    $data["fuel_types"][$i]["TYPENAME"] = $row["TYPENAME"];
    $i+=1;
}




$query =  "SELECT `PROVIDERID`,`PROVIDERNAME`,`phone` FROM `provider`";
$result = mysqli_query($connect, $query);
$i=0;
while ($row = mysqli_fetch_array($result)) {

    $data["provider"][$i]["PROVIDERID"] = $row["PROVIDERID"];
    $data["provider"][$i]["providerName"] = $row["PROVIDERNAME"];
    $data["provider"][$i]["phone"] = $row["phone"];

    $i += 1;
}

//if home page return also page body data
if(isset($_POST["dashboardPage"]) && $_POST["dashboardPage"]==1){


    $query = "SELECT container.CONTAINER_ID,container.CONTAINERNAME,fuel_types.TYPENAME,container.CAPACITY
from container join fuel_types on fuel_types.FUELTYPEID=container.FUELTYPEID ORDER BY container.CONTAINER_ID ASC";

    $result = mysqli_query($connect, $query);
    $result_copy=$result;
    $i=$j=$profits=$sell=0;
    $max_pump_num=0;

    while ($row = mysqli_fetch_array($result)) {
        $data["BodyContainers"][$i]["CONTAINER_ID"] = $row["CONTAINER_ID"];
        $data["BodyContainers"][$i]["CONTAINERNAME"] = $row["CONTAINERNAME"];
        $data["BodyContainers"][$i]["TYPENAME"] = $row["TYPENAME"];

        $data["BodyContainers"][$i]["CAPACITY"] = $row["CAPACITY"];

        $query =" CALL getContainerCurrentVolume(".$row["CONTAINER_ID"].", @p1)";
        $value = mysqli_query($connect, $query);
        $query="SELECT @p1 AS `Volume`;";
        $value = mysqli_query($connect, $query);
        $value_row = mysqli_fetch_array($value);
        $data["BodyContainers"][$i]["Value"]=$value_row["Volume"];
        $pumps_query = "SELECT pump.PUMPID,pump.PUMPNAME from pump where pump.CONTAINER_ID=".$row["CONTAINER_ID"]." ORDER BY pump.PUMPID ASC";
        $pumps_result = mysqli_query($connect, $pumps_query);
        $j=0;
        while ($pumps_row = mysqli_fetch_array($pumps_result)) {
            $data["BodyContainers"][$i]["PUMPS"][$j]["PUMPNAME"] = $pumps_row["PUMPNAME"];
            $data["BodyContainers"][$i]["PUMPS"][$j]["PUMPID"] = $pumps_row["PUMPID"];
            $j += 1;
        }
        if($j>$max_pump_num){
            $max_pump_num=$j;
        }
        $i+=1;
    }

    $data["max_pump_num"]=$max_pump_num;



}




if(isset($_POST["AccountingPage"]) && $_POST["AccountingPage"]==1){

    $sql = "SELECT date(Min(pumprecords.RECORDDATE)) as d FROM pumprecords where pumprecords.RECORDDATE!='2000-01-01 00:00:00'";
    $result = mysqli_query($connect, $sql);
    if($row = mysqli_fetch_array($result)) {
        $data["minDate"] = $row["d"];

    }
}





//////New//////


$query =  "SELECT `CUSTOMERID`,`CUSTOMERNAME`,`CUSTOMERPHONE` , `CUSTOMEREMAIL` FROM `customer` order by CUSTOMERNAME asc ;";
$result = mysqli_query($connect, $query);
$i=0;
while ($row = mysqli_fetch_array($result)) {

    $data["customer"][$i]["CUSTOMERID"] = $row["CUSTOMERID"];
    $data["customer"][$i]["CUSTOMERNAME"] = $row["CUSTOMERNAME"];

    $i += 1;
}

$query =" CALL getTotalDebt( @p1)";
$value = mysqli_query($connect, $query);
$query="SELECT @p1 AS `totalDebt`;";
$value = mysqli_query($connect, $query);
$value_row = mysqli_fetch_array($value);
$data["totalDebt"] = $value_row["totalDebt"];





echo json_encode($data);
