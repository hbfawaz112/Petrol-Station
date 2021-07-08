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

<!-- ////////////////////////////////NAVIGATION START////////////////////////////////////////////-->

<!-- fixed-top-->


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



            <li class="nav-item"><a href="vouchers_p.php"><i class="la la-cc-mastercard"></i><span class="menu-title" data-i18n="">Vouchers</span></a>
            </li>

            <li class="nav-item active"><a href="Customers_p.php"><i class="la la-group"></i><span class="menu-title" data-i18n="">Customers</span></a>
            </li>


            <li class="nav-item has-sub" >  <a href="#">  <i class="ft-droplet"></i> <span class="menu-title" data-i18n="" id="first_fuel"">Fuel Types <i class="nav-link-expand"></i> </span></a>
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
<div class="app-content content" >
    <div class="content-wrapper" >
        <div id="collapse1" class="card-accordion">
            <div class="card collapse-icon accordion-icon-rotate">
                <div class="card">

                    <div class="card-header" id="headingCOne">
                        <h5 class="mb-0">
                            <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseC1" aria-expanded="false" aria-controls="collapseC1">

                                <h4 class="card-title" id="basic-layout-form">Add Customer</h4>

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




                                                <form class="form" id="customer_form">
                                                    <div class="form-body">
                                                        <div class="form-group">
                                                            <label for="customer_name">Name</label>
                                                            <input type="text" id="customer_name" class="form-control" placeholder="Customer Name" name="customer_name" required>
                                                            <span class="-error" id="customer_name_error"></span>
                                                        </div>
                                                    </div>
                                                    <div class="form-body">
                                                        <div class="form-group">
                                                            <label for="customer_phone">Phone</label>
                                                            <input type="text" id="customer_phone" class="form-control" placeholder="01000000"  pattern="(01|02|03|04|05|06|07|08|09|70|76|71|81|82)\d{6}" name="customer_phone" required>
                                                            <span class="-error" id="customer_phone_error"></span>
                                                        </div>
                                                    </div>
                                                    <div class="form-body">
                                                        <div class="form-group">
                                                            <label for="customer_email">Email</label>
                                                            <input type="text" id="customer_email" class="form-control" placeholder="someone@example.com"  pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$" name="customer_email" >
                                                            <span class="-error" id="customer_email_error"></span>
                                                        </div>
                                                    </div>


                                                    <div class="form-actions">

                                                        <button type="submit" onclick="saveCustomer()" class="btn btn-primary" id="save" >
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

                            <h4 class="card-title" id="basic-layout-form">Customer Info</h4>

                        </button>
                    </h5>
                </div>

                <div id="collapseC21" class="collapse" aria-labelledby="headingC2" style="">
                    <div class="card-body">
                        <div class="row match-height">
                            <div class="col-md-12" class="card collapse-icon accordion-icon-rotate">
                                <div class="card">

                                    <div class="card-content collapse show">
                                        <div class="card-body">

                                            <form class="form" id="customer_list_form">



                                                <div class="col-md-12">

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="CustomerName">Customer</label>
                                                            <select style="max-width:90%;" id="CustomerName" name="CustomerName" class="form-control col-md-6"  onchange="getCustomerInfo(this)">
                                                            </select>
                                                            <span class="-error" id="select_customer_name_error"></span>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-12">
                                                        <p id="moneyToPay" name="moneyToPay" style="font-size:25px;"></p>
                                                    </div>

                                                    <div class="col-md-12">

                                                        <div class="row">


                                                            <div class="form-group"><br>
                                                                <button type="submit" onclick="viewCustomerInfo()" class="btn btn-primary" id="view"  >
                                                                    <i class="ft-info"></i> View
                                                                </button>
                                                            </div>

                                                            <div class="form-group"><br>
                                                                <button type="submit" onclick="editCustomerInfo()" class="btn btn-primary" id="edit" >
                                                                    <i class="ft-edit"></i> Edit
                                                                </button>
                                                            </div>


                                                            <div class="form-group"><br>
                                                                <button type="submit" onclick="payOff()" class="btn btn-primary" id="pay" >
                                                                    <i class="ft-credit-card"></i> Pay Off
                                                                </button>
                                                            </div>
                                                        </div>
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
                                                                <button type="submit" class="btn btn-primary"  onclick="dateChanged()" >
                                                                    <i class="la la-filter"></i> Filter
                                                                </button>
                                                            </div></div>

                                                    </div>






                                                </div>
                                                <div class="form-actions" id="message2">

                                                </div>

                                                <div class="card-header" id="headingC3">
                                                    <h5 class="mb-0">
                                                        <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseC31" aria-expanded="false" aria-controls="collapseC31">

                                                            <h4 class="card-title" id="transactionsCollapse">Transactions</h4>

                                                        </button>
                                                    </h5>
                                                </div>

                                                <div id="collapseC31" class="collapse" aria-labelledby="headingC3" style="">
                                                    <div class="card-body">
                                                        <div class="row match-height">
                                                            <div class="col-md-12" class="card collapse-icon accordion-icon-rotate">
                                                                <div class="card">

                                                                    <div class="card-content collapse show">
                                                                        <div class="card-body">

                                                                            <div class="table-responsive">
                                                                                <div><div>
                                                                                        <table class="table table-striped"  id="transactions_table" >
                                                                                            <thead>
                                                                                            <tr>
                                                                                                <th scope="col">Value</th>
                                                                                                <th scope="col">Date</th>
                                                                                                <th scope="col">Delete</th>

                                                                                            </tr>
                                                                                            </thead>
                                                                                            <tbody id="transactionsTableBody">
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


                                                <div class="card-header" id="headingC4">
                                                    <h5 class="mb-0">
                                                        <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseC41" aria-expanded="false" aria-controls="collapseC41">

                                                            <h4 class="card-title" id="vouchersCollapse">Vouchers</h4>

                                                        </button>
                                                    </h5>
                                                </div>

                                                <div id="collapseC41" class="collapse" aria-labelledby="headingC4" style="">
                                                    <div class="card-body">
                                                        <div class="row match-height">
                                                            <div class="col-md-12" class="card collapse-icon accordion-icon-rotate">
                                                                <div class="card">

                                                                    <div class="card-content collapse show">
                                                                        <div class="card-body">

                                                                            <div class="table-responsive">
                                                                                <div><div>
                                                                                        <table class="table table-striped"  id="vouchers_table" >
                                                                                            <thead>
                                                                                            <tr>
                                                                                                <th scope="col">Fuel Type</th>
                                                                                                <th scope="col">Voucher Value</th>
                                                                                                <th scope="col">Voucher Date</th>
                                                                                                <th scope="col">Note</th>
                                                                                                <th scope="col">Delete</th>

                                                                                            </tr>
                                                                                            </thead>
                                                                                            <tbody id="vouchersTableBody">
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
<script src="sweetalert.min.js"></script>
<script src="sweetalert2@9.js"></script>
<script>
	function insertSpaces(str) {
       str = str.replace(/ /g, '');

       return str.replace(/\B(?=(\d{3})+(?!\d))/g, " ");

   }

    let transactionTab = $('#transactions_table').DataTable(   {
        "order": [[ 1, "desc" ]]
    });
    let voucherTab = $('#vouchers_table').DataTable(   {
        "order": [[ 2, "desc" ]]
    });

    let toPayInfo = $('#moneyToPay');
    let transactionValues = 0;
    let VoucherValues = 0;
    let toPay = 0;
    let totalDebt = 0;
    let customerName , customerEmail , customerPhone , customerID;


    $('#pay').hide();
    $('#edit').hide();
    $('#view').hide();


    $("#customer_form").submit(function(e) {
        e.preventDefault();
    });
    $("#customer_list_form").submit(function(e) {
        e.preventDefault();
    });

    let customersName="|",phone={},cname={},phones="|";



		    
    function viewCustomerInfo()
    {
        Swal.fire({
            title: "<h1><b style='color: #00aec5'>Customer Information</b></h1>",
            showCancelButton: true,
            showConfirmButton: false,
            cancelButtonText: 'OK',
            cancelButtonColor: "#DD6B55",
            keepOpened: true,
            html:
                '<form class="form" id="updateCustomerInfos">' +
                '<div class="form-body">\n' +
                '    <div class="form-group">\n' +
                '         <label for="newName">Name</label>\n' +
                '         <input type="text" value="'+customerName+'" id="newName" class="form-control" placeholder="Customer Name" name="newName" readonly required>\n' +
                '         <span class="-error" id="newNameError"></span>\n' +
                '    </div>\n' +
                '</div>\n' +
                '<div class="form-body">\n' +
                '     <div class="form-group">\n' +
                '          <label for="newPhone">Phone</label>\n' +
                '          <input type="text" value="'+customerPhone+'" id="newPhone" class="form-control" placeholder="01000000"  pattern="(01|02|03|04|05|06|07|08|09|70|76|71|81|82)\\d{6}" name="newPhone" readonly required>\n' +
                '          <span class="-error" id="newPhoneError"></span>\n' +
                '     </div>\n' +
                '</div>\n' +
                '<div class="form-body">\n' +
                '     <div class="form-group">\n' +
                '          <label for="newEmail">Email</label>\n' +
                '          <input type="text" value="'+customerEmail+'" id="newEmail" class="form-control" placeholder="someone@example.com"  pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,4}$" name="newEmail" readonly>\n' +
                '          <span class="-error" id="newEmailError"></span>\n' +
                '     </div>\n' +
                '</div>'+
                '</form>'


            ,

            focusConfirm: true


        });
    }



    function payOff()
    {
        let currentCustomerID = document.getElementById('CustomerName').value;
        if(currentCustomerID == -1)
        {
            document.getElementById("select_customer_name_error").innerHTML="<p style='color: red;'>invalid customer name</p>";
            return;
        }

        else if(toPay == 0)
        {
            document.getElementById("select_customer_name_error").innerHTML="<p style='color: red;'>This Customer has no money to pay !!</p>";
            return;
        }

        else
        {
            document.getElementById("select_customer_name_error").innerHTML="";
            var today = new Date();
            var todaysDate = today.getFullYear() + '-' + ('0' + (today.getMonth() + 1)).slice(-2) + '-' + ('0' + today.getDate()).slice(-2);


            Swal.fire({
                title: "<h1><b>Pay Off</b></h1>",
                showCancelButton: true,
                showConfirmButton: true,
                keepOpened: true,
                html:
                    '<form class="form" id="payOffForm"><div class="form-group"><div class="form-body">'+
                    '<label for="transaction_value"><b>Value:</b></label><br>'+
                    '<input type="number" style="max-width:100%;" min="0" id="transaction_value" class="swal2-input"  name="transaction_value" /><br>' +
                    '<span class="-error" id="transaction_value_error"></span>'+
                    '<label for="transaction_date"><b>Date:</b></label>'+
                    '<input type= "date" id="transaction_date" class="swal2-input" value="'+todaysDate+'"/>'+
                    ' </div>\n' +
                    ' </div></form>'
                ,
                focusConfirm: false,
                preConfirm: () =>
                {
                    let trValue = document.getElementById('transaction_value').value;
                    let trDate = document.getElementById('transaction_date').value;

                    if(trValue == '')
                    {
                        document.getElementById("transaction_value_error").innerHTML="<p style='color: red;'>invalid voucher value</p>";
                        return false;
                    }
                    else if(trValue > toPay)
                    {
                        document.getElementById("transaction_value_error").innerHTML="<p style='color: red;'>invalid voucher value</p>";
                        return false;
                    }
                    else if(trValue < 0)
                    {
                        document.getElementById("transaction_value_error").innerHTML="<p style='color: red;'>invalid voucher value</p>";
                        return false;
                    }
                    else
                    {
                        document.getElementById("transaction_value_error").innerHTML="";
                        $.ajax({

                            url:"addTransaction.php",
                            method:"POST",
                            dataType:"JSON",
                            data:{"id":currentCustomerID,"value":trValue,"date":trDate},
                            success:function(data)
                            {
                                if(data==1)
                                {
                                    toPay-=trValue;
                                    toPayInfo.html("<b>Debt: </b>"+insertSpaces(toPay+"") + " L.L.");

                                    $('#message2').fadeIn();
                                    document.getElementById("message2").innerHTML = '<div class="alert alert-success mb-2" role="alert">\n' +
                                        '                                                <strong>Done!</strong> Transaction was Successfully added.\n' +
                                        '                                            </div>';

                                    $('#message2').delay(1000).fadeOut();


                                    /*transactionTab.row.add([
                                        trValue,
                                        trDate,
                                    ]).draw(false);*/

                                    let c = document.getElementById("CustomerName");
                                    getCustomerInfo(c);


                                }
                            }
                        });

                    }

                }

            });

        }

    }

    function editCustomerInfo()
    {
        Swal.fire({
            title: "<h1><b style='color: #00aec5'>Update Customer</b></h1>",
            showCancelButton: true,
            confirmButtonText: 'Confirm',
            confirmButtonColor: "#00aec5",
            cancelButtonColor: "#DD6B55",
            keepOpened: true,
            html:
                '<form class="form" id="updateCustomerInfos">' +
                '<div class="form-body">\n' +
                '    <div class="form-group">\n' +
                '         <label for="newName">Name</label>\n' +
                '         <input type="text" value="'+customerName+'" id="newName" class="form-control" placeholder="Customer Name" name="newName" required>\n' +
                '         <span class="-error" id="newNameError"></span>\n' +
                '    </div>\n' +
                '</div>\n' +
                '<div class="form-body">\n' +
                '     <div class="form-group">\n' +
                '          <label for="newPhone">Phone</label>\n' +
                '          <input type="text" value="'+customerPhone+'" id="newPhone" class="form-control" placeholder="01000000"  pattern="(01|02|03|04|05|06|07|08|09|70|76|71|81|82)\\d{6}" name="newPhone" required>\n' +
                '          <span class="-error" id="newPhoneError"></span>\n' +
                '     </div>\n' +
                '</div>\n' +
                '<div class="form-body">\n' +
                '     <div class="form-group">\n' +
                '          <label for="newEmail">Email</label>\n' +
                '          <input type="text" value="'+customerEmail+'" id="newEmail" class="form-control" placeholder="someone@example.com"  pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,4}$" name="newEmail" >\n' +
                '          <span class="-error" id="newEmailError"></span>\n' +
                '     </div>\n' +
                '</div>'+
                '</form>'


            ,

            focusConfirm: true,
            preConfirm: () =>
            {

                let cusNewName = document.getElementById('newName');
                let cusNewPhone = document.getElementById('newPhone').value;
                let cusNewEmail = document.getElementById('newEmail').value;
                let valid=1;

                document.getElementById("newPhoneError").innerHTML = '';
                document.getElementById("newNameError").innerHTML = '';



                if(cusNewName.value=='')
                {
                    document.getElementById("newNameError").innerHTML="<p style='color: red;'>invalid name</p>";
                    return false;
                }
                else if(cusNewName.value == customerName)
                {
                    document.getElementById("newNameError").innerHTML="";
                }
                else
                {
                    for(var i in cname)
                    {
                        if(cname[i].toLowerCase() == cusNewName.value.toLowerCase())
                        {
                            document.getElementById("newNameError").innerHTML="<p style='color: red;'>name not available</p>";
                            valid=0;
                            return false;
                        }
                        document.getElementById("newNameError").innerHTML='';
                    }
                }



                let isnum = /^\d+$/.test(cusNewPhone);
                if(cusNewPhone.length!=8 || !isnum || (cusNewPhone.charAt(0)==0 && cusNewPhone.charAt(1)==0))
                {
                    document.getElementById("newPhoneError").innerHTML="<p style='color: red;'>invalid phone</p>";
                    valid=0;
                    return false;
                }

                else if(cusNewPhone == customerPhone)
                {
                    document.getElementById("newPhoneError").innerHTML="";
                }
                else
                {
                    for(var j in phone)
                    {
                        if(phone[j] == cusNewPhone)
                        {
                            document.getElementById("newPhoneError").innerHTML="<p style='color: red;'>phone not available</p>";
                            valid=0;
                            return false;
                        }
                        document.getElementById("newPhoneError").innerHTML = '';
                    }
                }



                if($.trim(cusNewName.value).length==0)
                {

                    cusNewName.focus(function()
                    {
                        $(this).next("span").css("display", "inline");
                    });
                    valid=0;
                }
                if(valid==0)
                {
                    return false;
                }



                $.ajax({


                    url:"customers.php",
                    method:"POST",
                    data:{"id":customerID,"newName":cusNewName.value,"newPhone":cusNewPhone,"newEmail":cusNewEmail},
                    success:function(data)
                    {

                        if(data==1)
                        {
                            customerName = cusNewName.value;
                            customerPhone = cusNewPhone;
                            customerEmail = cusNewEmail;

                            $('#message2').fadeIn();
                            document.getElementById("message2").innerHTML='<div class="alert alert-success mb-2" role="alert">\n' +
                                '                                                <strong>Done!</strong> Customer updated Successfully .\n' +
                                '                                            </div>';

                            $('#message2').delay(1000).fadeOut();


                            phone[customerID+""]= cusNewPhone;
                            cname[customerID+""]=cusNewName.value;

                            document.getElementById("CustomerName").innerHTML = "";

                            for (let key in cname)
                            {
                                if(key==customerID+""){
                                    document.getElementById("CustomerName").innerHTML += ("<option value='" + key + "' selected>" + cusNewName.value + "</option>");
                                }else {
                                    document.getElementById("CustomerName").innerHTML += ("<option value='" + key + "'>" + cname[key] + "</option>");
                                }
                            }





                        }

                    }
                });


            }

        });
    }

    function dateChanged()
    {
        let c = document.getElementById("CustomerName");
        getCustomerInfo(c);
    }


    function getCustomerInfo(c) {

        transactionTab.rows().remove().draw();
        voucherTab.rows().remove().draw();
        transactionValues = 0;
        VoucherValues = 0;
        toPay = 0;
        //let sumMoney = 0;

        let d1=$("#date1").val();
        let d2=$("#date2").val();

        //alert(d1+" "+d2);

        document.getElementById("select_customer_name_error").innerHTML="";

        if(c.value!=-1)
        {
            customerName =  c.options[c.selectedIndex].textContent;
            customerID = c.value;

            $('#moneyToPay').show();
            $('#pay').show();
            $('#edit').show();
            $('#view').show();

            $.ajax({

                url:"getCustTranVouch.php",
                method:"POST",
                dataType:"JSON",
                data:{"id":c.value,"date1":d1,"date2":d2},
                success:function(data)
                {

                    totalDebt = data["totalDebt"];
                    customerPhone = data["customerPhone"];
                    customerEmail = data["customerEmail"];



                    if(data["sumTransactionValues"]!=0)
                    {
                        transactionValues = data["sumTransactionValues"];

                        document.getElementById("transactionsCollapse").innerHTML="<b>Transactions</b> (Total paid: "+insertSpaces(transactionValues+"")+" L.L.)";


                        let value, date, bdelete, trID;


                        for (let i = 0; i < data["customerTR"].length; i++)
                        {
                            trID = data["customerTR"][i]["trID"];
                            value = data["customerTR"][i]["value"];
                            date = data["customerTR"][i]["date"];
                            bdelete="<button type='submit' class='btn btn-icon btn-danger mr-1'   onclick='deleteTransaction("+trID+")'  id="+trID+"><i class='la la-trash'></i></button>";

                            transactionTab.row.add([
                                insertSpaces(value+""),
                                date,
                                bdelete,
                            ]).draw(false);


                        }
                    }
                    else
                    {
                        transactionValues = 0;
                        document.getElementById("transactionsCollapse").innerHTML="<b>Transactions</b> (Total paid: 0 L.L.)";
                    }

                    if(data["sumVoucherValues"]!=0)
                    {

                        VoucherValues = data["sumVoucherValues"];
                        //sumMoney = parseInt(data["sumMoneyToPay"]);

                        document.getElementById("vouchersCollapse").innerHTML="<b>Vouchers</b> (Total vouchers: "+insertSpaces(VoucherValues+"")+" L.L.)";


                        let fueltype, value, date, note, voID, bdelete;

                        for (let i = 0; i < data["customerVO"].length; i++)
                        {
                            voID = data["customerVO"][i]["voID"];
                            fueltype = data["customerVO"][i]["fueltype"];
                            value = data["customerVO"][i]["value"];
                            date = data["customerVO"][i]["date"];
                            note = data["customerVO"][i]["note"];
                            bdelete="<button type='submit' class='btn btn-icon btn-danger mr-1'   onclick='deleteVoucher("+voID+")'  id="+voID+"><i class='la la-trash'></i></button>";


                            voucherTab.row.add([
                                fueltype,
                                insertSpaces(value+""),
                                date,
                                note,
                                bdelete,
                            ]).draw(false);

                        }
                    }
                    else
                    {
                        VoucherValues = 0;
                        document.getElementById("vouchersCollapse").innerHTML="<b>Vouchers</b> (Total vouchers: 0 L.L.)";
                    }


                    toPay = VoucherValues - transactionValues;
                    toPayInfo.html("<b>Dept: </b>"+insertSpaces(toPay+"") + " L.L.");


                }
            });
        }
        else
        {
            document.getElementById("transactionsCollapse").innerHTML="Transactions";
            document.getElementById("vouchersCollapse").innerHTML="Vouchers";

            toPayInfo.html("<b>Total Debt: </b>"+insertSpaces(totalDebt+"") + " L.L.");
            $('#pay').hide();
            $('#edit').hide();
            $('#view').hide();

        }

    }

    function deleteVoucher(voID) {



        Swal.fire({
            title: "<h1><b style='color :red'> Delete</b></h1>",
            showCancelButton: true,
            type: "warning",
            confirmButtonText: 'Delete',
            confirmButtonColor: "red",
            cancelButtonColor: "orangered",
            html:
                '<form class="form" ><div class="form-group"><div class="form-body">' +
                ' <label for="datep">Are you sure,you want to delete this voucher?</label>\n' +
                ' </div>\n' +
                ' </div></form>'
            ,


            focusConfirm: true,


            preConfirm: () => {




                $.ajax({

                    url: "customers.php",
                    method: "POST",
                    dataType:"JSON",
                    data: {"delete": 1,"voID":voID},
                    success: function (data) {
                        let done=data["done"];
                        if(done ==1)
                        {
                            let c = document.getElementById("CustomerName");
                            getCustomerInfo(c);
                        }



                    }
                });


            }



        });
    }

    function deleteTransaction(trID) {



        Swal.fire({
            title: "<h1><b style='color :red'> Delete</b></h1>",
            showCancelButton: true,
            type: "warning",
            confirmButtonText: 'Delete',
            confirmButtonColor: "red",
            cancelButtonColor: "orangered",
            html:
                '<form class="form" ><div class="form-group"><div class="form-body">' +
                ' <label for="datep">Are you sure,you want to delete this transaction?</label>\n' +
                ' </div>\n' +
                ' </div></form>'
            ,


            focusConfirm: true,


            preConfirm: () => {




                $.ajax({

                    url: "customers.php",
                    method: "POST",
                    dataType:"JSON",
                    data: {"delete": 1,"trID":trID},
                    success: function (data) {
                        let done=data["done"];
                        if(done ==1)
                        {
                            let c = document.getElementById("CustomerName");
                            getCustomerInfo(c);
                        }



                    }
                });

                //alert("hi");

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
                        //types += name + "|";
                        document.getElementById("fuel_types").innerHTML += ("<li><a class='menu-item' href='fuelInfo_p.php?id=" + id + "&name=" + name + "'>" + name + "</a></li>");

                        if(i==0){
                            $('#first_fuel').attr("onclick","window.location.href='fuel_type_x_p.php?id=" + id + "&name=" + name + "'");
                        }

                    }
                }

                document.getElementById("fuel_types").innerHTML += ("<li><a class='menu-item' href='FuelTypes_p.php'>Add Type</a></li>");



                if(data["customer"]) {

                    document.getElementById("CustomerName").innerHTML = '<option value="-1" selected>Select Customer</option>';
                    for (let i = 0; i < data["customer"].length; i++) {
                        id = data["customer"][i]["CUSTOMERID"];
                        name = data["customer"][i]["CUSTOMERNAME"];
                        cname[id+""] = data["customer"][i]["CUSTOMERNAME"];
                        phone[id+""] = data["customer"][i]["CUSTOMERPHONE"];
                        customersName += cname[id] + "|";
                        document.getElementById("CustomerName").innerHTML += ("<option value='" + id + "'>" + name + "</option>");

                    }
                }
                totalDebt = data["totalDebt"];
                toPayInfo.html("<b>Total Debt: </b>"+insertSpaces(totalDebt+"") + " L.L.");
            }
        });
    }

    function saveCustomer() {

        let cusName=$("#customer_name");
        let ph=$("#customer_phone").val();
        let email=$("#customer_email").val();
        let valid=1;

        if(cusName.val()=='')
        {
            document.getElementById("customer_name_error").innerHTML="<p style='color: red;'>invalid name</p>";
            valid = 0;
        }

        for(var i in cname)
        {
            if(cname[i].toLowerCase() == cusName.val().toLowerCase())
            {
                cusName.focus(function() {$(this).next("span").css("display", "inline");});
                document.getElementById("customer_name_error").innerHTML="<p style='color: red;'>name not available</p>";
                valid=0;
            }
        }


        let isnum = /^\d+$/.test(ph);
        if(ph.length!=8 || !isnum || (ph.charAt(0)==0 && ph.charAt(1)==0))
        {
            document.getElementById("customer_phone_error").innerHTML="<p style='color: red;'>invalid phone</p>"; valid=0;
        }

        for(var j in phone)
        {
            if(phone[j] == ph)
            {
                document.getElementById("customer_phone_error").innerHTML="<p style='color: red;'>phone not available</p>";
                valid=0;
            }
        }


        if($.trim(cusName.val()).length==0){

            cusName.focus(function() {
                $(this).next("span").css("display", "inline");
            });
            valid=0;
        }
        if(valid==0){

            return;}

        $.ajax({


            url:"customers.php",
            method:"POST",
            dataType:"JSON",
            data:($("#customer_form").serialize()),
            success:function(data)
            {

                if(data["done"]==1){

                    $('#message').fadeIn();
                    document.getElementById("message").innerHTML='<div class="alert alert-success mb-2" role="alert">\n' +
                        '                                                <strong>Done!</strong> New Customer was Successfully added.\n' +
                        '                                            </div>';

                    $('#message').delay(1000).fadeOut();

                    let pid=data["pid"];
                    phone[pid+""]= $("#customer_phone").val();
                    customersName+=cusName.val()+"|";
                    cname[pid+""]=cusName.val();
                    phones+="|"+$("#customer_phone").val()+"|";
                    document.getElementById("CustomerName").innerHTML += ("<option value='" + pid + "'>" + cusName.val() + "</option>");

                    $("#customer_name").val('');
                    $("#customer_phone").val('');
                    $("#customer_email").val('');
                    document.getElementById("customer_phone_error").innerHTML="";
                    document.getElementById("customer_name_error").innerHTML="";

                }

            }
        });

    }


    getNavContent();
</script>
<!-- END PAGE LEVEL JS-->
</body>
</html>
