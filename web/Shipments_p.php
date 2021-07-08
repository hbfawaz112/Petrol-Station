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
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css"/>


    <link rel="stylesheet" type="text/css" href="card.css">
    <!-- END Custom CSS-->
</head>
<body  class="vertical-layout vertical-menu 2-columns   menu-expanded fixed-navbar" data-open="click" data-menu="vertical-menu" data-color="bg-chartbg" data-col="2-columns">



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

            <li class="nav-item active"><a href="Shipments_p.php"><i class="la la-truck"></i><span class="menu-title" data-i18n="">Shipments</span></a>
            </li>







            <li class="nav-item"><a href="vouchers_p.php"><i class="la la-cc-mastercard"></i><span class="menu-title" data-i18n="">Vouchers</span></a>
            </li>

            <li class="nav-item"><a href="Customers_p.php"><i class="la la-group"></i><span class="menu-title" data-i18n="">Customers</span></a>
            </li>






            <li class="nav-item has-sub" >  <a href="#">  <i class="ft-droplet"></i> <span class="menu-title" data-i18n="" onclick="window.location.href='FuelTypes_p.php'">Fuel Types <i class="nav-link-expand"></i> </span></a>
                <ul class="menu-content" id="fuel_types">

                </ul>
            </li>
            <li class="nav-item "><a href="Accounting_p.php"><i class="la la-dollar"></i><span class="menu-title" data-i18n="">Accounting</span></a>
            </li>
            <li class="nav-item"><a href="Providers_p.php"><i class="la la-group"></i><span class="menu-title" data-i18n="">Providers</span></a>
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
                <h2 class="content-header-title" id="PageTitle" style="color: #f1c40f;">&nbsp; Shipments</h2>
            </div>

        </div>
        <div id="collapse1" class="card-accordion" >
            <div class="card collapse-icon accordion-icon-rotate">
                <div class="card" >

                    <div class="card-header" id="headingCOne">
                        <h5 class="mb-0">
                            <button class="btn btn-link collapsed"  data-toggle="collapse" data-target="#collapseC1" aria-expanded="false" aria-controls="collapseC1">

                                <h4 class="card-title" id="basic-layout-form" style="color: #3b39b0" >Add Shipment</h4>

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



                                                <form class="form" id="shipmentform">
                                                    <div class="form-body">





                                                        <div class="row">


                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label for="provider">Provider</label>
                                                                    <select id="provider" name="interested" class="form-control" required>

                                                                    </select>

                                                                </div>
                                                            </div>





                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label for="date">Date</label>
                                                                    <input type="date" id="date" class="form-control"  required>
                                                                </div>
                                                            </div>



                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label for="container">Container</label>
                                                                    <select id="container" name="interested" class="form-control" onchange="setVolumemax(this.value)" required>


                                                                    </select>

                                                                </div>
                                                            </div>




                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label for="shipmentfueltype">Fuel Type</label>
                                                                    <select id="shipmentfueltype" name="interested" class="form-control" onchange="getContainer(0)" required>


                                                                    </select>

                                                                </div>
                                                            </div>




                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label for="volume">Volume</label>

                                                                    <input type="number" id="volume" class="form-control"  placeholder="volume"  required>

                                                                </div>
                                                            </div>




                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label for="shipmentvalue">Shipment Value(L.L)</label>
                                                                    <input type="number" id="shipmentvalue" class="form-control"  placeholder="value(L.L)" min="0" required>




                                                                </div>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label for="ispaid">Paid :</label>&nbsp;&nbsp;
                                                                    <input type="radio" name="pay" id="yes" value="1"><span style="color: green" >Yes  &nbsp;&nbsp;
                                                                <input type="radio" name="pay" id="no" value="0" checked="checked"><span style="color: red" >No



                                                                </div>
                                                            </div>




                                                        </div>
                                                        <fieldset class="form-group">
                                                            <textarea class="form-control" id="note" rows="3" placeholder="Note"></textarea>
                                                        </fieldset>
                                                        <button type="submit" class="btn btn-primary"   onclick="addShipments()">
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


                </div></div></div>


        <div id="collapse1" class="card-accordion" >
            <div class="card collapse-icon accordion-icon-rotate">
                <div class="card" >


                    <div class="card-body">
                        <div class="col-md-12">
                            <form class="form" id="selectform">
                                <div class="form-body">



                                    <div class="row">

                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="ProviderName">Provider Name</label>
                                                <select id="ProviderName" name="ProviderName" class="form-control " >
                                                    <option value="-1" selected>Select Provider</option>
                                                </select>
                                            </div></div>




                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="ContainerName">Container Name</label>
                                                <select id="ContainerName" name="Containername" class="form-control " >
                                                    <option value="-1" selected>Select Container</option>
                                                </select>

                                            </div> </div>
                                    </div>
                                    <div class="row">

                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="date1">From Date</label>
                                                <input type="date" id="date1" class="form-control"  >
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="date2">To Date</label>
                                                <input type="date" id="date2" class="form-control" >
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">

                                                <br>
                                                <button type="submit" class="btn btn-primary"  onclick="getPageBody()" >
                                                    <i class="la la-filter"></i> Filter
                                                </button>
                                            </div></div>

                                    </div>



                                </div>
                            </form>

                            <div></span><span id="sum" ></span></div><h4 style="font-weight: bold"><span style='color: red' id="deptla">Dept Money  : <span style='color: red' id="dept" ></span><span style='color: red' id="de">   (L.L) </h4>

                            <div><h4><b>
                                <span style='color: red' >Total Paid  :
                                    <span style='color: red' id="total_paid" ></span>
                                    <span style='color: red;' id="de">   (L.L) </span></b>
                                </span>
                                </h4>



                        </div>
                        <br>


                    </div>

                </div>











                <div class="col-md-12">
                    <div class="form-group">


                        <div class="table-responsive">
                            <table class="table table-striped"  id="shipments_table" >
                                <thead>
                                <tr>
                                    <th scope="col">Date</th>
                                    <th scope="col">Volume</th>
                                    <th scope="col">Container</th>
                                    <th scope="col">Provider</th>
                                    <th scope="col">Value(L.L)</th>
                                    <th scope="col">Notes</th>
                                    <th scope="col">Payment Date</th>
                                    <th scope="col">Delete</th>
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
        <div class='row match-height' id="PageBody">
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
<script type="text/javascript" src="https://cdn.datatables.net/plug-ins/1.10.20/api/sum().js"></script>
<script src="sweetalert.min.js"></script>
<script src="sweetalert2@9.js"></script>



