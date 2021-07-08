import 'package:flutter/material.dart';
import 'package:flutter_petrol_station/widgets/Drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_petrol_station/services/cloud_services.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:intl/number_symbols.dart';
import 'package:flutter/services.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

class Shipments extends StatefulWidget {
  static String id = 'shipments';
  @override
  _ShipmentsState createState() => _ShipmentsState();
}

class _ShipmentsState extends State<Shipments> {
  TextEditingController tdate = new TextEditingController(); 
  String dropdownValue = 'One';
  int _radioValue = 0;
  bool isPaid;
  String container_category,
      fuel_category,
      provider_category,
      selected_date,
      note;
  int add_Volume; // =

  String provider_category_details,
      container_category_details,
      fuel_category_details,
      fromDate,
      toDate;
  static int container_id_details, fuel_type_id_details, provider_id_details;

  Timestamp myTimeStamp, myTimeStamp1;
  static int container_id, fuel_type_id, provider_id;

  int volume, shipmentValue, capacity, maxVolume, oldVolume;
  bool IsPaid;
  Timestamp Paid_Date, Shipment_Date, mytimestamp, mytimestamp1;
  int lastID, docId;
  int volumeError = 0, shipmentValueError = 0;
  int totalVolume = 0,
      totalPaid = 0,
      totalDebt = 0,
      totalPaidFilter = 0,
      totalDebtFilter = 0;
  int filter = 0;

  var noteController = TextEditingController(),
      valueController = TextEditingController(),
      volumeController = TextEditingController();

  int shipmentToDelete, shipmentBeforeDelete, volumeToBeAdded;
  int fromDateError = 0, toDateError = 0;
  Color colorT = Colors.blueAccent, colorF = Colors.blueAccent;
  String Container_Name, Provider_Name;

  int currentContVolume;

  final DateTime nn = DateTime.now();
  final DateFormat formatter = DateFormat('dd/MM/yyyy h:mm a');
  DateTime today = DateTime.now();
  final DateFormat ff = DateFormat('yyyy/MM/dd HH:mm');
  String formatted;
  DateTime Record_Time;
  FirebaseFirestore db = FirebaseFirestore.instance;
  String station, pStation;
  User loggedInUser;
  Color colorE = Colors.blueAccent,
      colorP = Colors.blueAccent[100],
      colorD = Colors.blueAccent;
  int dateError = 0;
  CloudServices cloudServices =
      CloudServices(FirebaseFirestore.instance, FirebaseAuth.instance);

  @override
  void initState() {
    super.initState();
    loggedInUser = cloudServices.getCurrentUser();
    print("user");
    print(loggedInUser);
    asyncMethod();
  }

  void asyncMethod() async {
    // we do this to call a fct that need async wait when calling it;
    // when aiming to use the fct in initState
    if (loggedInUser != null) {
      station = await cloudServices.getUserStation(loggedInUser);
      getFirstCategory();
      //getVolume();
    }
    setState(() {});
    // hay l setState bhotta ekher shi bl fct yalle btrajj3 shi future krml yn3amal rebuild
    // krml yontor l data yalle 3m trj3 mn l firestore bs n3aytla ll method
  }
  //
  // void getContainerName(int container_id) {
  //   var qs = db
  //       .collection('Stations')
  //       .doc(station)
  //       .collection('Container')
  //       .where('Container_Id', isEqualTo: container_id)
  //       .get()
  //       .then((val) => {
  //             if (val.docs.length > 0)
  //               {
  //                 Container_Name = val.docs[0].get("Container_Name"),
  //               }
  //             else
  //               {
  //                 print("elseeeee"),
  //               }
  //           });
  // }
  //
  // void getProviderName(int provider_id) async {
  //   await db
  //       .collection('Stations')
  //       .doc(station)
  //       .collection('Provider')
  //       .doc(provider_id.toString())
  //       .get()
  //       .then((value) {
  //     print(value.data());
  //     Provider_Name = value.data()['Provider_Name'];
  //   });
  // }

