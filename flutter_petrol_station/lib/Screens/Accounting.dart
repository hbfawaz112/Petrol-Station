import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_petrol_station/Widgets/Drawer.dart';
import 'package:intl/intl.dart';

class Accounting extends StatefulWidget {
  @override
  _AccountingState createState() => _AccountingState();
}

class _AccountingState extends State<Accounting> {
  DateTime first_record_data;
  String dropdownValue;
  int pumpid;
  int lastrecord;
  int totalbill = 0, totalprofit = 0;
  int sumrecords;
  DateTime dt;
  int price = 0, profit = 0;
  var formatter = NumberFormat('#,##,000');
  int button_type = -1;
  bool isloading = false;
  DateTime last_record_date;
  int previous_record_id;
  int contid; // for get the container id for specific pump
  String contname; //get container
  int calculationprofit, calculationprice;
  Fuel F;
  int previous_record;
  int idob;
  String nameob;
  var fuel_types;
  int pumpidtdy;
  TextEditingController t1 = new TextEditingController();
  TextEditingController t2 = new TextEditingController();
  int cont_id;
  String cont_name;

  DateTime lastpricedate, lastprofitdate;
  DateTime datetimetoday = DateTime.now();
  DateFormat ff;
  DateTime todayy;
  int container_id_tdy;
  int totalbilltdy = 0, totalprofittoday = 0;
  int lastpricetdy, lastprofittdy;
  int previous_price, previous_profit;
  DateTime previous_price_date;
  int sum_littres = 0;

  DateTime T1, T2;
  List<DateTime> AllDateTime;
  DateTime last_pump_record_timestamp;

  int totalbillchanged = 0;
  int totalprofitchanged = 0;

  int record_value, record_id;

  int lastR = 0;
  int today = 0;
  int submit = 0;

  List<specificfuel> L;

  void get_first_record_date() async {
    await FirebaseFirestore.instance
        .collection("Stations")
        .doc("Petrol Station 1")
        .collection("Pump_Record")
        .get()
        .then((value) => {
              if (value.docs.length > 0)
                {
                  first_record_data = DateTime.tryParse(
                      (value.docs[0].get("Record_Time")).toDate().toString()),
                }
            });
            
    print(" ... first_record_data in fuction ... ${first_record_data}");
    //
  }

