<?php

require 'Access.php';

?>
<!DOCTYPE html>
<html  lang="en" data-textdirection="ltr" class="loading">
<head>
    <script src="jquery.min.js"></script>


    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">

    <title>Petrol Station </title><link rel="shortcut icon" type="image/x-icon" href="fuel.png">
    <link href="https://fonts.googleapis.com/css?family=Muli:300,300i,400,400i,600,600i,700,700i%7CComfortaa:300,400,700" rel="stylesheet">
    <link href="https://maxcdn.icons8.com/fonts/line-awesome/1.1/css/line-awesome.min.css" rel="stylesheet">
    <!-- BEGIN VENDOR CSS-->
    <link rel="stylesheet" type="text/css" href="theme-assets/css/vendors.css">
    <link rel="stylesheet" type="text/css" href="theme-assets/vendors/css/charts/chartist.css">
    <!-- END VENDOR CSS-->
    <!-- BEGIN CHAMELEON  CSS-->
    <link rel="stylesheet" type="text/css" href="theme-assets/css/app-lite.css">
    <!-- END CHAMELEON  CSS-->
    <!-- BEGIN Page Level CSS-->
    <link rel="stylesheet" type="text/css" href="theme-assets/css/core/menu/menu-types/vertical-menu.css">
    <link rel="stylesheet" type="text/css" href="theme-assets/css/core/colors/palette-gradient.css">
    <link rel="stylesheet" type="text/css" href="theme-assets/css/pages/dashboard-ecommerce.css">





    <!-- END Page Level CSS-->
    <!-- BEGIN Custom CSS-->
    <link rel="stylesheet" type="text/css" href="card.css">


    <!-- END Custom CSS-->
</head>
<body class="vertical-layout vertical-menu 2-columns   menu-expanded fixed-navbar" data-open="click" data-menu="vertical-menu" data-color="bg-chartbg" data-col="2-columns">





<!-- ////////////////////////////////NAVIGATION START////////////////////////////////////////////-->

<!-- fixed-top-->


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





<div class="main-menu menu-fixed menu-light menu-accordion    menu-shadow " data-scroll-to-active="true" data-img="theme-assets/images/backgrounds/02.jpg">
    <div class="navbar-header">
        <ul class="nav navbar-nav flex-row">
            <li class="nav-item mr-auto"><a class="navbar-brand" href="#"><img class="brand-logo" alt="Chameleon admin logo" src="fuel.png"/>
                <h3 class="brand-text">Petrol Station*</h3></a></li>
            <li class="nav-item d-md-none"><a class="nav-link close-navbar"><i class="ft-x"></i></a></li>
        </ul>
    </div>

    <div class="main-menu-content">
        <ul class="navigation navigation-main" id="main-menu-navigation" data-menu="menu-navigation">

            <li class="nav-item"><a href="index.php"><i class="ft-home"></i><span class="menu-title" data-i18n="">Dashboard</span></a>
            </li>






            <li class="nav-item has-sub active" >
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





<!-- ////////////////////////////////NAVIGATION END////////////////////////////////////////////-->


<div class="app-content content" >





    <div class="content-wrapper" >

        <br>
        <div class="content-header row">
            <div class="content-header-left col-md-4 col-12 mb-2">
                <h2 class="content-header-title" style="color: #f1c40f;">&nbsp;PUMPS</h2>
            </div>

        </div>
        <div id="collapse1" class="card-accordion">
            <div class="card collapse-icon accordion-icon-rotate">
                <div class="card">
                    <div class="card-header" id="headingCOne">
                        <h5 class="mb-0">
                            <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseC1" aria-expanded="false" aria-controls="collapseC1">

                                <h4 class="card-title" id="basic-layout-form">Add PUMP</h4>

                            </button>
                        </h5>
                    </div>

                    <div id="collapseC1" class="collapse" aria-labelledby="headingCOne" style="">
                        <div class="card-body">
                            <div class="row match-height">
                                <div class="col-md-12" class="card collapse-icon accordion-icon-rotate">
                                    <div class="card">

                                        <div class="card-content collapse show">
                                            <div class="card-body">




                                                <form class="form" id="pump_form">
                                                    <div class="form-body">


                                                        <div class="form-group">
                                                            <label for="pump_name">Pump Name</label>
                                                            <input type="text" id="pump_name" class="form-control" placeholder="Pump Name" name="pump_name" required>
                                                            <span class="-error" id="pump_name_error"></span>
                                                        </div>
                                                        <div class="row">