  void getFirstCategory() async {
    var s = await db
        .collection('Stations')
        .doc(station)
        .collection('Container')
        .get()
        .then((val) => {
              if (val.docs.length > 0)
                {
                  t = val.docs[0].get("Container_Name"),
                  container_category = val.docs[0].get("Container_Name"),
                  container_id = val.docs[0].get("Container_Id"),
                  container_category_details = container_category,
                  print("container id fct firsttt: $container_id"),
                  print("container name firsttt $container_category"),
                }
              else
                {print("Not Found")}
            });
    s = await db
        .collection('Stations')
        .doc(station)
        .collection('Provider')
        .get()
        .then((val) => {
              if (val.docs.length > 0)
                {
                  t = val.docs[0].get("Provider_Name"),
                  provider_category = val.docs[0].get("Provider_Name"),
                  provider_id = val.docs[0].get("Provider_Id"),
                  provider_category_details = provider_category,
                  print("provider id fct firsttt: $provider_id"),
                  print("provider name firsttt $provider_category"),
                }
              else
                {print("Not Found")}
            });

    s = await db
        .collection('Stations')
        .doc(station)
        .collection('Fuel_Type')
        .get()
        .then((val) => {
              if (val.docs.length > 0)
                {
                  t = val.docs[0].get("Fuel_Type_Name"),
                  fuel_category = val.docs[0].get("Fuel_Type_Name"),
                  fuel_type_id = val.docs[0].get("Fuel_Type_Id"),
                  print("fuel id fct firsttt: $fuel_type_id"),
                  print("fuel name firsttt $fuel_category"),
                }
              else
                {print("Not Found")}
            });
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 0:
          IsPaid = true;
          Paid_Date = Timestamp.fromDate(today);
          break;
        case 1:
          IsPaid = false;
          Paid_Date = Timestamp.fromDate(DateTime(0, 0, 0, 0, 0, 0, 0, 0));
          break;
      }
    });
  }

  void getTotalVolume() async {
    totalVolume = 0;
    //var c = db.collection('Stations').doc(station).collection('Shipment');
    var s = await FirebaseFirestore.instance
        .collection('Stations')
        .doc(station)
        .collection('Shipment')
        .get()
        .then((val) => {
              if (val.docs.length > 0)
                {
                  print("lengthhhhhhhhhhh"),
                  print(val.docs.length),
                  for (var i = 0; i < val.docs.length; i++)
                    {
                      print("Volumeeeeeeeeeeeeeeeeee"),
                      print(val.docs[i].get("Shipment_Volume")),
                      totalVolume += val.docs[i].get("Shipment_Volume"),
                    },
                }
              else
                {print("Not Found")}
            });
  }

  void getDebtMoney() async {
    totalDebt = 0;
    int tt = 0;
    var c = db.collection('Stations').doc(station).collection('Shipment');
    var s = await db
        .collection('Stations')
        .doc(station)
        .collection('Shipment')
        .where('IsPaid', isEqualTo: false)
        .get()
        .then((val) => {
              print(val),
              if (val.docs.length > 0)
                {
                  print("lengthhhhhhhhhhh"),
                  print(val.docs.length),
                  for (var i = 0; i < val.docs.length; i++)
                    {
                      print("valueeeeeeeeeeeee"),
                      print(val.docs[i].get("Shipment_Value")),
                      totalDebt += val.docs[i].get("Shipment_Value"),
                    },
                }
              else
                {print("Not Found")}
            });
  }

  void getPaidMoneyFilter(
      String container, String provider, String fromDate, String toDate) async {
    totalPaidFilter = 0;
    // final DateFormat formatterrr =
    //     DateFormat('''MMMM dd, yyyy 'at' hh:mm:ss a''');
    final DateFormat formatterrr = DateFormat('yyyy/MM/dd');

    DateTime fD = ff.parse(fromDate);
    DateTime tD = ff.parse(toDate);

    //DateTime fromD = DateTime.parse(fromDate);
    Timestamp myTimeStamp = Timestamp.fromDate(fD);
    //DateTime toD = DateTime.parse(toDate);
    Timestamp myTimeStamp1 = Timestamp.fromDate(tD);
    int total = 0;
    var c = db.collection('Stations').doc(station).collection('Shipment');
    var s = await FirebaseFirestore.instance
        .collection('Stations')
        .doc(station)
        .collection('Shipment')
        .where('IsPaid', isEqualTo: true)
        .where('Container_Name', isEqualTo: container)
        .where('Provider_Name', isEqualTo: provider)
        .where('Shipment_Date', isGreaterThanOrEqualTo: myTimeStamp)
        .where('Shipment_Date', isLessThanOrEqualTo: myTimeStamp1)
        .get()
        .then((val) => {
              print(val),
              if (val.docs.length > 0)
                {
                  print("lengthhhhhhhhhhh"),
                  print(val.docs.length),
                  for (var i = 0; i < val.docs.length; i++)
                    {
                      print("paiddddddddddddddd"),
                      print(val.docs[i].get("Shipment_Value")),
                      total += val.docs[i].get("Shipment_Value"),
                    },
                  setState(() {
                    totalPaidFilter = total;
                  }),
                }
              else
                {print("Not Found")}
            });
  }

  // //1974-03-20 00:00:00.000
  // final DateFormat formatterrr =
  //     DateFormat('''MMMM dd, yyyy 'at' hh:mm:ss a''');
  final DateFormat formatterrr = DateFormat('yyyy/MM/dd');
  void getDebtMoneyFilter(
      String container, String provider, String fromDate, String toDate) async {
    totalDebtFilter = 0;
    final fD = ff.parse(fromDate);
    final tD = ff.parse(toDate);
    var c = db.collection('Stations').doc(station).collection('Shipment');
    //DateTime fromD = DateTime.parse(fromDate);
    Timestamp myTimeStamp = Timestamp.fromDate(fD);
    //DateTime toD = DateTime.parse(toDate);
    Timestamp myTimeStamp1 = Timestamp.fromDate(tD);
    int total = 0;
    var s = await FirebaseFirestore.instance
        .collection('Stations')
        .doc(station)
        .collection('Shipment')
        .where('IsPaid', isEqualTo: false)
        .where('Container_Name', isEqualTo: container)
        .where('Provider_Name', isEqualTo: provider)
        .where('Shipment_Date', isGreaterThanOrEqualTo: myTimeStamp)
        .where('Shipment_Date', isLessThanOrEqualTo: myTimeStamp1)
        .get()
        .then((val) => {
              print(val),
              if (val.docs.length > 0)
                {
                  print("lengthhhhhhhhhhh"),
                  print(val.docs.length),
                  for (var i = 0; i < val.docs.length; i++)
                    {
                      print("valueeeeeeeeeeeee"),
                      print(val.docs[i].get("Shipment_Value")),
                      total += val.docs[i].get("Shipment_Value"),
                    },
                  setState(() {
                    totalDebtFilter = total;
                  }),
                }
              else
                {print("Not Found")}
            });
  }

  void getPaidMoney() async {
    totalPaid = 0;
    int total = 0;
    var c = db.collection('Stations').doc(station).collection('Shipment');
    var s = await FirebaseFirestore.instance
        .collection('Stations')
        .doc(station)
        .collection('Shipment')
        .where('IsPaid', isEqualTo: true)
        .get()
        .then((val) => {
              print(val),
              if (val.docs.length > 0)
                {
                  print("lengthhhhhhhhhhh"),
                  print(val.docs.length),
                  for (var i = 0; i < val.docs.length; i++)
                    {
                      print("paiddddddddddddddd"),
                      print(val.docs[i].get("Shipment_Value")),
                      totalPaid += val.docs[i].get("Shipment_Value"),
                    },
                }
              else
                {print("Not Found")}
            });
  }

  void getLastDocId() {
    var qs = db
        .collection('Stations')
        .doc(station)
        .collection('Shipment')
        .orderBy("Shipment_Id")
        .limitToLast(1)
        .get()
        .then((val) => {
              if (val.docs.length > 0)
                {
                  lastID = val.docs[val.docs.length - 1].get("Shipment_Id"),
                  docId = lastID + 1,
                  print("lastt IDD: $lastID"),
                  print("doc IDD: $docId"),
                }
              else
                {
                  print("elseeeee"),
                }
            });
  }

  String t;
  void getIds() async {
    var s;
    if (container_category != null) {
      s = await FirebaseFirestore.instance
          .collection('Stations')
          .doc(station)
          .collection('Container')
          .where('Container_Name', isEqualTo: container_category)
          .get()
          .then((val) => {
                if (val.docs.length > 0)
                  {
                    t = val.docs[0].get("Container_Name"),
                    container_id = val.docs[0].get("Container_Id"),
                    print("container id fct: $container_id"),
                    print("container name $t"),
                  }
                else
                  {print("Not Found")}
              });
    }

    if (provider_category != null) {
      s = await db
          .collection('Stations')
          .doc(station)
          .collection('Provider')
          .where('Provider_Name', isEqualTo: provider_category)
          .get()
          .then((val) => {
                if (val.docs.length > 0)
                  {
                    t = val.docs[0].get("Provider_Name"),
                    provider_category = val.docs[0].get("Provider_Name"),
                    provider_id = val.docs[0].get("Provider_Id"),
                    print("provider id fct firsttt: $provider_id"),
                    print("provider name firsttt $provider_category"),
                  }
                else
                  {print("Not Found")}
              });
    }
    if (fuel_category != null) {
      s = await db
          .collection('Stations')
          .doc(station)
          .collection('Fuel_Type')
          .where('Fuel_Type_Name', isEqualTo: fuel_category)
          .get()
          .then((val) => {
                if (val.docs.length > 0)
                  {
                    t = val.docs[0].get("Fuel_Type_Name"),
                    fuel_category = val.docs[0].get("Fuel_Type_Name"),
                    fuel_type_id = val.docs[0].get("Fuel_Type_Id"),
                    print("fuel id fct : $fuel_type_id"),
                    print("fuel name  $fuel_category"),
                  }
                else
                  {print("Not Found")}
              });
    }
  }

  void getIdsDetails() async {
    var s;
    if (container_category_details != null) {
      s = await FirebaseFirestore.instance
          .collection('Stations')
          .doc(station)
          .collection('Container')
          .where('Container_Name', isEqualTo: container_category_details)
          .get()
          .then((val) => {
                if (val.docs.length > 0)
                  {
                    t = val.docs[0].get("Container_Name"),
                    container_id_details = val.docs[0].get("Container_Id"),
                    print("container id fct: $container_id_details"),
                    print("container name $t"),
                  }
                else
                  {print("Not Found")}
              });
    }

    if (provider_category_details != null) {
      s = await db
          .collection('Stations')
          .doc(station)
          .collection('Provider')
          .where('Provider_Name', isEqualTo: provider_category_details)
          .get()
          .then((val) => {
                if (val.docs.length > 0)
                  {
                    t = val.docs[0].get("Provider_Name"),
                    provider_category_details =
                        val.docs[0].get("Provider_Name"),
                    provider_id_details = val.docs[0].get("Provider_Id"),
                    print("provider id fct firsttt: $provider_id_details"),
                    print("provider name firsttt $provider_category_details"),
                  }
                else
                  {print("Not Found")}
              });
    }
    if (fuel_category_details != null) {
      s = await db
          .collection('Stations')
          .doc(station)
          .collection('Fuel_Type')
          .where('Fuel_Type_Name', isEqualTo: fuel_category)
          .get()
          .then((val) => {
                if (val.docs.length > 0)
                  {
                    t = val.docs[0].get("Fuel_Type_Name"),
                    fuel_category = val.docs[0].get("Fuel_Type_Name"),
                    fuel_type_id = val.docs[0].get("Fuel_Type_Id"),
                    print("fuel id fct : $fuel_type_id"),
                    print("fuel name  $fuel_category"),
                  }
                else
                  {print("Not Found")}
              });
    }
  }
  // int v;
  // void getVolume() async {
  //   if (container_category != null) {
  //     var s = await db
  //         .collection('Stations')
  //         .doc(station)
  //         .collection('Container')
  //         .where('Container_Name', isEqualTo: container_category)
  //         .get()
  //         .then((val) => {
  //               if (val.docs.length > 0)
  //                 {
  //                   capacity = val.docs[0].get("Capacity"),
  //                   volume = val.docs[0].get("Volume"),
  //                   print("volume fct: $volume"),
  //                   print("capacity fct: $capacity"),
  //                   v = capacity - volume,
  //                   print("max volume fct: $v"),
  //                 }
  //               else
  //                 {print("Not Found")}
  //             });
  //   }
  //   setState(() {
  //     maxVolume = v;
  //   });
  // }

  void filter_fct() {
    print("opnpresseddddd filterrrrrrrrrrrrrrrr");
    if (container_category_details == null) {
      print('container null ');
    }
    if (provider_category_details == null) {
      print('provider null ');
    }
    if (fromDate == null) {
      print('fromdate null ');
      setState(() {
        fromDateError = 1;
        colorF = Colors.red;
      });
    }
    if (toDate == null) {
      print('todate null ');
      setState(() {
        toDateError = 1;
        colorT = Colors.red;
      });
    }
    if (container_category_details != null &&
        provider_category_details != null &&
        fromDate != null &&
        toDate != null) {
      setState(() {
        fromDateError = 0;
        colorF = Colors.blueAccent;

        toDateError = 0;
        colorT = Colors.blueAccent;
      });
      final DateFormat formatterrr =
          DateFormat('''MMMM dd, yyyy 'at' hh:mm:ss a ''');

      try {
        DateTime fD = ff.parse(fromDate);
        DateTime tD = ff.parse(toDate);

        //DateTime fromD = DateTime.parse(fromDate);
        Timestamp myTimeStamp = Timestamp.fromDate(fD);
        //DateTime toD = DateTime.parse(toDate);
        Timestamp myTimeStamp1 = Timestamp.fromDate(tD);

        setState(() {
          toDateError = 0;
          colorT = Colors.blueAccent;

          fromDateError = 0;
          colorF = Colors.blueAccent;
        });
        setState(() {
          toDateError = 0;
          colorT = Colors.blueAccent;

          fromDateError = 0;
          colorF = Colors.blueAccent;
          mytimestamp = Timestamp.fromDate(fD);
          mytimestamp1 = Timestamp.fromDate(tD);
          print('myTimeStamppppppppppppppp $mytimestamp');
          filter = 1;
          // getDeptMoneyFilter(
          //     container_category_details,
          //     provider_category_details,
          //     fromDate,
          //     toDate);
          //
          // getPaidMoneyFilter(
          //     container_category_details,
          //     provider_category_details,
          //     fromDate,
          //     toDate);
        });
      } catch (e) {
        setState(() {
          toDateError = 1;
          colorT = Colors.red;
          filter = 0;
          fromDateError = 1;
          colorF = Colors.red;

          getDebtMoney();
          getPaidMoney();
        });
      }
      getIdsDetails();
      print('filterrrrrrrrrrrrrrrrr');
      print(container_id_details);
      print(provider_id_details);
      getDebtMoneyFilter(container_category_details, provider_category_details,
          fromDate, toDate);
      getPaidMoneyFilter(container_category_details, provider_category_details,
          fromDate, toDate);

      //setState(() {});

    }
  }

  refresh() async {
    // setState(() {
    //   totalDebt = 0;
    //   totalPaid = 0;
    //   totalVolume = 0;
    // });
    totalDebt = 0;
    totalPaid = 0;
    totalVolume = 0;

    print('refreshhhhhhhhhhhhhhhhhhhhhh');
    int g = 0;
    await db
        .collection('Stations')
        .doc(station)
        .collection('Shipment')
        .get()
        .then((val) => {
              if (val.docs.length > 0)
                {
                  print("lengthhhhhhhhhhh"),
                  print(val.docs.length),
                  for (var i = 0; i < val.docs.length; i++)
                    {
                      print("Volumeeeeeeeeeeeeeeeeee"),
                      print(val.docs[i].get("Shipment_Volume")),
                      g += val.docs[i].get("Shipment_Volume"),
                    },
                  setState(() {
                    totalVolume = g;
                  }),
                }
              else
                {print("Not Found")},
              setState(() {}),
            });
    int pp = 0;
    await FirebaseFirestore.instance
        .collection('Stations')
        .doc(station)
        .collection('Shipment')
        .where('IsPaid', isEqualTo: true)
        .get()
        .then((val) => {
              print(val),
              if (val.docs.length > 0)
                {
                  print("lengthhhhhhhhhhh"),
                  print(val.docs.length),
                  for (var i = 0; i < val.docs.length; i++)
                    {
                      print("paiddddddddddddddd"),
                      print(val.docs[i].get("Shipment_Value")),
                      pp += val.docs[i].get("Shipment_Value"),
                    },
                  setState(() {
                    totalPaid = pp;
                  }),
                }
              else
                {print("Not Found")},
              setState(() {}),
            });
    int dd = 0;
    await db
        .collection('Stations')
        .doc(station)
        .collection('Shipment')
        .where('IsPaid', isEqualTo: false)
        .get()
        .then((val) => {
              print(val),
              if (val.docs.length > 0)
                {
                  print("lengthhhhhhhhhhh"),
                  print(val.docs.length),
                  for (var i = 0; i < val.docs.length; i++)
                    {
                      print("valueeeeeeeeeeeee"),
                      print(val.docs[i].get("Shipment_Value")),
                      dd += val.docs[i].get("Shipment_Value"),
                    },
                  setState(() {
                    totalDebt = dd;
                  }),
                }
              else
                {print("Not Found")},
              setState(() {}),
            });
    //setState(() {});
  }

  refreshFilter(
      String container, String provider, String fromDate, String toDate) async {
    getPaidMoneyFilter(container, provider, fromDate, toDate);
    getDebtMoneyFilter(container, provider, fromDate, toDate);
  }

  NumberFormat numberFormat = new NumberFormat('###,000');
  NumberSymbols numberFormatSymbols;
  @override
  Widget build(BuildContext context) {
    tdate.text = ff.format(DateTime.now());
    numberFormatSymbols = new NumberSymbols(
      NAME: "zz",
      DECIMAL_SEP: '.',
      GROUP_SEP: '\u00A0',
      PERCENT: '%',
      ZERO_DIGIT: '0',
      PLUS_SIGN: '+',
      MINUS_SIGN: '-',
      EXP_SYMBOL: 'e',
      PERMILL: '\u2030',
      INFINITY: '\u221E',
      NAN: 'NaN',
      DECIMAL_PATTERN: '#,##0.###',
      SCIENTIFIC_PATTERN: '#E0',
      PERCENT_PATTERN: '#,##0%',
      CURRENCY_PATTERN: '\u00A4#,##0.00',
      DEF_CURRENCY_CODE: 'AUD',
    );
    totalVolume = 0;
    totalDebt = 0;
    totalPaid = 0;

    getDebtMoney();
    getPaidMoney();
    getTotalVolume();
    getLastDocId();

    print("builddddd $docId");
    print("builddddd $lastID");
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        backgroundColor: Color(0xFF083369),
        actions: [
          Row(
            children: [
              Icon(
                Icons.exit_to_app,
                size: 24,
                color: Colors.white,
              ),
              Text('LOGOUT',
                  style: TextStyle(color: Colors.white, fontSize: 21.0)),
              SizedBox(width: 20)
            ],
          )
        ],
      ),
      drawer: getDrawer(),
      body: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          Text('  Shipments',
              style: TextStyle(
                color: Colors.amber,
                fontSize: 36,
                fontWeight: FontWeight.w500,
              )),
          SizedBox(
            height: 20,
          ),
          Card(
            elevation: 12,
            child: ExpansionTile(
              title: Text("Add Shipments",
                  style: TextStyle(fontSize: 29, color: Colors.blue[900])),
              trailing: Icon(Icons.arrow_drop_down,
                  size: 20, color: Colors.blue[900]),
              children: [
                Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Text("Provider",
                            style: TextStyle(
                                fontSize: 21,
                                color: Colors.blue.shade800,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        StreamBuilder(
                          stream: db
                              .collection('Stations')
                              .doc(station)
                              .collection('Provider')
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                width: 350.0,
                                height: 58,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 1.0, style: BorderStyle.solid),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: provider_category,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: const TextStyle(
                                        color: Colors.deepPurple),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.deepPurpleAccent,
                                    ),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        provider_category = newValue;
                                      });
                                    },
                                    items: snapshot.data != null
                                        ? snapshot.data.docs
                                            .map((DocumentSnapshot document) {
                                            return new DropdownMenuItem<String>(
                                                value: document
                                                    .get('Provider_Name')
                                                    .toString(),
                                                child: new Container(
                                                  child: Center(
                                                    child: new Text(
                                                      document
                                                          .get('Provider_Name')
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                ));
                                          }).toList()
                                        : DropdownMenuItem(
                                            value: 'null',
                                            child: new Container(
                                              height: 100.0,
                                              child: new Text('null'),
                                            ),
                                          ),
                                  ),
                                ),
                              );
                            } else {
                              return Text('');
                            }
                          },
                        ),
                        SizedBox(height: 40),
                        Text("Date",
                            style: TextStyle(
                                fontSize: 21,
                                color: Colors.blue.shade800,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        TextFormField(
                         
                            keyboardType: TextInputType.datetime,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.date_range_rounded,
                                  color: Colors.indigo[300]),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: colorD),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: colorD, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                              labelText: ff.format(today),
                              fillColor: Colors.white,
                              labelStyle: TextStyle(color: Colors.black45),
                            ),
                            onChanged: (String s) {
                              selected_date = s;
                            }),
                        Text(
                          dateError == 1 ? 'Enter a valid Date' : '',
                          style: TextStyle(color: colorD),
                        ),
                        SizedBox(height: 40),
                        Text("Container",
                            style: TextStyle(
                                fontSize: 21,
                                color: Colors.blue.shade800,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        StreamBuilder(
                          stream: db
                              .collection('Stations')
                              .doc(station)
                              .collection('Container')
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                width: 350.0,
                                height: 58,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 1.0, style: BorderStyle.solid),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: container_category,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: const TextStyle(
                                        color: Colors.deepPurple),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.deepPurpleAccent,
                                    ),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        container_category = newValue;
                                        //getVolume();
                                      });
                                    },
                                    items: snapshot.data != null
                                        ? snapshot.data.docs
                                            .map((DocumentSnapshot document) {
                                            return new DropdownMenuItem<String>(
                                                value: document
                                                    .get('Container_Name')
                                                    .toString(),
                                                child: new Container(
                                                  child: Center(
                                                    child: new Text(
                                                      document
                                                          .get('Container_Name')
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                ));
                                          }).toList()
                                        : DropdownMenuItem(
                                            value: 'null',
                                            child: new Container(
                                              height: 100.0,
                                              child: new Text('null'),
                                            ),
                                          ),
                                  ),
                                ),
                              );
                            } else {
                              return Text('');
                            }
                          },
                        ),
                        // SizedBox(height: 40),
                        // Text("Fuel Type",
                        //     style: TextStyle(
                        //         fontSize: 21,
                        //         color: Colors.blue.shade800,
                        //         fontWeight: FontWeight.bold)),
                        // SizedBox(height: 10),
                        // StreamBuilder(
                        //   stream: db
                        //       .collection('Stations')
                        //       .doc(station)
                        //       .collection('Fuel_Type')
                        //       .snapshots(),
                        //   builder:
                        //       (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        //     if (snapshot.hasData) {
                        //       return Container(
                        //         width: 350.0,
                        //         height: 58,
                        //         decoration: ShapeDecoration(
                        //           shape: RoundedRectangleBorder(
                        //             side: BorderSide(
                        //                 width: 1.0, style: BorderStyle.solid),
                        //             borderRadius:
                        //                 BorderRadius.all(Radius.circular(15.0)),
                        //           ),
                        //         ),
                        //         child: DropdownButtonHideUnderline(
                        //           child: DropdownButton<String>(
                        //             isExpanded: true,
                        //             value: fuel_category,
                        //             icon: const Icon(Icons.arrow_drop_down),
                        //             iconSize: 24,
                        //             elevation: 16,
                        //             style: const TextStyle(
                        //                 color: Colors.deepPurple),
                        //             underline: Container(
                        //               height: 2,
                        //               color: Colors.deepPurpleAccent,
                        //             ),
                        //             onChanged: (String newValue) {
                        //               setState(() {
                        //                 fuel_category = newValue;
                        //               });
                        //             },
                        //             items: snapshot.data != null
                        //                 ? snapshot.data.docs
                        //                     .map((DocumentSnapshot document) {
                        //                     return new DropdownMenuItem<String>(
                        //                         value: document
                        //                             .get('Fuel_Type_Name')
                        //                             .toString(),
                        //                         child: new Container(
                        //                           child: Center(
                        //                             child: new Text(
                        //                               document
                        //                                   .get('Fuel_Type_Name')
                        //                                   .toString(),
                        //                               style: TextStyle(
                        //                                   fontSize: 20,
                        //                                   fontWeight:
                        //                                       FontWeight.w400),
                        //                             ),
                        //                           ),
                        //                         ));
                        //                   }).toList()
                        //                 : DropdownMenuItem(
                        //                     value: 'null',
                        //                     child: new Container(
                        //                       height: 100.0,
                        //                       child: new Text('null'),
                        //                     ),
                        //                   ),
                        //           ),
                        //         ),
                        //       );
                        //     } else {
                        //       return Text('');
                        //     }
                        //   },
                        // ),
                        SizedBox(height: 50),
                        Text("Volume",
                            style: TextStyle(
                                fontSize: 21,
                                color: Colors.blue.shade800,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        StreamBuilder(
                          stream: db
                              .collection('Stations')
                              .doc(station)
                              .collection('Container')
                              .where('Container_Name',
                                  isEqualTo: container_category)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              oldVolume =
                                  snapshot.data.docs[0].data()["Volume"];
                              var c = snapshot.data.docs[0].data()["Capacity"];
                              //print(v.toString());
                              //print(c.toString());
                              maxVolume = c - oldVolume;
                              return Column(
                                children: <Widget>[
                                  TextFormField(
                                      controller: volumeController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        ThousandsFormatter(),
                                      ],
                                      style: TextStyle(color: Colors.black),
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: colorE),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: colorE, width: 2.0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0)),
                                        ),
                                        labelText: maxVolume.toString() != null
                                            ? numberFormat
                                                .format(maxVolume)
                                                .toString()
                                            : '',
                                        fillColor: Colors.white,
                                        labelStyle:
                                            TextStyle(color: Colors.black45),
                                      ),
                                      onChanged: (String s) {
                                        String g =
                                            s.replaceAll(RegExp(','), '');
                                        volume = int.parse(g);
                                      }),
                                  Text(
                                    maxVolume == 0
                                        ? 'Container $container_category is full'
                                        : volumeError == 1
                                            ? 'Enter positive value less  than $maxVolume'
                                            : '',
                                    style: TextStyle(color: colorE),
                                  ),
                                ],
                              );
                            } else {
                              return Text('');
                            }
                          },
                        ),
                        SizedBox(height: 40),
                        Text("ShipmentValue(L.L)",
                            style: TextStyle(
                                fontSize: 21,
                                color: Colors.blue.shade800,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Column(
                          children: <Widget>[
                            TextFormField(
                                // inputFormatters: [
                                //   WhitelistingTextInputFormatter.digitsOnly,
                                //   new LengthLimitingTextInputFormatter(25),
                                //   new NumberFormatter()
                                // ],
                                inputFormatters: [
                                  ThousandsFormatter(),
                                ],
                                controller: valueController,
                                keyboardType: TextInputType.number,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: colorP),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: colorP, width: 2.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                  ),
                                  labelText: "value L.L",
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(color: Colors.black45),
                                ),
                                onChanged: (String s) {
                                  String g = s.replaceAll(RegExp(','), '');

                                  print('valueeeeeeeeees $g');
                                  shipmentValue = int.parse(g);
                                }),
                            Text(
                              shipmentValueError == 1
                                  ? 'Enter  positive value'
                                  : '',
                              style: TextStyle(color: colorP),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(children: [
                          Text("Paid : ",
                              style: TextStyle(
                                  fontSize: 21, color: Colors.black45)),
                          new Radio(
                              value: 1,
                              groupValue: _radioValue,
                              onChanged: (value) {
                                setState(() {
                                  _radioValue = value;
                                });
                              }),
                          new Text(
                            'Yes',
                            style: new TextStyle(
                                fontSize: 21.0, color: Colors.green),
                          ),
                          new Radio(
                            value: 0,
                            groupValue: _radioValue,
                            onChanged: (value) {
                              setState(() {
                                _radioValue = value;
                              });
                            },
                          ),
                          new Text(
                            'No',
                            style: new TextStyle(
                                fontSize: 21.0, color: Colors.red),
                          ),
                        ]),
                        SizedBox(height: 15),
                        TextFormField(
                            maxLines: 3,
                            controller: noteController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 2.0),
                                ),
                                labelText: "Note",
                                fillColor: Colors.black,
                                labelStyle: TextStyle(color: Colors.black45),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blueAccent, width: 2.0))),
                            onChanged: (String s) {
                              note = s;
                            }),
                        SizedBox(height: 12),
                        ButtonTheme(
                          height: 50.0,
                          minWidth: 130,
                          child: RaisedButton(
                            color: Colors.indigo[800],
                            elevation: 12,
                            child: Text('Save',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25)),
                            onPressed: () {
                              getIds();
                              getLastDocId();
                              int docID = lastID + 1;
                              print("doc idddddd: $docId");
                              if (selected_date == null) {
                                setState(() {
                                  dateError = 1;
                                  colorD = Colors.red;
                                });
                              }
                              if (volume == null ||
                                  volume > maxVolume ||
                                  volume < 0) {
                                setState(() {
                                  colorE = Colors.red;
                                  volumeError = 1;
                                });
                              } else {
                                setState(() {
                                  colorE = Colors.blueAccent;
                                  volumeError = 0;
                                });

                                if (shipmentValue == null ||
                                    shipmentValue < 0) {
                                  setState(() {
                                    colorP = Colors.red;
                                    shipmentValueError = 1;
                                  });
                                } else {
                                  setState(() {
                                    colorP = Colors.blueAccent[100];
                                    shipmentValueError = 0;
                                  });
                                }
                                if (volume != null &&
                                        volume > 0 &&
                                        shipmentValue != null &&
                                        shipmentValue > 0 &&
                                        selected_date !=
                                            null //&& correct date format
                                    ) {
                                  setState(() {
                                    colorP = Colors.blueAccent[100];
                                    shipmentValueError = 0;
                                    colorD = Colors.blueAccent[100];
                                    dateError = 0;
                                  });
                                  print(
                                      "Radio value isssssssssss $_radioValue");
                                  if (_radioValue == 1) {
                                    IsPaid = true;
                                    Paid_Date = Timestamp.fromDate(today);
                                  } else {
                                    IsPaid = false;
                                    Paid_Date = null;
                                  }
                                  int newVol = (oldVolume + volume);
                                  DateTime ship_date = ff.parse(selected_date);
                                  db
                                      .collection("Stations")
                                      .doc(station)
                                      .collection("Shipment")
                                      .doc(docID.toString())
                                      .set({
                                    'Comment': note != null ? note : '',
                                    'Container_Name': container_category,
                                    'IsPaid': IsPaid,
                                    'Paid_Date': Paid_Date,
                                    'Provider_Name': provider_category,
                                    'Shipment_Date':
                                        Timestamp.fromDate(ship_date),
                                    'Shipment_Id': docID != null ? docID : 0,
                                    'Shipment_Value': shipmentValue,
                                    'Shipment_Volume': volume
                                  }).then((value) {
                                    db
                                        .collection("Stations")
                                        .doc(station)
                                        .collection("Container")
                                        .doc(container_id.toString())
                                        .update({"Volume": newVol});
                                    noteController.clear();
                                    valueController.clear();
                                    volumeController.clear();
                                  }).catchError((onError) {
                                    print('error $onError');
                                  });
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ))
              ],
              backgroundColor: Colors.white,
              initiallyExpanded: false,
            ),
          ),

          SizedBox(height: 25),

          //*************************************************************************************//

          Card(
            elevation: 12,
            child: ExpansionTile(
              title: Text("Show Shipments",
                  style: TextStyle(fontSize: 29, color: Colors.blue[900])),
              trailing: Icon(Icons.arrow_drop_down,
                  size: 20, color: Colors.blue[900]),
              children: [
                Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(children: [
                      SizedBox(height: 10),
                      Text("Provider Name",
                          style:
                              TextStyle(fontSize: 21, color: Colors.black45)),
                      SizedBox(height: 10),
                      StreamBuilder(
                        stream: db
                            .collection('Stations')
                            .doc(station)
                            .collection('Provider')
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              width: 350.0,
                              height: 58,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1.0, style: BorderStyle.solid),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: provider_category_details,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  elevation: 16,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      provider_category_details = newValue;
                                    });
                                  },
                                  items: snapshot.data != null
                                      ? snapshot.data.docs
                                          .map((DocumentSnapshot document) {
                                          return new DropdownMenuItem<String>(
                                              value: document
                                                  .get('Provider_Name')
                                                  .toString(),
                                              child: new Container(
                                                child: Center(
                                                  child: new Text(
                                                    document
                                                        .get('Provider_Name')
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ),
                                                ),
                                              ));
                                        }).toList()
                                      : DropdownMenuItem(
                                          value: provider_category_details,
                                          child: new Container(
                                            height: 100.0,
                                            child: new Text('null'),
                                          ),
                                        ),
                                ),
                              ),
                            );
                          } else {
                            return Text('');
                          }
                        },
                      ),
                      SizedBox(height: 15),
                      SizedBox(height: 10),
                      Text("Container Name",
                          style:
                              TextStyle(fontSize: 21, color: Colors.black45)),
                      SizedBox(height: 10),
                      StreamBuilder(
                        stream: db
                            .collection('Stations')
                            .doc(station)
                            .collection('Container')
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              width: 350.0,
                              height: 58,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1.0, style: BorderStyle.solid),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: container_category_details,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  elevation: 16,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      container_category_details = newValue;
                                      //getVolume();
                                    });
                                  },
                                  items: snapshot.data != null
                                      ? snapshot.data.docs
                                          .map((DocumentSnapshot document) {
                                          return new DropdownMenuItem<String>(
                                              value: document
                                                  .get('Container_Name')
                                                  .toString(),
                                              child: new Container(
                                                child: Center(
                                                  child: new Text(
                                                    document
                                                        .get('Container_Name')
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ),
                                                ),
                                              ));
                                        }).toList()
                                      : DropdownMenuItem(
                                          value: container_category_details,
                                          child: new Container(
                                            height: 100.0,
                                            child: new Text('null'),
                                          ),
                                        ),
                                ),
                              ),
                            );
                          } else {
                            return Text('');
                          }
                        },
                      ),
                      SizedBox(height: 15),
                      Text("From Date",
                          style:
                              TextStyle(fontSize: 21, color: Colors.black45)),
                      SizedBox(height: 10),
                      TextFormField(
                          keyboardType: TextInputType.datetime,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.date_range_rounded,
                                color: Colors.indigo[300]),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorF),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorF, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                            labelText: ff.format(today),
                            fillColor: Colors.white,
                            labelStyle: TextStyle(color: Colors.black45),
                          ),
                          onChanged: (String s) {
                            fromDate = s;
                          }),
                      Text(
                        fromDateError == 1 ? 'Enter a valid date' : '',
                        style: TextStyle(color: colorF),
                      ),
                      SizedBox(height: 15),
                      Text("To Date",
                          style:
                              TextStyle(fontSize: 21, color: Colors.black45)),
                      SizedBox(height: 10),
                      TextFormField(
                          keyboardType: TextInputType.datetime,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.date_range_rounded,
                                color: Colors.indigo[300]),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorT),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorT, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                            labelText: ff.format(today),
                            fillColor: Colors.white,
                            labelStyle: TextStyle(color: Colors.black45),
                          ),
                          onChanged: (String s) {
                            toDate = s;
                          }),
                      Text(
                        toDateError == 1 ? 'Enter a valid date' : '',
                        style: TextStyle(color: colorT),
                      ),
                      SizedBox(height: 10),
                      ButtonTheme(
                        height: 50.0,
                        minWidth: 30,
                        child: RaisedButton(
                          color: Colors.indigo[800],
                          elevation: 12,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Filter',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25)),
                                Icon(Icons.filter_alt_outlined,
                                    color: Colors.white, size: 20)
                              ]),
                          onPressed: () {
                            filter_fct();
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            filter == 0
                                ? StreamBuilder(
                                    stream: db
                                        .collection('Stations')
                                        .doc(station)
                                        .collection('Shipment')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Text('ffff');
                                      } else {
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                                totalVolume != null
                                                    ? 'Total Volume : ${numberFormat.format(totalVolume)} Litters'
                                                    : 'Total Volume : 0 Litters',
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    color: Colors.indigo[900])),
                                            Text(
                                                totalDebt != null
                                                    ? 'Debt Money : ${numberFormat.format(totalDebt)} (L.L)'
                                                    : 'Debt Money : 0 (L.L)',
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    color: Colors.red[500])),
                                            Text(
                                                totalPaid != null
                                                    ? 'Total Paid : ${numberFormat.format(totalPaid)} (L.L)'
                                                    : 'Total Paid : 0 (L.L)',
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    color: Colors.red[500])),
                                          ],
                                        );
                                      }
                                    },
                                  )
                                : StreamBuilder(
                                    stream: db
                                        .collection('Stations')
                                        .doc(station)
                                        .collection('Shipment')
                                        .where('IsPaid', isEqualTo: false)
                                        .where('Container_Name',
                                            isEqualTo:
                                                container_category_details)
                                        .where('Provider_Name',
                                            isEqualTo:
                                                provider_category_details)
                                        .where('Shipment_Date',
                                            isGreaterThanOrEqualTo: mytimestamp)
                                        .where('Shipment_Date',
                                            isLessThanOrEqualTo: mytimestamp1)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Text('ffff');
                                      } else {
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                                totalDebtFilter != null
                                                    ? 'Debt Money : ${numberFormat.format(totalDebtFilter)} (L.L)'
                                                    : 'Debt Money : 0 (L.L)',
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    color: Colors.red[500])),
                                            Text(
                                                totalPaidFilter != null
                                                    ? 'Total Paid : ${numberFormat.format(totalPaidFilter)} (L.L)'
                                                    : 'Total Paid : 0 (L.L)',
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    color: Colors.red[500])),
                                          ],
                                        );
                                      }
                                    },
                                  ),
                            SizedBox(height: 55),
                            TextFormField(
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black, width: 2.0),
                                    ),
                                    labelText: "Search Here",
                                    fillColor: Colors.white,
                                    labelStyle:
                                        TextStyle(color: Colors.black45),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blueAccent,
                                            width: 2.0))),
                                onChanged: (String s) {}),
                            SizedBox(height: 55),
                            filter == 0
                                ? StreamBuilder(
                                    stream: db
                                        .collection('Stations')
                                        .doc(station)
                                        .collection('Shipment')
                                        .orderBy('Shipment_Date',
                                            descending: true)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      // if (provider_category_details == null ||
                                      //     container_category_details == null ||
                                      //     toDate == null ||
                                      //     fromDate == null) {

                                      //return all shipment records
                                      if (!snapshot.hasData) {
                                        return Text('');
                                      } else {
                                        return Column(
                                          //scrollDirection: Axis.horizontal,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text('Date'),
                                                Text('Volume'),
                                                Text('Container'),
                                                Text('Provider'),
                                                Text('Value(L.L)'),
                                                Text('Notes'),
                                                Text('Payment Date'),
                                                Text('Delete'),
                                              ],
                                            ),
                                            Divider(
                                              color: Colors.indigo,
                                              thickness: 4,
                                            ),
                                            ListView.builder(
                                                shrinkWrap: true,
                                                physics: ScrollPhysics(),
                                                itemCount:
                                                    snapshot.data.docs.length,
                                                itemBuilder: (context, index) {
                                                  print(
                                                      "gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg");
                                                  int length =
                                                      snapshot.data.docs.length;
                                                  DocumentSnapshot
                                                      documentSnapshot =
                                                      snapshot.data.docs[index];
                                                  Container_Name =
                                                      documentSnapshot[
                                                          'Container_Name'];
                                                  Provider_Name =
                                                      documentSnapshot[
                                                          'Provider_Name'];
                                                  int docID = documentSnapshot[
                                                      'Shipment_Id'];
                                                  String shipmentId =
                                                      docID.toString();
                                                  bool ISPaid =
                                                      documentSnapshot[
                                                          'IsPaid'];
                                                  int volume = documentSnapshot[
                                                      'Shipment_Volume'];
                                                  print(
                                                      'containerrrrrrrrrrrrrrrr $Container_Name');

                                                  //if (index == 1) {
                                                  //shipmentBeforeDelete =
                                                  //  documentSnapshot[
                                                  //    'Shipment_Volume'];
                                                  //}
                                                  // int provider_Id =
                                                  //     documentSnapshot[
                                                  //         'Provider_Id'];

                                                  return Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Text(formatter
                                                              .format(DateTime.tryParse(
                                                                  (documentSnapshot[
                                                                          'Shipment_Date'])
                                                                      .toDate()
                                                                      .toString()))
                                                              .toString()),
                                                          Text((numberFormat.format(
                                                                  documentSnapshot[
                                                                      'Shipment_Volume']))
                                                              .toString()),
                                                          Text(
                                                              'Container $Container_Name'),
                                                          Text(Provider_Name),
                                                          Text((numberFormat.format(
                                                                  documentSnapshot[
                                                                      'Shipment_Value']))
                                                              .toString()),
                                                          Text(documentSnapshot[
                                                              'Comment']),
                                                          ISPaid == false
                                                              ? GestureDetector(
                                                                  child:
                                                                      TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    db
                                                                        .collection(
                                                                            "Stations")
                                                                        .doc(
                                                                            station)
                                                                        .collection(
                                                                            "Shipment")
                                                                        .doc(
                                                                            shipmentId)
                                                                        .update({
                                                                      "IsPaid":
                                                                          true,
                                                                      "Paid_Date":
                                                                          Timestamp.fromDate(
                                                                              today)
                                                                    }).then((value) {
                                                                      setState(
                                                                          () {
                                                                        print(
                                                                            "afterrr updateee payyyyyyyy");
                                                                        ISPaid =
                                                                            true;
                                                                        // getTotalVolume();
                                                                        // getPaidMoney();
                                                                        // getDebtMoney();
                                                                      });
                                                                      refresh();
                                                                      // int pp =
                                                                      //     0;
                                                                      // FirebaseFirestore
                                                                      //     .instance
                                                                      //     .collection(
                                                                      //         'Stations')
                                                                      //     .doc(
                                                                      //         station)
                                                                      //     .collection(
                                                                      //         'Shipment')
                                                                      //     .where(
                                                                      //         'IsPaid',
                                                                      //         isEqualTo:
                                                                      //             true)
                                                                      //     .get()
                                                                      //     .then((val) =>
                                                                      //         {
                                                                      //           print(val),
                                                                      //           if (val.docs.length > 0)
                                                                      //             {
                                                                      //               print("lengthhhhhhhhhhh"),
                                                                      //               print(val.docs.length),
                                                                      //               for (var i = 0; i < val.docs.length; i++)
                                                                      //                 {
                                                                      //                   print("paiddddddddddddddd"),
                                                                      //                   print(val.docs[i].get("Shipment_Value")),
                                                                      //                   pp += val.docs[i].get("Shipment_Value"),
                                                                      //                 },
                                                                      //               print("totalllllll paid i pay:  $pp .............. "),
                                                                      //               setState(() {
                                                                      //                 totalPaid = pp;
                                                                      //                 print("totalllllll paid i pay:  $pp .............. $totalPaid");
                                                                      //               }),
                                                                      //             }
                                                                      //           else
                                                                      //             {
                                                                      //               print("Not Found")
                                                                      //             }
                                                                      //         });
                                                                      //
                                                                      // getPaidMoney();
                                                                      // getDebtMoney();
                                                                      //refresh();
                                                                      //   int dd =
                                                                      //       0;
                                                                      //   print(
                                                                      //       "debtttt calculationnnnn");
                                                                      //   db
                                                                      //       .collection(
                                                                      //           'Stations')
                                                                      //       .doc(
                                                                      //           station)
                                                                      //       .collection(
                                                                      //           'Shipment')
                                                                      //       .where(
                                                                      //           'IsPaid',
                                                                      //           isEqualTo:
                                                                      //               false)
                                                                      //       .get()
                                                                      //       .then((val) =>
                                                                      //           {
                                                                      //             print(val),
                                                                      //             if (val.docs.length > 0)
                                                                      //               {
                                                                      //                 print("lengthhhhhhhhhhh"),
                                                                      //                 print(val.docs.length),
                                                                      //                 for (var i = 0; i < val.docs.length; i++)
                                                                      //                   {
                                                                      //                     print("valueeeeeeeeeeeee"),
                                                                      //                     print(val.docs[i].get("Shipment_Value")),
                                                                      //                     dd += val.docs[i].get("Shipment_Value"),
                                                                      //                   },
                                                                      //                 setState(() {
                                                                      //                   totalDebt = dd;
                                                                      //                 }),
                                                                      //               }
                                                                      //           });
                                                                      // }).catchError(
                                                                      //         (onError) {
                                                                      //   print(
                                                                      //       "error update payyyyyyyy $onError");
                                                                    });
                                                                    //refresh();
                                                                  },
                                                                  child: Text(
                                                                      'Pay'),
                                                                  style:
                                                                      ButtonStyle(
                                                                    backgroundColor:
                                                                        MaterialStateProperty.all(
                                                                            Colors.green),
                                                                    shape: MaterialStateProperty
                                                                        .all<
                                                                            RoundedRectangleBorder>(
                                                                      RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ))
                                                              : Text(documentSnapshot[
                                                                          'Paid_Date'] !=
                                                                      null
                                                                  ? formatter
                                                                      .format(DateTime.tryParse((documentSnapshot[
                                                                              'Paid_Date'])
                                                                          .toDate()
                                                                          .toString()))
                                                                      .toString()
                                                                  : 'not paid'),
                                                          GestureDetector(
                                                              child: IconButton(
                                                            icon: const Icon(
                                                                Icons.delete),
                                                            color: Colors.red,
                                                            onPressed: () {
                                                              // getContainerOldVolume(
                                                              //   Container_Name);
                                                              print(
                                                                  "Deleteeeeeeeeeeeeeeeee");
                                                              int docID =
                                                                  documentSnapshot[
                                                                      'Shipment_Id'];
                                                              String docId = docID
                                                                  .toString();
                                                              showDialog<
                                                                  String>(
                                                                context:
                                                                    context,
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    AlertDialog(
                                                                  title: const Text(
                                                                      'DELETE !!!',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.red)),
                                                                  content:
                                                                      const Text(
                                                                          'Are you sure you want to delete ???'),
                                                                  actions: <
                                                                      Widget>[
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context,
                                                                            'Cancel');
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        'Cancel',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.red),
                                                                      ),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        //currentContainerVolume;
                                                                        int containerrr_iddd;
                                                                        int oldddd_volumeee =
                                                                            0;
                                                                        db
                                                                            .collection('Stations')
                                                                            .doc(station)
                                                                            .collection('Shipment')
                                                                            .doc(docId)
                                                                            .delete()
                                                                            .then((value) {
                                                                          db
                                                                              .collection('Stations')
                                                                              .doc(station)
                                                                              .collection('Container')
                                                                              .where('Container_Name', isEqualTo: Container_Name)
                                                                              .get()
                                                                              .then((val) => {
                                                                                    if (val.docs.length > 0)
                                                                                      {
                                                                                        print("lengthhhhhhhhhhh"),
                                                                                        print(val.docs.length),
                                                                                        //for (var i = 0; i < val.docs.length; i++)
                                                                                        //{
                                                                                        containerrr_iddd = val.docs[0].get("Container_Id"),
                                                                                        oldddd_volumeee = val.docs[0].get("Volume"),

                                                                                        print('conttttttt idddddddddddd $containerrr_iddd'),
                                                                                        print('olddddd volumeeeee $oldddd_volumeee'),
                                                                                        //},

                                                                                        add_Volume = (oldddd_volumeee - documentSnapshot['Shipment_Volume']), //documentSnapshot['Shipment_Volume'];
                                                                                        print('adddddddddd volumeeeeeeeee $add_Volume'),
                                                                                        print('shipmentttt volumeeeeee ${documentSnapshot['Shipment_Volume']}'),
                                                                                        db.collection('Stations').doc(station).collection('Container').doc(containerrr_iddd.toString()).update({
                                                                                          'Volume': add_Volume
                                                                                        }).then((value) {
                                                                                          // int g = 0;
                                                                                          // db.collection('Stations').doc(station).collection('Shipment').get().then((val) => {
                                                                                          //       if (val.docs.length > 0)
                                                                                          //         {
                                                                                          //           print("lengthhhhhhhhhhh"),
                                                                                          //           print(val.docs.length),
                                                                                          //           for (var i = 0; i < val.docs.length; i++)
                                                                                          //             {
                                                                                          //               print("Volumeeeeeeeeeeeeeeeeee"),
                                                                                          //               print(val.docs[i].get("Shipment_Volume")),
                                                                                          //               g += val.docs[i].get("Shipment_Volume"),
                                                                                          //             },
                                                                                          //           setState(() {
                                                                                          //             totalVolume = g;
                                                                                          //           }),
                                                                                          //         }
                                                                                          //       else
                                                                                          //         {print("Not Found")}
                                                                                          //     });

                                                                                          // int pp = 0;
                                                                                          // FirebaseFirestore.instance.collection('Stations').doc(station).collection('Shipment').where('IsPaid', isEqualTo: false).where('Container_Name', isEqualTo: Container_Name).where('Provider_Name', isEqualTo: Provider_Name).where('Shipment_Date', isGreaterThanOrEqualTo: myTimeStamp).where('Shipment_Date', isLessThanOrEqualTo: myTimeStamp1).get().then((val) => {
                                                                                          //       print(val),
                                                                                          //       if (val.docs.length > 0)
                                                                                          //         {
                                                                                          //           print("lengthhhhhhhhhhh"),
                                                                                          //           print(val.docs.length),
                                                                                          //           for (var i = 0; i < val.docs.length; i++)
                                                                                          //             {
                                                                                          //               print("valueeeeeeeeeeeee"),
                                                                                          //               print(val.docs[i].get("Shipment_Value")),
                                                                                          //               pp += val.docs[i].get("Shipment_Value"),
                                                                                          //             },
                                                                                          //           setState(() {
                                                                                          //             totalPaid = pp;
                                                                                          //           }),
                                                                                          //         }
                                                                                          //       else
                                                                                          //         {print("Not Found")}
                                                                                          //     });
                                                                                          //
                                                                                          // int dd = 0;
                                                                                          // FirebaseFirestore.instance.collection('Stations').doc(station).collection('Shipment').where('IsPaid', isEqualTo: false).where('Container_Name', isEqualTo: Container_Name).where('Provider_Name', isEqualTo: Provider_Name).where('Shipment_Date', isGreaterThanOrEqualTo: myTimeStamp).where('Shipment_Date', isLessThanOrEqualTo: myTimeStamp1).get().then((val) => {
                                                                                          //       print(val),
                                                                                          //       if (val.docs.length > 0)
                                                                                          //         {
                                                                                          //           print("lengthhhhhhhhhhh"),
                                                                                          //           print(val.docs.length),
                                                                                          //           for (var i = 0; i < val.docs.length; i++)
                                                                                          //             {
                                                                                          //               print("valueeeeeeeeeeeee"),
                                                                                          //               print(val.docs[i].get("Shipment_Value")),
                                                                                          //               dd += val.docs[i].get("Shipment_Value"),
                                                                                          //             },
                                                                                          //           setState(() {
                                                                                          //             totalDebt = dd;
                                                                                          //           }),
                                                                                          //         }
                                                                                          //       else
                                                                                          //         {print("Not Found")}
                                                                                          //     });
                                                                                          //getPaidMoney();
                                                                                          //getDebtMoney();
                                                                                          //refresh();

                                                                                          //setState(() {
                                                                                          refresh();
                                                                                          //});

                                                                                          // setState(() {
                                                                                          //   getDebtMoney();
                                                                                          //   getPaidMoney();
                                                                                          //   getTotalVolume();
                                                                                          // });
                                                                                        }),
                                                                                        print("deleteddddd"),
                                                                                      }
                                                                                    else
                                                                                      {
                                                                                        print("Not Found")
                                                                                      }
                                                                                  });
                                                                          Navigator.pop(
                                                                              context,
                                                                              'OK');
                                                                        });
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        'OK',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.green),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          )),
                                                        ],
                                                      ),
                                                    ],
                                                  );
                                                }),
                                          ],
                                        );
                                      }
                                    },
                                  )
                                : StreamBuilder(
                                    // zeeddd whereeeeeee
                                    stream: db
                                        .collection('Stations')
                                        .doc(station)
                                        .collection('Shipment')
                                        .where('Container_Name',
                                            isEqualTo:
                                                container_category_details)
                                        .where('Provider_Name',
                                            isEqualTo:
                                                provider_category_details)
                                        .where('Shipment_Date',
                                            isGreaterThanOrEqualTo: mytimestamp)
                                        .where('Shipment_Date',
                                            isLessThanOrEqualTo: mytimestamp1)
                                        .orderBy('Shipment_Date',
                                            descending: true)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      // if (provider_category_details == null ||
                                      //     container_category_details == null ||
                                      //     toDate == null ||
                                      //     fromDate == null) {

                                      //return all shipment records
                                      if (!snapshot.hasData) {
                                        return Text('');
                                      } else {
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text('Date'),
                                                Text('Volume'),
                                                Text('Container'),
                                                Text('Provider'),
                                                Text('Value(L.L)'),
                                                Text('Notes'),
                                                Text('Payment Date'),
                                                Text('Delete'),
                                              ],
                                            ),
                                            Divider(
                                              color: Colors.indigo,
                                              thickness: 4,
                                            ),
                                            ListView.builder(
                                                shrinkWrap: true,
                                                physics: ScrollPhysics(),
                                                itemCount:
                                                    snapshot.data.docs.length,
                                                itemBuilder: (context, index) {
                                                  print(
                                                      "tttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt");
                                                  int length =
                                                      snapshot.data.docs.length;
                                                  DocumentSnapshot
                                                      documentSnapshot =
                                                      snapshot.data.docs[index];
                                                  Container_Name =
                                                      documentSnapshot[
                                                          'Container_Name'];
                                                  Provider_Name =
                                                      documentSnapshot[
                                                          'Provider_Name'];
                                                  int docID = documentSnapshot[
                                                      'Shipment_Id'];
                                                  String shipmentId =
                                                      docID.toString();
                                                  bool ISPaid =
                                                      documentSnapshot[
                                                          'IsPaid'];

                                                  print(
                                                      'containerrrrrrrrrrrrrrrrfilttttttttttttttttttttttttttttttttterrrrrrrrr $Container_Name');
                                                  print(
                                                      'providerrrrrrrrrrfilttttttttttttttttttttttttttttttttterrrrrrrrr $Provider_Name');

                                                  // int provider_Id =
                                                  //     documentSnapshot[
                                                  //         'Provider_Id'];

                                                  return Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Text(formatter
                                                              .format(DateTime.tryParse(
                                                                  (documentSnapshot[
                                                                          'Shipment_Date'])
                                                                      .toDate()
                                                                      .toString()))
                                                              .toString()),
                                                          Text(numberFormat
                                                              .format(documentSnapshot[
                                                                  'Shipment_Volume'])
                                                              .toString()),
                                                          Text(
                                                              'Container $Container_Name'),
                                                          Text(Provider_Name),
                                                          Text(numberFormat
                                                              .format(documentSnapshot[
                                                                  'Shipment_Value'])
                                                              .toString()),
                                                          Text(documentSnapshot[
                                                              'Comment']),
                                                          ISPaid == false
                                                              ? GestureDetector(
                                                                  child:
                                                                      TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    db
                                                                        .collection(
                                                                            "Stations")
                                                                        .doc(
                                                                            station)
                                                                        .collection(
                                                                            "Shipment")
                                                                        .doc(
                                                                            shipmentId)
                                                                        .update({
                                                                      "IsPaid":
                                                                          true,
                                                                      "Paid_Date":
                                                                          Timestamp.fromDate(
                                                                              today)
                                                                    }).then(
                                                                            (value) {
                                                                      setState(
                                                                          () {
                                                                        ISPaid =
                                                                            true;

                                                                        //refresh();
                                                                        //setState(
                                                                        //     () {
                                                                        //   getDebtMoney();
                                                                        //   getPaidMoney();
                                                                        //   getTotalVolume();
                                                                        //});
                                                                      });
                                                                      refreshFilter(
                                                                          container_category_details,
                                                                          provider_category_details,
                                                                          fromDate,
                                                                          toDate);
                                                                      //
                                                                      // int pp =
                                                                      //     0;
                                                                      // FirebaseFirestore
                                                                      //     .instance
                                                                      //     .collection(
                                                                      //         'Stations')
                                                                      //     .doc(
                                                                      //         station)
                                                                      //     .collection(
                                                                      //         'Shipment')
                                                                      //     .where(
                                                                      //         'IsPaid',
                                                                      //         isEqualTo:
                                                                      //             true)
                                                                      //     .get()
                                                                      //     .then((val) =>
                                                                      //         {
                                                                      //           print(val),
                                                                      //           if (val.docs.length > 0)
                                                                      //             {
                                                                      //               print("lengthhhhhhhhhhh"),
                                                                      //               print(val.docs.length),
                                                                      //               for (var i = 0; i < val.docs.length; i++)
                                                                      //                 {
                                                                      //                   print("paiddddddddddddddd"),
                                                                      //                   print(val.docs[i].get("Shipment_Value")),
                                                                      //                   pp += val.docs[i].get("Shipment_Value"),
                                                                      //                 },
                                                                      //               setState(() {
                                                                      //                 totalPaidFilter = pp;
                                                                      //               }),
                                                                      //             }
                                                                      //           else
                                                                      //             {
                                                                      //               print("Not Found")
                                                                      //             }
                                                                      //         });
                                                                      //
                                                                      // int dd =
                                                                      //     0;
                                                                      // db
                                                                      //     .collection(
                                                                      //         'Stations')
                                                                      //     .doc(
                                                                      //         station)
                                                                      //     .collection(
                                                                      //         'Shipment')
                                                                      //     .where(
                                                                      //         'IsPaid',
                                                                      //         isEqualTo:
                                                                      //             false)
                                                                      //     .get()
                                                                      //     .then((val) =>
                                                                      //         {
                                                                      //           print(val),
                                                                      //           if (val.docs.length > 0)
                                                                      //             {
                                                                      //               print("lengthhhhhhhhhhh"),
                                                                      //               print(val.docs.length),
                                                                      //               for (var i = 0; i < val.docs.length; i++)
                                                                      //                 {
                                                                      //                   print("valueeeeeeeeeeeee"),
                                                                      //                   print(val.docs[i].get("Shipment_Value")),
                                                                      //                   dd += val.docs[i].get("Shipment_Value"),
                                                                      //                 },
                                                                      //               setState(() {
                                                                      //                 totalDebtFilter = dd;
                                                                      //               }),
                                                                      //             }
                                                                      //         });
                                                                    }).catchError(
                                                                            (onError) {
                                                                      print(
                                                                          "error update payyyyyyyy $onError");
                                                                    });
                                                                  },
                                                                  child: Text(
                                                                      'Pay'),
                                                                  style:
                                                                      ButtonStyle(
                                                                    backgroundColor:
                                                                        MaterialStateProperty.all(
                                                                            Colors.green),
                                                                    shape: MaterialStateProperty
                                                                        .all<
                                                                            RoundedRectangleBorder>(
                                                                      RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ))
                                                              : Text(documentSnapshot[
                                                                          'Paid_Date'] !=
                                                                      null
                                                                  ? formatter
                                                                      .format(DateTime.tryParse((documentSnapshot[
                                                                              'Paid_Date'])
                                                                          .toDate()
                                                                          .toString()))
                                                                      .toString()
                                                                  : 'not paid'),
                                                          GestureDetector(
                                                              child: IconButton(
                                                            icon: const Icon(
                                                                Icons.delete),
                                                            color: Colors.red,
                                                            onPressed: () {
                                                              print(
                                                                  "Deleteeeeeeeeeeeeeeeee");
                                                              int docID =
                                                                  documentSnapshot[
                                                                      'Shipment_Id'];
                                                              String docId = docID
                                                                  .toString();
                                                              showDialog<
                                                                  String>(
                                                                context:
                                                                    context,
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    AlertDialog(
                                                                  title: const Text(
                                                                      'DELETE !!!',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.red)),
                                                                  content:
                                                                      const Text(
                                                                          'Are you sure you want to delete ???'),
                                                                  actions: <
                                                                      Widget>[
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context,
                                                                            'Cancel');
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        'Cancel',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.red),
                                                                      ),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        int containerrr_iddd;
                                                                        int oldddd_volumeee =
                                                                            0;
                                                                        db
                                                                            .collection('Stations')
                                                                            .doc(station)
                                                                            .collection('Shipment')
                                                                            .doc(docId)
                                                                            .delete()
                                                                            .then((value) {
                                                                          db
                                                                              .collection('Stations')
                                                                              .doc(station)
                                                                              .collection('Container')
                                                                              .where('Container_Name', isEqualTo: Container_Name)
                                                                              .get()
                                                                              .then((val) => {
                                                                                    if (val.docs.length > 0)
                                                                                      {
                                                                                        print("lengthhhhhhhhhhh"),
                                                                                        print(val.docs.length),
                                                                                        //for (var i = 0; i < val.docs.length; i++)
                                                                                        //{
                                                                                        containerrr_iddd = val.docs[0].get("Container_Id"),
                                                                                        oldddd_volumeee = val.docs[0].get("Volume"),

                                                                                        print('conttttttt idddddddddddd $containerrr_iddd'),
                                                                                        print('olddddd volumeeeee $oldddd_volumeee'),
                                                                                        //},

                                                                                        add_Volume = oldddd_volumeee - documentSnapshot['Shipment_Volume'],
                                                                                        print('adddddddddd volumeeeeeeeee $add_Volume'),
                                                                                        print('shipmentttt volumeeeeee ${documentSnapshot['Shipment_Volume']}'),
                                                                                        db.collection('Stations').doc(station).collection('Container').doc(containerrr_iddd.toString()).update({
                                                                                          'Volume': add_Volume
                                                                                        }).then((value) {
                                                                                          //setState(() {
                                                                                          //getDebtMoney();
                                                                                          //getPaidMoney();
                                                                                          //getTotalVolume();
                                                                                          //});
                                                                                          // setState(() {
                                                                                          refreshFilter(container_category_details, provider_category_details, fromDate, toDate);

                                                                                          //});

                                                                                          //   int pp = 0;
                                                                                          //   FirebaseFirestore.instance.collection('Stations').doc(station).collection('Shipment').where('IsPaid', isEqualTo: true).get().then((val) => {
                                                                                          //         print(val),
                                                                                          //         if (val.docs.length > 0)
                                                                                          //           {
                                                                                          //             print("lengthhhhhhhhhhh"),
                                                                                          //             print(val.docs.length),
                                                                                          //             for (var i = 0; i < val.docs.length; i++)
                                                                                          //               {
                                                                                          //                 print("paiddddddddddddddd"),
                                                                                          //                 print(val.docs[i].get("Shipment_Value")),
                                                                                          //                 pp += val.docs[i].get("Shipment_Value"),
                                                                                          //               },
                                                                                          //             setState(() {
                                                                                          //               totalPaidFilter = pp;
                                                                                          //             }),
                                                                                          //           }
                                                                                          //         else
                                                                                          //           {print("Not Found")}
                                                                                          //       });
                                                                                          //
                                                                                          //   int dd = 0;
                                                                                          //   db.collection('Stations').doc(station).collection('Shipment').where('IsPaid', isEqualTo: false).get().then((val) => {
                                                                                          //         print(val),
                                                                                          //         if (val.docs.length > 0)
                                                                                          //           {
                                                                                          //             print("lengthhhhhhhhhhh"),
                                                                                          //             print(val.docs.length),
                                                                                          //             for (var i = 0; i < val.docs.length; i++)
                                                                                          //               {
                                                                                          //                 print("valueeeeeeeeeeeee"),
                                                                                          //                 print(val.docs[i].get("Shipment_Value")),
                                                                                          //                 dd += val.docs[i].get("Shipment_Value"),
                                                                                          //               },
                                                                                          //             setState(() {
                                                                                          //               totalDebtFilter = dd;
                                                                                          //             }),
                                                                                          //           }
                                                                                          //       });
                                                                                        }),

                                                                                        //getPaidMoney(),
                                                                                        //getDebtMoney(),

                                                                                        //refresh(),

                                                                                        print("deleteddddd"),
                                                                                      }
                                                                                    else
                                                                                      {
                                                                                        print("Not Found")
                                                                                      }
                                                                                  });
                                                                          Navigator.pop(
                                                                              context,
                                                                              'OK');
                                                                        });
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        'OK',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.green),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          )),
                                                        ],
                                                      ),
                                                    ],
                                                  );
                                                }),
                                          ],
                                        );
                                      }
                                    },
                                  ),
                            SizedBox(height: 20),
                            Divider(
                              color: Colors.black,
                            ),
                          ]),
                    ]))
              ],
              backgroundColor: Colors.white,
              initiallyExpanded: false,
            ),
          ),
        ],
      ),
    );
  }
}

//Custom InputFormatter
class NumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      print(text.length);

      if (nonZeroIndex == 1) {
        buffer.write(','); // Add double spaces.
      } else {
        if (nonZeroIndex == 4) {
          print("non");
          print(nonZeroIndex);
          if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
            buffer.write(','); // Add double spaces.
          }
        } else {
          if (nonZeroIndex != 3 &&
              nonZeroIndex % 3 == 1 &&
              nonZeroIndex != text.length) {
            buffer.write(','); // Add double spaces.
          }
        }
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}

//
// else {
// //filter shipments records
// return Column(); // kmn stream builder bs m3 where conditions 3l filter data
// }