  void getlastreacord() async {
    totalbill = 0;
    totalprofit = 0;
    totalbilltdy = 0;
    totalprofittoday = 0;
    totalbillchanged = 0;
    totalprofitchanged = 0;
    sum_littres = 0;
    calculationprice = 0;
    calculationprofit = 0;
    setState(() {
      isloading = true;
    });
    await FirebaseFirestore.instance
        .collection("Stations")
        .doc("Petrol Station 1")
        .collection("Pump")
        .get()
        .then((val) async => {
              if (val.docs.length > 0)
                {
                  print("Fet 1"),
                  for (int i = 0; i < val.docs.length; i++)
                    {
                      pumpid = val.docs[i].get("Pump_Id"),

                      contid = val.docs[i].get("Container_Id"),
                      print('pumpidddddddddddddddddddd ${pumpid}'),
                      print('contiddddddddddddddddddd ${contid}'),
                      await FirebaseFirestore.instance
                          .collection('Stations')
                          .doc("Petrol Station 1")
                          .collection('Container')
                          .where('Container_Id', isEqualTo: contid)
                          .get()
                          .then((val) async => {
                                contname = val.docs[0].get("Container_Name"),
                                print("Nameee in theeeennnnn ${contname}")
                              }),
                      // getContainerName(contid),
                      print('NAmeeeeeeeeeeeeeeeeeeeee ${contname}'),
                      await FirebaseFirestore.instance
                          .collection('Stations')
                          .doc("Petrol Station 1")
                          .collection('Pump_Record')
                          .where('Pump_Id', isEqualTo: pumpid)
                          .orderBy('Pump_Record_Id')
                          .get()
                          .then((val) async => {
                                if (val.docs.length > 0)
                                  {
                                    if (val.docs.length > 1)
                                      {
                                        previous_record = val
                                            .docs[val.docs.length - 2]
                                            .get("Record"),
                                      }
                                    else
                                      {
                                        previous_record = 0,
                                      },
                                    print("FETTTTTTTTTTTTTTTTTTTTTTT2"),
                                    lastrecord = val.docs[val.docs.length - 1]
                                        .get("Record"),
                                    print(
                                        "Lasttttttttttttttttt record ${lastrecord}"),
                                    dt = DateTime.tryParse(
                                        (val.docs[0].get("Record_Time"))
                                            .toDate()
                                            .toString()),
                                    await FirebaseFirestore.instance
                                        .collection('Stations')
                                        .doc("Petrol Station 1")
                                        .collection('Price-Profit')
                                        .where('Fuel_Type_Id',
                                            isEqualTo: contname)
                                        .where('Date',
                                            isLessThanOrEqualTo: val
                                                .docs[val.docs.length - 1]
                                                .get("Record_Time"))
                                        .get()
                                        .then((val) => {
                                              if (val.docs.length > 0)
                                                {
                                                  price = val
                                                      .docs[val.docs.length - 1]
                                                      .get("Official_Price"),
                                                  calculationprice =
                                                      (lastrecord -
                                                              previous_record) *
                                                          price,
                                                  profit = val
                                                      .docs[val.docs.length - 1]
                                                      .get("Official_Profit"),
                                                  calculationprofit =
                                                      (lastrecord -
                                                              previous_record) *
                                                          profit,
                                                  print(
                                                      "get it price : ${price}")
                                                }
                                            }),
                                    print(
                                        "calculationpriceeeeeeeeeeeeeeeeeeeeee : ${calculationprice}"),
                                    print(
                                        "calculationprofittttttttttttttttttt : ${calculationprofit}"),
                                  }
                                else
                                  {
                                    print("elseeeee"),
                                  }
                              }),
                      totalbill = totalbill + calculationprice,
                      totalprofit = totalprofit + calculationprofit,
                    }
                }
            });

    setState(() {
      isloading = false;
      button_type = 3;
      totalbill;
      totalprofit;
    });

    print("Total bill is ${totalbill}");
    print("Total profit is ${totalprofit}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    asyncmeth();
    // print('IN BUILD ${fuel_types[1].name.toString()}');
  }

  void asyncmeth() async {
    await getarrayoffueltypes();
    setState(() {
      dropdownValue = fuel_types[0].name.toString();
    });
  }

  void getarrayoffueltypes() async {
    fuel_types = new List<Fuel>();
    fuel_types.add(new Fuel(0, "All Fuel Type"));
    await FirebaseFirestore.instance
        .collection("Stations")
        .doc("Petrol Station 1")
        .collection("Fuel_Type")
        .get()
        .then((val) => {
              for (int i = 0; i < val.docs.length; i++)
                {
                  idob = val.docs[i].get("Fuel_Type_Id"),
                  nameob = val.docs[i].get("Fuel_Type_Name").toString(),
                  F = new Fuel(idob, nameob),
                  print("OBJECTTT ${F.name}"),
                  fuel_types.add(F),
                },
            });

    print(fuel_types);
  }

  void gettoday1() async {
    L = new List();

    setState(() {
      isloading = true;
    });
    sum_littres = 0;
    totalbilltdy = 0;
    totalprofittoday = 0;
    totalbillchanged = 0;
    totalprofitchanged = 0;
    L.clear();
    int cont_id;
    String cont_name;
    if (dropdownValue == "All Fuel Type") {
      await FirebaseFirestore.instance
          .collection('Stations')
          .doc("Petrol Station 1")
          .collection('Container')
          .get()
          .then((val) async => {
                if (val.docs.length > 0)
                  {
                    for (int k = 0; k < val.docs.length; k++)
                      {
                        totalbillchanged = 0,
                        totalprofitchanged = 0,
                        sum_littres = 0,
                        cont_id = val.docs[k].get("Container_Id"),
                        cont_name = val.docs[k].get("Container_Name"),
                        print("Contttttttainerrrrrrrrrr name: $cont_name"),
                        await FirebaseFirestore.instance
                            .collection('Stations')
                            .doc("Petrol Station 1")
                            .collection('Pump')
                            .where('Container_Id', isEqualTo: cont_id)
                            .get()
                            .then((val3) async => {
                                  if (val3.docs.length > 0)
                                    {
                                      for (int l = 0; l < val3.docs.length; l++)
                                        {
                                          //foreach pump get all pump records
                                          pumpidtdy =
                                              val3.docs[l].get("Pump_Id"),
                                          print("pump id: $pumpidtdy"),
                                          await FirebaseFirestore.instance
                                              .collection("Stations")
                                              .doc("Petrol Station 1")
                                              .collection("Pump_Record")
                                              .where("Container_Id",
                                                  isEqualTo: cont_id)
                                              .where("Pump_Id",
                                                  isEqualTo: pumpidtdy)
                                              .where("Record_Time",
                                                  isGreaterThanOrEqualTo:
                                                      todayy)
                                              .orderBy("Record_Time",
                                                  descending: true)
                                              .get()
                                              .then((val1) async => {
                                                    if (val1.docs.length > 0)
                                                      {
                                                        //loop over all pump records
                                                        //foreach pump record get its date
                                                        //and then get the last price-profit where price-profit date
                                                        //smaller than the record date
                                                        for (int y = 0;
                                                            y <
                                                                val1.docs
                                                                    .length;
                                                            y++)
                                                          {
                                                            record_value = val1
                                                                .docs[y]
                                                                .get("Record"),
                                                            record_id = val1
                                                                .docs[y]
                                                                .get(
                                                                    "Pump_Record_Id"),
                                                            print(
                                                                "recordd iddd : $record_id"),
                                                            print(
                                                                "record value : $record_value"),
                                                            last_pump_record_timestamp =
                                                                DateTime.tryParse((val1
                                                                        .docs[y]
                                                                        .get(
                                                                            "Record_Time"))
                                                                    .toDate()
                                                                    .toString()),
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'Stations')
                                                                .doc(
                                                                    "Petrol Station 1")
                                                                .collection(
                                                                    'Price-Profit')
                                                                .where(
                                                                    'Fuel_Type_Id',
                                                                    isEqualTo:
                                                                        cont_name)
                                                                .where('Date',
                                                                    isLessThanOrEqualTo:
                                                                        last_pump_record_timestamp)
                                                                .orderBy('Date',
                                                                    descending:
                                                                        true)
                                                                .get()
                                                                .then(
                                                                    (value) async =>
                                                                        {
                                                                          if (value.docs.length >
                                                                              0)
                                                                            {
                                                                              lastpricetdy = value.docs[0].get("Official_Price"),
                                                                              lastprofittdy = value.docs[0].get("Official_Profit"),
                                                                              lastpricedate = DateTime.tryParse((value.docs[0].get("Date")).toDate().toString()),
                                                                              print("price-profit date $lastpricedate < last record $last_pump_record_timestamp"),
                                                                              print('Dateeeeeeeeeeeeee ${lastpricedate}'),
                                                                              print('priceeeeeee ${lastpricetdy}'),
                                                                              print('profittttt ${lastprofittdy}'),
                                                                              if (val1.docs[y].get("Pump_Record_Id") == 1)
                                                                                {
                                                                                  totalbilltdy = totalbilltdy + (val1.docs[y].get("Record") * lastpricetdy),
                                                                                  totalbillchanged = totalbillchanged + (val1.docs[y].get("Record") * lastpricetdy),
                                                                                  totalprofittoday = totalprofittoday + (val1.docs[y].get("Record") * lastprofittdy),
                                                                                  totalprofitchanged = totalprofitchanged + (val1.docs[y].get("Record") * lastprofittdy),
                                                                                  sum_littres = sum_littres + val1.docs[y].get("Record"),
                                                                                  print("Torla billll a ${totalbillchanged}"),
                                                                                  print("Torla profittt a ${totalprofitchanged}"),
                                                                                }
                                                                              else
                                                                                {
                                                                                  await FirebaseFirestore.instance.collection("Stations").doc("Petrol Station 1").collection("Pump_Record").where("Container_Id", isEqualTo: cont_id).where("Pump_Id", isEqualTo: pumpidtdy).orderBy("Pump_Record_Id").get().then((value1) => {
                                                                                        if (value1.docs.length > 0)
                                                                                          {
                                                                                            for (int t = 0; t < value1.docs.length; t++)
                                                                                              {
                                                                                                if (value1.docs[t].get("Pump_Record_Id") == record_id)
                                                                                                  {
                                                                                                    if (t == 0)
                                                                                                      {
                                                                                                        previous_record_id = 0,
                                                                                                        previous_record = 0,
                                                                                                      }
                                                                                                    else
                                                                                                      {
                                                                                                        previous_record_id = value1.docs[t - 1].get("Pump_Record_Id"),
                                                                                                        print("previous idddd ${previous_record_id}"),
                                                                                                        previous_record = value1.docs[t - 1].get("Record"),
                                                                                                        print("previous record ${previous_record}"),
                                                                                                        //totalbilltdy = totalbilltdy + ((val1.docs[y].get("Record") - previous_record) * lastpricetdy),
                                                                                                        //totalprofittoday = totalprofittoday + ((val1.docs[y].get("Record") - previous_record) * lastprofittdy),
                                                                                                      },
                                                                                                    sum_littres = sum_littres + (val1.docs[y].get("Record") - previous_record),
                                                                                                    totalbilltdy = totalbilltdy + ((val1.docs[y].get("Record") - previous_record) * lastpricetdy),
                                                                                                    totalprofittoday = totalprofittoday + ((val1.docs[y].get("Record") - previous_record) * lastprofittdy),
                                                                                                    totalbillchanged = totalbillchanged + ((val1.docs[y].get("Record") - previous_record) * lastpricetdy),
                                                                                                    totalprofitchanged = totalprofitchanged + ((val1.docs[y].get("Record") - previous_record) * lastprofittdy),
                                                                                                    print("Torla billll changedd  a ${totalbillchanged}"),
                                                                                                    print("Torla profittt changedd  a ${totalprofitchanged}"),
                                                                                                    print("Torla sum littre a ${sum_littres}"),
                                                                                                  }
                                                                                              },
                                                                                          }
                                                                                      }),
                                                                                },
                                                                            }
                                                                        }),
                                                          }
                                                      }
                                                  }),
                                        }
                                    }
                                }),
                        L.add(new specificfuel(cont_name, totalbillchanged,
                            totalprofitchanged, sum_littres)),
                      },
                    print("total billlll $totalbilltdy"),
                    L.add(new specificfuel(
                        "Total", totalbilltdy, totalprofittoday, 0)),
                  }
              });
    } else {
      print("elseee specificccccc");
      sum_littres = 0;
      //cont_id = val.docs[k].get("Container_Id"),
      cont_name = dropdownValue;
      print("contanier nameeeeeeeee: $cont_name");
      await FirebaseFirestore.instance
          .collection('Stations')
          .doc("Petrol Station 1")
          .collection('Container')
          .where('Container_Name', isEqualTo: dropdownValue)
          .get()
          .then((val) async => {
                if (val.docs.length > 0)
                  {
                    cont_id = val.docs[0].get("Container_Id"),
                    print("Contttttttainerrrrrrrrrr name: $cont_name"),
                    await FirebaseFirestore.instance
                        .collection('Stations')
                        .doc("Petrol Station 1")
                        .collection('Pump')
                        .where('Container_Id', isEqualTo: cont_id)
                        .get()
                        .then((val3) async => {
                              if (val3.docs.length > 0)
                                {
                                  for (int l = 0; l < val3.docs.length; l++)
                                    {
                                      //foreach pump get all pump records
                                      pumpidtdy = val3.docs[l].get("Pump_Id"),
                                      print("pump id: $pumpidtdy"),
                                      await FirebaseFirestore.instance
                                          .collection("Stations")
                                          .doc("Petrol Station 1")
                                          .collection("Pump_Record")
                                          .where("Container_Id",
                                              isEqualTo: cont_id)
                                          .where("Pump_Id",
                                              isEqualTo: pumpidtdy)
                                          .where("Record_Time",
                                              isGreaterThanOrEqualTo: todayy)
                                          .orderBy("Record_Time",
                                              descending: true)
                                          .get()
                                          .then((val1) async => {
                                                if (val1.docs.length > 0)
                                                  {
                                                    //loop over all pump records
                                                    //foreach pump record get its date
                                                    //and then get the last price-profit where price-profit date
                                                    //smaller than the record date
                                                    for (int y = 0;
                                                        y < val1.docs.length;
                                                        y++)
                                                      {
                                                        record_value = val1
                                                            .docs[y]
                                                            .get("Record"),
                                                        record_id = val1.docs[y]
                                                            .get(
                                                                "Pump_Record_Id"),
                                                        print(
                                                            "recordd iddd : $record_id"),
                                                        print(
                                                            "record value : $record_value"),
                                                        last_pump_record_timestamp =
                                                            DateTime.tryParse(
                                                                (val1.docs[y].get(
                                                                        "Record_Time"))
                                                                    .toDate()
                                                                    .toString()),
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'Stations')
                                                            .doc(
                                                                "Petrol Station 1")
                                                            .collection(
                                                                'Price-Profit')
                                                            .where(
                                                                'Fuel_Type_Id',
                                                                isEqualTo:
                                                                    cont_name)
                                                            .where('Date',
                                                                isLessThanOrEqualTo:
                                                                    last_pump_record_timestamp)
                                                            .orderBy('Date',
                                                                descending:
                                                                    true)
                                                            .get()
                                                            .then(
                                                                (value) async =>
                                                                    {
                                                                      if (value
                                                                              .docs
                                                                              .length >
                                                                          0)
                                                                        {
                                                                          lastpricetdy = value
                                                                              .docs[0]
                                                                              .get("Official_Price"),
                                                                          lastprofittdy = value
                                                                              .docs[0]
                                                                              .get("Official_Profit"),
                                                                          lastpricedate = DateTime.tryParse((value.docs[0].get("Date"))
                                                                              .toDate()
                                                                              .toString()),
                                                                          print(
                                                                              "price-profit date $lastpricedate < last record $last_pump_record_timestamp"),
                                                                          print(
                                                                              'Dateeeeeeeeeeeeee ${lastpricedate}'),
                                                                          print(
                                                                              'priceeeeeee ${lastpricetdy}'),
                                                                          print(
                                                                              'profittttt ${lastprofittdy}'),
                                                                          print(
                                                                              "val1111111 record id"),
                                                                          print(val1
                                                                              .docs[y]
                                                                              .get('Pump_Record_Id')),
                                                                          if (val1.docs[y].get('Pump_Record_Id') ==
                                                                              1)
                                                                            {
                                                                              totalbilltdy = totalbilltdy + (val1.docs[y].get("Record") * lastpricetdy),
                                                                              totalprofittoday = totalprofittoday + (val1.docs[y].get("Record") * lastprofittdy),
                                                                              sum_littres = sum_littres + val1.docs[y].get("Record"),
                                                                              print("Torla billll a ${totalbilltdy}"),
                                                                              print("Torla profittt a ${totalprofittoday}"),
                                                                            }
                                                                          else
                                                                            {
                                                                              print("elsee record id ==== $record_id"),
                                                                              await FirebaseFirestore.instance.collection("Stations").doc("Petrol Station 1").collection("Pump_Record").where("Pump_Id", isEqualTo: pumpidtdy).where("Container_Id", isEqualTo: cont_id).orderBy("Pump_Record_Id").get().then((value1) => {
                                                                                    if (value1.docs.length > 0)
                                                                                      {
                                                                                        print("pump records to get previous"),
                                                                                        for (int t = 0; t < value1.docs.length; t++)
                                                                                          {
                                                                                            if (value1.docs[t].get("Pump_Record_Id") == record_id)
                                                                                              {
                                                                                                if (t == 0)
                                                                                                  {
                                                                                                    previous_record_id = 0,
                                                                                                    previous_record = 0,
                                                                                                  }
                                                                                                else
                                                                                                  {
                                                                                                    previous_record_id = value1.docs[t - 1].get("Pump_Record_Id"),
                                                                                                    print("previous idddd ${previous_record_id}"),
                                                                                                    previous_record = value1.docs[t - 1].get("Record"),
                                                                                                    print("previous record ${previous_record}"),
                                                                                                    //totalbilltdy = totalbilltdy + ((val1.docs[y].get("Record") - previous_record) * lastpricetdy),
                                                                                                    //totalprofittoday = totalprofittoday + ((val1.docs[y].get("Record") - previous_record) * lastprofittdy),
                                                                                                  },
                                                                                                sum_littres = sum_littres + (val1.docs[y].get("Record") - previous_record),
                                                                                                totalbilltdy = totalbilltdy + ((val1.docs[y].get("Record") - previous_record) * lastpricetdy),
                                                                                                totalprofittoday = totalprofittoday + ((val1.docs[y].get("Record") - previous_record) * lastprofittdy),
                                                                                                print("Torla billll a ${totalbilltdy}"),
                                                                                                print("Torla profittt a ${totalprofittoday}"),
                                                                                                print("Torla sum littre a ${sum_littres}"),
                                                                                              }
                                                                                            //  else{
                                                                                            //continue,}
                                                                                          },
                                                                                      },

                                                                                    //}
                                                                                  }),
                                                                            },
                                                                        }
                                                                    }),
                                                      },
                                                    L.add(new specificfuel(
                                                        cont_name,
                                                        totalbilltdy,
                                                        totalprofittoday,
                                                        sum_littres)),
                                                  }
                                              }),
                                    }
                                }
                            }),
                  }
              });

      print("total billlll $totalbilltdy");
    }
    setState(() {
      isloading = false;
    });
  }

  List<DateTime> getDaysInBeteween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(DateTime(
          startDate.year,
          startDate.month,
          // In Dart you can set more than. 30 days, DateTime will do the trick
          startDate.day + i));
    }
    return days;
  }

  void submitbtn() async {
    L = new List();

    setState(() {
      isloading = true;
    });
    totalbilltdy = 0;
    totalprofittoday = 0;
    totalbillchanged = 0;
    totalprofitchanged = 0;
    sum_littres = 0;
    L.clear();

    print("todayy ${todayy}");
    T1 = ff.parse(t1.text);
    T2 = ff.parse(t2.text);

    print("T1111 ${T1}");
    print("T1111 ${T2}");

    AllDateTime = getDaysInBeteween(T1, T2);
    //print(AllDateTime);
    if (dropdownValue == "All Fuel Type") {
      //lopp container:
      await FirebaseFirestore.instance
          .collection('Stations')
          .doc("Petrol Station 1")
          .collection('Container')
          .get()
          .then((val) async => {
                if (val.docs.length > 0)
                  {
                    for (int k = 0; k < val.docs.length; k++)
                      {
                        cont_id = val.docs[k].get("Container_Id"),
                        cont_name = val.docs[k].get("Container_Name"),
                        print("Contaein nameee isss ${cont_name}"),
                        await FirebaseFirestore.instance
                            .collection('Stations')
                            .doc("Petrol Station 1")
                            .collection('Pump')
                            .where('Container_Id', isEqualTo: cont_id)
                            .get()
                            .then((val) async => {
                                  if (val.docs.length > 0)
                                    {
                                      for (int i = 0; i < val.docs.length; i++)
                                        {
                                          pumpidtdy =
                                              val.docs[i].get("Pump_Id"),
                                          for (int i = 0;
                                              i < AllDateTime.length;
                                              i++)
                                            {
                                              // get price btween i i+1
                                              if (i == AllDateTime.length - 1)
                                                {
                                                  print(
                                                      " ***********i==AllDateTime.length-1****************"),
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('Stations')
                                                      .doc("Petrol Station 1")
                                                      .collection(
                                                          'Price-Profit')
                                                      .where('Fuel_Type_Id',
                                                          isEqualTo: cont_name)
                                                      .where('Date',
                                                          isGreaterThanOrEqualTo:
                                                              AllDateTime[i])
                                                      .get()
                                                      .then((value) async => {
                                                            if (value.docs
                                                                    .length >
                                                                0)
                                                              {
                                                                lastpricetdy = value
                                                                    .docs[value
                                                                            .docs
                                                                            .length -
                                                                        1]
                                                                    .get(
                                                                        "Official_Price"),
                                                                lastprofittdy = value
                                                                    .docs[value
                                                                            .docs
                                                                            .length -
                                                                        1]
                                                                    .get(
                                                                        "Official_Profit"),
                                                                lastpricedate = DateTime.tryParse((value
                                                                        .docs[value.docs.length -
                                                                            1]
                                                                        .get(
                                                                            "Date"))
                                                                    .toDate()
                                                                    .toString()),
                                                                print(
                                                                    "Prices is ${lastpricetdy}"),

                                                                //get reacords
                                                                await FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'Stations')
                                                                    .doc(
                                                                        "Petrol Station 1")
                                                                    .collection(
                                                                        'Pump_Record')
                                                                    .where(
                                                                        "Container_Id",
                                                                        isEqualTo:
                                                                            cont_id)
                                                                    .where(
                                                                        "Pump_Id",
                                                                        isEqualTo:
                                                                            pumpidtdy)
                                                                    .where(
                                                                        "Record_Time",
                                                                        isGreaterThanOrEqualTo:
                                                                            AllDateTime[
                                                                                i])
                                                                    .orderBy(
                                                                        "Record_Time",
                                                                        descending:
                                                                            true)
                                                                    .get()
                                                                    .then(
                                                                        (val1) async =>
                                                                            {
                                                                              for (int y = 0; y < val1.docs.length; y++)
                                                                                {
                                                                                  record_id = val1.docs[y].get("Pump_Record_Id"),
                                                                                  record_value = val1.docs[y].get("Record"),
                                                                                  if (val1.docs[y].get('Pump_Record_Id') == 1)
                                                                                    {
                                                                                      totalbilltdy = totalbilltdy + (val1.docs[y].get("Record") * lastpricetdy),
                                                                                      totalprofittoday = totalprofittoday + (val1.docs[y].get("Record") * lastprofittdy),
                                                                                      totalprofitchanged = totalprofitchanged + (val1.docs[y].get("Record") * lastprofittdy),
                                                                                      totalbillchanged = totalbillchanged + (val1.docs[y].get("Record") * lastpricetdy),
                                                                                      sum_littres = sum_littres + val1.docs[y].get("Record"),
                                                                                      print("Torla billll a ${totalbillchanged}"),
                                                                                      print("Torla profittt a ${totalprofitchanged}"),
                                                                                    }
                                                                                  else
                                                                                    {
                                                                                      print("elsee record id ==== $record_id"),
                                                                                      await FirebaseFirestore.instance.collection("Stations").doc("Petrol Station 1").collection("Pump_Record").where("Container_Id", isEqualTo: cont_id).where("Pump_Id", isEqualTo: pumpidtdy).orderBy("Pump_Record_Id").get().then((value1) => {
                                                                                            if (value1.docs.length > 0)
                                                                                              {
                                                                                                print("pump records to get previous"),
                                                                                                for (int t = 0; t < value1.docs.length; t++)
                                                                                                  {
                                                                                                    if (value1.docs[t].get("Pump_Record_Id") == record_id)
                                                                                                      {
                                                                                                        if (t == 0)
                                                                                                          {
                                                                                                            previous_record_id = 0,
                                                                                                            previous_record = 0,
                                                                                                          }
                                                                                                        else
                                                                                                          {
                                                                                                            previous_record_id = value1.docs[t - 1].get("Pump_Record_Id"),
                                                                                                            print("previous idddd ${previous_record_id}"),
                                                                                                            previous_record = value1.docs[t - 1].get("Record"),
                                                                                                            print("previous record ${previous_record}"),
                                                                                                            //totalbilltdy = totalbilltdy + ((val1.docs[y].get("Record") - previous_record) * lastpricetdy),
                                                                                                            //totalprofittoday = totalprofittoday + ((val1.docs[y].get("Record") - previous_record) * lastprofittdy),
                                                                                                          },
                                                                                                        sum_littres = sum_littres + (val1.docs[y].get("Record") - previous_record),
                                                                                                        totalbilltdy = totalbilltdy + ((val1.docs[y].get("Record") - previous_record) * lastpricetdy),
                                                                                                        totalprofittoday = totalprofittoday + ((val1.docs[y].get("Record") - previous_record) * lastprofittdy),
                                                                                                        totalbillchanged = totalbillchanged + ((val1.docs[y].get("Record") - previous_record) * lastpricetdy),
                                                                                                        totalprofitchanged = totalprofitchanged + ((val1.docs[y].get("Record") - previous_record) * lastprofittdy),
                                                                                                        print("Torla billll a ${totalbillchanged}"),
                                                                                                        print("Torla profittt a ${totalprofitchanged}"),
                                                                                                        print("Torla sum littre a ${sum_littres}"),
                                                                                                      }
                                                                                                    //  else{
                                                                                                    //continue,}
                                                                                                  },
                                                                                              },

                                                                                            //}
                                                                                          }),
                                                                                    },
                                                                                }
                                                                            })
                                                              }
                                                          }),
                                                }
                                              else
                                                {
                                                  print(
                                                      " ***********NOT i==AllDateTime.length-1****************"),
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('Stations')
                                                      .doc("Petrol Station 1")
                                                      .collection(
                                                          'Price-Profit')
                                                      .where('Fuel_Type_Id',
                                                          isEqualTo: cont_name)
                                                      .where('Date',
                                                          isGreaterThanOrEqualTo:
                                                              AllDateTime[i])
                                                      .where('Date',
                                                          isLessThanOrEqualTo:
                                                              AllDateTime[
                                                                  i + 1])
                                                      .get()
                                                      .then((value) async => {
                                                            if (value.docs
                                                                    .length >
                                                                0)
                                                              {
                                                                lastpricetdy = // b3den : get last price btwenn these 2 days
                                                                    value.docs[
                                                                            value.docs.length -
                                                                                1]
                                                                        .get(
                                                                            "Official_Price"),
                                                                lastprofittdy = value
                                                                    .docs[value
                                                                            .docs
                                                                            .length -
                                                                        1]
                                                                    .get(
                                                                        "Official_Profit"),
                                                                lastpricedate = DateTime.tryParse((value
                                                                        .docs[value.docs.length -
                                                                            1]
                                                                        .get(
                                                                            "Date"))
                                                                    .toDate()
                                                                    .toString()),
                                                                print(
                                                                    "Prices is ${lastpricetdy}"),

                                                                //get reacords
                                                                await FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'Stations')
                                                                    .doc(
                                                                        "Petrol Station 1")
                                                                    .collection(
                                                                        'Pump_Record')
                                                                    .where(
                                                                        "Container_Id",
                                                                        isEqualTo:
                                                                            cont_id)
                                                                    .where(
                                                                        "Pump_Id",
                                                                        isEqualTo:
                                                                            pumpidtdy)
                                                                    .where(
                                                                        "Record_Time",
                                                                        isGreaterThanOrEqualTo: AllDateTime[
                                                                            i])
                                                                    .where(
                                                                        'Record_Time',
                                                                        isLessThanOrEqualTo: AllDateTime[i +
                                                                            1])
                                                                    .orderBy(
                                                                        "Record_Time",
                                                                        descending:
                                                                            true)
                                                                    .get()
                                                                    .then(
                                                                        (val1) async =>
                                                                            {
                                                                              for (int y = 0; y < val1.docs.length; y++)
                                                                                {
                                                                                  record_id = val1.docs[y].get("Pump_Record_Id"),
                                                                                  record_value = val1.docs[y].get("Record"),

                                                                                  if (val1.docs[y].get('Pump_Record_Id') == 1)
                                                                                    {
                                                                                      totalbilltdy = totalbilltdy + (val1.docs[y].get("Record") * lastpricetdy),
                                                                                      totalprofittoday = totalprofittoday + (val1.docs[y].get("Record") * lastprofittdy),
                                                                                      sum_littres = sum_littres + val1.docs[y].get("Record"),
                                                                                      print("Torla billll a ${totalbilltdy}"),
                                                                                      print("Torla profittt a ${totalprofittoday}"),
                                                                                    }
                                                                                  else
                                                                                    {
                                                                                      print("elsee record id ==== $record_id"),
                                                                                      await FirebaseFirestore.instance.collection("Stations").doc("Petrol Station 1").collection("Pump_Record").where("Pump_Id", isEqualTo: pumpidtdy).where("Container_Id", isEqualTo: cont_id).orderBy("Pump_Record_Id").get().then((value1) => {
                                                                                            if (value1.docs.length > 0)
                                                                                              {
                                                                                                print("pump records to get previous"),
                                                                                                for (int t = 0; t < value1.docs.length; t++)
                                                                                                  {
                                                                                                    if (value1.docs[t].get("Pump_Record_Id") == record_id)
                                                                                                      {
                                                                                                        if (t == 0)
                                                                                                          {
                                                                                                            previous_record_id = 0,
                                                                                                            previous_record = 0,
                                                                                                          }
                                                                                                        else
                                                                                                          {
                                                                                                            previous_record_id = value1.docs[t - 1].get("Pump_Record_Id"),
                                                                                                            print("previous idddd ${previous_record_id}"),
                                                                                                            previous_record = value1.docs[t - 1].get("Record"),
                                                                                                            print("previous record ${previous_record}"),
                                                                                                            //totalbilltdy = totalbilltdy + ((val1.docs[y].get("Record") - previous_record) * lastpricetdy),
                                                                                                            //totalprofittoday = totalprofittoday + ((val1.docs[y].get("Record") - previous_record) * lastprofittdy),
                                                                                                          },
                                                                                                        sum_littres = sum_littres + (val1.docs[y].get("Record") - previous_record),
                                                                                                        totalbilltdy = totalbilltdy + ((val1.docs[y].get("Record") - previous_record) * lastpricetdy),
                                                                                                        totalprofittoday = totalprofittoday + ((val1.docs[y].get("Record") - previous_record) * lastprofittdy),
                                                                                                        totalbillchanged = totalbillchanged + ((val1.docs[y].get("Record") - previous_record) * lastpricetdy),
                                                                                                        totalprofitchanged = totalprofitchanged + ((val1.docs[y].get("Record") - previous_record) * lastprofittdy),
                                                                                                        print("Torla billll a ${totalbillchanged}"),
                                                                                                        print("Torla profittt a ${totalprofitchanged}"),
                                                                                                        print("Torla sum littre a ${sum_littres}"),
                                                                                                      }
                                                                                                    //  else{
                                                                                                    //continue,}
                                                                                                  },
                                                                                              },

                                                                                            //}
                                                                                          }),
                                                                                    },
                                                                                  //  L.add(new specificfuel(cont_name,totalbillchanged ,totalprofitchanged , sum_littres )),
                                                                                }
                                                                            })
                                                              }
                                                          }),
                                                }
                                            }
                                        }
                                    }
                                }),
                        print("Total Bill ${cont_name} ${totalbilltdy}"),
                        L.add(new specificfuel(cont_name, totalbillchanged,
                            totalprofitchanged, sum_littres)),
                        sum_littres = 0,
                      }
                  }
              });

      print("Total Bill ${totalbilltdy}");
      L.add(new specificfuel("Total", totalbilltdy, totalprofittoday, 0));
    } else {
      // specfiiccccccc submit
      sum_littres = 0;
      await FirebaseFirestore.instance
          .collection("Stations")
          .doc("Petrol Station 1")
          .collection("Container")
          .where("Container_Name", isEqualTo: dropdownValue)
          .get()
          .then((val) async => {
                if (val.docs.length > 0)
                  {
                    cont_id = val.docs[0].get("Container_Id"),
                    await FirebaseFirestore.instance
                        .collection('Stations')
                        .doc("Petrol Station 1")
                        .collection('Pump')
                        .where('Container_Id', isEqualTo: cont_id)
                        .get()
                        .then((val) async => {
                              if (val.docs.length > 0)
                                {
                                  for (int i = 0; i < val.docs.length; i++)
                                    {
                                      pumpidtdy = val.docs[i].get("Pump_Id"),
                                      for (int i = 0;
                                          i < AllDateTime.length;
                                          i++)
                                        {
                                          // get price btween i i+1
                                          if (i == AllDateTime.length - 1)
                                            {
                                              print(
                                                  " ***********i==AllDateTime.length-1****************"),
                                              await FirebaseFirestore.instance
                                                  .collection('Stations')
                                                  .doc("Petrol Station 1")
                                                  .collection('Price-Profit')
                                                  .where('Fuel_Type_Id',
                                                      isEqualTo: dropdownValue)
                                                  .where('Date',
                                                      isGreaterThanOrEqualTo:
                                                          AllDateTime[i])
                                                  .get()
                                                  .then((value) async => {
                                                        if (value.docs.length >
                                                            0)
                                                          {
                                                            lastpricetdy = value
                                                                .docs[value.docs
                                                                        .length -
                                                                    1]
                                                                .get(
                                                                    "Official_Price"),
                                                            lastprofittdy = value
                                                                .docs[value.docs
                                                                        .length -
                                                                    1]
                                                                .get(
                                                                    "Official_Profit"),
                                                            lastpricedate = DateTime.tryParse((value
                                                                    .docs[value
                                                                            .docs
                                                                            .length -
                                                                        1]
                                                                    .get(
                                                                        "Date"))
                                                                .toDate()
                                                                .toString()),
                                                            print(
                                                                "Prices is ${lastpricetdy}"),

                                                            //get reacords
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'Stations')
                                                                .doc(
                                                                    "Petrol Station 1")
                                                                .collection(
                                                                    'Pump_Record')
                                                                .where(
                                                                    "Container_Id",
                                                                    isEqualTo:
                                                                        cont_id)
                                                                .where(
                                                                    "Pump_Id",
                                                                    isEqualTo:
                                                                        pumpidtdy)
                                                                .where(
                                                                    "Record_Time",
                                                                    isGreaterThanOrEqualTo:
                                                                        AllDateTime[
                                                                            i])
                                                                .orderBy(
                                                                    "Record_Time",
                                                                    descending:
                                                                        true)
                                                                .get()
                                                                .then(
                                                                    (val1) async =>
                                                                        {
                                                                          for (int y = 0;
                                                                              y < val1.docs.length;
                                                                              y++)
                                                                            {
                                                                              record_id = val1.docs[y].get("Pump_Record_Id"),
                                                                              record_value = val1.docs[y].get("Record"),
                                                                              if (val1.docs[y].get('Pump_Record_Id') == 1)
                                                                                {
                                                                                  totalbilltdy = totalbilltdy + (val1.docs[y].get("Record") * lastpricetdy),
                                                                                  totalprofittoday = totalprofittoday + (val1.docs[y].get("Record") * lastprofittdy),
                                                                                  totalprofitchanged = totalprofitchanged + (val1.docs[y].get("Record") * lastprofittdy),
                                                                                  totalbillchanged = totalbillchanged + (val1.docs[y].get("Record") * lastpricetdy),
                                                                                  sum_littres = sum_littres + val1.docs[y].get("Record"),
                                                                                  print("Torla billll a ${totalbillchanged}"),
                                                                                  print("Torla profittt a ${totalprofitchanged}"),
                                                                                }
                                                                              else
                                                                                {
                                                                                  print("elsee record id ==== $record_id"),
                                                                                  await FirebaseFirestore.instance.collection("Stations").doc("Petrol Station 1").collection("Pump_Record").where("Pump_Id", isEqualTo: pumpidtdy).where("Container_Id", isEqualTo: cont_id).orderBy("Pump_Record_Id").get().then((value1) => {
                                                                                        if (value1.docs.length > 0)
                                                                                          {
                                                                                            print("pump records to get previous"),
                                                                                            for (int t = 0; t < value1.docs.length; t++)
                                                                                              {
                                                                                                if (value1.docs[t].get("Pump_Record_Id") == record_id)
                                                                                                  {
                                                                                                    if (t == 0)
                                                                                                      {
                                                                                                        previous_record_id = 0,
                                                                                                        previous_record = 0,
                                                                                                      }
                                                                                                    else
                                                                                                      {
                                                                                                        previous_record_id = value1.docs[t - 1].get("Pump_Record_Id"),
                                                                                                        print("previous idddd ${previous_record_id}"),
                                                                                                        previous_record = value1.docs[t - 1].get("Record"),
                                                                                                        print("previous record ${previous_record}"),
                                                                                                        //totalbilltdy = totalbilltdy + ((val1.docs[y].get("Record") - previous_record) * lastpricetdy),
                                                                                                        //totalprofittoday = totalprofittoday + ((val1.docs[y].get("Record") - previous_record) * lastprofittdy),
                                                                                                      },
                                                                                                    sum_littres = sum_littres + (val1.docs[y].get("Record") - previous_record),
                                                                                                    totalbilltdy = totalbilltdy + ((val1.docs[y].get("Record") - previous_record) * lastpricetdy),
                                                                                                    totalprofittoday = totalprofittoday + ((val1.docs[y].get("Record") - previous_record) * lastprofittdy),
                                                                                                    totalbillchanged = totalbillchanged + ((val1.docs[y].get("Record") - previous_record) * lastpricetdy),
                                                                                                    totalprofitchanged = totalprofitchanged + ((val1.docs[y].get("Record") - previous_record) * lastprofittdy),
                                                                                                    print("Torla billll a ${totalbillchanged}"),
                                                                                                    print("Torla profittt a ${totalprofitchanged}"),
                                                                                                    print("Torla sum littre a ${sum_littres}"),
                                                                                                  }
                                                                                                //  else{
                                                                                                //continue,}
                                                                                              },
                                                                                          },

                                                                                        //}
                                                                                      }),
                                                                                },
                                                                            }
                                                                        })
                                                          }
                                                      }),
                                            }
                                          else
                                            {
                                              print(
                                                  " ***********NOT i==AllDateTime.length-1****************"),
                                              await FirebaseFirestore.instance
                                                  .collection('Stations')
                                                  .doc("Petrol Station 1")
                                                  .collection('Price-Profit')
                                                  .where('Fuel_Type_Id',
                                                      isEqualTo: dropdownValue)
                                                  .where('Date',
                                                      isGreaterThanOrEqualTo:
                                                          AllDateTime[i])
                                                  .where('Date',
                                                      isLessThanOrEqualTo:
                                                          AllDateTime[i + 1])
                                                  .get()
                                                  .then((value) async => {
                                                        if (value.docs.length >
                                                            0)
                                                          {
                                                            lastpricetdy = // b3den : get last price btwenn these 2 days
                                                                value.docs[value
                                                                            .docs
                                                                            .length -
                                                                        1]
                                                                    .get(
                                                                        "Official_Price"),
                                                            lastprofittdy = value
                                                                .docs[value.docs
                                                                        .length -
                                                                    1]
                                                                .get(
                                                                    "Official_Profit"),
                                                            lastpricedate = DateTime.tryParse((value
                                                                    .docs[value
                                                                            .docs
                                                                            .length -
                                                                        1]
                                                                    .get(
                                                                        "Date"))
                                                                .toDate()
                                                                .toString()),
                                                            print(
                                                                "Prices is ${lastpricetdy}"),

                                                            //get reacords
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'Stations')
                                                                .doc(
                                                                    "Petrol Station 1")
                                                                .collection(
                                                                    'Pump_Record')
                                                                .where("Container_Id",
                                                                    isEqualTo:
                                                                        cont_id)
                                                                .where(
                                                                    "Pump_Id",
                                                                    isEqualTo:
                                                                        pumpidtdy)
                                                                .where(
                                                                    "Record_Time",
                                                                    isGreaterThanOrEqualTo:
                                                                        AllDateTime[
                                                                            i])
                                                                .where(
                                                                    'Record_Time',
                                                                    isLessThanOrEqualTo:
                                                                        AllDateTime[
                                                                            i +
                                                                                1])
                                                                .orderBy(
                                                                    "Record_Time",
                                                                    descending:
                                                                        true)
                                                                .get()
                                                                .then(
                                                                    (val1) async =>
                                                                        {
                                                                          for (int y = 0;
                                                                              y < val1.docs.length;
                                                                              y++)
                                                                            {
                                                                              record_id = val1.docs[y].get("Pump_Record_Id"),
                                                                              record_value = val1.docs[y].get("Record"),
                                                                              if (val1.docs[y].get('Pump_Record_Id') == 1)
                                                                                {
                                                                                  totalbilltdy = totalbilltdy + (val1.docs[y].get("Record") * lastpricetdy),
                                                                                  totalprofittoday = totalprofittoday + (val1.docs[y].get("Record") * lastprofittdy),
                                                                                  sum_littres = sum_littres + val1.docs[y].get("Record"),
                                                                                  print("Torla billll a ${totalbilltdy}"),
                                                                                  print("Torla profittt a ${totalprofittoday}"),
                                                                                }
                                                                              else
                                                                                {
                                                                                  print("elsee record id ==== $record_id"),
                                                                                  await FirebaseFirestore.instance.collection("Stations").doc("Petrol Station 1").collection("Pump_Record").where("Pump_Id", isEqualTo: pumpidtdy).where("Container_Id", isEqualTo: cont_id).orderBy("Pump_Record_Id").get().then((value1) => {
                                                                                        if (value1.docs.length > 0)
                                                                                          {
                                                                                            print("pump records to get previous"),
                                                                                            for (int t = 0; t < value1.docs.length; t++)
                                                                                              {
                                                                                                if (value1.docs[t].get("Pump_Record_Id") == record_id)
                                                                                                  {
                                                                                                    if (t == 0)
                                                                                                      {
                                                                                                        previous_record_id = 0,
                                                                                                        previous_record = 0,
                                                                                                      }
                                                                                                    else
                                                                                                      {
                                                                                                        previous_record_id = value1.docs[t - 1].get("Pump_Record_Id"),
                                                                                                        print("previous idddd ${previous_record_id}"),
                                                                                                        previous_record = value1.docs[t - 1].get("Record"),
                                                                                                        print("previous record ${previous_record}"),
                                                                                                        //totalbilltdy = totalbilltdy + ((val1.docs[y].get("Record") - previous_record) * lastpricetdy),
                                                                                                        //totalprofittoday = totalprofittoday + ((val1.docs[y].get("Record") - previous_record) * lastprofittdy),
                                                                                                      },
                                                                                                    sum_littres = sum_littres + (val1.docs[y].get("Record") - previous_record),
                                                                                                    totalbilltdy = totalbilltdy + ((val1.docs[y].get("Record") - previous_record) * lastpricetdy),
                                                                                                    totalprofittoday = totalprofittoday + ((val1.docs[y].get("Record") - previous_record) * lastprofittdy),
                                                                                                    print("Torla billll a ${totalbilltdy}"),
                                                                                                    print("Torla profittt a ${totalprofittoday}"),
                                                                                                    print("Torla sum littre a ${sum_littres}"),
                                                                                                  }
                                                                                                //  else{
                                                                                                //continue,}
                                                                                              },
                                                                                          },

                                                                                        //}
                                                                                      }),
                                                                                },
                                                                            },
                                                                          L.add(new specificfuel(
                                                                              dropdownValue,
                                                                              totalbilltdy,
                                                                              totalprofittoday,
                                                                              sum_littres)),
                                                                        })
                                                          }
                                                      }),
                                            }
                                        }
                                    }
                                }
                            }),
                  }
              });
    }

    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // getarrayoffueltypes();
    ff = DateFormat('yyyy/MM/dd');
    todayy = ff.parse(ff.format(DateTime.now()));

   // t2.text = ff.format(DateTime.now());
    
    get_first_record_date();
    print(" ... first_record_data ... ${first_record_data}");

   // t1.text = ff.format(first_record_data);
    
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
            Card(
                elevation: 12,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(children: [
                    SizedBox(height: 15),
                    Text("Fuel Type",
                        style: TextStyle(fontSize: 21, color: Colors.black45)),
                    SizedBox(height: 10),
                    Container(
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
                                value: dropdownValue,
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
                                    dropdownValue = newValue;
                                  });
                                },
                                items: fuel_types
                                    .map<DropdownMenuItem<String>>((f) {
                                  print(f.name.toString());
                                  return new DropdownMenuItem<String>(
                                      value: f.name.toString(),
                                      child: new Container(
                                        child: Center(
                                          child: new Text(
                                            '${f.name.toString()}',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ));
                                }).toList()))),
                    SizedBox(height: 15),
                    Text("From Date",
                        style: TextStyle(fontSize: 21, color: Colors.black45)),
                    SizedBox(height: 10),
                    TextFormField(
                        controller: t1,
                        style: TextStyle(color: Colors.black),
                        
                        decoration: InputDecoration(
                          labelText: ff.format(DateTime.now()),
                            suffixIcon: Icon(Icons.date_range_rounded,
                                color: Colors.indigo[300]),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2.0),
                            ),
                            fillColor: Colors.white,
                            labelStyle: TextStyle(color: Colors.black45),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueAccent, width: 2.0))),
                        onChanged: (String s) {}),
                    SizedBox(height: 15),
                    Text("To Date",
                        style: TextStyle(fontSize: 21, color: Colors.black45)),
                    SizedBox(height: 10),
                    TextFormField(
                        controller: t2,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                           labelText: ff.format(DateTime.now()),
                            suffixIcon: Icon(Icons.date_range_rounded,
                                color: Colors.indigo[300]),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2.0),
                            ),
                            fillColor: Colors.white,
                            labelStyle: TextStyle(color: Colors.black45),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueAccent, width: 2.0))),
                        onChanged: (String s) {}),
                    SizedBox(height: 10),
                    Divider(height: 10, thickness: 2, color: Colors.grey),
                    SizedBox(height: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ButtonTheme(
                            height: 50.0,
                            minWidth: 100,
                            child: RaisedButton(
                              color: Color(0xFF083369),
                              elevation: 6,
                              child: Text('Submit',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 19)),
                              onPressed: () {
                                setState(() {
                                  submit = 1;
                                  today = 0;
                                  lastR = 0;
                                });
                                submitbtn();
                              },
                            ),
                          ),
                          ButtonTheme(
                            height: 50.0,
                            minWidth: 100,
                            child: RaisedButton(
                              color: Color(0xFF083369),
                              elevation: 6,
                              child: Text('Today',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 19)),
                              onPressed: () {
                                setState(() {
                                  submit = 0;
                                  today = 1;
                                  lastR = 0;
                                  t1.text = ff.format(DateTime.now()).toString();
                                  t2.text = ff.format(DateTime.now()).toString();
                                });
                                
    
                                gettoday1();
                              },
                            ),
                          ),
                          ButtonTheme(
                            height: 50.0,
                            minWidth: 100,
                            child: RaisedButton(
                              color: Color(0xFF083369),
                              elevation: 6,
                              child: Text('Last Record',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 19)),
                              onPressed: () {
                                setState(() {
                                  submit = 0;
                                  today = 0;
                                  lastR = 1;
                                });
                                getlastreacord();
                              },
                            ),
                          ),
                        ]),
                    SizedBox(height: 10),
                  ]),
                )),
            SizedBox(height: 10),
            // totalbill;

            isloading == true
                ? CircularProgressIndicator()
                : lastR == 1
                    ? TotalCard(totalbill, totalprofit)
                    : today == 1
                        ? ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: L.length,
                            itemBuilder: (context, index) {
                              print("IN LIST VIEW ${index}");
                              return SpecificCard(
                                  L[index].getf(),
                                  L[index].gettb(),
                                  L[index].gettp(),
                                  L[index].getsl());
                            })
                        : submit == 1
                            ? ListView.builder(
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: L.length,
                                itemBuilder: (context, index) {
                                  print("IN LIST VIEW ${index}");
                                  return SpecificCard(
                                      L[index].getf(),
                                      L[index].gettb(),
                                      L[index].gettp(),
                                      L[index].getsl());
                                })
                            : Text("NO DATA"),
          ],
        ));
  }
}

