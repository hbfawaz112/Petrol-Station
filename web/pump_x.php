<?php

require  'Access.php';
require 'db_connect.php';




if(isset($_POST["functionId"]) && $_POST["functionId"]==2){
    if(isset($_POST["pumpId"]) && isset($_POST["record"])){ //&& isset($_POST["recordDate"]) ){

        date_default_timezone_set('Asia/Beirut');
        insertRecord($connect,$_POST["pumpId"],$_POST["record"],date("Y-m-d H:i:s"));
    }
} else if (isset($_POST["functionId"]) && $_POST["functionId"] == 1 && isset($_POST['id'])) {
    getInfo($connect, $_POST['id']);
}else if(isset($_POST["functionId"]) && $_POST["functionId"] == 3 && isset($_POST['pid']) && isset($_POST["pump_name"]) && isset($_POST["container_id"])){


    updatePump($connect,$_POST['pid'],$_POST["pump_name"],$_POST["container_id"]);


}else if(isset($_POST["functionId"]) && $_POST["functionId"] == 112 && isset($_POST['record_id']) ){


    delete_record($connect,$_POST['record_id']);


}
function delete_record($connect, $record_id){
    $query = "delete from pumprecords where pumprecords.PUMPRECORDID=".$record_id.";";
    echo mysqli_query($connect, $query);

}

function getInfo($connect,$pumpId){
    $query = "SELECT pumprecords.RECORD,pumprecords.RECORDDATE FROM pumprecords WHERE PUMPID=".$pumpId." ORDER by RECORDDATE DESC LIMIT 1;";
    $result = mysqli_query($connect, $query);
    if(mysqli_num_rows($result)){
        $row = mysqli_fetch_array($result);
        $data["PREVIOUS_RECORD"] =$row["RECORD"];
        $data["RECORD_DATE"]= $row["RECORDDATE"];
    }else{
        $data["PREVIOUS_RECORD"] =0;
        $data["RECORD_DATE"]= 'no prevous updates';

    }


    //  $query = "SELECT pumprecords.RECORD,pumprecords.RECORDDATE FROM pumprecords WHERE PUMPID=".$pumpId." ORDER by RECORDDATE ASC ";
    $query="SELECT PUMPRECORDID,RECORD,RECORDDATE,container.CONTAINERNAME FROM pumprecords join container on pumprecords.CONTAINER_ID=container.CONTAINER_ID WHERE pumprecords.PUMPID=".$pumpId." ORDER by pumprecords.RECORDDATE Asc;";
    $result = mysqli_query($connect, $query);
    $i=0;

    while($row = mysqli_fetch_array($result)){

        $data["record"][$i]["record_id"] =$row["PUMPRECORDID"];
        $data["record"][$i]["date"] =$row["RECORDDATE"];
        $data["record"][$i]["value"]= $row["RECORD"];
        $data["record"][$i]["container"]= $row["CONTAINERNAME"];
        $i+=1;

    }




    $query="SELECT pump.CONTAINER_ID FROM pump WHERE pump.PUMPID=$pumpId";
    $result = mysqli_query($connect, $query);
    $row = mysqli_fetch_array($result);
    $data["pump_container"]=$row["CONTAINER_ID"];
    $query =" CALL getContainerCurrentVolume(".$row["CONTAINER_ID"].", @p1)";
    $result = mysqli_query($connect, $query);
    $query="SELECT @p1 AS Volume;";
    $value = mysqli_query($connect, $query);
    $row = mysqli_fetch_array($value);
    $data["maxRecord"]=$row["Volume"]+$data["PREVIOUS_RECORD"];



    $query = "Call getCurrentPumpPrices(".$_POST['id'].", @p2, @p3);";

    $result = mysqli_query($connect, $query);

    $query=" SELECT @p2 AS OfficalPrice, @p3 AS Profit;";
    $result = mysqli_query($connect, $query);
    $row = mysqli_fetch_array($result);


    $data["OfficalPrice"] =$row["OfficalPrice"];
    $data["Profit"]= $row["Profit"];

    echo json_encode($data,JSON_PRETTY_PRINT);

}


function insertRecord($connect,$pumpId,$record,$recordDate){
    //  $query = "INSERT INTO pumprecords (PUMPRECORDID, PUMPID, RECORD, RECORDDATE) VALUES (NULL, $pumpId, $record,'$recordDate')";
    $query="CALL insertPumpRecord($pumpId, $record, '$recordDate');";

    $result = mysqli_query($connect, $query);

    echo $result;

}

function updatePump($connection,$pumpId,$pumpName,$containerId){

    $query="CALL updatePump($pumpId, $containerId, '".$pumpName."');";
    $result = mysqli_query($connection, $query);

    echo $result;

}
