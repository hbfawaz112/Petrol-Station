import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_petrol_station/widgets/Drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_petrol_station/services/cloud_services.dart';

class Providers extends StatefulWidget {
  static String id = 'Provider';
  @override
  _ProvidersState createState() => _ProvidersState();
}

class _ProvidersState extends State<Providers> {
  String dropdownValue = 'IPT';
  TextEditingController t1 = new TextEditingController();
  TextEditingController t2 = new TextEditingController();
  int last_provider_id;
  int new_provider_id;

  int save = 0;

  String selecting_provider;
  TextEditingController t3 = new TextEditingController();
  TextEditingController t4 = new TextEditingController();
  int selected_provider_id;
  String selected_Phone;

  bool isfilled = true;
  bool readOnlyOption = true, enable = false;
  Color fillColor = Colors.black12;

  bool add_privder_name_error = false;

  bool add_privder_phone_error = false;
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

  void addProvider() async {
    // get the last prover id
    await FirebaseFirestore.instance
        .collection('Stations')
        .doc(station)
        .collection('Provider')
        .orderBy('Provider_Id', descending: true)
        .get()
        .then((val) => {
              if (val.docs.length > 0)
                {
                  last_provider_id = val.docs[0].get("Provider_Id"),
                  print('last id is  : ${last_provider_id}')
                }
              else
                {print("Not Found")}
            });

    new_provider_id = last_provider_id + 1;

    FirebaseFirestore.instance
        .collection('Stations')
        .doc(station)
        .collection('Provider')
        .doc(new_provider_id.toString())
        .set({
      'Provider_Id': new_provider_id,
      'Provider_Name': t1.text,
      'Provider_Phone': t2.text,
    });
    print('done addedd');
  }

  void Provider_changed(newValue) async {
    setState(() {
      selecting_provider = newValue;
      print('${selecting_provider}');
    });
    //get the provider id where provider_name=selecting_provider
    await FirebaseFirestore.instance
        .collection('Stations')
        .doc(station)
        .collection('Provider')
        .where('Provider_Name', isEqualTo: selecting_provider)
        .get()
        .then((val) => {
              if (val.docs.length > 0)
                {
                  selected_provider_id = val.docs[0].get("Provider_Id"),
                  print("select provider has id : ${selected_provider_id}"),
                }
              else
                {print("Not Found")}
            });
    //get the phone number where providername=newValue
    await FirebaseFirestore.instance
        .collection('Stations')
        .doc(station)
        .collection('Provider')
        .where('Provider_Id', isEqualTo: selected_provider_id)
        .get()
        .then((val) => {
              if (val.docs.length > 0)
                {
                  selected_Phone = val.docs[0].get("Provider_Phone"),
                  print("select provider has phone number : ${selected_Phone}"),
                  setState(() {
                    isfilled = false;
                  }),
                  t3.text = selecting_provider,
                  t4.text = selected_Phone,
                }
              else
                {print("Not Found")}
            });
  }

  void update_provider() async {
    FirebaseFirestore.instance
        .collection('Stations')
        .doc(station)
        .collection('Provider')
        .doc('${selected_provider_id}')
        .update({'Provider_Name': t3.text, 'Provider_Phone': t4.text});
    print('Provider updated');
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => super.widget));
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
        body: ListView(children: [
          Card(
              elevation: 12,
              child: ExpansionTile(
                  title: Text("Add Provider",
                      style:
                          TextStyle(fontSize: 29, color: Colors.indigo[300])),
                  trailing: Icon(Icons.arrow_drop_down,
                      size: 20, color: Colors.indigo[300]),
                  children: [
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(children: [
                          SizedBox(height: 20),
                          Text("Provider Name",
                              style: TextStyle(
                                  fontSize: 21, color: Colors.black45)),
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
                                labelText: "Provider Name",
                                fillColor: Colors.white,
                                labelStyle: TextStyle(color: Colors.black45),
                              ),
                              onChanged: (String s) {}),
                          SizedBox(height: 15),
                          Text("Provider Phone",
                              style: TextStyle(
                                  fontSize: 21, color: Colors.black45)),
                          SizedBox(height: 10),
                          TextFormField(
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
                                labelText: "ex:01111111",
                                fillColor: Colors.white,
                                labelStyle: TextStyle(color: Colors.black45),
                              ),
                              onChanged: (String s) {}),
                          SizedBox(height: 15),
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
                                addProvider();
                              },
                            ),
                          ),
                        ]))
                  ])),
          SizedBox(height: 16),
          Card(
              elevation: 12,
              child: ExpansionTile(
                  title: Text("Provider Info",
                      style:
                          TextStyle(fontSize: 29, color: Colors.indigo[300])),
                  trailing: Icon(Icons.arrow_drop_down,
                      size: 20, color: Colors.indigo[300]),
                  children: [
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(children: [
                          Divider(),
                          SizedBox(height: 20),
                          Text("Select Provider",
                              style: TextStyle(
                                  fontSize: 21, color: Colors.black45)),
                          SizedBox(height: 10),
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('Stations')
                                  .doc(station)
                                  .collection('Provider')
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
                                            width: 1.0,
                                            style: BorderStyle.solid),
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
                                        value: selecting_provider,
                                        //isDense: true,
                                        hint: Text('Fuel Type'),
                                        onChanged: (newValue) {
                                          Provider_changed(newValue);
                                        },
                                        items: snapshot.data != null
                                            ? snapshot.data.docs.map(
                                                (DocumentSnapshot document) {
                                                return new DropdownMenuItem<
                                                        String>(
                                                    value: document
                                                        .get('Provider_Name')
                                                        .toString(),
                                                    child: new Container(
                                                      // height: 20.0,

                                                      //color: primaryColor,

                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 7,
                                                                left: 8),
                                                        child: new Text(
                                                          document
                                                              .get(
                                                                  'Provider_Name')
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
                          Text("Provider Name",
                              style: TextStyle(
                                  fontSize: 21, color: Colors.black45)),
                          SizedBox(height: 10),
                          TextFormField(
                              enabled: enable,
                              readOnly: readOnlyOption,
                              controller: t3,
                              // enableInteractiveSelection: false,
                              focusNode: FocusNode(),
                              //readOnly: true,
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
                                labelText: "Provider Name",
                                fillColor: fillColor,
                                filled: isfilled,
                                labelStyle: TextStyle(color: Colors.black45),
                              ),
                              onChanged: (String s) {}),
                          SizedBox(height: 15),
                          Text("Provider Phone",
                              style: TextStyle(
                                  fontSize: 21, color: Colors.black45)),
                          SizedBox(height: 10),
                          TextFormField(
                              enabled: enable,
                              readOnly: readOnlyOption,
                              controller: t4,

                              // enableInteractiveSelection: false,
                              focusNode: FocusNode(),
                              //readOnly: true,
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
                                labelText: "01000000",
                                fillColor: fillColor,
                                filled: isfilled,
                                labelStyle: TextStyle(color: Colors.black45),
                              ),
                              onChanged: (String s) {}),
                          SizedBox(height: 15),
                          ButtonTheme(
                            height: 50.0,
                            minWidth: 130,
                            child: RaisedButton(
                              color: Colors.indigo[800],
                              elevation: 12,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.edit,
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
                                  update_provider();
                                }
                              },
                            ),
                          ),
                        ]))
                  ])),
        ]));
  }
}