class TotalCard extends StatefulWidget {
  int bill, profit;
  TotalCard(int bill, int profit) {
    this.bill = bill;
    this.profit = profit;
  }

  @override
  _TotalCardState createState() => _TotalCardState();
}

class _TotalCardState extends State<TotalCard> {
  var formatter = NumberFormat('###,###,###');

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(7),
        child: Container(
          decoration:
              BoxDecoration(border: Border.all(width: 4, color: Colors.green)),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text('Total',
                      style: TextStyle(fontSize: 35, color: Color(0xFF083369))),
                ),
              ),
              SizedBox(height: 10),
              Card(
                  child: Column(children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('Bill',
                        style: TextStyle(fontSize: 22, color: Colors.green)),
                  ),
                ),
                SizedBox(height: 30),
                Text('${formatter.format(widget.bill)}L.L',
                    style: TextStyle(fontSize: 35, color: Colors.green))
              ])),
              SizedBox(height: 10),
              Card(
                  child: Column(children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('Profit',
                        style: TextStyle(fontSize: 22, color: Colors.green)),
                  ),
                ),
                SizedBox(height: 30),
                Text('${formatter.format(widget.profit)}L.L',
                    style: TextStyle(fontSize: 35, color: Colors.green))
              ]))
            ],
          ),
        ));
  }
}

