<?php

require 'Access.php';

?>
<!DOCTYPE html>
<html class="loading" lang="en" data-textdirection="ltr">
<head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <title>Petrol Station </title>
    <link rel="shortcut icon" type="image/x-icon" href="fuel.png">
    <link href="https://fonts.googleapis.com/css?family=Muli:300,300i,400,400i,600,600i,700,700i%7CComfortaa:300,400,700" rel="stylesheet">
    <link href="https://maxcdn.icons8.com/fonts/line-awesome/1.1/css/line-awesome.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="theme-assets/css/vendors.css">
    <link rel="stylesheet" type="text/css" href="theme-assets/vendors/css/charts/chartist.css">
    <link rel="stylesheet" type="text/css" href="theme-assets/css/app-lite.css">
    <link rel="stylesheet" type="text/css" href="theme-assets/css/core/menu/menu-types/vertical-menu.css">
    <link rel="stylesheet" type="text/css" href="theme-assets/css/core/colors/palette-gradient.css">
    <link rel="stylesheet" type="text/css" href="theme-assets/css/pages/dashboard-ecommerce.css">
    <link rel="stylesheet" type="text/css" href="card.css">
    <script src="jquery.min.js"></script>
</head>

<body class="vertical-layout vertical-menu 2-columns fixed-navbar pace-done" data-open="click" data-menu="vertical-menu" data-color="bg-chartbg" data-col="2-columns">

<nav class="header-navbar navbar-expand-md navbar navbar-with-menu navbar-without-dd-arrow fixed-top navbar-semi-light">
    <div class="navbar-wrapper">
        <div class="navbar-container content">
            <div class="collapse navbar-collapse show" id="navbar-mobile">
                <ul class="nav navbar-nav mr-auto float-left">

                    <li class="nav-item mobile-menu d-md-none mr-auto"><a class="nav-link nav-menu-main menu-toggle hidden-xs" href="#"><i class="ft-menu font-large-1"></i></a></li>
                    <li class="nav-item d-none d-md-block"><a class="nav-link nav-menu-main menu-toggle hidden-xs" href="#"><i class="ft-menu"></i></a></li>

                </ul>
                <ul class="nav navbar-nav float-right">
                    <li class="nav-item"><a class="nav-link nav-link-label" href="logout.php" data-toggle="dropdown" onclick="window.location.href='logout.php'"><i class="ft-log-out">    LOGOUT         </i></a>
                    </li>
                </ul>

            </div>
        </div>
    </div>
