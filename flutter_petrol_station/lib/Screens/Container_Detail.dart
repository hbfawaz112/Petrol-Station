import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_petrol_station/Screens/dashboard_firstore.dart';
import 'package:flutter_petrol_station/widgets/Drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_petrol_station/services/cloud_services.dart';

class Container_Details extends StatefulWidget {
  static String idd = "Container_Details";
  String name;
  int id;
  Container_Details(this.id, this.name);

  @override
  _Container_DetailsState createState() => _Container_DetailsState();
}

class _Container_DetailsState extends State<Container_Details> {
  static String idd = "Container_Detail";
  int id;
  TextEditingController t1 = new TextEditingController();
  int volume;
  int newvolume, reduceVolume;
  String station;
  User loggedInUser;
  FirebaseFirestore db = FirebaseFirestore.instance;
  CloudServices cloudServices =
      CloudServices(FirebaseFirestore.instance, FirebaseAuth.instance);
  int emptyfeild = -1;
  Color colorV = Colors.blueAccent;
  int max_volume_error = -1;

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

    setState(() {});
    // hay l setState bhotta ekher shi bl fct yalle btrajj3 shi future krml yn3amal rebuild
    // krml yontor l data yalle 3m trj3 mn l firestore bs n3aytla ll method
  }

  void update_volume() async {
    print("iddddddddddddddddddddddddddddd ${widget.id}");
    //get the volume of specific container id;
    var s = await FirebaseFirestore.instance
        .collection('Stations')
        .doc(station)
        .collection('Container')
        .where('Container_Id', isEqualTo: widget.id)
        .get()
        .then((val) => {
              if (val.docs.length > 0)
                {
                  volume = val.docs[0].get("Volume"),
                  print('Current volume is ${volume}')
                }
              else
                {print("Not Found")}
            });


 
   if(t1.text==''){
      print("Empty text feild....");
      setState(() {
              emptyfeild=1;
               max_volume_error = -1;
            });
        
    }
    else if (reduceVolume > volume) {
      setState(() {
        max_volume_error = 1;
       emptyfeild=-1;
      });
      t1.text='';
    }
     else {
      setState(() {
      max_volume_error = -1;
       emptyfeild=-1;
      });
      newvolume = volume - reduceVolume;
      print("NEW VOLUME : ${newvolume}  , ${widget.id}");
      FirebaseFirestore.instance
          .collection('Stations')
          .doc(station)
          .collection('Container')
          .doc('${widget.id}')
          .update({'Volume': newvolume});
           t1.text='';
           Fluttertoast.showToast(
        msg: "Container Updated Successfully....",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
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
          body: ListView(children: [
            Card(
                elevation: 12,
                child: ExpansionTile(
                    title: Text("Editing Container Volume",
                        style:
                            TextStyle(fontSize: 25, color: Colors.indigo[300])),
                    trailing: Icon(Icons.arrow_drop_down,
                        size: 20, color: Colors.indigo[300]),
                    children: [
                      Divider(color: Colors.black38),
                      Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(children: [
                            SizedBox(height: 20),
                            Text("Reduce Current Volume By",
                                style: TextStyle(
                                    fontSize: 21, color: Colors.black45)),
                            SizedBox(height: 10),
                            TextFormField(
                                keyboardType: TextInputType.number,
                               /* inputFormatters: [
                                  ThousandsFormatter(),
                                ],*/
                                controller: t1,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: colorV),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: colorV, width: 2.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32.0)),
                                  ),
                                  labelText: "",
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(color: Colors.black45),
                                ),
                                onChanged: (String s) {
                                  String g = s.replaceAll(RegExp(','), '');
                                  reduceVolume = int.parse(g);
                                }),
                            max_volume_error==1?Text("Maximum value entred is ${volume}" , style:TextStyle(fontSize: 22.0,color: Colors.red,fontWeight: FontWeight.w800)):Text(''),
                            emptyfeild==1?Text("You must entred a real value",style:TextStyle(fontSize: 22.0,color: Colors.red,fontWeight: FontWeight.w800)) : Text(''),
                            SizedBox(height: 15),
                            Divider(color: Colors.black38),
                            Divider(color: Colors.black38),
                            SizedBox(height: 15),
                            TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.indigo),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
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
                                update_volume();
                              },
                            ),
                          ]))
                    ])),
                    
            SizedBox(
              height: 22,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text('Container ${widget.name} ',
                    style: TextStyle(fontSize: 35, color: Colors.green)),
              ),
            ),
            SizedBox(
              height: 22,
            ),
            Container(
              color: Colors.lightBlue,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height /
                      MediaQuery.of(context).size.height +
                  200,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Container ${widget.name} ',
                          style: TextStyle(
                              color: Colors.indigo[900],
                              fontSize: 37,
                              fontWeight: FontWeight.w900)),
                      SizedBox(height: 20),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('Stations')
                              .doc(station)
                              .collection('Container')
                              .where('Container_Id', isEqualTo: widget.id)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              DocumentSnapshot documentSnapshot =
                                  snapshot.data.docs[0];
                              return Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 28),
                                child: LinearPercentIndicator(
                                  width: MediaQuery.of(context).size.width -
                                      MediaQuery.of(context).size.width / 5,
                                  animation: true,
                                  lineHeight: 20.0,
                                  animationDuration: 2500,
                                  percent: documentSnapshot['Volume'] /
                                      documentSnapshot['Capacity'],
                                  center: Text(
                                    '${documentSnapshot['Volume']} L',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                  linearStrokeCap: LinearStrokeCap.roundAll,
                                  progressColor: Colors.green,
                                ),
                              ));
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          }),
                    ]),
              ),
            ),
          ])),
    );
  }
}
