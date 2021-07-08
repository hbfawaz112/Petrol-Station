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
            <li class="nav-item active"><a href="Accounting_p.php"><i class="la la-dollar"></i><span class="menu-title" data-i18n="">Accounting</span></a>
            </li>

            <li class="nav-item"><a href="Providers_p.php"><i class="la la-users"></i><span class="menu-title" data-i18n="">Providers</span></a>
            </li>
            <li class="nav-item has-sub ">

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

            <!--
            <div class="card">
                <div class="card-body">
                    <div class="row match-height">
                        <div style="width: 85%;" class="card collapse-icon accordion-icon-rotate">
                            <div class="card">

                                <div class="card-content collapse show">
                                    <div class="card-body">

                                        <div id="chartContainer" class="height-350" style="max-width: 100%;max-height: 100%;display: block">
                                        </div>

                                    </div>
                                </div>  </div>
                        </div>
                    </div>
                </div>
            </div>
            <br><BR><BR>  -->



            <div class="row match-height">
                <div class="full-width">
                    <div class="">
                        <div class="card">


                            <div class="card-body">
                                <div class="row match-height">
                                    <div class="full-width" class="card collapse-icon accordion-icon-rotate">
                                        <div class="card">

                                            <div class="card-content collapse show">
                                                <div class="card-body">


                                                    <form class="form" id="formS" onsubmit="getResults(0)">
                                                        <div class="form-body" >


                                                            <div class="row"  class="col-auto">


                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <label for="FuelTypes">Fuel Type</label>
                                                                        <select id="FuelTypes" name="fid" class="form-control" required>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6"></div>
                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <label for="minDate">From</label>
                                                                        <input type="date" id="minDate" name="mnd" class="form-control" onchange="setMinforMaxDate(this)" required>
                                                                    </div>
                                                                </div>

                                                                <br>
                                                                <div class="col-md-6">
                                                                    <div class="form-group">

                                                                        <label for="maxDate">To</label>

                                                                        <input type="date" id="maxDate" name="mxd" class="form-control" onchange="setMaxforMinDate(this)" required>


                                                                    </div>
                                                                </div>




                                                            </div>
                                                        </div>

                                                        <div class="form-actions">


                                                            <button type="submit"   class="btn">
                                                                Submit
                                                            </button>
                                                            <button onclick="getResults(1)" class="btn">
                                                                Today
                                                            </button>

                                                            <button  class="btn" onclick="getLastRecordsInfo()" form="owner" style="margin-top: 2px;">
                                                                Last Records
                                                            </button>
                                                            <button  class="btn" onclick="exportData()" form="owner" style="margin-top: 2px;">
                                                                Export
                                                            </button>

                                                        </div>
                                                    </form>
                                                    <div id="message">
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
            <div class='full-width' id="HomeBody" >



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

<script src="jquery.min.js"></script>

