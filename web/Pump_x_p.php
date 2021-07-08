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

    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css"/>
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





            <li class="nav-item has-sub active open" >
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

            <li class="nav-item has-sub" >  <a href="FuelTypes_p.php">  <i class="ft-droplet"></i> <span id="first_fuel" class="menu-title" data-i18n="" onclick="window.location.href='FuelTypes_p.php'">Fuel Types <i class="nav-link-expand"></i> </span></a>
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
                <h2 class="content-header-title" id="PageTitle" style="color: #f1c40f;">&nbsp;</h2>
            </div>

        </div>







        <div id="collapse231" class="card-accordion">
            <div class="card collapse-icon accordion-icon-rotate">
                <div class="card">
                    <div class="card-header" id="headingC23">
                        <h5 class="mb-0">
                            <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseC221" aria-expanded="false" aria-controls="collapseC221">

                                <h4 class="card-title" id="basic-layout-form">Pump Info</h4>

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

                                                <form class="form" id="pump_form">

                                                    <div class="form-body">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="pump_name">pump Name</label>
                                                                <input type="text" id="pump_name" class="form-control" placeholder="pump Name" name="pump_name" required>
                                                                <span class="-error" id="pump_name_error"></span>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="Container_Name">Container Name</label>
                                                                <select id="Container_Name" name="container_id" class="form-control" required>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>


<!--

                                                    <div class="form-actions">

                                                        <button  class="btn btn-primary" id="edit">
                                                            <i class="ft-edit"></i> Edit
                                                        </button>
                                                        <button type="submit" onclick="updatePump()" class="btn btn-primary" id="saveUpdate" >
                                                            <i class="ft-edit"></i> save
                                                        </button>
                                                    </div> -->

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
        </div>





































        <!-- Chart -->
        <div id="collapse3" class="card-accordion">
            <div class="card collapse-icon accordion-icon-rotate">
                <div class="card">


                    <div class="card-body">
                        <div class="row match-height">
                            <div class="full-width" class="card collapse-icon accordion-icon-rotate">
                                <div class="card">

                                    <div class="card-content collapse show">
                                        <div class="card-body">


                                            <form class="form" id="record_form">
                                                <div class="form-body" >


                                                    <div class="row"  class="full-width">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="newCounter"><b>New Counter</b></label>
                                                                <input type="number" id="newCounter" name="record" class="form-control" required>
                                                            </div>
                                                        </div>

                                                        <br>
                                                        <div class="col-md-6">
                                                            <div class="form-group">

                                                                <label for="previousCounter"><b>Previous Counter</b></label>
                                                                <p id="previousCounter" style="padding-top: 0.5em;"></p>


                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group">

                                                                <label for="last_update"><b>Last Update</b></label>
                                                                <p id="last_update" style="padding-top: 0.5em;"></p>

                                                            </div>
                                                        </div>


                                                    </div>
                                                </div>

                                                <div class="form-actions">

                                                    <button type="submit"  onclick="saveRecord()" class="btn btn-primary">
                                                        <i class="la la-check-square-o"></i> Save
                                                    </button>
                                                </div>
                                            </form>

                                            <div id="message">
                                            </div>

                                        </div>

                                        <div id="Results">

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



        <div class='row match-height' id="HomeBody" >

            <div class="col-md-12">
                <div class="form-group">





                </div>
            </div>
        </div>


        <div id="collapse1" class="card-accordion">
            <div class="card collapse-icon accordion-icon-rotate">
                <div class="card">
                    <div class="card-header" id="headingCOne">
                        <h5 class="mb-0">
                            <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseC1" aria-expanded="false" aria-controls="collapseC1">

                                <h4 class="card-title" id="basic-layout-form">Previous Records</h4>

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

                                                <div class="table-responsive">
                                                    <div id="delete_message"></div>
                                                    <table class="table table-striped"  id="records_table">
                                                        <thead>
                                                        <tr>
                                                            <th>Date</th>
                                                            <th>Counter</th>
                                                            <!-- <th>Container</th> -->
                                                            <th></th>
                                                        </tr>
                                                        </thead>
                                                        <tbody id="tableBody">
                                                        </tbody>
                                                    </table>
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


<script type="text/javascript" src="jquery-3.3.1.js"></script>
<script type="text/javascript" src="jquery.dataTables.min.js"></script>
<script src="sweetalert.min.js"></script>
<script src="sweetalert2@9.js"></script>



