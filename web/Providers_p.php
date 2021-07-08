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
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css"/>
</head>

<body class="vertical-layout vertical-menu 2-columns   menu-expanded fixed-navbar" data-open="click" data-menu="vertical-menu" data-color="bg-chartbg" data-col="2-columns">
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


            <li class="nav-item active"><a href="Providers_p.php"><i class="la la-users"></i><span class="menu-title" data-i18n="">Providers</span></a>
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
        <div id="collapse1" class="card-accordion">
            <div class="card collapse-icon accordion-icon-rotate">
                <div class="card">

                    <div class="card-header" id="headingCOne">
                        <h5 class="mb-0">
                            <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseC1" aria-expanded="false" aria-controls="collapseC1">

                                <h4 class="card-title" id="basic-layout-form">Add Provider</h4>

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




                                                <form class="form" id="provider_form">
                                                    <div class="form-body">
                                                        <div class="form-group">
                                                            <label for="provider_name">Provider Name</label>
                                                            <input type="text" id="provider_name" class="form-control" placeholder="Provider Name" name="provider_name" required>
                                                            <span class="-error" id="provider_name_error"></span>
                                                        </div>
                                                    </div>
                                                    <div class="form-body">
                                                        <div class="form-group">
                                                            <label for="provider_phone">Provider Phone</label>
                                                            <input type="text" id="provider_phone" class="form-control" placeholder="01000000"  pattern="(01|02|03|04|05|06|07|08|09|70|76|71|81|82)\d{6}" name="provider_phone" required>
                                                            <span class="-error" id="provider_phone_error"></span>
                                                        </div>
                                                    </div>


                                                    <div class="form-actions">

                                                        <button type="submit" onclick="saveProvider()" class="btn btn-primary" id="save" >
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







                <div class="card-header" id="headingC2">
                    <h5 class="mb-0">
                        <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseC21" aria-expanded="false" aria-controls="collapseC21">

                            <h4 class="card-title" id="basic-layout-form">Provider Info</h4>

                        </button>
                    </h5>
                </div>

                <div id="collapseC21" class="collapse show" aria-labelledby="headingC2" style="">
                    <div class="card-body">
                        <div class="row match-height">
                            <div class="col-md-12" class="card collapse-icon accordion-icon-rotate">
                                <div class="card">

                                    <div class="card-content collapse show">
                                        <div class="card-body">


                                            <div class="col-md-12">
                                                <div class="form-group">
                                                    <label for="ProviderName">Provider Name</label>
                                                    <select id="ProviderName" name="ProviderName" class="form-control col-md-6" onchange="getProviderInfo(this)">
                                                    </select><br>
                                                    <div>
                                                        <span id="phone"></span></div>

                                                </div>
                                            </div>

                                            <div class="col-md-12">
                                                <div class="form-group">




                                                </div>
                                            </div>

                                            <form class="form" id="update_provider_form">
                                                <div class="form-body">
                                                    <div class="form-group">
                                                        <label for="update_provider_name">Provider Name</label>
                                                        <input type="text" id="update_provider_name" class="form-control" placeholder="Provider Name" name="update_provider_name" required>
                                                        <span class="-error" id="update_provider_name_error"></span>
                                                    </div>
                                                </div>
                                                <div class="form-body">
                                                    <div class="form-group">
                                                        <label for="update_provider_phone">Provider Phone</label>
                                                        <input type="tel" id="update_provider_phone" class="form-control" placeholder="01000000"  pattern="(01|02|03|04|05|06|07|08|09|70|76|71|81|82)\d{6}" name="update_provider_phone" required>
                                                        <span class="-error" id="update_provider_phone_error"></span>
                                                    </div>
                                                </div>


                                                <div class="form-actions">

                                                    <button  class="btn btn-primary" id="edit">
                                                        <i class="ft-edit"></i> Edit
                                                    </button>
                                                    <button type="submit" onclick="updateProvider()" class="btn btn-primary" id="saveUpdate" >
                                                        <i class="ft-edit"></i> save
                                                    </button>
                                                </div>
                                            </form>
                                            <div class="form-actions" id="message2">

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
        <div class='row match-height' id="PageBody">
        </div>
    </div>
</div>