<script>
    // alert(document.getElementById('yes').value);
    let maxi=new Array();
    let findept=0;
    let total_paid=0;
    let s=window.location.search;
    let urlParams=new URLSearchParams(s);
    let container_id1=urlParams.get('id');
    let ft=urlParams.get('ft');

    // let conname=urlParams.get('name2');


    let table = $('#shipments_table').DataTable(   {
        "order": [[ 0, "desc" ]]
    }),providersName="|",phone=new Array(),phones="|";

    function insertSpaces(str) {
        str = str.replace(/ /g, '');

        return str.replace(/\B(?=(\d{3})+(?!\d))/g, " ");

    }


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
                    document.getElementById("ContainerName").innerHTML = '<option value="-1" selected>Select Container</option>';


                    for(let i=0;i<data["containers"].length;i++) {
                        id = data["containers"][i]["CONTAINER_ID"];
                        name = data["containers"][i]["CONTAINERNAME"];
                        document.getElementById("containers").innerHTML += ("<li><a class='menu-item' href='Container_p.php?id=" + id + "&name=" + name + "'>" + name + "</a></li>");
                        if (id == container_id1) {
                            $("#collapseC1").attr({"class":"collapse show"});
                            maxi[id]=data["containers"][i]["Max"];
                            document.getElementById('container').innerHTML += ("<option value=" + id + " selected>" + name + "</option>");
                            $("#volume").attr({"placeholder":'max :'+ maxi[id],"max":maxi[id]});
                        }
                        document.getElementById('ContainerName').innerHTML += ("<option value=" + id + ">" + name + "</option>");
                    }
                }
                if(data["pumps"]) {
                    for (let i = 0; i < data["pumps"].length; i++) {
                        id = data["pumps"][i]["PUMPID"];
                        name = data["pumps"][i]["PUMPNAME"];

                        document.getElementById("pumps").innerHTML+=("<li><a class='menu-item' href='Pump_x_p.php?id="+id+"&name="+name+"'>"+name+" ("+data["pumps"][i]["fuelName"]+")"+"</a></li>");

                    }
                }

                if(data["provider"]) {

                    // document.getElementById("ProviderName").innerHTML = '<option value="-1" selected>Select Provider</option>';

                    for (let i = 0; i < data["provider"].length; i++) {
                        id = data["provider"][i]["PROVIDERID"];
                        name = data["provider"][i]["providerName"];
                        phone[id] = data["provider"][i]["phone"];
                        providersName += name + "|";
                        phones += data["provider"][i]["phone"] + "|";
                        document.getElementById("ProviderName").innerHTML += ("<option value='" + id + "'>" + name + "</option>");
                        document.getElementById('provider').innerHTML+=("<option value="+ id +">"+name+"</option>");
                    }
                }
                if(data["fuel_types"]) {
                    document.getElementById('shipmentfueltype').innerHTML = '';
                    for (let i = 0; i < data["fuel_types"].length; i++) {

                        id = data["fuel_types"][i]["FUELTYPEID"];
                        name = data["fuel_types"][i]["TYPENAME"];

                        document.getElementById("fuel_types").innerHTML += ("<li><a class='menu-item' href='fuel_type_x_p.php?id=" + id + "&name=" + name + "'>" + name + "</a></li>");

                        if (name == ft) {
                            document.getElementById('shipmentfueltype').innerHTML += ("<option value=" + id + " selected>" + name + "</option>");
                            m = 1;
                        } else {
                            document.getElementById('shipmentfueltype').innerHTML += ("<option value=" + id + ">" + name + "</option>");


                        }


                    }
                }

                if (m == 0) {
                    getContainer(0);
                }
                getDate();





            }
        });

    }

    $("#shipmentform").submit(function(e) {
        e.preventDefault();
    });
    $("#selectform").submit(function(e) {
        e.preventDefault();
    });
    function addShipments() {
        let valid=1;
        let rad=0;
        var today = new Date();
        let provider=$("#provider").val();
        let volume=$("#volume").val();
        if (document.getElementById('yes').checked) {
            rad = document.getElementById('yes').value;
        }

        if(volume<=0 || volume==null) {
            document.getElementById("volume_error").innerHTML = "<p style='color: red;'>Volume not valid</p>";
            return;
        }

        let fueltype=$("#shipmentfueltype").val();
        let container=$("#container").val();
        let date=$("#date").val();
        let note=$("#note").val();
        let shipvalue=$("#shipmentvalue").val();
        if(shipvalue<0 || shipvalue==null) {
            return;
        }

        // alert(rad)

        if(volume>maxi[container]){
            return;
        }
        $.ajax({



            url:"shipments.php",
            method:"POST",
            data:{"provider":provider,"volume":volume,"fueltype":fueltype,"container":container,"date":date,"note":note,"shipvalue":shipvalue,"radio":rad},
            success:function(data)
            {



                if(data==1) {
                    document.getElementById("volume").value='';
                    document.getElementById("shipmentvalue").value='';
                    getDate();
                    getContainer(1);
                    getPageBody();


                    $('#message').fadeIn();
                    document.getElementById("message").innerHTML = '<div class="alert alert-success mb-2" role="alert">\n' +
                        '                                                <strong>Done!</strong> Shipment was Successfully added.\n' +
                        '                                            </div>';

                    $('#message').delay(1000).fadeOut();
                    document.getElementById("volume_error").innerHTML ='';




                }


            }
        });
    }
    function getContainer(v) {

        let id,name;
        //
        // document.getElementById("container").innerHTML+='<option value="-1" selected>containers</option>';
        let fueltype=$("#shipmentfueltype").val();

        $.ajax({



            url:"getContainers.php",
            method:"POST",
            data:{"fueltype":fueltype},
            dataType: "JSON",
            success:function(data)
            {

                if(data==1)
                {document.getElementById('container').options.length = 0;
                    setVolumemax(-1);
                    return;}


                let i=0;
                for(i=0;i<data["containers"].length;i++){

                    id=data["containers"][i]["CONTAINER_ID"];

                    name=data["containers"][i]["CONTAINERNAME"];

                    maxi[id]=data["containers"][i]["Max"];

                    if(v==0)
                    {
                        if(i==0) {
                            document.getElementById('container').options.length = 0;
                        }
                        document.getElementById('container').innerHTML+=("<option value="+ id +">"+name+"</option>");
                    }

                }

                setVolumemax($("#container").val());

            }
        });



    }

    function getDate() {

        var today = new Date();

        document.getElementById("date").value = today.getFullYear() + '-' + ('0' + (today.getMonth() + 1)).slice(-2) + '-' + ('0' + today.getDate()).slice(-2);
    }
    function setVolumemax(v) {
        if(v==-1) {

            $("#volume").attr({"placeholder": 'max :' + 'unavailable', "max": 0});
            document.getElementById("volume").disabled = true;
        }
        else {

            let max = maxi[v];
            $("#volume").attr({"placeholder": 'max :' + max, "max": max ,"min":1});
            if(max==0)
            {
                document.getElementById("volume").disabled = true;
                return;
            }
            document.getElementById("volume").disabled = false;

        }

    }
    function getPageBody() {
        document.getElementById("sum").innerHTML='';
        document.getElementById("dept").innerHTML='0';
        document.getElementById("total_paid").innerHTML='0';

        // document.getElementById("deptla").innerHTML='';

        let p= $("#ProviderName").val();
        let c=$("#ContainerName").val();
        let d1=$("#date1").val();
        let d2=$("#date2").val();

        //let d2=new Date(d22);
        //  d2.setHours(d2.getHours()+12);





        //alert(d1)
        //alert(p+""+c);
        let rows = table
            .rows()
            .remove()
            .draw();

        $.ajax({

            url:"shipments.php",
            method:"POST",
            dataType:"JSON",
            data:{"shipments":1,"providerId":p,"containerId":c,"date1":d1,"date2":d2},
            success:function(data)
            {
                let date,type,container,volume,provider,comments,shipid,ispaid,buttonshape,pdate,shipmvalue,dept,bdelete;
                dept=data["mydept"]["dept"];
                for(let i=0;i<data["shipments"].length;i++){
                    date=data["shipments"][i]["date"];
                    type=data["shipments"][i]["type"];
                    container=data["shipments"][i]["Container"];
                    volume=data["shipments"][i]["Volume"];
                    comments=data["shipments"][i]["COMMENTS"];
                    provider=data["shipments"][i]["provider"];
                    shipid=data["shipments"][i]["shipmentid"];
                    ispaid=data["shipments"][i]["ispaid"];
                    pdate=data["shipments"][i]["pdate"];
                    shipmvalue=data["shipments"][i]["value"];
                    bdelete="<button type='submit' class='btn btn-icon btn-danger mr-1'   onclick='deleteshipment("+shipid+")'  id="+shipid+"><i class='la la-trash'></i></button>";


                    if(ispaid ==0)
                        buttonshape="<span style='color: green' id="+shipid+" ><button type='submit' class='btn btn-success  btn-min-width mr-1 mb-1'  onclick='getprp("+shipid+")' >Pay</button></span>";
                    else
                        buttonshape="<span style='color: green' >"+pdate;


                    table.row.add( [
                        date,
                        volume,
                        container,
                        provider,
                        insertSpaces(shipmvalue+""),
                        comments,
                        buttonshape,
                        bdelete
                    ] ).draw( false );



                }

                document.getElementById('sum').innerHTML=" <h4 style='color: blue ;font-weight: bold'>  Total Volume : "+insertSpaces(table.column( 1 ).data().sum()+"")+"  Litters</h4>";
                // document.getElementById('deptla').innerHTML="Dept money : ";
                findept=dept;
                total_paid = data["total_Paid"];
                document.getElementById('dept').innerHTML=insertSpaces(dept+"");

                document.getElementById("total_paid").innerHTML=insertSpaces(total_paid+"");

            }

        });


    }
    function getprp(shipid) {

        //getDate();
        var today = new Date();
        var d= today.getFullYear() + '-' + ('0' + (today.getMonth() + 1)).slice(-2) + '-' + ('0' + today.getDate()).slice(-2);




        Swal.fire({
            title: "<h1><b style='color: #00aec5'> Pay</b></h1>",
            showCancelButton: true,
            confirmButtonText: 'Confirm',
            confirmButtonColor: "#00aec5",
            cancelButtonColor: "#DD6B55",
            html:
                '<form class="form" id="updatename"><div class="form-group"><div class="form-body">' +
                ' <label for="datep">Payment Date</label>\n' +
                ' <input type="date" id="datep" class="form-control"  required value='+d+'><br>' +
                ' </div>\n' +
                ' </div></form>'
            ,

            focusConfirm: true,


            preConfirm: () => {
                let paydate = document.getElementById('datep').value;

                $.ajax({

                    url: "shipments.php",
                    method: "POST",
                    dataType:"JSON",
                    data: {"pay": 1,"shipid":shipid,"paydate":paydate},
                    success: function (data) {
                        let date2,shipmentvalue;
                        date2=data["my"]["date"];
                        shipmentvalue=data["my"]["value"];

                        document.getElementById(shipid).innerHTML=date2;
                        var oldvalue = findept;
                        var newvalue = parseInt(oldvalue,10) - parseInt(shipmentvalue,10);
                        findept=newvalue;

                        let prevous_paid = total_paid;
                        let new_paid = parseInt(prevous_paid,10) + parseInt(shipmentvalue,10);
                        total_paid=new_paid;

                        document.getElementById("dept").innerText=insertSpaces(newvalue+"");

                        document.getElementById("total_paid").innerText=insertSpaces(total_paid+"");





                    }
                });

            }



        });
    }
    function deleteshipment(shipid) {



        Swal.fire({
            title: "<h1><b style='color :red'> Delete</b></h1>",
            showCancelButton: true,
            type: "warning",
            confirmButtonText: 'Delete',
            confirmButtonColor: "red",
            cancelButtonColor: "orangered",
            html:
                '<form class="form" ><div class="form-group"><div class="form-body">' +
                ' <label for="datep">Are you sure,you want to delete this shipment?</label>\n' +
                ' </div>\n' +
                ' </div></form>'
            ,


            focusConfirm: true,


            preConfirm: () => {


                $.ajax({

                    url: "shipments.php",
                    method: "POST",
                    dataType:"JSON",
                    data: {"delete": 1,"dshipid":shipid},
                    success: function (data) {
                        let done=data["done"];
                        if(done ==1)
                        {
                            getPageBody();
                        }



                    }
                });

            }



        });
    }



    getNavContent();
    getPageBody();






</script>
<!-- END PAGE LEVEL JS-->
</body>
</html>
