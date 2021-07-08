import 'package:flutter/material.dart';
import 'package:flutter_petrol_station/widgets/Drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_petrol_station/widgets/Drawer.dart';
import 'package:flutter_petrol_station/services/cloud_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddFuelType extends StatefulWidget {
  static String id = 'Add_Fuel_Types';
  @override
  _AddFuelTypeState createState() => _AddFuelTypeState();
}

class _AddFuelTypeState extends State<AddFuelType> {
  TextEditingController t1 = new TextEditingController();
  TextEditingController t2 = new TextEditingController();
  TextEditingController t3 = new TextEditingController();
  int fuel_type_error = -1;
  int official_price_error = -1;
  int profit_error = -1;

  int last_fuel_type_id;
  int last_price_prfit_id;
  int last_price_id;
  int last_profit_id;
  int new_fuel_type_id;

  String station, pStation;
  User loggedInUser;

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
    }
    setState(() {});
    // hay l setState bhotta ekher shi bl fct yalle btrajj3 shi future krml yn3amal rebuild
    // krml yontor l data yalle 3m trj3 mn l firestore bs n3aytla ll method
  }

  CloudServices cloudServices =
  CloudServices(FirebaseFirestore.instance, FirebaseAuth.instance);

  void add_fuel_type_fct() async {
    if (t1.text == '' || t2.text == '' || t3.text == '') {
      if (t1.text == '') {
        setState(() {
          fuel_type_error = 1;
        });
      } else {
        setState(() {
          fuel_type_error = -1;
        });
      }

      if (t2.text == '') {
        setState(() {
          official_price_error = 1;
        });
      } else {
        setState(() {
          official_price_error = -1;
        });
      }
      if (t3.text == '') {
        setState(() {
          profit_error = 1;
        });
      } else {
        setState(() {
          profit_error = -1;
        });
      }
    } else {
      setState(() {
        profit_error = -1;
        official_price_error = -1;
        fuel_type_error = -1;
      });

      // 1- get the last fuel type id from fuel type collection:
      await FirebaseFirestore.instance
          .collection('Stations')
          .doc(station)
          .collection('Fuel_Type')
          .orderBy('Fuel_Type_Id', descending: true)
          .get()
          .then((val) => {
        if (val.docs.length > 0)
          {
            last_fuel_type_id = val.docs[0].get("Fuel_Type_Id"),
            print('last id is  : ${last_fuel_type_id}')
          }
        else
          {print("Not Found")}
      });
      // 2- Get the last price-profit id :
      await FirebaseFirestore.instance
          .collection('Stations')
          .doc(station)
          .collection('Price-Profit')
          .orderBy('Price_Profit_Id', descending: true)
          .get()
          .then((val) => {
        if (val.docs.length > 0)
          {
            last_price_prfit_id = val.docs[0].get("Price_Profit_Id"),
            print('last id is  : ${last_price_prfit_id}')
          }
        else
          {print("Not Found")}
      });


      //get the new fuel_type_id :
      new_fuel_type_id = last_fuel_type_id + 1;
      // now let's start adding each value on it's specific collection:
      // a - adding to fuel_type collection:

      FirebaseFirestore.instance
          .collection('Stations')
          .doc(station)
          .collection('Fuel_Type')
          .doc(new_fuel_type_id.toString())
          .set({'Fuel_Type_Id': new_fuel_type_id, 'Fuel_Type_Name': t1.text});

      // b- adding to price-profit collection:
      FirebaseFirestore.instance
          .collection('Stations')
          .doc(station)
          .collection('Price-Profit')
          .doc((last_price_prfit_id + 1).toString())
          .set({
        'Date': Timestamp.fromDate(DateTime.now()),
        'Fuel_Type_Id': t1.text,
        'Official_Price': int.parse(t2.text),
        'Official_Profit':int.parse(t3.text),

        'Price_Profit_Id': last_price_prfit_id + 1
      });
      t1.text='';t2.text='';t3.text='';
    }
  }

  @override
  Widget build(BuildContext context) {
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
              padding: EdgeInsets.all(12),
              child: Text(' Add Fuel Type',
                  style: TextStyle(
                    color: Colors.amberAccent,
                    fontSize: 36,
                    fontWeight: FontWeight.w500,
                  )),
            ),
            Padding(
                padding: EdgeInsets.all(12),
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text("Fuel Type",
                            style:
                            TextStyle(fontSize: 21, color: Colors.black45)),
                        SizedBox(height: 10),
                        TextFormField(
                            controller: t1,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 2.0),
                                ),
                                labelText: "Fuel Type",
                                fillColor: Colors.white,
                                labelStyle: TextStyle(color: Colors.black45),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blueAccent, width: 2.0))),
                            onChanged: (String s) {}),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          fuel_type_error == 1
                              ? 'You must enter a valid fuel type'
                              : '',
                          style: TextStyle(color: Colors.red, fontSize: 21),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Official Price ",
                            style:
                            TextStyle(fontSize: 21, color: Colors.black45)),
                        SizedBox(height: 10),
                        TextFormField(
                            controller: t2,
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 2.0),
                                ),
                                labelText: "0",
                                fillColor: Colors.white,
                                labelStyle: TextStyle(color: Colors.black45),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blueAccent, width: 2.0))),
                            onChanged: (String s) {}),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          official_price_error == 1
                              ? 'You must enter a valid price'
                              : '',
                          style: TextStyle(color: Colors.red, fontSize: 21),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Profit",
                            style:
                            TextStyle(fontSize: 21, color: Colors.black45)),
                        SizedBox(height: 10),
                        TextFormField(
                            controller: t3,
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 2.0),
                                ),
                                labelText: "0",
                                fillColor: Colors.white,
                                labelStyle: TextStyle(color: Colors.black45),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blueAccent, width: 2.0))),
                            onChanged: (String s) {}),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          profit_error == 1
                              ? 'You must enter a valid Profit'
                              : '',
                          style: TextStyle(color: Colors.red, fontSize: 21),
                        ),
                        SizedBox(
                          height: 5,
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
                                  Text('Save',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25)),
                                ]),
                            onPressed: () {
                              add_fuel_type_fct();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        ));
  }
}