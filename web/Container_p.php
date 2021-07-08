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
    <link rel="stylesheet" type="text/css" href="style.css">

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






            <li class="nav-item has-sub" >  <a href="#">  <i class="ft-droplet"></i> <span id="first_fuel" class="menu-title" data-i18n="" >Fuel Types <i class="nav-link-expand"></i> </span></a>
                <ul class="menu-content" id="fuel_types">

                </ul>
            </li>
            <li class="nav-item "><a href="Accounting_p.php"><i class="la la-dollar"></i><span class="menu-title" data-i18n="">Accounting</span></a>
            </li>

            <li class="nav-item"><a href="Providers_p.php"><i class="la la-users"></i><span class="menu-title" data-i18n="">Providers</span></a>
            </li>

            <li class="nav-item has-sub active open">
                <a href="#">
                    <i class="la la-flask">
                    </i> <span class="menu-title" data-i18n="" onclick="window.location.href='Containers_p.php'">Containers
                        <i class="nav-link-expand"></i>  </span></a>
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
        <!--         REDUCE VOLUME UPDATE START_1            -->
        <div id="collapse231" class="card-accordion">
            <div class="card collapse-icon accordion-icon-rotate">
                <div class="card">
                    <div class="card-header" id="headingC23">
                        <h5 class="mb-0">
                            <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseC221" aria-expanded="false" aria-controls="collapseC221">

                                <h4 class="card-title" id="basic-layout-form">Editing Container Volume</h4>

                            </button>
                        </h5>
                    </div>

                    <div id="collapseC221" class="collapse" aria-labelledby="headingC23" style="">
                        <div class="card-body">
                            <div class="row match-height">
                                <div class="col-md-12" class="card collapse-icon accordion-icon-rotate">
                                    <div class="card">

                                        <div class="card-content collapse show">
                                            <div class="card-body">


                                                <div class="col-md-12">
                                                    <div class="form-group">




                                                    </div>
                                                </div>

                                                <form class="form" id="container_volume_form">

                                                    <div class="form-body">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="containervolume">Reduce Current Volume By:</label>
                                                                <input type="number" id="containervolume" class="form-control"  min="1" required>

                                                            </div>
                                                        </div>

                                                    </div>


                                                    <div class="form-actions" id="volume_form_message">

                                                    </div>
                                                    <div class="form-actions">

                                                        <button type="submit"  onclick="reduceVolume()" class="btn btn-primary">
                                                            <i class="la la-check-square-o"></i> Save
                                                        </button>
                                                    </div>


                                                </form>
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




        <!--         REDUCE VOLUME UPDATE END_1            -->
        <div class="content-header row">
            <div class="content-header-left col-md-4 col-12 mb-2">
                <br>
                <h2 class="content-header-title" id="PageTitle" style="color: #f1c40f;">&nbsp;</h2>
            </div>

        </div>




        <div class='row match-height' id="HomeBody">
        </div>

        <br>

        <div class="form-actions" id="message"></div>




    </div></div>



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

<script type="text/javascript" src="jquery-3.3.1.js"></script>
<script type="text/javascript" src="jquery.dataTables.min.js"></script>
<script src="sweetalert.min.js"></script>
<script src="sweetalert2@9.js"></script>

