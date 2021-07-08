import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_petrol_station/Models/Customer.dart';
import 'package:flutter_petrol_station/Screens/Accounting.dart';
import 'package:flutter_petrol_station/Screens/Customers.dart';
import 'package:flutter_petrol_station/Screens/Dashboard.dart';
import 'package:flutter_petrol_station/Screens/Fuel_Type.dart';

import 'package:flutter_petrol_station/models/Fuel_Type.dart';
import 'package:flutter_petrol_station/screens/Add_Container.dart';
import 'package:flutter_petrol_station/screens/shipments.dart';
import 'package:flutter_petrol_station/services/cloud_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_petrol_station/screens/pump_records.dart';
import 'package:flutter_petrol_station/screens/All_Pumps.dart';
import 'package:flutter_petrol_station/screens/Voucher.dart';
import 'package:flutter_petrol_station/screens/Add_Fuel_Type.dart';
import 'package:flutter_petrol_station/screens/Provider.dart';
import 'package:flutter_petrol_station/screens/Container_Detail.dart';



class getDrawer extends StatefulWidget {
  @override
  _getDrawerState createState() => _getDrawerState();
}

class _getDrawerState extends State<getDrawer> {
  User loggedInUser;
  
  CloudServices cloudServices =
      CloudServices(FirebaseFirestore.instance, FirebaseAuth.instance);

  String station;

  @override
  void initState() {
    super.initState();
    loggedInUser = cloudServices.getCurrentUser();
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

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: new ListView(children: <Widget>[
      // Text(""),

      new ListTile(
        title: Text(
          "Petrol Station",
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w300),
        ),
        onTap: () {
          Navigator.pop(context);
        },
        leading: Image.asset('assets/fuel.png', width: 40, height: 40),
      ),

      Divider(),
      new ListTile(
        title: Text("Dashboard",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              color: Colors.black,
              fontSize: 23,
            )),
        leading: Icon(Icons.home_outlined, color: Colors.grey, size: 35.0),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Dashboard()),
          );
        },
      ),

      ExpansionTile(
          title: Text("Pumps",
              style: TextStyle(
                  fontSize: 23,
                  color: Colors.black,
                  fontWeight: FontWeight.w300)),
          leading:
              Icon(Icons.ev_station_outlined, color: Colors.grey, size: 35.0),
          trailing:
              Icon(Icons.arrow_drop_down, size: 20, color: Colors.indigo[300]),
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllPumps()),
                );
              },
              child: Text('All Pumps',
                  style: TextStyle(
                      fontSize: 21,
                      color: Colors.black,
                      fontWeight: FontWeight.w900)),
            ),
            SizedBox(height: 10),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Stations')
                    .doc(station)
                    .collection('Pump')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot documentSnapshot =
                              snapshot.data.docs[index];
                          return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Pump_Records(
                                          pumpID: documentSnapshot["Pump_Id"],
                                          pumpName:
                                              documentSnapshot["Pump_Name"])),
                                );
                              },
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(documentSnapshot["Pump_Name"],
                                      style: TextStyle(
                                          fontSize: 21,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300)),
                                ),
                              ));
                        });
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ]),
      new ListTile(
        title: Text("Shipments",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              color: Colors.black,
              fontSize: 23,
            )),
        leading: Icon(Icons.directions_bus, color: Colors.grey, size: 35.0),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Shipments()));
        },
      ),
      new ListTile(
        title: Text("Voucher",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              color: Colors.black,
              fontSize: 23,
            )),
        leading: Icon(Icons.local_atm, color: Colors.grey, size: 35.0),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Voucher()));
        },
      ),
      new ListTile(
        title: Text("Customers",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              color: Colors.black,
              fontSize: 23,
            )),
        leading: Icon(Icons.group_outlined, color: Colors.grey, size: 35.0),
        onTap: () {
           Navigator.push(
              context, MaterialPageRoute(builder: (context) => Customers()));
        },
      ),

      ExpansionTile(
          title: Text("Fuel Types",
              style: TextStyle(
                  fontSize: 23,
                  color: Colors.black,
                  fontWeight: FontWeight.w300)),
          leading: Icon(Icons.invert_colors, color: Colors.grey, size: 35.0),
          trailing:
              Icon(Icons.arrow_drop_down, size: 20, color: Colors.indigo[300]),
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Stations')
                    .doc(station)
                    .collection('Fuel_Type')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot documentSnapshot =
                              snapshot.data.docs[index];
                          return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FuelInfo(
                                          FuelTypeId:
                                              documentSnapshot["Fuel_Type_Id"],
                                          FuelTypeName: documentSnapshot[
                                              "Fuel_Type_Name"])),
                                );
                              },
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      documentSnapshot["Fuel_Type_Name"],
                                      style: TextStyle(
                                          fontSize: 21,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300)),
                                ),
                              ));
                        });
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
            InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddFuelType()));
                },
                child: Text("Add Type",
                    style: TextStyle(
                        fontSize: 21,
                        color: Colors.black,
                        fontWeight: FontWeight.w700))),
          ]),
      new ListTile(
        title: Text("Accounting",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              color: Colors.black,
              fontSize: 23,
            )),
        leading: Icon(Icons.monetization_on_outlined,
            color: Colors.grey, size: 35.0),
        onTap: () {

           Navigator.push(
              context, MaterialPageRoute(builder: (context) => Accounting()));

        },
      ),
      new ListTile(
        title: Text("Provider",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              color: Colors.black,
              fontSize: 23,
            )),
        leading: Icon(Icons.supervisor_account_sharp,
            color: Colors.grey, size: 35.0),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Providers()));
        },
      ),
      ExpansionTile(
          title: Text("Containers",
              style: TextStyle(
                  fontSize: 23,
                  color: Colors.black,
                  fontWeight: FontWeight.w300)),
          leading: Icon(Icons.gradient, color: Colors.grey, size: 35.0),
          trailing:
              Icon(Icons.arrow_drop_down, size: 20, color: Colors.indigo[300]),
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Stations')
                    .doc(station)
                    .collection('Container')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot documentSnapshot =
                              snapshot.data.docs[index];
                          return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Container_Details(
                                          documentSnapshot["Container_Id"],
                                          documentSnapshot["Container_Name"])),
                                );
                              },
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      "Container " +
                                          documentSnapshot["Container_Name"],
                                      style: TextStyle(
                                          fontSize: 21,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300)),
                                ),
                              ));
                        });
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddContainer_Firestore()),
                );
              },
              child: Text('Add Container',
                  style: TextStyle(
                      fontSize: 21,
                      color: Colors.black,
                      fontWeight: FontWeight.w900)),
            ),
          ]),
      Divider(),
    ]));
  }
}