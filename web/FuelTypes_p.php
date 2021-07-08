<?php

require 'Access.php';

?>
<!DOCTYPE html>
<html class="loading" lang="en" data-textdirection="ltr">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <meta name="author" content="ThemeSelect">
    <title>Petrol Station </title>
    <link rel="shortcut icon" type="image/x-icon" href="fuel.png">
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
    <script src="jquery.min.js"></script>

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


            <li class="nav-item"><a href="vouchers_p.php"><i class="la la-cc-mastercard"></i><span class="menu-title" data-i18n="">Vouchers</span></a>
            </li>

            <li class="nav-item"><a href="Customers_p.php"><i class="la la-group"></i><span class="menu-title" data-i18n="">Customers</span></a>
            </li>


            <li class="nav-item has-sub active open" >  <a href="#">  <i class="ft-droplet"></i> <span class="menu-title" data-i18n="" id="first_fuel">Fuel Types <i class="nav-link-expand"></i> </span></a>
                <ul class="menu-content" id="fuel_types">

                </ul>
            </li>


            <li class="nav-item "><a href="Accounting_p.php"><i class="la la-dollar"></i><span class="menu-title" data-i18n="">Accounting</span></a>
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

        <div class="content-header row">
            <div class="content-header-left col-md-4 col-12 mb-2">
                <br>
                <h2 class="content-header-title" id="PageTitle" style="color: #f1c40f;">&nbsp; Fuel Types</h2>
            </div>

        </div>
        <!-- Chart -->
        <div id="collapse3" class="card-accordion">
            <div class="card collapse-icon accordion-icon-rotate">
                <div class="card">


                    <div class="card-body">
                        <div class="row match-height">
                            <div class="col-md-6" class="card collapse-icon accordion-icon-rotate">
                                <div class="card">

                                    <div class="card-content collapse show">
                                        <div class="card-body">
                                            <form class="form" id="fuelform">
                                                <div class="form-body">
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="Fuel_Type">Fuel Type</label>
                                                                <input type="text" id="Fuel_Type" class="form-control" placeholder="Fuel Name" name="Fuel_Type" required>
                                                                <span class="-error" id="Fuel_Type_Error"></span>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="form-body">
                                                        <div class="form-group">
                                                            <label for="officialPrice">Official Price</label>
                                                            <input type="number" min="0" value="0" id="officialPrice" class="form-control" placeholder="Official Fuel Price" name="officialPrice" required>
                                                            <span class="-error" id="officialPriceError"></span>
                                                        </div>
                                                    </div>
                                                    <div class="form-body">
                                                        <div class="form-group">
                                                            <label for="profit">Profit</label>
                                                            <input type="number" min="0" value="0" id="profit" class="form-control" placeholder="Profit" name="profit" required>
                                                            <span class="-error" id="profitError"></span>
                                                        </div>
                                                    </div>

                                                    <button type="submit" class="btn btn-primary" onclick="addFuelType()">
                                                        <i class="la la-check-square-o"></i> Save
                                                    </button>


                                                </div>
                                            </form>
                                            <br>
                                            <br>

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




        <!-- eCommerce statistic -->



        <div class='row match-height' id="HomeBody">
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
    let maxi=new Array();
    let s=window.location.search;
    let urlParams=new URLSearchParams(s);
    let container_id1=urlParams.get('id');
    let ft=urlParams.get('ft');

    // let conname=urlParams.get('name2');

    let types="|";

    function getNavContent(){


        $.ajax({


            url:"getNavContent.php",
            method:"POST",
            dataType:"JSON",
            success:function(data)
            {
                let m=0;
                let name,id;

                if(data["containers"]) {

                    for(let i=0;i<data["containers"].length;i++) {
                        id = data["containers"][i]["CONTAINER_ID"];
                        name = data["containers"][i]["CONTAINERNAME"];
                        document.getElementById("containers").innerHTML += ("<li><a class='menu-item' href='Container_p.php?id=" + id + "&name=" + name + "'>" + name + "</a></li>");
                        if (id == container_id1) {
                            maxi[id]=data["containers"][i]["Max"];
                            document.getElementById('container').innerHTML += ("<option value=" + id + " selected>" + name + "</option>");
                            $("#volume").attr({"placeholder":'max :'+ maxi[id],"max":maxi[id]});
                        }
                    }
                }
                if(data["pumps"]) {
                    for (let i = 0; i < data["pumps"].length; i++) {
                        id = data["pumps"][i]["PUMPID"];
                        name = data["pumps"][i]["PUMPNAME"];
                        document.getElementById("pumps").innerHTML+=("<li><a class='menu-item' href='Pump_x_p.php?id="+id+"&name="+name+"'>"+name+" ("+data["pumps"][i]["fuelName"]+")"+"</a></li>");

                    }
                }

                if(data["fuel_types"]) {

                    for (let i = 0; i < data["fuel_types"].length; i++) {

                        id = data["fuel_types"][i]["FUELTYPEID"];
                        name = data["fuel_types"][i]["TYPENAME"];
                        types += name + "|";
                        document.getElementById("fuel_types").innerHTML += ("<li><a class='menu-item' href='fuel_type_x_p.php?id=" + id + "&name=" + name + "'>" + name + "</a></li>");

                        if(i==0){
                            $('#first_fuel').attr("onclick","window.location.href='fuel_type_x_p.php?id=" + id + "&name=" + name + "'");
                        }

                    }
                }

                document.getElementById("fuel_types").innerHTML += ("<li class='active' id='addNew'><a  href='FuelTypes_p.php'>Add Type</a></li>");

            }
        });

    }

    $("#fuelform").submit(function(e) {
        e.preventDefault();
    });

    function addFuelType() {

        let type=$("#Fuel_Type");
        let price=$("#officialPrice").val();
        let profit=$("#profit").val();

        if(type.val()=='')
        {
            document.getElementById("Fuel_Type_Error").innerHTML="<p style='color: red;'>Fuel Type Required</p>";
            return;
        }
        else if(price=='')
        {
            document.getElementById("officialPriceError").innerHTML="<p style='color: red;'>Official Price Required</p>";
            return;
        }
        else if(profit=='')
        {
            document.getElementById("profitError").innerHTML="<p style='color: red;'>Profit Required</p>";
            return;
        }
        else if(profit<0 || price<0){return;}
        else
        {
            document.getElementById("Fuel_Type_Error").innerHTML='';
            document.getElementById("officialPriceError").innerHTML='';
            document.getElementById("profitError").innerHTML='';
        }


        if(types.toLowerCase().includes("|"+type.val().toLowerCase()+"|"))
        {
            type.focus(function() {$(this).next("span").css("display", "inline");});
            document.getElementById("Fuel_Type_Error").innerHTML="<p style='color: red;'>Fuel Type Name not available</p>";
            return;
        }
        else
        {
            document.getElementById("Fuel_Type_Error").innerHTML='';
            type=type.val();
        }


        $.ajax({

            url:"addfuel.php",
            method:"POST",
            dataType:"JSON",
            data:{"type":type,"price":price,"profit":profit},
            success:function(data)
            {

                types += type + "|";

                $('#addNew').before("<li><a class='menu-item' href='fuel_type_x_p.php?id="+data+"&name="+type+"'>"+type+"</a></li>");

                    $('#message').fadeIn();
                    document.getElementById("message").innerHTML = '<div class="alert alert-success mb-2" role="alert">\n' +
                        '                                                <strong>Done!</strong> Fuel Type was Successfully added.\n' +
                        '                                            </div>';

                $('#message').delay(1000).fadeOut();
                $("#Fuel_Type").val('');
                $("#officialPrice").val(0);
                $("#profit").val(0);

            }
        });
    }

    getNavContent();


</script>
<!-- END PAGE LEVEL JS-->
</body>
</html>
