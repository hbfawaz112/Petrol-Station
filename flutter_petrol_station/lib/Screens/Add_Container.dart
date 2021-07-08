import 'package:flutter_petrol_station/widgets/Drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_petrol_station/services/cloud_services.dart';

class AddContainer_Firestore extends StatefulWidget {
  static String id = "Add_Container";
  AddContainer_Firestore({Key key}) : super(key: key);

  @override
  _AddContainer_FirestoreState createState() => _AddContainer_FirestoreState();
}

class _AddContainer_FirestoreState extends State<AddContainer_Firestore> {
  TextEditingController t1 = new TextEditingController();
  TextEditingController t2 = new TextEditingController();
  TextEditingController t3 = new TextEditingController();
  TextEditingController t4 = new TextEditingController();

  int container_name_error = -1;
  int capacity_error = -1;
  int volume_error = -1;

  var category;
  String station;
  int Fuel_Type_Id;
  int lastid;

  FirebaseFirestore db = FirebaseFirestore.instance;
  CloudServices cloudServices =
      CloudServices(FirebaseFirestore.instance, FirebaseAuth.instance);
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
      //getVolume();
    }
    setState(() {});
    // hay l setState bhotta ekher shi bl fct yalle btrajj3 shi future krml yn3amal rebuild
    // krml yontor l data yalle 3m trj3 mn l firestore bs n3aytla ll method
  }

  void addContainer() async {
    if (t1.text == '') {
      setState(() {
        container_name_error = 1;
      });
    } else if (t2.text == '') {
      setState(() {
        capacity_error = 1;
      });
    } else if (t4.text == '') {
      setState(() {
        volume_error = 1;
      });
    } else {
      setState(() {
        container_name_error = -1;
        capacity_error = -1;
        volume_error = -1;
      });
      QuerySnapshot _myDoc = await FirebaseFirestore.instance
          .collection('Stations')
          .doc(station)
          .collection('Container')
          .get();
      List<DocumentSnapshot> _myDocCount = _myDoc.docs;
      int n = _myDocCount.length;
      print('The lenght of document is{$n}');

      var s = await FirebaseFirestore.instance
          .collection('Stations')
          .doc(station)
          .collection('Fuel_Type')
          .where('Fuel_Type_Name', isEqualTo: category)
          .get()
          .then((val) => {
                if (val.docs.length > 0)
                  {
                    // print(val.docs[0].get("Fuel_Type_Id")),

                    Fuel_Type_Id = val.docs[0].get("Fuel_Type_Id"),
                  }
                else
                  {print("Not Found")}
              });

      var s1 = await FirebaseFirestore.instance
          .collection('Stations')
          .doc(station)
          .collection('Container')
          .get()
          .then((val) => {
                if (val.docs.length > 0)
                  {
                    // print(val.docs[0].get("Fuel_Type_Id")),

                    lastid = val.docs[n - 1].get("Container_Id"),
                    print('last id is  : ${lastid}')
                  }
                else
                  {print("Not Found")}
              });

      FirebaseFirestore.instance
          .collection('Stations')
          .doc(station)
          .collection('Container')
          .doc((lastid + 1).toString())
          .set({
        'Container_Id': lastid + 1,
        'Container_Name': t1.text.toString(),
        'Capacity': int.parse(t2.text),
        'Fuel_Type_Id': Fuel_Type_Id,
        'Volume': int.parse(t4.text)
      });
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
              child: Text(' Add Container',
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
                        Text("Container Name",
                            style:
                                TextStyle(fontSize: 21, color: Colors.black45)),
                        SizedBox(height: 10),
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
                              labelText: "Container Name",
                              fillColor: Colors.white,
                              labelStyle: TextStyle(color: Colors.black45),
                            ),
                            onChanged: (String s) {}),
                        Text(
                          container_name_error == 1
                              ? 'You must enter a valid container name'
                              : '',
                          style: TextStyle(fontSize: 18.0, color: Colors.red),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text("Capicity ",
                            style:
                                TextStyle(fontSize: 21, color: Colors.black45)),
                        SizedBox(height: 10),
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
                              labelText: "1000",
                              fillColor: Colors.white,
                              labelStyle: TextStyle(color: Colors.black45),
                            ),
                            onChanged: (String s) {}),
                        Text(
                          capacity_error == 1
                              ? 'You must enter a valid capacity'
                              : '',
                          style: TextStyle(fontSize: 18.0, color: Colors.red),
                        ),
                        SizedBox(
                          height: 12,
                        ),
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
                                      icon: const Icon(Icons.arrow_drop_down),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: const TextStyle(
                                          color: Colors.deepPurple),
                                      underline: Container(
                                        height: 2,
                                        color: Colors.deepPurpleAccent,
                                      ),

                                      value: category,
                                      //isDense: true,
                                      hint: Text('Fuel Type'),
                                      onChanged: (newValue) {
                                        setState(() {
                                          category = newValue;
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
                                                    // height: 20.0,

                                                    //color: primaryColor,

                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 7, left: 8),
                                                      child: new Text(
                                                        document
                                                            .get(
                                                                'Fuel_Type_Name')
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
                        Text("Initial Volume ",
                            style:
                                TextStyle(fontSize: 21, color: Colors.black45)),
                        SizedBox(height: 10),
                        TextFormField(
                            keyboardType: TextInputType.number,
                            controller: t4,
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
                              labelText: "Initial Volume",
                              fillColor: Colors.white,
                              labelStyle: TextStyle(color: Colors.black45),
                            ),
                            onChanged: (String s) {}),
                        Text(
                          volume_error == 1
                              ? 'You must enter a valid volume'
                              : '',
                          style: TextStyle(fontSize: 18.0, color: Colors.red),
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
                                  Text('Save',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25)),
                                ]),
                            onPressed: () {
                              addContainer();
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