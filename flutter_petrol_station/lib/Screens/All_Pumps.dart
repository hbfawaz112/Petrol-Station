import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_petrol_station/screens/pump_records.dart';
import 'package:flutter_petrol_station/widgets/Drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_petrol_station/services/cloud_services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dashboard_firstore.dart';

class AllPumps extends StatefulWidget {
  static String id = "All_Pumps";
  @override
  _AllPumpsState createState() => _AllPumpsState();
}

class _AllPumpsState extends State<AllPumps> {
  var category;
  int lastpumpid;
  int newpumpid;
  int containerid;
  int last_pump_record;
  int new_pump_record;
  int pump_name_error = -1;
  int initial_counter_error = -1;

  FirebaseFirestore db = FirebaseFirestore.instance;
  CloudServices cloudServices =
      CloudServices(FirebaseFirestore.instance, FirebaseAuth.instance);
  TextEditingController t1 = new TextEditingController();
  TextEditingController t2 = new TextEditingController();

  String station;
  User loggedInUser;

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
      getFirstCategory();
    }
    setState(() {});
  }

  void getFirstCategory() async {
    var s = await db
        .collection('Stations')
        .doc(station)
        .collection('Container')
        .get()
        .then((val) => {
              if (val.docs.length > 0)
                {
                  category = val.docs[0].get("Container_Name"),
                }
              else
                {print("Not Found")}
            });
  }

  void Add_Pump() async {
    if (t1.text == '' || t2.text == '') {
      setState(() {
        pump_name_error = 1;
        initial_counter_error = 1;
      });
    } else {
      //get the number of documents
      QuerySnapshot _myDoc = await FirebaseFirestore.instance
          .collection('Stations')
          .doc(station)
          .collection('Pump')
          .get();
      List<DocumentSnapshot> _myDocCount = _myDoc.docs;
      int n = _myDocCount.length;
      print('The lenght of documents of pump collection is{$n}');

      //get the last pump doc id :
      await FirebaseFirestore.instance
          .collection('Stations')
          .doc(station)
          .collection('Pump')
          .orderBy('Pump_Id', descending: true)
          .get()
          .then((val) => {
                if (val.docs.length > 0)
                  {
                    lastpumpid = val.docs[0].get("Container_Id"),
                    print('last id is  : ${lastpumpid}')
                  }
                else
                  {print("Not Found")}
              });

      newpumpid = lastpumpid + 1;
      print('new  pump id is ${newpumpid}');

      //get the id of selected container name
      await FirebaseFirestore.instance
          .collection('Stations')
          .doc(station)
          .collection('Container')
          .where('Container_Name', isEqualTo: category)
          .get()
          .then((val) => {
                if (val.docs.length > 0)
                  {
                    containerid = val.docs[0].get("Container_Id"),
                    print("select container has id ${containerid}")
                  }
                else
                  {print("Not Found")}
              });
      print(DateTime.now());

      /************/

      // NOW ADD ALL THESE DATA TO A NEW PUMP DOCUMENT IN PUMP COLLECTION
      FirebaseFirestore.instance
          .collection('Stations')
          .doc(station)
          .collection('Pump')
          .doc(newpumpid.toString())
          .set({
        'Container_Id': containerid,
        'Pump_Id': newpumpid,
        'Pump_Name': t1.text,
        'X_Id': DateTime.now()
      });
      print('done addedd');
      Fluttertoast.showToast(
        msg: "The New Pump Has Been Added..",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );

      //then create for it a new pump record with record is the initial counter:

      //get the number of documents
      QuerySnapshot _myDoc1 = await FirebaseFirestore.instance
          .collection('Stations')
          .doc(station)
          .collection('Pump_Record')
          .get();
      List<DocumentSnapshot> _myDocCount1 = _myDoc1.docs;
      int n1 = _myDocCount1.length;
      print('The lenght of document pump_record is{$n1}');

      //get the last doc id (pump record id): and the newone (+1)
      await FirebaseFirestore.instance
          .collection('Stations')
          .doc(station)
          .collection('Pump_Record')
          .orderBy('Pump_Record_Id', descending: true)
          .get()
          .then((val) => {
                if (val.docs.length > 0)
                  {
                    last_pump_record = val.docs[0].get("Pump_Record_Id"),
                    print('last id is  : ${last_pump_record}')
                  }
                else
                  {print("Not Found")}
              });

      new_pump_record = last_pump_record + 1;
      print('new pumprecordid id is ${new_pump_record}');

      //Add the new pump_record_document
      FirebaseFirestore.instance
          .collection('Stations')
          .doc(station)
          .collection('Pump_Record')
          .doc(new_pump_record.toString())
          .set({
        'Pump_Record_Id': new_pump_record,
        'Container_Id': containerid,
        'Pump_Id': newpumpid,
        'Record': int.parse(t2.text),
        'X_Id': DateTime.now(),
        'Record_Time': DateTime.now()
      });
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
            elevation: 0,
            backgroundColor: Color(0xFF083369),
           
          ),
          drawer: getDrawer(),
          body: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Text('Pumps',
                    style: TextStyle(
                      color: Colors.amberAccent,
                      fontSize: 33,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              Card(
                  elevation: 12,
                  child: ExpansionTile(
                      title: Text("Add Pump",
                          style:
                              TextStyle(fontSize: 29, color: Colors.indigo[300])),
                      trailing: Icon(Icons.arrow_drop_down,
                          size: 20, color: Colors.indigo[300]),
                      children: [
                        Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(children: [
                              Text("Pump Name",
                                  style: TextStyle(
                                      fontSize: 21, color: Colors.black45)),
                              SizedBox(height: 5),
                              TextFormField(
                                  controller: t1,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blueAccent),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(32.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blueAccent, width: 2.0),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(32.0)),
                                    ),
                                    labelText: "Pump Name",
                                    fillColor: Colors.white,
                                    labelStyle: TextStyle(color: Colors.black45),
                                  ),
                                  onChanged: (String s) {}),
                              Text(
                                pump_name_error == 1 ? 'Enter a pump name' : '',
                                style: TextStyle(color: Colors.red, fontSize: 18),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text("Container Name",
                                  style: TextStyle(
                                      fontSize: 21, color: Colors.black45)),
                              SizedBox(height: 10),
                              StreamBuilder(
                                stream: db
                                    .collection('Stations')
                                    .doc(station)
                                    .collection('Container')
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                      width: 350.0,
                                      height: 58,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 1.0,
                                              style: BorderStyle.solid),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0)),
                                        ),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          value: category,
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
                                              category = newValue;
                                              //getVolume();
                                            });
                                          },
                                          items: snapshot.data != null
                                              ? snapshot.data.docs.map(
                                                  (DocumentSnapshot document) {
                                                  return new DropdownMenuItem<
                                                          String>(
                                                      value: document
                                                          .get('Container_Name')
                                                          .toString(),
                                                      child: new Container(
                                                        child: Center(
                                                          child: new Text(
                                                            document
                                                                .get(
                                                                    'Container_Name')
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
                                                  value: category,
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
                              SizedBox(
                                height: 20,
                              ),
                              Text("Initial Counter",
                                  style: TextStyle(
                                      fontSize: 21, color: Colors.black45)),
                              SizedBox(height: 5),
                              TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: t2,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blueAccent),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(32.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blueAccent, width: 2.0),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(32.0)),
                                    ),
                                    labelText: "0",
                                    fillColor: Colors.white,
                                    labelStyle: TextStyle(color: Colors.black45),
                                  ),
                                  onChanged: (String s) {}),
                              Text(
                                initial_counter_error == 1
                                    ? 'Enter an initial Counter'
                                    : '',
                                style: TextStyle(fontSize: 18, color: Colors.red),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Divider(
                                color: Colors.black,
                                thickness: 2,
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
                                                color: Colors.white,
                                                fontSize: 25)),
                                      ]),
                                  onPressed: () {
                                    Add_Pump();
                                  },
                                ),
                              ),
                            ]))
                      ])),
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
                          physics: ScrollPhysics(),
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot documentSnapshot =
                                snapshot.data.docs[index];
                            return Padding(
                              padding: EdgeInsets.all(12),
                              child: Card(
                                  child: Column(
                                children: [
                                  Container(
                                    color: Colors.lightBlue,
                                    width: 400,
                                    height: 150,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(documentSnapshot["Pump_Name"],
                                                style: TextStyle(
                                                    color: Colors.indigo[50],
                                                    fontSize: 37,
                                                    fontWeight: FontWeight.w900)),
                                            StreamBuilder(
                                                stream: FirebaseFirestore.instance
                                                    .collection('Stations')
                                                    .doc(station)
                                                    .collection('Container')
                                                    .where('Container_Id',
                                                        isEqualTo:
                                                            documentSnapshot[
                                                                "Container_Id"])
                                                    .snapshots(),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    DocumentSnapshot
                                                        documentSnapshot2 =
                                                        snapshot.data.docs[0];
                                                    return Text(
                                                        '${documentSnapshot2["Container_Name"]}',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .yellowAccent,
                                                            fontSize: 21,
                                                            fontWeight:
                                                                FontWeight.w700));
                                                  } else {
                                                    return CircularProgressIndicator();
                                                  }
                                                })
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        StreamBuilder(
                                            stream: FirebaseFirestore.instance
                                                .collection('Stations')
                                                .doc(station)
                                                .collection('Pump_Record')
                                                .where('Pump_Id',
                                                    isEqualTo: documentSnapshot[
                                                        "Pump_Id"])
                                                .orderBy('Record',
                                                    descending: true)
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                DocumentSnapshot
                                                    documentSnapshot1 =
                                                    snapshot.data.docs[0];
                                                return Text(
                                                    '${documentSnapshot1["Record"]}',
                                                    style:
                                                        TextStyle(fontSize: 35));
                                              } else {
                                                return CircularProgressIndicator();
                                              }
                                            })
                                      ]),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(30),
                                    child: ButtonTheme(
                                      height: 50.0,
                                      minWidth: 270,
                                      child: RaisedButton(
                                        color: Colors.grey,
                                        child: Text('New Recodrd',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 23)),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Pump_Records(
                                                        pumpID: documentSnapshot[
                                                            "Pump_Id"],
                                                        pumpName:
                                                            documentSnapshot[
                                                                "Pump_Name"])),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              )),
                            );
                          });
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ],
          )),
    );
  }
}