<!-- END PAGE LEVEL JS-->
<script>
    let s=window.location.search;
    let urlParams=new URLSearchParams(s);
    let pump_id=urlParams.get('id');
    let peviousCounter=0,maxCounter=0;
    let officalPrice=0;
    let profit=0;
    let pumpsName="|";
    let cid=-1;
    let myname="";
    $("#pump_name").attr("disabled",true);
    $("#Container_Name").attr("disabled",true);


    $("#saveUpdate").hide();

   /* $("#edit").click(function(e) {
        $("#pump_name").attr("disabled",false);
        $("#Container_Name").attr("disabled",false);
        $("#edit").hide();
        $("#saveUpdate").show();
    });*/


    $("#record_form").submit(function(e) {
        e.preventDefault();
    });
    $("#pump_form").submit(function(e) {
        e.preventDefault();
    });
    let table = $('#records_table').DataTable(
        {
            "order": [[ 0, "desc" ]]
        }
    );

    function getNavContent(){
        $.ajax({

            url:"getNavContent.php",
            method:"POST",
            dataType:"JSON",
            success:function(data)
            {
                let name,id;
                if(data["pumps"]){
                    for(let i=0;i<data["pumps"].length;i++){
                        id=data["pumps"][i]["PUMPID"];
                        name=data["pumps"][i]["PUMPNAME"];
                        pumpsName += name + "|";
                        if(id==pump_id){
                            document.getElementById("pumps").innerHTML+=("<li class='active'><a class='menu-item' id='x' href='Pump_x_p.php?id="+id+"&name="+name+"'>"+name+" ("+data["pumps"][i]["fuelName"]+")"+"</a></li>");
                            document.getElementById("PageTitle").innerHTML+=name+"<sup>"+data["pumps"][i]["fuelName"]+"</sup>";
                            document.getElementById("pump_name").value=name;
                            myname=name;
                        }
                        else {
                            document.getElementById("pumps").innerHTML+=("<li><a class='menu-item' href='Pump_x_p.php?id="+id+"&name="+name+"'>"+name+" ("+data["pumps"][i]["fuelName"]+")"+"</a></li>");}


                    }
                }
                if(data["containers"]) {
                    for (let i = 0; i < data["containers"].length; i++) {

                        id = data["containers"][i]["CONTAINER_ID"];
                        name = data["containers"][i]["CONTAINERNAME"];

                        document.getElementById("containers").innerHTML += ("<li><a class='menu-item' href='Container_p.php?id=" + id + "&name=" + name + "'>" + name + "</a></li>");
                        if(cid==id){
                            document.getElementById("Container_Name").innerHTML += ("<option value='" + id + "' selected> " + name + "</option>");
                        }else {
                            document.getElementById("Container_Name").innerHTML += ("<option value='" + id + "' > " + name + "</option>");
                        }
                    }
                }
                if(data["fuel_types"]) {
                    for(let i=0;i<data["fuel_types"].length;i++){

                        id=data["fuel_types"][i]["FUELTYPEID"];
                        name=data["fuel_types"][i]["TYPENAME"];

                        document.getElementById("fuel_types").innerHTML+=("<li><a class='menu-item' href='fuel_type_x_p.php?id="+id+"&name="+name+"'>"+name+"</a></li>");
                        if(i==0){
                            $('#first_fuel').attr("onclick","window.location.href='fuel_type_x_p.php?id=" + id + "&name=" + name + "'");
                        }

                    }
                }

                document.getElementById("fuel_types").innerHTML += ("<li><a class='menu-item' href='FuelTypes_p.php'>Add Type</a></li>");



            }
        });
    }
    function getPageBody() {

        $.ajax({

            url:"pump_x.php",
            method:"POST",
            dataType:"JSON",
            data:{"id":pump_id,"functionId":1},
            success:function(data)
            {

                let record_container;
                cid=data["pump_container"];
                peviousCounter=parseInt(data["PREVIOUS_RECORD"]);
                maxCounter=parseInt(data["maxRecord"]);
                $("#newCounter").attr({"placeholder":parseInt(data["PREVIOUS_RECORD"]),"min":peviousCounter,"max":maxCounter});
                document.getElementById("previousCounter").innerHTML=data["PREVIOUS_RECORD"];
                if(data["RECORD_DATE"]=="2000-01-01 00:00:00"){
                    data["RECORD_DATE"]="Initial Counter";
                }
                document.getElementById("last_update").innerHTML= data["RECORD_DATE"];
                officalPrice=parseInt(data["OfficalPrice"]);
                profit=parseInt(data["Profit"]);

                let rows = table
                    .rows()
                    .remove()
                    .draw();


                let date,counter,prevousRecord=-1,deleteButton="",record_id;
                for(let i=0;i<data["record"].length;i++){
                    date=data["record"][i]["date"];
                    counter=data["record"][i]["value"];
                    //record_container=data["record"][i]["container"];
                    record_id = data["record"][i]["record_id"];

                    if(i!=0 && i==data["record"].length-1) {
                        deleteButton = "<span style='color: darkred'><button style='width: auto;' class='btn btn-danger'  onclick='delete_Record(" + record_id + ")' ><i class='la la-trash-o'></i> </button></span>";
                    }

                    if("2000-01-01 00:00:00"==date){
                        date="<span style='font-size: 0px;'>-2</span>Initial Counter";

                    }

                  //  if(counter!=prevousRecord){
                        table.row.add([
                            date,
                            counter,
                         //   record_container,
                            deleteButton
                        ]).draw( false );
                    //}
                    //prevousRecord = counter;
                }



            }
        });
    }

    function delete_Record(record_Id) {


        Swal.fire({
            title: "<h1><b style='color: #8B0000'> Delete</b></h1>",
            showCancelButton: true,
            confirmButtonText: 'Delete',
            confirmButtonColor: "#8B0000",
            cancelButtonColor: "#DD6B55",
            html:
                '<i class="alert-warning"></i> Are you Sure, You wont to delete this record!!'
            ,

            focusConfirm: true,


            preConfirm: () => {
                $.ajax({

                    url:"pump_x.php",
                    method:"POST",
                    data:{"record_id":record_Id,"functionId":112},//,"recordDate":recordDate },
                    success:function(data)
                    {

                        if(data==1){


                            $('#delete_message').fadeIn();

                            document.getElementById("delete_message").innerHTML ='<div class="alert alert-success mb-2" role="alert">\n' +
                                '<strong>Done!</strong> Record Deleted Successfully.\n' +
                                '</div>';
                            $('#delete_message').delay(1000).fadeOut();


                            getPageBody();


                        }
                    }
                });
            }



        });
    }


    function saveRecord() {
        let record=$("#newCounter").val();

        if($.trim(record).length!=0 && record>=parseInt(peviousCounter) && record<=maxCounter){
            $.ajax({

                url:"pump_x.php",
                method:"POST",
                data:{"pumpId":pump_id,"record":record,"functionId":2},//,"recordDate":recordDate },
                success:function(data)
                {
                    if(data==1){


                        $('#message').fadeIn();

                        document.getElementById("message").innerHTML ='<div class="alert alert-success mb-2" role="alert">\n' +
                            '<strong>Done!</strong> New Record was Successfully added.\n' +
                            '</div>';
                        $('#message').delay(1000).fadeOut();



                        let litters=record-peviousCounter;
                        litters= litters.toFixed(2);
                        document.getElementById("HomeBody").innerHTML='';
                        document.getElementById("HomeBody").innerHTML+=getResultTemplate("Litters",insertSpaces(litters+""));
                        document.getElementById("HomeBody").innerHTML+=getResultTemplate("Sell",insertSpaces((litters*officalPrice).toFixed(0)+""));
                        document.getElementById("HomeBody").innerHTML+=getResultTemplate("Profits",insertSpaces((litters*profit).toFixed(0)+""));
                        getPageBody();


                    }
                }
            });
        }

    }
    function getResultTemplate(text,value) {

        return ' <div class="col-xl-4 col-lg-12">\n' +
            '        <div class="card pull-up ecom-card-1 bg-white">\n' +
            '            <div class="card-content ecom-card2 height-180">\n' +
            '                <h5 class="text-muted warning position-absolute p-1">'+text+'</h5>\n' +
            '                \n' +
            '                <div class="progress-stats-container ct-golden-section height-75 position-relative pt-3">\n' +
            '                    \n' +
            '\t\t\t\t\t\n' +
            '                <h1 class="text-muted warning position-absolute p-1">\n' +
            '\t\t\t\t\t<p  style=" font-size: 40px; text-align: center;">'+value+'</p>\n' +
            '\t\t\t\t</h1>\n' +
            '                </div>\n' +
            '            </div>\n' +
            '        </div>\n' +
            '    </div>';
    }

    //3000000->3 000 000
    function insertSpaces(str) {
        str = str.replace(/ /g, '');

        return str.replace(/\B(?=(\d{3})+(?!\d))/g, " ");

    }
    getPageBody();
    getNavContent();
    /*
    function updatePump() {
        let name=$("#pump_name").val();
        let valid=1;
        if(pumpsName.toLowerCase().includes("|"+name.toLowerCase()+"|") && myname.toLowerCase()!=name.toLowerCase()){ // Check if name is available
            $("#pump_name").focus(function() {
                $(this).next("span").css("display", "inline");
            });
            document.getElementById("pump_name_error").innerHTML="<p style='color: red;'>name not available</p>";
            valid=0;
        }else {
            document.getElementById("pump_name_error").innerHTML='';
        }
        if($.trim(name).length==0){

            $("#pump_name").focus(function() {
                $(this).next("span").css("display", "inline");
            });
            valid=0;
        }

        if(valid==0){ return;}
        $.ajax({
            url:"pump_x.php",
            method:"POST",
            data:$("#pump_form").serialize()+"&functionId=3"+"&pid="+pump_id,
            success:function(data)
            {


                if(data){
                    document.getElementById("x").innerHTML=name;
                    document.getElementById("PageTitle").innerHTML="&nbsp;"+name;
                    document.getElementById("pump_name").value=name;
                    pumpsName.replace("|"+myname+"|","|"+name+"|");
                    myname=name;
                    $('#message2').fadeIn();
                    document.getElementById("message2").innerHTML='<div class="alert alert-success mb-2" role="alert">\n' +
                        '                                                <strong>Done!</strong> Pump Updated Successfully.\n' +
                        '                                            </div>';
                    $('#message2').delay(1000).fadeOut();


                    $("#pump_name").attr("disabled",true);
                    $("#Container_Name").attr("disabled",true);
                    $("#edit").show();
                    $("#saveUpdate").hide();

                    getPageBody();


                }

            }
        });

    }*/

</script>
</body>
</html>