</nav>
<div class="main-menu menu-fixed menu-light menu-accordion menu-shadow " data-scroll-to-active="true" data-img="theme-assets/images/backgrounds/02.jpg">
    <div class="navbar-header">
        <ul class="nav navbar-nav flex-row">
            <li class="nav-item mr-auto"><a class="navbar-brand" href="#"><img class="brand-logo" alt="Chameleon admin logo" src="fuel.png"/>
                <h3 class="brand-text">Petrol Station*</h3></a></li>
            <li class="nav-item d-md-none"><a class="nav-link close-navbar"><i class="ft-x"></i></a></li>
        </ul>
    </div>

    <div class="main-menu-content">
        <ul class="navigation navigation-main" id="main-menu-navigation" data-menu="menu-navigation">


            <li class="nav-item active"><a href="index.php"><i class="ft-home"></i><span class="menu-title" data-i18n="">Dashboard</span></a>
            </li>




            <li class="nav-item has-sub" >
                <a href="#">
                    <i class="ft-layout"></i> <span class="menu-title" data-i18n="" onclick="window.location.href='Pumps_p.php'">
                    Pumps
                    <i class="nav-link-expand"></i>
                </span>
                </a>
                <ul class="menu-content" id="pumps">


                </ul>
            </li>


            <li class="nav-item"><a href="Shipments_p.php"><i class="la la-truck"></i><span class="menu-title" data-i18n="" onclick="window.location.href='Shipments_p.php'">Shipments </a>
            </li>



            <li class="nav-item" >  <a href="#">  <i class="la la-cc-mastercard"></i> <span class="menu-title" data-i18n="" onclick="window.location.href='vouchers_p.php'">Vouchers<i class="nav-link-expand"></i> </span></a>



            </li>

            <li class="nav-item" >  <a href="Customers_p.php">  <i class="la la-group"></i> <span class="menu-title" data-i18n="" onclick="window.location.href='Customers_p.php'">Customers<i class="nav-link-expand"></i> </span></a>


            </li>




            <li class="nav-item has-sub" >  <a href="FuelTypes_p.php">  <i class="ft-droplet"></i> <span class="menu-title" data-i18n="" id="first_fuel">Fuel Types <i class="nav-link-expand"></i> </span></a>
                <ul class="menu-content" id="fuel_types">

                </ul>
            </li>







            <li class="nav-item" >  <a href="Accounting_p.php">  <i class="la la-dollar"></i> <span class="menu-title" data-i18n="" onclick="window.location.href='Accounting_p.php'">Accounting<i class="nav-link-expand"></i> </span></a>


            </li>
            <li class="nav-item"><a href="Providers_p.php"><i class="la la-users"></i><span class="menu-title" data-i18n="">Providers</span></a>
            </li>

            <li class="nav-item has-sub">

                <a href="#">  <i class="la la-flask"></i> <span class="menu-title" data-i18n="" onclick="window.location.href='Containers_p.php'">Containers <i class="nav-link-expand"></i>  </span></a>
                <ul class="menu-content" id="containers">

                </ul>
            </li>



        </ul>
    </div>


    <div class="navigation-background"></div>
</div>

<div class="app-content content" >
    <div class="content-wrapper" >
        <div class="content-wrapper-before"></div>
        <div class="content-header row"></div>
        <div class="content-body"  >
            <div class="row match-height">
                <div class="col-12">
                    <div class="">

                    </div>
                </div>
            </div>

            <div class='row match-height' id="HomeBody">
            </div>


        </div>
    </div>