<!--
                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label for="Dispenser_Name">Dispenser Name</label>
                                                                    <select id="Dispenser_Name" name="dispenser_id" class="form-control" required>

                                                                    </select>
                                                                </div>
                                                            </div>
-->
                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label for="Container_Name">Container Name</label>
                                                                    <select id="Container_Name" name="container_id" class="form-control" required>


                                                                    </select>
                                                                </div>
                                                            </div>

                                                        </div>
                                                        <div class="form-group">
                                                            <label for="Counter0">Initial Counter</label>
                                                            <input type="number" min="0" value="0" id="Counter0" class="form-control" placeholder="Initial Counter" name="Counter0">
                                                            <span class="-error" id="Counter0_error"></span>
                                                        </div>
                                                    </div>

                                                    <div class="form-actions">

                                                        <button type="submit" onclick="savePump()" class="btn btn-primary" id="save" >
                                                            <i class="la la-check-square-o"></i> Save
                                                        </button>
                                                    </div>
                                                </form>
                                                <div class="form-actions" id="message">

                                                </div>




                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>



            <!-- Chart -->
            <!-- eCommerce statistic -->



            <div class='row match-height' id="PageBody">









            </div>
        </div>
















    </div>

































    <!--/ Statistics -->
</div>
</div>
</div>








































<footer class="footer footer-static footer-light navbar-border navbar-shadow">

</footer>

<!-- BEGIN VENDOR JS-->
<script src="theme-assets/vendors/js/vendors.min.js" type="text/javascript"></script>
<!-- BEGIN VENDOR JS-->
<!-- BEGIN PAGE VENDOR JS-->
<script src="theme-assets/vendors/js/charts/chartist.min.js" type="text/javascript"></script>
<!-- END PAGE VENDOR JS-->
<!-- BEGIN CHAMELEON  JS-->
<script src="theme-assets/js/core/app-menu-lite.js" type="text/javascript"></script>
<script src="theme-assets/js/core/app-lite.js" type="text/javascript"></script>
<!-- END CHAMELEON  JS-->
<!-- BEGIN PAGE LEVEL JS-->
<script src="theme-assets/js/scripts/pages/dashboard-lite.js" type="text/javascript"></script>