</div>
</div>
</div>
<footer class="footer footer-static footer-light navbar-border navbar-shadow">
</footer>
<script src="jquery.min.js"></script>
<script src="theme-assets/vendors/js/vendors.min.js" type="text/javascript"></script>
<script src="theme-assets/vendors/js/charts/chartist.min.js" type="text/javascript"></script>
<script src="theme-assets/js/core/app-menu-lite.js" type="text/javascript"></script>
<script src="theme-assets/js/core/app-lite.js" type="text/javascript"></script>
<script src="theme-assets/js/scripts/pages/dashboard-lite.js" type="text/javascript"></script>
<script type="text/javascript" src="jquery-3.3.1.js"></script>
<script type="text/javascript" src="jquery.dataTables.min.js"></script>
<script>


    let providersName="|",phone={},pname={},phones="|";
    let editable=false;

    $("#provider_form").submit(function(e) {
        e.preventDefault();
    });

    $("#update_provider_form").submit(function(e) {
        e.preventDefault();
    });


     $("#update_provider_name").attr("readOnly",true);
     $("#update_provider_phone").attr("readOnly",true);

    $("#saveUpdate").hide();
    $("#edit").hide();
    $("#edit").click(function() {
        if($("#ProviderName").val()!=-1){
        $("#update_provider_name").attr("readOnly",false);
        $("#update_provider_phone").attr("readOnly",false);
            $("#edit").hide();
            $("#saveUpdate").show();
        }
    });


    function getProviderInfo(v) {
        document.getElementById("update_provider_name").value = "";
        document.getElementById("update_provider_phone").value ="";
        document.getElementById("update_provider_name_error").innerHTML = '';
        document.getElementById("update_provider_phone_error").innerHTML = '';

        $("#update_provider_name").attr("readOnly",true);
        $("#update_provider_phone").attr("readOnly",true);
        $("#edit").hide();
        $("#saveUpdate").hide();

        if(v.value!=-1) {
            document.getElementById("update_provider_name").value = pname[v.value + ""];
            document.getElementById("update_provider_phone").value = phone[v.value + ""];
            $("#edit").show();
        }

    }


    function updateProvider() {

        let prName=$("#update_provider_name");
        let ph=$("#update_provider_phone").val();
        let valid=1;
        let pid=$("#ProviderName").val();
        let sameName=false,samePhone=false;
        if(phone[pid+""]==ph){samePhone=true;}
        if(pname[pid+""]==prName.val()){sameName=true;}

        if (samePhone && sameName){
            $('#message2').fadeIn();
            document.getElementById("message2").innerHTML='<div class="alert alert-success mb-2" role="alert">\n' +
                '                                                <strong>Same!</strong>\n' +
                '                                            </div>';

            $('#message2').delay(1000).fadeOut();
            $("#update_provider_name").attr("readOnly",true);
            $("#update_provider_phone").attr("readOnly",true);
            $("#edit").show();
            $("#saveUpdate").hide();
            document.getElementById("update_provider_name_error").innerHTML = '';

            document.getElementById("update_provider_phone_error").innerHTML='';
            return;}
        if (!sameName) {
            if (providersName.toLowerCase().includes("|" + prName.val().toLowerCase() + "|") && pname[pid+""].toLowerCase()!=prName.val().toLowerCase()) {

                prName.focus(function () {
                    $(this).next("span").css("display", "inline");
                });
                document.getElementById("update_provider_name_error").innerHTML = "<p style='color: red;'>name not available</p>";
                valid = 0;
            } else {
                document.getElementById("update_provider_name_error").innerHTML = '';
            }

            if($.trim(prName.val()).length==0){

                prName.focus(function() {
                    $(this).next("span").css("display", "inline");
                });
                valid=0;
            }
        }
        let isnum = /^\d+$/.test(ph);
        if(!samePhone) {
            if (ph.length != 8 || !isnum || (ph.charAt(0)==0 && ph.charAt(1)==0)) {
                document.getElementById("update_provider_phone_error").innerHTML = "<p style='color: red;'>invalid phone</p>";
                valid = 0;
            } else {
                if (phones.includes("|" + ph + "|")) {
                    document.getElementById("update_provider_phone_error").innerHTML = "<p style='color: red;'>phone already exist</p>";
                    valid = 0;
                } else {
                    document.getElementById("update_provider_phone_error").innerHTML = '';
                }
            }
        }
        if(valid==0){ return;}



        $.ajax({

            url:"providers.php",
            method:"POST",
            dataType:"JSON",
            data:($("#update_provider_form").serialize()+"&functionId=1&providerId="+pid),
            success:function(data)
            {

                if(data["done"]){
                    $("#update_provider_name").attr("readOnly",true);
                    $("#update_provider_phone").attr("readOnly",true);
                    $("#edit").show();
                    $("#saveUpdate").hide();

                    $('#message2').fadeIn();
                    document.getElementById("message2").innerHTML='<div class="alert alert-success mb-2" role="alert">\n' +
                        '                                                <strong>Done!</strong> Provider Updated Successfully.\n' +
                        '                                            </div>';
                    $('#message2').delay(1000).fadeOut();
                    let newName = prName.val();
                    let newPhone = ph;
                    providersName=providersName.replace(pname[pid +""]+"|","|"+newName+"|");
                    phones=phones.replace(phone[pid+""]+"|","|"+newPhone+"|");
                    phone[pid+""]=newPhone;
                    pname[pid+""]=newName;
                    document.getElementById("ProviderName").innerHTML ="<option value='-1'>Select Provider</option>";
                    for (let key in pname) {
                        if(key==pid+""){

                            document.getElementById("ProviderName").innerHTML += ("<option value='" + parseInt(key) + "' selected>" + pname[key]+ "</option>");
                        }else {
                            document.getElementById("ProviderName").innerHTML += ("<option value='" + parseInt(key) + "'>" + pname[key] + "</option>");
                        }
                    }

                }

            }
        });
    }

    function getNavContent(){
        $.ajax({

            url:"getNavContent.php",
            method:"POST",
            dataType:"JSON",
            success:function(data)
            {
                let name,id;
                document.getElementById("PageBody").innerHTML='';

                if(data["pumps"]){
                for(let i=0;i<data["pumps"].length;i++){
                    id=data["pumps"][i]["PUMPID"];
                    name=data["pumps"][i]["PUMPNAME"];

                    document.getElementById("pumps").innerHTML+=("<li><a class='menu-item' href='Pump_x_p.php?id="+id+"&name="+name+"'>"+name+" ("+data["pumps"][i]["fuelName"]+")"+"</a></li>");


                }
                }

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

                document.getElementById("ProviderName").innerHTML = '<option value="-1" selected>Select Provider</option>';
                if(data["provider"]) {


                     for (let i = 0; i < data["provider"].length; i++) {
                        id = data["provider"][i]["PROVIDERID"];
                        pname[id+""] = data["provider"][i]["providerName"];
                        phone[id+""] = data["provider"][i]["phone"];
                        providersName += pname[id] + "|";
                        phones += data["provider"][i]["phone"] + "|";
                        document.getElementById("ProviderName").innerHTML += ("<option value='" + id + "'>" + pname[id] + "</option>");

                    }
                }
            }
        });
    }

    function saveProvider() {
        let prName=$("#provider_name");
        let ph=$("#provider_phone").val();
        let valid=1;

        if(providersName.toLowerCase().includes("|"+prName.val().toLowerCase()+"|")){

            prName.focus(function() {$(this).next("span").css("display", "inline");});
            document.getElementById("provider_name_error").innerHTML="<p style='color: red;'>name not available</p>";
            valid=0;
        }else {
            document.getElementById("provider_name_error").innerHTML='';
        }


        let isnum = /^\d+$/.test(ph);
        if(ph.length!=8 || !isnum || (ph.charAt(0)==0 && ph.charAt(1)==0)){
            document.getElementById("provider_phone_error").innerHTML="<p style='color: red;'>invalid phone</p>"; valid=0;
        }else {
            if (phones.includes("|"+ph+"|")) {
                document.getElementById("provider_phone_error").innerHTML = "<p style='color: red;'>phone already exist</p>";
                valid = 0;
            } else {
                document.getElementById("provider_phone_error").innerHTML = '';
            }
        }

        if($.trim(prName.val()).length==0){

            prName.focus(function() {
                $(this).next("span").css("display", "inline");
            });
            valid=0;
        }
        if(valid==0){ return;}
        $.ajax({

            url:"providers.php",
            method:"POST",
            dataType:"JSON",
            data:($("#provider_form").serialize()),
            success:function(data)
            {

                if(data["done"]==1){

                    $('#message').fadeIn();
                    document.getElementById("message").innerHTML='<div class="alert alert-success mb-2" role="alert">\n' +
                        '                                                <strong>Done!</strong> New Provider was Successfully added.\n' +
                        '                                            </div>';

                    $('#message').delay(1000).fadeOut();

                    let pid=data["pid"];
                    phone[pid+""]= $("#provider_phone").val();
                    providersName+=prName.val()+"|";
                    pname[pid+""]=prName.val();
                    phones+="|"+$("#provider_phone").val()+"|";
                    document.getElementById("ProviderName").innerHTML += ("<option value='" + pid + "'>" + prName.val() + "</option>");
                    prName.val('');
                    $("#provider_phone").val('');

                }

            }
        });

    }


    getNavContent();
</script>
<!-- END PAGE LEVEL JS-->
</body>
</html>
