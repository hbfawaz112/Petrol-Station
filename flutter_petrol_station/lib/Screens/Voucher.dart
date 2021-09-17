import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_petrol_station/widgets/Drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_petrol_station/Services/cloud_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:intl/intl.dart';

import 'dashboard_firstore.dart';

class Voucher extends StatefulWidget {
  static String id = 'Voucher';
  @override
  _VoucherState createState() => _VoucherState();
}

class _VoucherState extends State<Voucher> {
  String dropdownValue = 'One';
  var fuel_type;
  var customer_name;
  int Fuel_Type_Id;
  int Customer_Id;
  int last_voucher_id;
  int voucher_value_error = -1;
  TextEditingController t1 = new TextEditingController();
  TextEditingController t2 = new TextEditingController();
  TextEditingController t3 = new TextEditingController();

  String station, pStation;
  User loggedInUser;
   DateFormat ff;

  @override
  void initState() {
    super.initState();
    loggedInUser = cloudServices.getCurrentUser();
     ff = DateFormat('yyyy-MM-dd');
       t2.text = ff.format(DateTime.now()).toString();
    print("user");
    print(loggedInUser);
    asyncMethod();
  }

  void asyncMethod() async {
    // we do this to call a fct that need async wait when calling it;
    // when aiming to use the fct in initState
    if (loggedInUser != null) {
      station = await cloudServices.getUserStation(loggedInUser);
    }
    setState(() {});
    // hay l setState bhotta ekher shi bl fct yalle btrajj3 shi future krml yn3amal rebuild
    // krml yontor l data yalle 3m trj3 mn l firestore bs n3aytla ll method
  }

  CloudServices cloudServices =
      CloudServices(FirebaseFirestore.instance, FirebaseAuth.instance);

