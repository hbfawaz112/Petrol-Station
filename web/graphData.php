<?php
require  'Access.php';
require 'db_connect.php';


;
exportCsv($connect,-2,date('Y-m-d', strtotime(date("Y-m-d")."" . ' - 30 days')),date("Y-m-d"));

function getFuelLitters($connect,$fuelId,$minDate,$maxDate)
{


    $data["total"]["litters"]=0;



    $where = "";
    if ($fuelId > 0) {
        $where = " where FUELTYPEID=" . $fuelId;
    }
    $query = "SELECT FUELTYPEID,TYPENAME FROM fuel_types " . $where;
    $result = mysqli_query($connect, $query);
    $i = 0;

    while ($row = mysqli_fetch_array($result)) {


        $data["fuel_types"][$i]["FUELTYPEID"] = $row["FUELTYPEID"];
        $data["fuel_types"][$i]["TYPENAME"] = $row["TYPENAME"];



        $query2 = "select pump.PUMPID 
			from container
			join pumprecords on pumprecords.CONTAINER_ID=container.CONTAINER_ID 
            join pump on pumprecords.PUMPID=pump.PUMPID
			join fuel_types f on container.FUELTYPEID=f.FUELTYPEID
            where f.FUELTYPEID=".$row['FUELTYPEID']." and date(pumprecords.RECORDDATE) between '$minDate' and '$maxDate'
			group by pump.PUMPID;";


        $result2 = mysqli_query($connect, $query2);

        $litters=0;


        while ($row2 = mysqli_fetch_array($result2)) {


            $query3 = "CALL getPumpLittersByDateandfuel_type(" . $row2["PUMPID"] . "," . $row["FUELTYPEID"] . ",'" . $minDate . "','" . $maxDate . "',@p1)";
            $value = mysqli_query($connect, $query3);
            $query3 = " SELECT @p1 AS litters;";
            $value = mysqli_query($connect, $query3);
            $value_row = mysqli_fetch_array($value);
            $litters +=$value_row["litters"];
        }


        $data["fuel_types"][$i]["litters"] = $litters;
        $data["total"]["litters"]+=$litters;
        $i+=1;


    }

    return $data;

}




function exportCsv($connect,$fuelId,$minDay,$maxDay)
{

    $minDay_2 = new DateTime($minDay);
    $maxDay_2 = new DateTime($maxDay);

    $Days_number =  $maxDay_2->diff($minDay_2)->format("%a");


    $data[0][0] = "Date(Y-M-D)" ;

    for ($k = 0; $k <= $Days_number; $k++) {

        $result = getFuelLitters($connect, $fuelId, $minDay, $minDay);

        if($k==0){
            for($j=0;$j<count($result["fuel_types"]);$j++) {
                $data[0][$j+1] = $result["fuel_types"][$j]["TYPENAME"] . " (Litters)";
            }
            if($fuelId==-2){
                $data[0][$j+1] = "Total (Litters)";
            }
        }

        $data[$k+1][0] = " ".$minDay ;

        for($j=0;$j<count($result["fuel_types"]);$j++) {

            $litters = $result["fuel_types"][$j]["litters"];
            $data[$k+1][$j+1] = $litters;


        }
        if($fuelId==-2){
            $data[$k+1][$j+1] =  $result["total"]["litters"];
        }


        $minDay = date('Y-m-d', strtotime($minDay . ' + 1 days'));
    }

    echo json_encode($data);

}




