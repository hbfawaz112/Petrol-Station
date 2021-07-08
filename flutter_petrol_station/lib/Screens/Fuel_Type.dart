import 'package:flutter/material.dart';
import 'package:flutter_petrol_station/widgets/Drawer.dart';
import 'package:flutter_petrol_station/Services/cloud_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/number_symbols.dart';
import 'package:flutter/services.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:intl/intl.dart';

String station;
NumberFormat numberFormat;

class FuelInfo extends StatefulWidget {
  //get passed data from previous page
  final String FuelTypeName;
  final int FuelTypeId;
  const FuelInfo({Key key, this.FuelTypeId, this.FuelTypeName})
      : super(key: key);

  @override
  _FuelInfoState createState() => _FuelInfoState(
      FuelTypeId: this.FuelTypeId, FuelTypeName: this.FuelTypeName);
}

class _FuelInfoState extends State<FuelInfo> {
  //To Use received data without widget. ( Storing the passed value in a different variable before using it)
  String FuelTypeName;
  int FuelTypeId;

  _FuelInfoState({this.FuelTypeId, this.FuelTypeName});

  int newPrice, newProfit;
  int save = 0;
  Color fillColor = Colors.black12;
  FirebaseFirestore db = FirebaseFirestore.instance;
  CloudServices cloudServices =
      CloudServices(FirebaseFirestore.instance, FirebaseAuth.instance);
  int officialPrice, profit;
  User loggedInUser;
  var msgController = TextEditingController(),
      msgController1 = TextEditingController();
  bool enable = false, readOnlyOption = true;
  int priceLastID, profitLastID, profitDocId, priceDocId;
  int priceprofitid;
  int profitError = 0, priceError = 0;
  Color profitColor = Colors.blueAccent, priceColor = Colors.blueAccent;
  @override
  void initState() {
    super.initState();

    loggedInUser = cloudServices.getCurrentUser();
    asyncMethod();
    print("inittt");
    print(station);
    // future that allows us to access context. function is called inside the future
    // otherwise it would be skipped and args would return null
    //getContainerInfo(widget.pumpID);
    //print(station);
  }

  void asyncMethod() async {
    // we do this to call a fct that need async wait when calling it;
    // when aiming to use the fct in initState
    if (loggedInUser != null) {
      station = await cloudServices.getUserStation(loggedInUser);
    }
    await getPriceValue();
    await getProfitValue();
    setState(() {});
    // hay l setState bhotta ekher shi bl fct yalle btrajj3 shi future krml yn3amal rebuild
    // krml yontor l data yalle 3m trj3 mn l firestore bs n3aytla ll method
  }

  void getPriceProfitLastDocId() {
    var qs = db
        .collection('Stations')
        .doc(station)
        .collection('Price-Profit')
        .orderBy("Price_Profit_Id")
        .get()
        .then((val) => {
              if (val.docs.length > 0)
                {
                  profitLastID =
                      val.docs[val.docs.length - 1].get("Price_Profit_Id"),
                  priceprofitid = profitLastID + 1,
                  print("lastt profittttt IDD: $profitLastID"),
                  print("doc profitttt IDD: $priceprofitid"),
                }
              else
                {
                  print("elseeeee"),
                }
            });
  }

  void getProfitValue() async {
    var qs = await db
        .collection('Stations')
        .doc(station)
        .collection('Price-Profit')
        .where('Fuel_Type_Id', isEqualTo: FuelTypeName)
        .orderBy('Price_Profit_Id')
        .get()
        .then((val) => {
              if (val.docs.length > 0)
                {
                  profit = val.docs[val.docs.length - 1].get("Official_Profit"),
                  print('profitttttttt $profit'),
                }
              else
                {
                  print("elseeeee"),
                }
            });
    setState(() {});
  }

  void getPriceValue() async {
    var qs = await db
        .collection('Stations')
        .doc(station)
        .collection('Price-Profit')
        .where('Fuel_Type_Id', isEqualTo: FuelTypeName)
        .orderBy('Price_Profit_Id')
        .get()
        .then((val) => {
              if (val.docs.length > 0)
                {
                  officialPrice =
                      val.docs[val.docs.length - 1].get("Official_Price"),
                  print('officialPriceeeeeeeeeee $officialPrice'),
                }
              else
                {
                  print("elseeeee"),
                }
            });
    setState(() {});
  }