</div>
<footer class="footer footer-static footer-light navbar-border navbar-shadow">
</footer>
<script src="theme-assets/vendors/js/vendors.min.js" type="text/javascript"></script>
<script src="theme-assets/vendors/js/charts/chartist.min.js" type="text/javascript"></script>
<script src="theme-assets/js/core/app-menu-lite.js" type="text/javascript"></script>
<script src="theme-assets/js/core/app-lite.js" type="text/javascript"></script>
<script src="theme-assets/js/scripts/pages/dashboard-lite.js" type="text/javascript"></script>
<script>
    function getNavContent(){
        $.ajax({

            url:"getNavContent.php",
            method:"POST",
            data:{"dashboardPage":1},
            dataType:"JSON",
            success:function(data)
            {
                //GET NAV CONTENT
                let name,id;
                if(data["pumps"]){
                for(let i=0;i<data["pumps"].length;i++){

                    id=data["pumps"][i]["PUMPID"];
                    name=data["pumps"][i]["PUMPNAME"];

                    document.getElementById("pumps").innerHTML+=("<li><a class='menu-item' href='Pump_x_p.php?id="+id+"&name="+name+"'>"+name+" ("+data["pumps"][i]["fuelName"]+")"+"</a></li>");

                }}

                if(data["containers"]) {
                    for (let i = 0; i < data["containers"].length; i++) {

                        id = data["containers"][i]["CONTAINER_ID"];
                        name = data["containers"][i]["CONTAINERNAME"];

                        document.getElementById("containers").innerHTML += ("<li><a class='menu-item' href='Container_p.php?id=" + id + "&name=" + name + "'>" + name + "</a></li>");

                    }
                }

                if(data["fuel_types"]) {
                    for (let i = 0; i < data["fuel_types"].length; i++) {
                        id = data["fuel_types"][i]["FUELTYPEID"];
                        name = data["fuel_types"][i]["TYPENAME"];
                        document.getElementById("fuel_types").innerHTML += ("<li><a class='menu-item' href='fuel_type_x_p.php?id=" + id + "&name=" + name + "'>" + name + "</a></li>");
                        if(i==0){
                            $('#first_fuel').attr("onclick","window.location.href='fuel_type_x_p.php?id=" + id + "&name=" + name + "'");
                        }

                    }
                }

                document.getElementById("fuel_types").innerHTML += ("<li><a class='menu-item' href='FuelTypes_p.php'>Add Type</a></li>");
                //GET PAGE BODY
                if(data["BodyContainers"]) {
                    let containerId,containerName,value,capacity,pumps,containerFuelType;
                    let max_pump_num=data["max_pump_num"];
                    for(let i=0;i<data["BodyContainers"].length;i++) {
                        containerId = data["BodyContainers"][i]["CONTAINER_ID"];
                        containerName = data["BodyContainers"][i]["CONTAINERNAME"];
                        containerFuelType = data["BodyContainers"][i]["TYPENAME"];
                        value = data["BodyContainers"][i]["Value"];
                        capacity = data["BodyContainers"][i]["CAPACITY"];
                        pumps="";
                        if(data["BodyContainers"][i]["PUMPS"]){
                            pumps = data["BodyContainers"][i]["PUMPS"];}
                        document.getElementById("HomeBody").innerHTML += (getContainerTemplate(containerId, containerName, containerFuelType, value, capacity, pumps,max_pump_num));

                    }
                }

            }
        });
    }
    function getContainerTemplate(containerId,containerName,containerFuelType,value,capacity,pumps,max_pump_num) {
        let off=0;
        let temp="\n" +
            "                <div class='col-xl-4 col-lg-12'>\n" +
            "                    <div class='card'>\n" +
            "                        <div class='card-header' style='background-color: #00aec5;'>\n" +
            "                            <p></p>\n" +
            "                            <p  style=' font-size: 50px; text-align: center; color: #0d6aad;'><B>"+containerName+"</B></p>\n" +

            "                            <footer style='width: 100%;'><meter value='"+value+"'  max='"+capacity+"' data-value='"+value+"L"/*+"/"+capacity*/+"' style='width: 100%; height: 40px;' ></meter></footer>\n" +
            "\n" +
            "\n" +
            "                        </div>\n" +
            "                        <div class='card-content'>\n" +
            "                            <div class='card-body'>\n" +
            "                                <div class='card-body'>\n"+
            "                                    <h4 class='card-title' ><a href='Pumps_p.php'>Pumps</a></h4>\n";


        if(pumps.length==0){
            temp+="<h4 class='card-title' >No Attached PUMPS<a href='Pumps_p.php?cid="+containerId+"'>&nbsp;&nbsp;&nbsp;ADD NEW PUMP</a></h4>";
            off=1;

        }else{
        for (let i=0;i<pumps.length;i++){
            temp+="<h4 class='card-title' ><a href='Pump_x_p.php?id="+pumps[i]["PUMPID"]+"'>&nbsp;&nbsp;&nbsp;"+pumps[i]["PUMPNAME"]+"</a></h4>";
        }
        }
        for (let i=pumps.length+off;i<max_pump_num;i++){temp+="<h4 class='card-title' ><p style='color: white'>A</p></h4>";}

        temp+=
            "\n" +
            "\n" +
            "                                    <br>\n" +
            "\n" +
            "                                    <button type='button' class='btn mb-1 btn-secondary btn-lg btn-block' onclick=window.location.href='Shipments_p.php?id="+containerId+"&ft="+containerFuelType+"'>New Shipment</button>\n" +
            "                                </div>\n" +
            "                            </div>\n" +
            "                        </div>\n" +
            "                    </div>\n" +
            "                </div>";
        return temp;
    }
    getNavContent();

</script>
<!-- END PAGE LEVEL JS-->
</body>
</html>