  void Add_Voucher() async {
    //get the fueul_type_id of the selected fuel type
    await FirebaseFirestore.instance
        .collection('Stations')
        .doc(station)
        .collection('Fuel_Type')
        .where('Fuel_Type_Name', isEqualTo: fuel_type)
        .get()
        .then((val) => {
              if (val.docs.length > 0)
                {
                  // print(val.docs[0].get("Fuel_Type_Id")),

                  Fuel_Type_Id = val.docs[0].get("Fuel_Type_Id"),
                  print('the fuel type id of selected one is ${Fuel_Type_Id}')
                }
              else
                {print("Not Found")}
            });

    //get the customer id  of the selected customer name
    await FirebaseFirestore.instance
        .collection('Stations')
        .doc(station)
        .collection('Customer')
        .where('Customer_Name', isEqualTo: customer_name)
        .get()
        .then((val) => {
              if (val.docs.length > 0)
                {
                  // print(val.docs[0].get("Fuel_Type_Id")),

                  Customer_Id = val.docs[0].get("Customer_Id"),
                  print('the Customer id of selected one is ${Customer_Id}')
                }
              else
                {print("Not Found")}
            });

    //get the last voucher id in firstore and add 1 to it:
    await FirebaseFirestore.instance
        .collection('Stations')
        .doc(station)
        .collection('Voucher')
        .orderBy('Voucher_Id', descending: true)
        .get()
        .then((val) => {
              if (val.docs.length > 0)
                {
                  last_voucher_id = val.docs[0].get("Voucher_Id"),
                  print('last voucher id is  : ${last_voucher_id}')
                }
              else
                {print("Not Found")}
            });

    if (t1.text == '') {
      setState(() {
        voucher_value_error = 1;
      });
    } else {
      String g = t1.text.replaceAll(RegExp(','), '');
      FirebaseFirestore.instance
          .collection('Stations')
          .doc(station)
          .collection('Voucher')
          .doc((last_voucher_id + 1).toString())
          .set({
        'Voucher_Id': last_voucher_id + 1,
        'Customer_Id': Customer_Id,
        'Fuel_Type_Id': Fuel_Type_Id,
        'Note': t3.text,
        'Voucher_Date': ff.parse(t2.text),
        'Voucher_Value': int.parse(g)
      });
      Fluttertoast.showToast(
        msg: "Voucher added succefully for the customer ${customer_name}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
      t1.text='';
    }
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      // ignore: missing_return
      onWillPop: () { 
        Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => Dashboard()),
  );
       },
      child: Scaffold(
          backgroundColor: Colors.indigo[50],
          appBar: AppBar(
            backgroundColor: Color(0xFF083369),
            
          ),
          drawer: getDrawer(),
          body: ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              Text('  Vouchers',
                  style: TextStyle(
                    color: Colors.amberAccent,
                    fontSize: 36,
                    fontWeight: FontWeight.w500,
                  )),
              SizedBox(
                height: 20,
              ),
              Card(
                  elevation: 12,
                  child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          SizedBox(height: 15),
                          Text("Fuel Type",
                              style:
                                  TextStyle(fontSize: 21, color: Colors.black45)),
                          SizedBox(height: 10),
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('Stations')
                                  .doc(station)
                                  .collection('Fuel_Type')
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData)
                                  Center(
                                    child: const CupertinoActivityIndicator(),
                                  );

                                return Container(
                                    width: 350.0,
                                    height: 58,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 1.0, style: BorderStyle.solid),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                      ),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        value: fuel_type,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        iconSize: 24,
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.deepPurple),
                                        underline: Container(
                                          height: 2,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        hint: Center(
                                            child: Text('Fuel Type',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w400))),
                                       onChanged: (newValue) {
                                          setState(() {
                                            fuel_type = newValue;
                                          });
                                        },
                                        items: snapshot.data != null
                                            ? snapshot.data.docs
                                                .map((DocumentSnapshot document) {
                                                return new DropdownMenuItem<
                                                        String>(
                                                    value: document
                                                        .get('Fuel_Type_Name')
                                                        .toString(),
                                                    child: new Container(
                                                      child: Center(
                                                        child: new Text(
                                                          document
                                                              .get(
                                                                  'Fuel_Type_Name')
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
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
                              }),
                          SizedBox(height: 15),
                          Text("Voucher Value (L.L)",
                              style:
                                  TextStyle(fontSize: 21, color: Colors.black45)),
                          SizedBox(height: 10),
                          TextFormField(
                              controller: t1,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                ThousandsFormatter(),
                              ],
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32.0)),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32.0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 2.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32.0)),
                                ),
                                labelText: "value (L.L)",
                                fillColor: Colors.white,
                                labelStyle: TextStyle(color: Colors.black45),
                              ),
                              onChanged: (String s) {}),
                          SizedBox(height: 5),
                          Text(
                              voucher_value_error == 1
                                  ? 'Invalid Voucher value(must enter a valid one)'
                                  : '',
                              style: TextStyle(color: Colors.red, fontSize: 21)),
                          SizedBox(height: 5),
                          Text("Customer Name",
                              style:
                                  TextStyle(fontSize: 21, color: Colors.black45)),
                          SizedBox(height: 10),
                          
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('Stations')
                                  .doc(station)
                                  .collection('Customer')
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData)
                                  Center(
                                    child: const CupertinoActivityIndicator(),
                                  );

                                return Container(
                                    width: 350.0,
                                    height: 58,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 1.0, style: BorderStyle.solid),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                      ),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        iconSize: 24,
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.deepPurple),
                                        underline: Container(
                                          height: 2,
                                          color: Colors.deepPurpleAccent,
                                        ),

                                        value: customer_name,
                                        //isDense: true,
                                        hint: Text('Customer Name'),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            customer_name = newValue;
                                          });
                                        },
                                        items: snapshot.data != null
                                            ? snapshot.data.docs
                                                .map((DocumentSnapshot document) {
                                                return new DropdownMenuItem<
                                                        String>(
                                                    value: document
                                                        .get('Customer_Name')
                                                        .toString(),
                                                    child: new Container(
                                                      // height: 20.0,

                                                      //color: primaryColor,

                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                                top: 7, left: 8),
                                                        child: new Text(
                                                          document
                                                              .get(
                                                                  'Customer_Name')
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900),
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
                                    ));
                              }),
                          SizedBox(height: 20),
                          Text("Voucher Date",
                              style:
                                  TextStyle(fontSize: 21, color: Colors.black45)),
                          SizedBox(height: 10),
                          TextFormField(
                              controller: t2,
                              keyboardType: TextInputType.datetime,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32.0)),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32.0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 2.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32.0)),
                                ),
                               // labelText: DateTime.now().toString(),
                                fillColor: Colors.white,
                                labelStyle: TextStyle(color: Colors.black45),
                              ),

onTap: () async {
                  DateTime pickedDate = await showDatePicker(
                      context: context, initialDate: DateTime.now(),
                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101)
                  );
                  
                  if(pickedDate != null ){
                      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); 
                      print(formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                         t2.text = formattedDate; //set output date to TextField value. 
                      });
                  }else{
                      print("Date is not selected");
                  }
                },

                              onChanged: (String s) {}),
                          SizedBox(height: 25),
                          TextFormField(
                              controller: t3,
                              maxLines: 3,
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
                              onChanged: (String s) {}),
                          SizedBox(height: 18),
                          ButtonTheme(
                            height: 50.0,
                            minWidth: 130,
                            child: RaisedButton(
                              color: Colors.indigo[800],
                              elevation: 12,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.my_library_add_outlined,
                                        color: Colors.white, size: 20),
                                    Text('Add',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 25)),
                                  ]),
                              onPressed: () {
                                Add_Voucher();
                              },
                            ),
                          ),
                        ],
                      )))
            ],
          )),
    );
  }
}