  NumberSymbols numberFormatSymbols;
  @override
  Widget build(BuildContext context) {
    numberFormat = new NumberFormat('###,000');
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
    getPriceProfitLastDocId();
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
          Padding(
            padding: EdgeInsets.all(15),
            child: Text('  Fuel Info',
                style: TextStyle(
                  color: Colors.amberAccent,
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                )),
          ),
          SizedBox(height: 20),
          Padding(
              padding: EdgeInsets.all(15),
              child: Card(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                            FuelTypeName != null
                                ? 'Fuel Name : $FuelTypeName '
                                : 'Fuel Name',
                            style: TextStyle(
                                fontSize: 37, color: Color(0xFF083369))),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("Official Price ",
                        style: TextStyle(fontSize: 21, color: Colors.black45)),
                    SizedBox(height: 10),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          ThousandsFormatter(),
                        ],
                        enabled: enable,
                        readOnly: readOnlyOption,
                        controller: msgController,
                        enableInteractiveSelection: false,
                        focusNode: FocusNode(),
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: priceColor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: priceColor, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                          labelText: officialPrice.toString() != null
                              ? numberFormat.format(officialPrice)
                              : 0,
                          fillColor: fillColor,
                          filled: true,
                          labelStyle: TextStyle(color: Colors.black45),
                        ),
                        onChanged: (String s) {
                          String g = s.replaceAll(RegExp(','), '');

                          newPrice = int.parse(g);
                        }),
                    Text(
                      priceError == 1 ? 'Enter positive value' : '',
                      style: TextStyle(color: priceColor),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text("Profit",
                        style: TextStyle(fontSize: 21, color: Colors.black45)),
                    SizedBox(height: 10),
                    TextFormField(
                        enabled: enable,
                        controller: msgController1,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          ThousandsFormatter(),
                        ],
                        enableInteractiveSelection: false,
                        focusNode: FocusNode(),
                        readOnly: readOnlyOption,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: profitColor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: profitColor, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                          labelText: profit.toString() != null
                              ? numberFormat.format(profit)
                              : 0,
                          fillColor: fillColor,
                          filled: true,
                          labelStyle: TextStyle(color: Colors.black45),
                        ),
                        onChanged: (String s) {
                          String g = s.replaceAll(RegExp(','), '');

                          newProfit = int.parse(g);
                        }),
                    Text(
                      profitError == 1 ? 'Enter positive value' : '',
                      style: TextStyle(color: profitColor),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    ButtonTheme(
                      height: 50.0,
                      minWidth: 130,
                      child: RaisedButton(
                        color: Colors.indigo[800],
                        elevation: 12,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.library_add_check_outlined,
                                  size: 22, color: Colors.white),
                              SizedBox(
                                width: 14,
                              ),
                              Text(save == 0 ? 'Edit' : 'Save',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25)),
                            ]),
                        onPressed: () {
                          if (save == 0) {
                            setState(() {
                              enable = true;
                              save = 1;
                              fillColor = Colors.white;
                              readOnlyOption = false;
                            });
                          } else {
                            //save
                            print(
                                "lassssssttttttprice $priceLastID docccccc $priceDocId");
                            print(
                                "lassssssttttttprofitttt $profitLastID docccccc $profitDocId");
                            if (newProfit == null || newProfit < 0) {
                              setState(() {
                                profitColor = Colors.red;
                                profitError = 1;
                              });
                            }
                            if (newPrice == null || newPrice < 0) {
                              setState(() {
                                priceColor = Colors.red;
                                priceError = 1;
                              });
                            }
                            if (newProfit != null && newPrice != null) {
                              print('notttttttt null $priceDocId $profitDocId');
                              setState(() {
                                profitColor = Colors.blueAccent;
                                profitError = 0;
                                priceColor = Colors.blueAccent;
                                priceError = 0;
                              });

                              db
                                  .collection('Stations')
                                  .doc(station)
                                  .collection('Price-Profit')
                                  .doc(priceprofitid.toString())
                                  .set({
                                'Fuel_Type_Id': FuelTypeName.toString(),
                                'Date': Timestamp.fromDate(DateTime.now()),
                                'Price_Profit_Id': priceprofitid + 1,
                                'Official_Profit': newProfit,
                                'Official_Price': newPrice
                              }).then((result) {
                                print("Success!");

                                setState(() {
                                  msgController.clear();
                                  msgController1.clear();
                                  //officialPrice = newPrice;
                                  //profit = newProfit;
                                  newProfit = null;
                                  newPrice = null;
                                  db
                                      .collection('Stations')
                                      .doc(station)
                                      .collection('Price-Profit')
                                      .where('Fuel_Type_Id',
                                          isEqualTo: FuelTypeName)
                                      .orderBy('Price_Profit_Id')
                                      .get()
                                      .then((val) => {
                                            if (val.docs.length > 0)
                                              {
                                                setState(() {
                                                  officialPrice = val
                                                      .docs[val.docs.length - 1]
                                                      .get("Official_Price");
                                                  profit = val
                                                      .docs[val.docs.length - 1]
                                                      .get("Official_Profit");
                                                }),
                                                print(
                                                    'officialPriceeeeeeeeeee $officialPrice'),
                                              }
                                            else
                                              {
                                                print("elseeeee"),
                                              }
                                          });
                                });
                              }).catchError((onError) {
                                //alert error
                                print('error');
                              });
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )),
          SizedBox(height: 20),
          SingleChildScrollView(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Stations')
                    .doc(station)
                    .collection('Price-Profit')
                    .orderBy('Price_Profit_Id', descending: true)
                    .where('Fuel_Type_Id', isEqualTo: FuelTypeName)
                    .snapshots(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? new fueltypedatatable(snapshot.data.docs, FuelTypeName)
                      : Text('No data');
                }),
          ),
        ],
      ),
    );
  }
}

class fueltypedatatable extends StatelessWidget {
  List list;
  String fuel_name;
  fueltypedatatable(List list, String fuel_name) {
    this.list = list;
    this.fuel_name = fuel_name;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Expanded(
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 25,
                      columns: [
                        DataColumn(
                            label: Text(
                          "Fuel Type",
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.w800),
                        )),
                        DataColumn(
                            label: Text(
                          "Price",
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.w800),
                        )),
                        DataColumn(
                            label: Text(
                          "Profit",
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.w500),
                        )),
                        DataColumn(
                            label: Text(
                          "Date",
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.w500),
                        )),
                      ],
                      rows: list
                          .map((pp) => DataRow(cells: [
                                DataCell(
                                  Text(
                                    '${fuel_name}',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                      '${numberFormat.format(pp["Official_Price"])}',
                                      style: TextStyle(fontSize: 18)),
                                ),
                                DataCell(
                                  Text(
                                      '${numberFormat.format(pp["Official_Profit"])}',
                                      style: TextStyle(fontSize: 18)),
                                ),
                                DataCell(
                                  Text(
                                      '${DateTime.tryParse((pp["Date"]).toDate().toString())}',
                                      style: TextStyle(fontSize: 18)),
                                ),
                              ]))
                          .toList(),
                    )))));
  }
}