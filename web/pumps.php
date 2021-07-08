<?php

require  'Access.php';
require 'db_connect.php';



if(isset($_POST["functionId"]) && $_POST["functionId"]==2){
    $_POST["dispenser_id"]=2;
    if(isset($_POST["pump_name"]) && isset($_POST["container_id"]) && isset($_POST["dispenser_id"]) ){
        if(!isset($_POST["Counter0"])){$_POST["Counter0"]=0;}

         insertPump($connect,$_POST["pump_name"],$_POST["dispenser_id"],$_POST["container_id"],$_POST["Counter0"]);
    }
}else{

    if(isset($_POST["functionId"]) && $_POST["functionId"]==1){
        getformContenttoDisplay($connect);
    }
}

function getformContenttoDisplay($connection)
{
    $query = "select dispenser.DISPENSERID,DISPENSERNAME from dispenser where dispenser.DISPENSERID not in (select pump.DISPENSERID from pump GROUP by pump.DISPENSERID HAVING count(pump.DISPENSERID)>=2)";
    $result = mysqli_query($connection, $query);
    $i=0;
    while ($row = mysqli_fetch_array($result)) {
        $data["dispensers"][$i]["DISPENSERID"] = $row["DISPENSERID"];
        $data["dispensers"][$i]["DISPENSERNAME"] = $row["DISPENSERNAME"];

        $i+=1;
    }

    $query = "SELECT CONTAINER_ID,CONTAINERNAME FROM container";
    $result = mysqli_query($connection, $query);
    $i=0;
    while ($row = mysqli_fetch_array($result)) {
        $data["containers"][$i]["CONTAINER_ID"] = $row["CONTAINER_ID"];
        $data["containers"][$i]["CONTAINERNAME"] = $row["CONTAINERNAME"];
        $i+=1;

    }

    echo json_encode($data);
}

function insertPump($connection,$name,$dispenserId,$containerId,$record)
{

    $data["done"] = -1;
    $query = "INSERT INTO pump (PUMPID, PUMPNAME,DISPENSERID, CONTAINER_ID, xid) VALUES (NULL,'$name', $dispenserId, $containerId,CURRENT_TIMESTAMP)";
    $result = mysqli_query($connection, $query);

    $last_id=-1;
    if($result){
        date_default_timezone_set('Asia/Beirut');
       // $recordDate= date("Y-m-d H:i:s");
        $last_id = mysqli_insert_id($connection);
      //  $query = "INSERT INTO `pumprecords` (`PUMPRECORDID`, `PUMPID`, `RECORD`, `RECORDDATE`) VALUES (NULL, $last_id, $record,'$recordDate')";
        $query="CALL insertPumpRecord($last_id, $record, '2000-01-01 00:00:00.000000');";
        $result = mysqli_query($connection, $query);


        $query = "SELECT fuel_types.TYPENAME from container join fuel_types on container.FUELTYPEID=fuel_types.FUELTYPEID where container.CONTAINER_ID=".$containerId." ;";
        $result = mysqli_query($connection, $query);
        if($row = mysqli_fetch_array($result)) {$data["fuelName"]= $row["TYPENAME"];
            $data["done"] = 1;}

    }

    $data["pumpId"] = $last_id;

    echo json_encode($data);
}

