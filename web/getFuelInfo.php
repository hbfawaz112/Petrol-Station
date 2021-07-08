<?php


require  'Access.php';
require 'db_connect.php';

$data=null;
$id=$_POST["id"];



$query = "SELECT PRICEID,FUELTYPEID,OFFICALPRICE,PRICEDATE FROM prices where FUELTYPEID='$id' ORDER By PRICEDATE DESC";
$result = mysqli_query($connect, $query);
$row = mysqli_fetch_array($result);
$data["officialPrice"] = $row["OFFICALPRICE"];

$query = "SELECT PROFITID,FUELTYPEID,PROFITVALUE,PROFITDATE FROM profits where FUELTYPEID='$id' ORDER By PROFITDATE DESC";
$result = mysqli_query($connect, $query);
$row = mysqli_fetch_array($result);
$data["profitValue"] = $row["PROFITVALUE"];




$query = "SELECT fuel_types.TYPENAME,prices.PRICEID,prices.FUELTYPEID,prices.OFFICALPRICE,prices.PRICEDATE, profits.PROFITID,profits.FUELTYPEID,profits.PROFITVALUE,profits.PROFITDATE
from prices
left join profits on profits.FUELTYPEID = prices.FUELTYPEID  and  profits.FUELTYPEID='$id' and profits.PROFITDATE = prices.PRICEDATE
left join fuel_types on fuel_types.FUELTYPEID = prices.FUELTYPEID  and  fuel_types.FUELTYPEID='$id'
where prices.FUELTYPEID='$id'
ORDER By PROFITDATE DESC";


$result = mysqli_query($connect, $query);
$i = 0;


while ($row = mysqli_fetch_array($result))
{
    $data["fuel"][$i]["fuelname"] = $row["TYPENAME"];
    $data["fuel"][$i]["price"] = $row["OFFICALPRICE"];
    $data["fuel"][$i]["profit"] = $row["PROFITVALUE"];
    $data["fuel"][$i]["date"] = $row["PRICEDATE"];

    $i += 1;

}




echo json_encode($data);