class SpecificCard extends StatelessWidget {
  int bill, profit, littres;
  String fuel_name;
  SpecificCard(String fuel_name, int bill, int profit, int littres) {
    this.bill = bill;
    this.profit = profit;
    this.fuel_name = fuel_name;
    this.littres = littres;
  }

  var formatter = NumberFormat('###,###,###');

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(7),
        child: Container(
          decoration:
              BoxDecoration(border: Border.all(width: 4, color: Colors.green)),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text('${fuel_name}',
                      style: TextStyle(fontSize: 35, color: Color(0xFF083369))),
                ),
              ),
              fuel_name != "Total"
                  ? Card(
                      child: Column(children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Text('Litters',
                              style:
                                  TextStyle(fontSize: 22, color: Colors.green)),
                        ),
                      ),
                      SizedBox(height: 30),
                      Text('${formatter.format(littres)} L',
                          style: TextStyle(fontSize: 35, color: Colors.green))
                    ]))
                  : Text(""),
              SizedBox(height: 10),
              Card(
                  child: Column(children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('Bill',
                        style: TextStyle(fontSize: 22, color: Colors.green)),
                  ),
                ),
                SizedBox(height: 30),
                Text('${formatter.format(bill)} L.L',
                    style: TextStyle(fontSize: 35, color: Colors.green))
              ])),
              SizedBox(height: 10),
              Card(
                  child: Column(children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('Profit',
                        style: TextStyle(fontSize: 22, color: Colors.green)),
                  ),
                ),
                SizedBox(height: 30),
                Text('${formatter.format(profit)} L.L',
                    style: TextStyle(fontSize: 35, color: Colors.green))
              ]))
            ],
          ),
        ));
  }
}

class Fuel {
  int id;
  String name;
  Fuel(int id, String name) {
    this.id = id;
    this.name = name;
  }
}

class specificfuel {
  String fuel_name;
  int totalbill;
  int totalprofit;
  int sumlittre;

  specificfuel(
      String fuel_name, int totalbill, int totalprofit, int sumlittre) {
    this.fuel_name = fuel_name;
    this.totalbill = totalbill;
    this.totalprofit = totalprofit;
    this.sumlittre = sumlittre;
  }
  String getf() {
    return fuel_name;
  }

  int gettb() {
    return totalbill;
  }

  int gettp() {
    return totalprofit;
  }

  int getsl() {
    return sumlittre;
  }
}