<script>

    let pumpsName="|";
    let s=window.location.search;
    let urlParams=new URLSearchParams(s);
    let container_id=urlParams.get('cid');
    $("#pump_form").submit(function(e) {
        e.preventDefault();
    });

   function getNavContent(){
        $.ajax({

            url:"getNavContent.php",
            method:"POST",
            dataType:"JSON",
            success:function(data)
            {
                let name,id;
                document.getElementById("pumps").innerHTML='';
                document.getElementById("PageBody").innerHTML='';
                pumpsName="|";

                if(data["pumps"]) {
                    for (let i = 0; i < data["pumps"].length; i++) {//show pumps in nav and in body
                        id = data["pumps"][i]["PUMPID"];
                        name = data["pumps"][i]["PUMPNAME"];
                        pumpsName += name + "|";
                        document.getElementById("pumps").innerHTML += ("<li><a class='menu-item' href='Pump_x_p.php?id="+id+"&name="+name+"'>"+name+" ("+data["pumps"][i]["fuelName"]+")"+"</a></li>");
                        document.getElementById("PageBody").innerHTML += getPumpTemplate(id, name,data["pumps"][i]["fuelName"], data["pumps"][i]["record"]);
                    }
                }
                if(data["containers"]) {

                    let j=-1,containerId,containerName;
                    if(container_id || container_id==0){
                        j=container_id;
                        $("#collapseC1").attr({"class":"collapse show"});
                    }

                    for(let i=0;i<data["containers"].length;i++){
                        containerId=data["containers"][i]["CONTAINER_ID"];
                        containerName=data["containers"][i]["CONTAINERNAME"];

                        document.getElementById("containers").innerHTML+=("<li><a class='menu-item' href='Container_p.php?id="+containerId+"&name="+containerName+"'>"+containerName+"</a></li>");
                        if(i==0 && j==-1){j=containerId;}
                        if(containerId==j) {
                            document.getElementById("Container_Name").innerHTML += ("<option value='" + containerId + "' selected> " + containerName + "</option>");
                        }else {
                            document.getElementById("Container_Name").innerHTML += ("<option value='" + containerId + "' > " + containerName + "</option>");
                        }
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


            }
        });
    }
  /* function getformContenttoDisplay() {
        $.ajax({
            url:"pumps.php",
            method:"POST",
            data:{"functionId":1},
            dataType:"JSON",
            success:function(data)
            {
                let containerId,containerName,dispencerId,dispencerName,j=-1;



                document.getElementById("Dispenser_Name").innerHTML='';

                if(data["dispensers"]) {

                    $("#save").attr('disabled', false);
                    for (let i = 0; i < data["dispensers"].length; i++) {

                        dispencerId = data["dispensers"][i]["DISPENSERID"];
                        dispencerName = data["dispensers"][i]["DISPENSERNAME"];

                        if (i == 0) {
                            document.getElementById("Dispenser_Name").innerHTML += ("<option value='" + dispencerId + "' selected>" + dispencerName + "</option>");
                        } else {
                            document.getElementById("Dispenser_Name").innerHTML += ("<option value='" + dispencerId + "'>" + dispencerName + "</option>");
                        }

                    }

                }else {
                    $('#message').fadeIn();
                    document.getElementById("message").innerHTML='<div class="alert alert-danger  mb-2" role="alert">\n' +
                        '<strong>WARNING!</strong> NO AVAILABLE DISPENSERS.\n' +
                        '<a href="newDispenser_p.php">Add New Dispenser</a></div>';
                    $("#save").attr('disabled', true);
                }
            }
        });
    }*/
   function savePump() {
        let a=$("#pump_name").val();
        let valid=1;
        if(pumpsName.toLowerCase().includes("|"+a.toLowerCase()+"|")){ // Check if name is available
            $("#pump_name").focus(function() {
                $(this).next("span").css("display", "inline");
            });
            document.getElementById("pump_name_error").innerHTML="<p style='color: red;'>name not available</p>";
            valid=0;
        }else {
            document.getElementById("pump_name_error").innerHTML='';
        }
        if($.trim(a).length==0){

            $("#pump_name").focus(function() {
                $(this).next("span").css("display", "inline");
            });
            valid=0;
        }
        if($("#Counter0").val()<0){valid=0;}
        if(valid==0){ return;}
       $.ajax({
            url:"pumps.php",
            method:"POST",
            dataType:"JSON",
            data:$("#pump_form").serialize()+"&functionId=2",
            success:function(data)
            {

                if(data["done"]==1){

                    $('#message').fadeIn();
                    document.getElementById("message").innerHTML='<div class="alert alert-success mb-2" role="alert">\n' +
                        '                                                <strong>Done!</strong> New Pump was Successfully added.\n' +
                        '                                            </div>';

                 $('#message').delay(1000).fadeOut();
                    let pid=data["pumpId"];
                    let name=$("#pump_name").val();
                    let counter=$("#Counter0").val();
                    pumpsName+=name+"|";
                    document.getElementById("pumps").innerHTML+=("<li><a class='menu-item' href='Pump_x_p.php?id="+pid+"&name="+name+"'>"+name+"</a></li>");//add to nav

                    document.getElementById("PageBody").innerHTML+=getPumpTemplate(pid,name,data["fuelName"],counter);//add to page body
                    $("#pump_name").val('');
                   // getformContenttoDisplay();//refresh dispensers list ( to make sure that the dispensers doesn't have more than 2 pumps)

                }

            }
        });

    }
   function getPumpTemplate(pumpId,pumpName,fuelType,counter) {

        return "                <div class='col-xl-4 col-lg-12'>\n" +
            "                    <div class='card'>\n" +
            "                        <div class='card-header' style='background-color: #00aec5;'>\n" +
            "                            <p></p>\n" +
            "                            <p  style=' font-size: 50px; text-align: center; color: #f1f1f1'><B>"+pumpName+"</B><sup style=' font-size: 25px; color: #f1c40f'><b>"+fuelType+"</b></sup></p>\n" +

           "                            <footer><object type='text/html'   height='80' style='display: block;" +
            "  margin-left: auto;" +
            "  ' data='demo.html?v="+counter+"'></object></footer>\n" +
    /*    "                            <footer><h3><p style='text-align: center; font-size: 50px;'>"+counter+"</p></h3></footer>\n" +*/
       "                        </div>\n" +
       "                        <div class='card-content'>\n" +
       "                            <div class='card-body'>\n" +
       "                                <div class='card-body'>\n"+
       "                                    <br>\n" +
       "\n" +
       "                                    <button type='button' class='btn mb-1 btn-secondary btn-lg btn-block' onclick=window.location.href='Pump_x_p.php?id="+pumpId+"'>New Record</button>\n" +
       "                                </div>\n" +
       "                            </div>\n" +
       "                        </div>\n" +
       "                    </div>\n" +
       "                </div>";


}
getNavContent();
//getformContenttoDisplay();
</script>
<!-- END PAGE LEVEL JS-->
</body>
</html>