<script>


    $("#formS").submit(function(e) {
        e.preventDefault();
    });
    function getNavContent(){
        $.ajax({

            url:"getNavContent.php",
            method:"POST",
            data:{"AccountingPage":1},
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

                document.getElementById('FuelTypes').innerHTML=("<option value=-1>NO FUEL TYPE</option>");
                if(data["fuel_types"]) {

                    document.getElementById('FuelTypes').innerHTML=("<option value='-2' selected>All FUEL TYPES</option>");
                    for (let i = 0; i < data["fuel_types"].length; i++) {
                        id = data["fuel_types"][i]["FUELTYPEID"];
                        name = data["fuel_types"][i]["TYPENAME"];
                        document.getElementById("fuel_types").innerHTML += ("<li><a class='menu-item' href='fuel_type_x_p.php?id=" + id + "&name=" + name + "'>" + name + "</a></li>");
                        document.getElementById('FuelTypes').innerHTML+=("<option value="+ id +">"+name+"</option>");

                        if(i==0){
                            $('#first_fuel').attr("onclick","window.location.href='fuel_type_x_p.php?id=" + id + "&name=" + name + "'");
                        }

                    }
                }

                document.getElementById("fuel_types").innerHTML += ("<li><a class='menu-item' href='FuelTypes_p.php'>Add Type</a></li>");

                let today = new Date().toISOString().split("T")[0];
                $("#maxDate").val(today);

                $("#maxDate").attr("max",today);
                $("#minDate").attr("max",today);

                if(data["minDate"]){
                    $("#minDate").attr("min",data["minDate"]);
                    $("#maxDate").attr("min",data["minDate"]);
                    $("#minDate").val(data["minDate"]);

                }

            }
        });
    }






    function getLastRecordsInfo() {

        $.ajax({
            type: "GET",
            url: "Accounting.php?last_records=12",
            dataType: 'JSON',
            success: function (data) {

                getTotal(data);
            }
        });

    }





















    function getResults(isToday) {

        if(isToday){

            let today = new Date().toISOString().split("T")[0];
            $("#maxDate").val(today);
            $("#minDate").val(today);
            $("#minDate").attr("max",today);

        }
        let xhtml = new XMLHttpRequest();
        let url = "Accounting.php?"+$("#formS").serialize();

        xhtml.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {

                let myArr = JSON.parse(this.responseText);


                getResultTemplate(myArr);
            }
        };
        xhtml.open("GET", url, true);
        xhtml.send();

    }

    function exportData() {

        let url2 = "Accounting.php?"+$("#formS").serialize()+"&function_Id=3";


        let fuelList = document.getElementById("FuelTypes");
        let selectedFuel = fuelList.options[fuelList.selectedIndex].text;

        $.ajax({
            type: "GET",
            url: url2,
            dataType: 'JSON',
            success: function (json) {

                let csv = ConvertToCSV(json);

                downloadFile(selectedFuel+'.csv', csv);
            }
        });



    }



    function ConvertToCSV(objArray) {
        let rows = typeof objArray !== "object" ? JSON.parse(objArray) : objArray;
        let str = "";
        rows.forEach(row => {
            let line = "";
            let columns =
                typeof row !== "object" ? JSON.parse(row) : Object.values(row);
            columns.forEach(column => {
                if (line !== "") {
                    line += ",";
                }
                if (typeof column === "object") {
                    line += JSON.stringify(column);
                }  else {
                    line += column;
                }
            });
            str += line + "\r\n";
        });
        return str;
    }




    function downloadFile(fileName, csv) {

        if (navigator.userAgent.indexOf('MSIE') !== -1
            || navigator.appVersion.indexOf('Trident/') > 0) {
            var IEwindow = window.open("", "", "Width=0px; Height=0px");
            IEwindow.document.write('sep=,\r\n' + csv);
            IEwindow.document.close();
            IEwindow.document.execCommand('SaveAs', true, fileName);
            IEwindow.close();
        }
        else {
            var aLink = document.createElement('a');
            var evt = document.createEvent("MouseEvents");
            evt.initMouseEvent("click", true, true, window,
                0, 0, 0, 0, 0, false, false, false, false, 0, null);
            aLink.download = fileName;
            aLink.href = 'data:text/csv;charset=UTF-8,' + encodeURIComponent(csv);
            aLink.dispatchEvent(evt);
        }
    }





    function getTotal(Results) {


        document.getElementById("HomeBody").innerHTML = "";
        document.getElementById("HomeBody").innerHTML += "<br>" +
            "" +
            "<fieldset style='border: solid; border-width: medium;border-color: #f1c40f;border-block-width: medium; '>" +
            "    <legend style='width:auto; margin-bottom: 0px; font-size: 30px; font-weight: bold; color: #1f497d;'>TOTAL</legend><div>"
            +//  getResultInnerTemplate("Litters", insertSpaces(Results["total"]["litters"]+"L"))+
            getResultInnerTemplate("Bill", insertSpaces(Results["total"]["Bill"] + "L.L."))
            + getResultInnerTemplate("Profits", insertSpaces(Results["total"]["Profit"] + "L.L.")) +
            "</div></fieldset>";

    }





    function getResultTemplate(Results) {


        document.getElementById("HomeBody").innerHTML="";
        if(Results["fuel_types"].length>1){

            document.getElementById("HomeBody").innerHTML +="<br>" +
                "" +
                "<fieldset style='border: solid; border-width: medium;border-color: #f1c40f;border-block-width: medium; '>" +
                "    <legend style='width:auto; margin-bottom: 0px; font-size: 30px; font-weight: bold; color: #1f497d;'>TOTAL</legend><div>"
                +//  getResultInnerTemplate("Litters", insertSpaces(Results["total"]["litters"]+"L"))+
                getResultInnerTemplate("Bill",insertSpaces(Results["total"]["Bill"]+"L.L."))
                +  getResultInnerTemplate("Profits", insertSpaces(Results["total"]["Profit"]+"L.L."))+
                "</div></fieldset>";

        }

        for (let i = 0; i<Results["fuel_types"].length; i++) {
            document.getElementById("HomeBody").innerHTML +="<br>" +
                "" +
                "<fieldset style='border: solid; border-width: medium;border-color: #f1c40f;border-block-width: medium; '>" +
                "    <legend style='width:auto; margin-bottom: 0px; font-size: 30px; font-weight: bold; color: #1f497d;'>"+Results["fuel_types"][i]["TYPENAME"]+"</legend><div>"

                +  getResultInnerTemplate("Litters", insertSpaces(Results["fuel_types"][i]["litters"]+"")+"L")+
                getResultInnerTemplate("Bill",insertSpaces(Results["fuel_types"][i]["Bill"]+"")+"L.L.")
                +  getResultInnerTemplate("Profits", insertSpaces(Results["fuel_types"][i]["Profit"]+"")+"L.L.")+
                "</div></fieldset>";

        }


    }


    function getResultInnerTemplate(text,value) {

        return ' <div class="full-width">' +
            '        <div class="card pull-up ecom-card-1 bg-white">' +
            '            <div class="card-content ecom-card2 height-100">' +
            '                <h5 class="text-muted warning position-absolute p-1">'+text+'</h5>' +
            '                ' +
            '                <div class="progress-stats-container ct-golden-section height-75 position-relative pt-3">'
            +'                <h1 class="text-muted warning position-absolute p-1">' +
            '<p  style=" font-size: 30px; text-align: center;">'+value+'</p>' +
            '                </h1>' +
            '                </div>' +
            '            </div>' +
            '        </div>' +
            '    </div>';
    }


    //3000000->3 000 000
    function insertSpaces(str) {
        str = str.replace(/ /g, '');

        return str.replace(/\B(?=(\d{3})+(?!\d))/g, " ");

    }

    function setMinforMaxDate(v) {

        $("#maxDate").attr("min",v.value);

    }

    function setMaxforMinDate(v) {
        $("#minDate").attr("max",v.value);

    }

    getNavContent();








    ////////////////

