<?php

require  'Access.php';
require 'db_connect.php';




date_default_timezone_set('Asia/Beirut');
$paydate=NULL;
//$data["mydept"]["dept"]=0;
if(isset($_POST['provider']) && isset($_POST['volume']) && isset($_POST['container']) && isset($_POST['fueltype']) && isset($_POST['shipvalue'])) {
    $provider = $_POST['provider'];
    $volume = $_POST['volume'];
    $container = $_POST['container'];
    $date = $_POST['date'];
    $note = $_POST['note'];
    $fueltype = $_POST['fueltype'];
    $shipvalue=$_POST['shipvalue'];
    $rad=$_POST['radio'];

    if ($date == date("Y-m-d"))
        $date = date("Y-m-d H:i:s");
    if($rad == 1)
        $paydate=$date;

    $query = "insert into shipment (PROVIDERID,CONTAINER_ID,SHIPMENTVOLUME,SHIPMENTVALUE,ISPAID,PAIDDATE,SHIPMENTDATE,COMMENTS) VALUES ('$provider','$container','$volume','$shipvalue','$rad','$paydate','$date','$note')";
    $result=mysqli_query($connect, $query);
    echo $result;

}
else {
    if (isset($_POST["shipments"]) && $_POST["shipments"] = 1) {
        getProviderShipments($connect);
    }
    if(isset($_POST["pay"]) && $_POST["pay"] = 1)
        pay($connect,$_POST["shipid"],$_POST["paydate"]);
    if(isset($_POST["delete"]) && $_POST["delete"] = 1)
        deleteshipment($connect,$_POST["dshipid"]);
}


function pay($connection,$id1,$date1){
    if ($date1 == date("Y-m-d"))
        $date1 = date("Y-m-d H:i:s");
    $query = "update shipment set PAIDDATE = '".$date1."',ISPAID = '1' where SHIPMENTID ='" .$id1."'";
    $result = mysqli_query($connection, $query);

    if ($result) {
        $query2 = "select SHIPMENTVALUE from shipment where SHIPMENTID ='" .$id1."'";
        $result2 = mysqli_query($connection, $query2);
        if($row = mysqli_fetch_array($result2)) {
            $data["my"]["date"] = $date1;
            $data["my"]["value"] = $row["SHIPMENTVALUE"];
            echo json_encode($data);
        }
    }

}

function deleteshipment($connection,$did)
{
    $data["done"] =-1;
    $query = "Delete from shipment where SHIPMENTID ='" .$did."'";
    $result = mysqli_query($connection, $query);
    if($result){
        $data["done"] =1;

    }
    echo json_encode($data);

}




function getProviderShipments($connection){
    $b = false;


    $where = " where";

    if ($_POST["containerId"] != -1) {
        $where = $where . " container.CONTAINER_ID=" . $_POST["containerId"];
        $b = true;


    }

    if ($_POST["providerId"] != -1) {

        if ($b) {

            $where = $where . " and provider.PROVIDERID=" . $_POST["providerId"];

        } else {
            $where = $where . " provider.PROVIDERID=" . $_POST["providerId"];

            $b = true;

        }

    }
    if (!empty($_POST["date1"]))
    {
        if($b){
            $where = $where . " and" ;

        }
        $where = $where . " shipment.SHIPMENTDATE >= '".$_POST["date1"]."'" ;
        $b=true;


    }
    if (!empty($_POST["date2"]))
    {

        //  $_POST['date2'] = date("Y-m-d H:i:s");

        $date=date('Y-m-d', strtotime($_POST['date2']. ' + 1 days'));


        if($b){
            $where = $where . " and" ;



        }
        $where = $where . " shipment.SHIPMENTDATE <= '".$date."'" ;

        $b=true;

    }


    if ($b==false) {
        $where = "";

    }


    $query = "select shipment.SHIPMENTVOLUME,shipment.SHIPMENTDATE,shipment.COMMENTS,shipment.SHIPMENTID,shipment.ISPAID,shipment.PAIDDATE,shipment.SHIPMENTVALUE,fuel_types.TYPENAME,container.CONTAINERNAME,provider.PROVIDERNAME
    from shipment join provider on shipment.PROVIDERID=provider.PROVIDERID join container on shipment.CONTAINER_ID=container.CONTAINER_ID join fuel_types on container.FUELTYPEID=fuel_types.FUELTYPEID ".$where;
    $result = mysqli_query($connection, $query);
    $i = 0;
    $data["mydept"]["dept"]=0;
    $data["total_Paid"] = 0;

    while ($row = mysqli_fetch_array($result)) {

        $data["shipments"][$i]["date"] = $row["SHIPMENTDATE"];
        $data["shipments"][$i]["type"] = $row["TYPENAME"];
        $data["shipments"][$i]["Container"] = $row["CONTAINERNAME"];
        $data["shipments"][$i]["Volume"] = $row["SHIPMENTVOLUME"];
        $data["shipments"][$i]["provider"]=$row["PROVIDERNAME"];
        $data["shipments"][$i]["COMMENTS"] = $row["COMMENTS"];
        $data["shipments"][$i]["shipmentid"] = $row["SHIPMENTID"];
        $data["shipments"][$i]["ispaid"] = $row["ISPAID"];
        $data["shipments"][$i]["pdate"] = $row["PAIDDATE"];
        $data["shipments"][$i]["value"] = $row["SHIPMENTVALUE"];
        if($row["ISPAID"] == 0)
        {
            $data["mydept"]["dept"]+=$row["SHIPMENTVALUE"];

        }else{
            $data["total_Paid"] += $row["SHIPMENTVALUE"];
        }

        $i += 1;
    }

    echo json_encode($data);
}