<script>


    let s=window.location.search;
    let urlParams=new URLSearchParams(s);
    let id=urlParams.get('id');
    let cid=id;
    let conname={};

    //REDUCE VOLUME UPDATE
    let capacity_copy;

    $("#container_volume_form").submit(function(e) {
        e.preventDefault();
    });
    function getNavContent(){

        $.ajax({

            url:"getNavContent.php",
            method:"POST",
            dataType:"JSON",
            success:function(data) {
                let name, id;
                if (data["pumps"]) {
                    for (let i = 0; i < data["pumps"].length; i++) {
                        id = data["pumps"][i]["PUMPID"];
                        name = data["pumps"][i]["PUMPNAME"];

                        document.getElementById("pumps").innerHTML+=("<li><a class='menu-item' href='Pump_x_p.php?id="+id+"&name="+name+"'>"+name+" ("+data["pumps"][i]["fuelName"]+")"+"</a></li>");;

                    }
                }

                if(data["containers"]) {
                    for (let i = 0; i < data["containers"].length; i++) {

                        id = data["containers"][i]["CONTAINER_ID"];
                        name = data["containers"][i]["CONTAINERNAME"];
                        conname[id]=name;

                        if (id == cid) {
                            document.getElementById("PageTitle").innerHTML += name;
                            document.getElementById("containers").innerHTML+=("<li class='active'><a id = "+id+ " class='menu-item' href='Container_p.php?id=" + id + "&name=" + name + "'>" + name + "</a></li>");
                        }else
                        {
                            document.getElementById("containers").innerHTML += ("<li><a id = "+id+ "class='menu-item' href='Container_p.php?id=" + id + "&name=" + name + "'>" + name + "</a></li>");
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
    function getContainer() {

        let id1,name1,capacity1,volume1,type1;

        $.ajax({



            url:"getContainers.php",
            method:"POST",
            data:{"containerId":cid},
            dataType: "JSON",
            success:function(data)
            {

                for(i=0;i<data["containers"].length;i++){

                    id1=data["containers"][i]["CONTAINER_ID"];
                    name1=data["containers"][i]["CONTAINERNAME"];
                    capacity1=data["containers"][i]["CAPACITY"];
                    volume1=data["containers"][i]["Volume"];
                    type1=data["containers"][i]["type"];



                }

                document.getElementById("HomeBody").innerHTML = (getContainerTemplate(id1, name1, volume1, capacity1,type1));

            }
        });



    }
    function getContainerTemplate(containerId,containerName,value,capacity,type) {
        capacity_copy=capacity;
        let temp="\n" +
            "                <div class='col-xl-12 col-lg-18'>\n" +
            "                    <div class='card'>\n" +
            "                        <div class='card-header' style='background-color: #00aec5;'>\n" +
            "                            <p></p>\n" +
            "                            <p  style=' font-weight: lighter ; font-size: 50px; text-align: center; '><B><a onmouseover=\"style.fontWeight = 'bold'\" onmouseout=\"style.fontWeight = 'normal'\" style='color: royalblue' title=\"Change name.\"id="+containerId+"1"+" onclick='getprp()'  "+containerId+"'>"+containerName+"</a></B></p>\n" +

            "                            <footer style='width: 100%; '><meter id='current_volume' value='"+value+"'  max='"+capacity+"' data-value='"+value+"/"+capacity+"' style='width: 100%; height: 40px; text-align: justify'  ></meter></footer>\n"
        ;

        return temp;
    }

    function getprp() {


        Swal.fire({
            title: "<h1><b style='color: #00aec5'>Change Name</b></h1>",
            showCancelButton: true,
            confirmButtonText: 'Confirm',
            confirmButtonColor: "#00aec5",
            cancelButtonColor: "#DD6B55",
            html:
                '<form class="form" id="updatename"><div class="form-group"><div class="form-body">' +

                '<input type="text" id="contname" class="swal2-input"  name="contname" value="'+conname[cid]+'"/><br>' +
                ' </div>\n' +
                ' </div></form>'
            ,

            focusConfirm: true,
            preConfirm: () => {
                let valid=1;

                let trValue = document.getElementById('contname').value;

                for(var i in conname)
                {
                    if(conname[i].toLowerCase() == trValue.toLowerCase())
                    {
                        valid=0;

                    }
                }



                if (trValue == '' || valid == 0) {
                    Swal.showValidationMessage('invalid name')
                    //swal.showValidationError('Vous devez choisir un dossier');


                    //showConfirmButton: true;

                }
                else {

                    $.ajax({

                        url: "addcontainer.php",
                        method: "POST",
                        dataType: "JSON",
                        data: {"newname": trValue, "cid": cid},
                        success: function (data) {
                            if (data == 1) {

                                $('#message').fadeIn();
                                document.getElementById("message").innerHTML = '<div class="alert alert-success mb-2" role="alert">\n' +
                                    '                                                <strong>Done!</strong> Container Updated sucessfully.\n' +
                                    '                                            </div>';

                                $('#message').delay(1000).fadeOut();

                                // getNavContent();
                                document.getElementById("PageTitle").innerHTML = trValue;
                                document.getElementById(cid).textContent=trValue;
                                document.getElementById(cid+"1").textContent=trValue;
                                conname[cid]=trValue;



                            }
                        }
                    });

                }

            }

        });
    }

    // REDUCE VOLUME UPDATE
    function reduceVolume(){


        let litters = document.getElementById('containervolume').value;
        if(litters>0 && litters<1000000){

            $.ajax({

                url: "reduceContainerVolume.php",
                method: "POST",
                dataType: "JSON",
                data: {"litters": litters, "cid": cid},
                success: function (data) {
                    if (data == 1) {

                        document.getElementById('current_volume').value = parseInt(document.getElementById('current_volume').value) - parseInt(litters);
                        let volume= document.getElementById('current_volume').value;

                        document.getElementById('current_volume').setAttribute( "data-value", volume+"/"+capacity_copy);

                        $('#volume_form_message').fadeIn();
                        document.getElementById("volume_form_message").innerHTML = '<div class="alert alert-success mb-2" role="alert">\n' +
                            '                                                <strong>Done!</strong> Container Volume Reduced sucessfully.\n' +
                            '                                            </div>';

                        $('#volume_form_message').delay(1000).fadeOut();




                    }
                }
            });
        }

    }
    getNavContent();
    getContainer();


</script>
<!-- END PAGE LEVEL JS-->
</body>
</html>