/*
    function addData(data) {
        let dataPoints1 = [];
        for (let j=1;j<data[0].length-1;j++) {
            dataPoints1[j-1] = [];
        }
        for (let i = 1; i < data.length; i++) {

            for (let j=1;j<data[0].length-1;j++){
                dataPoints1[j-1].push({
                    x: new Date(data[i][0]),
                    y: data[i][j]
                });

            }
        }

        let d = [];
        for (let i = 1; i < data[0].length-1; i++) {
            d[i-1]={};
            d[i-1].name = data[0][i]+"";
            d[i-1].type ="spline";
            d[i-1].yValueFormatString = "#0.## l";
            d[i-1].showInLegend = true;
            d[i-1].dataPoints = dataPoints1[i - 1];

        }


        var chart = new CanvasJS.Chart("chartContainer", {
            animationEnabled: true,
            title:{
                text: "Daily Sold Litters "
            },
            axisX: {
                valueFormatString: "DD MMM,YY"
            },
            axisY: {
                title: "Litters",
                includeZero: false,
                suffix: " l"
            },
            legend:{
                cursor: "pointer",
                fontSize: 16,
                itemclick: toggleDataSeries
            },
            toolTip:{
                shared: false
            },
            data:d
        });
        chart.render();

        function toggleDataSeries(e){
            if (typeof(e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
                e.dataSeries.visible = false;
            }
            else{
                e.dataSeries.visible = true;
            }
            chart.render();
        }


    }
    $.getJSON("graphData.php", addData);
*/
    /////////////



</script>
<!--<script src="jquery.canvasjs.min.js"></script>-->
</body>
</html>
