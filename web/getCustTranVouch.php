<?php

require  'Access.php';


require 'db_connect.php';

date_default_timezone_set('Asia/Beirut');

$whereTR = null;
$whereVO = null;

if (!empty($_POST["date1"]))
{
    $whereTR = $whereTR . " and date(transaction.TRANSACTIONDATE) >= '".$_POST["date1"]."'" ;
    $whereVO = $whereVO . " and date(voucher.VOUCHERDATE) >= '".$_POST["date1"]."'" ;
}

if (!empty($_POST["date2"]))
{
    //$date=date('Y-m-d', strtotime($_POST['date2']. ' + 1 days'));
    $whereTR = $whereTR . " and date(transaction.TRANSACTIONDATE) <= '".$_POST['date2']."'" ;
    $whereVO = $whereVO . " and date(voucher.VOUCHERDATE) <= '".$_POST['date2']."'" ;
}



$data=null;
$id=$_POST["id"];

if($whereTR == null)
    $query = "SELECT TRANSACTIONID,CUSTOMERID,TRANSACTIONVALUE,TRANSACTIONDATE FROM transaction where CUSTOMERID='$id'";
else
    $query = "SELECT TRANSACTIONID,CUSTOMERID,TRANSACTIONVALUE,TRANSACTIONDATE FROM transaction where CUSTOMERID='$id'".$whereTR;
$result = mysqli_query($connect, $query);
$i=0;
$sumTr=0;
while ($row = mysqli_fetch_array($result))
{
    $data["customerTR"][$i]["trID"] = $row["TRANSACTIONID"];
    $data["customerTR"][$i]["value"] = $row["TRANSACTIONVALUE"];
    $data["customerTR"][$i]["date"] = $row["TRANSACTIONDATE"];
    $sumTr+=$row["TRANSACTIONVALUE"];
    $i+=1;
}

$data["sumTransactionValues"]=$sumTr;

$date = null;
$s = 0;



if($whereVO == null)
{
    $query = "SELECT fuel_types.FUELTYPEID,fuel_types.TYPENAME, voucher.VOUCHERID,voucher.CUSTOMERID,voucher.FUELTYPEID,voucher.VOUCHERVALUE,voucher.VOUCHERDATE,voucher.NOTE
    from voucher join fuel_types on fuel_types.FUELTYPEID=voucher.FUELTYPEID WHERE voucher.CUSTOMERID='$id'";
}
else
{
    $query = "SELECT fuel_types.FUELTYPEID,fuel_types.TYPENAME, voucher.VOUCHERID,voucher.CUSTOMERID,voucher.FUELTYPEID,voucher.VOUCHERVALUE,voucher.VOUCHERDATE,voucher.NOTE
    from voucher join fuel_types on fuel_types.FUELTYPEID=voucher.FUELTYPEID WHERE voucher.CUSTOMERID='$id'".$whereVO;
}


$result = mysqli_query($connect, $query);
$i = 0;
$sumVou = 0;
while ($row = mysqli_fetch_array($result)) {
    $data["customerVO"][$i]["voID"] = $row["VOUCHERID"];
    $data["customerVO"][$i]["fueltype"] = $row["TYPENAME"];
    $data["customerVO"][$i]["value"] = $row["VOUCHERVALUE"];
    $data["customerVO"][$i]["date"] = $row["VOUCHERDATE"];
    $data["customerVO"][$i]["note"] = $row["NOTE"];

    $typeid = $row["FUELTYPEID"];
    $date = $row["VOUCHERDATE"];
    $value = $row["VOUCHERVALUE"];

    if ($date == date("Y-m-d"))
        $date = date("Y-m-d H:i:s");



    /*$q = "Call getFuelPrices(".$typeid.", '".$date."', @p2, @p3);";
    $res = mysqli_query($connect, $q);


    $m=" SELECT @p2 AS `OfficalPrice`, @p3 AS `Profit`;";
    $res = mysqli_query($connect, $m);
    $r = mysqli_fetch_array($res);

    $price =$r["OfficalPrice"];

    $s += $value * $price;*/

    $sumVou += $row["VOUCHERVALUE"];

    $i += 1;

}

$data["sumVoucherValues"] = $sumVou;
//$data["sumMoneyToPay"] = $s;


$query = "SELECT CUSTOMERID,CUSTOMERNAME,CUSTOMERPHONE,CUSTOMEREMAIL FROM customer where CUSTOMERID='$id' ";
$result = mysqli_query($connect, $query);
$row = mysqli_fetch_array($result);
$data["customerPhone"] = $row["CUSTOMERPHONE"];
$data["customerEmail"] = $row["CUSTOMEREMAIL"];


$query =" CALL getTotalDebt( @p1)";
$value = mysqli_query($connect, $query);
$query="SELECT @p1 AS `totalDebt`;";
$value = mysqli_query($connect, $query);
$value_row = mysqli_fetch_array($value);
$data["totalDebt"] = $value_row["totalDebt"];


echo json_encode($data);
