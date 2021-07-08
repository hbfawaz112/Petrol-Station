import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_petrol_station/Services/authProvider.dart';
import 'package:flutter_petrol_station/Services/cloud_services.dart';
import 'package:flutter_petrol_station/Widgets/Drawer.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:flutter_petrol_station/Screens/Pump_Records.dart';
import 'Login_Screen.dart';
import 'Pump_Records.dart';
import 'Shipments.dart';
class Dashboard extends StatefulWidget {
  static String id = "Dashboard";
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  User loggedInUser;
  String station;
  String id;
  CloudServices cloudServices =
      CloudServices(FirebaseFirestore.instance, FirebaseAuth.instance);

  Future getContainers() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('Stations')
        .doc('Petrol Station 1')
        .collection('Container')
        .get();
    //print(snapshot.docs[0]["Container_Name"]);

    return snapshot;
  }

  Future getPumpNames(int id) async {
    var s = await FirebaseFirestore.instance
        .collection('Stations')
        .doc('Petrol Station 1')
        .collection('Pump')
        .where('Container_Id', isEqualTo: id)
        .get();
    return s;
  }

  void asyncMethod() async {
    if (loggedInUser != null) {
      station = await cloudServices.getUserStation(loggedInUser);
      print(' your station is : ${station}');
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loggedInUser = cloudServices.getCurrentUser();
    id = loggedInUser.uid;
    print('okiii ${id}');
    asyncMethod();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        backgroundColor: Color(0xFF083369),
        title: Text("Dashboard"),
        centerTitle: true,
        actions: [
          InkWell(
              onTap: () async {
               // await AuthProvider().logOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              child: Row(
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
              ))
        ],
      ),
      drawer: getDrawer(),
      body: StreamBuilder(
          stream: Stream.fromFuture(getContainers()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot =
                        snapshot.data.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Card(
                        elevation: 12.0,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                color: Colors.lightBlue,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height /
                                        snapshot.data.docs.length +
                                    50,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(children: [
                                    Text(
                                        'Container ${documentSnapshot["Container_Name"]}',
                                        style: TextStyle(
                                            color: Colors.indigo[900],
                                            fontSize: 37,
                                            fontWeight: FontWeight.w900)),
                                    SizedBox(height: 20),
                                    Expanded(
                                        child: LinearPercentIndicator(
                                      width: MediaQuery.of(context).size.width -
                                          MediaQuery.of(context).size.width / 5,
                                      animation: true,
                                      lineHeight: 20.0,
                                      animationDuration: 2500,
                                      percent: documentSnapshot["Volume"] /
                                          documentSnapshot["Capacity"],
                                      center: Text(
                                        '${documentSnapshot["Volume"]} L',
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                                      linearStrokeCap: LinearStrokeCap.roundAll,
                                      progressColor: Colors.green,
                                    )),
                                  ]),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Pumps  ",
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.indigo[200],
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Center(
                                      child: StreamBuilder(
                                          stream: Stream.fromFuture(
                                              getPumpNames(documentSnapshot[
                                                  "Container_Id"])),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      snapshot.data.docs.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    DocumentSnapshot
                                                        documentSnapshot1 =
                                                        snapshot
                                                            .data.docs[index];
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Center(
                                                        child: InkWell(
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => Pump_Records(
                                                                      pumpID: documentSnapshot1[
                                                                          "Pump_Id"],
                                                                      pumpName:
                                                                          documentSnapshot1[
                                                                              "Pump_Name"])),
                                                            );
                                                          },
                                                          child: Text(
                                                            '    ${documentSnapshot1["Pump_Name"]}',
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                color: Colors
                                                                        .indigo[
                                                                    200]),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            } else {
                                              return Text('Loaddinggg....');
                                            }
                                          })),
                                ],
                              ),
                              SizedBox(height: 5.0),
                              ButtonTheme(
                                height: 50.0,
                                minWidth: 270,
                                child: RaisedButton(
                                  color: Colors.grey,
                                  elevation: 12,
                                  child: Text('New Shipment',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 23)),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Shipments()),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 25.0),
                            ]),
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}