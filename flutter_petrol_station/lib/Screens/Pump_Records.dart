import 'package:flutter/material.dart';
import 'package:flutter_petrol_station/widgets/Drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_petrol_station/services/cloud_services.dart';
import 'package:flutter_petrol_station/models/Pump_Record.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:intl/number_symbols.dart';

String station;

class Pump_Records extends StatefulWidget {
  static String id = 'pump_records';

  //get passed data from previous page
  final String pumpName;
  final int pumpID;
  const Pump_Records({Key key, this.pumpID, this.pumpName}) : super(key: key);

  @override
  _PumpsState createState() =>
      //To Use received data without widget. ( Storing the passed value in a different variable before using it)
      _PumpsState(pumpID: this.pumpID, pumpName: this.pumpName);
}

class _PumpsState extends State<Pump_Records> {
  //To Use received data without widget. ( Storing the passed value in a different variable before using it)
  String pumpName;
  int pumpID;
  _PumpsState({this.pumpID, this.pumpName});

  User loggedInUser;
  static int container_id, pump_id;
  static String container_name, pump_name;
  //String station;
  Map<String, Object> received_data;
  int containerID;
  String containerName;
  int previousCounter, newCounter, lastRecordId;
  int counterToDelete, counterBeforeDelete, volumeToBeAdded;
  DateTime lastUpdate;
  int recordError = 0;
  int oldVolume, negativeVolume, distractedContVolume, oldVol, newVol;
  Color colorR = Colors.blueAccent, colorT = Colors.blueAccent;
  var msgController = TextEditingController();

  final now = new DateTime.now();
  DateTime dateToday =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  //dd/MM/yyyy h:mm a
  final DateTime nn = DateTime.now();
  final DateFormat formatter = DateFormat('dd/MM/yyyy h:mm a');
  String formatted;
  DateTime Record_Time;

  FirebaseFirestore db = FirebaseFirestore.instance;
  CloudServices cloudServices =
      CloudServices(FirebaseFirestore.instance, FirebaseAuth.instance);

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
      await getPumpRecord();
      await getContainerId(widget.pumpID);
      print("asynccccc $containerID");
      await getContainerOldVolume();
      if (containerID != null) {
        await getContainerName(containerID);
      }

      //  setState(() {});
    }

    setState(() {});
    // hay l setState bhotta ekher shi bl fct yalle btrajj3 shi future krml yn3amal rebuild
    // krml yontor l data yalle 3m trj3 mn l firestore bs n3aytla ll method
  }

  void getContainerName(int container_id) async {
    String cont_name;
    print("In get name $container_id");

    await db
        .collection('Stations')
        .doc(station)
        .collection('Container')
        .doc(container_id.toString())
        .get()
        .then((value) {
      print("dataaaaaaaaaaaaa");
      print(value.data());
      cont_name = value.data()['Container_Name'];
      print("container nameee: $cont_name");
      containerName = cont_name;
    });
    // .where('Container_Id', isEqualTo: container_id)
    // .get();
  }

  getContainerId(int pumpId) async {
    print("pump idddddddddd in fct: $pumpId");
    print("stationnnn: $station");
    print(station);
    int cont_id;

    DocumentReference documentReference = db
        .collection('Stations')
        .doc(station)
        .collection('Pump')
        .doc(pumpId.toString());
    await documentReference.get().then((value) {
      print("dataaaaaaaaaaaaa");
      print(value.data());
      cont_id = value.data()['Container_Id'];
      print("container idddddd: $cont_id");
      containerID = cont_id;
    });
  }

  void getLastRecordId() {
    var qs = db
        .collection('Stations')
        .doc(station)
        .collection('Pump_Record')
        .orderBy('Pump_Record_Id', descending: true)
        .get()
        .then((val) => {
              if (val.docs.length > 0)
                {
                  lastRecordId = val.docs[0].get("Pump_Record_Id"),
                  print("last record iddddd$lastRecordId"),
                }
              else
                {
                  print("elseeeee"),
                }
            });
    setState(() {});
  }

  void getPumpRecord() async {
    db
        .collection('Stations')
        .doc(station)
        .collection('PumpRecord')
        .where('Pump_Id', isEqualTo: pumpID)
        .get()
        .then((value) {
      if (value.docs.length > 0) {}
    });

    var qs = await db
        .collection('Stations')
        .doc(station)
        .collection('Pump_Record')
        .where('Pump_Id', isEqualTo: pumpID)
        .orderBy('Pump_Record_Id', descending: true)
        .get()
        .then((val) => {
              if (val.docs.length > 0)
                {
                  // {
                  //   setState(() {
                  //     previousCounter = val.docs[0].get("Record");
                  //     print(previousCounter);
                  //     lastUpdate = DateTime.tryParse(
                  //         (val.docs[0].get("Record_Time")).toDate().toString());
                  //     print(lastUpdate);
                  //     lastRecordId = val.docs[0].get("Pump_Record_Id");
                  //     print("last record iddddd$lastRecordId");
                  //   }),

                  previousCounter = val.docs[0].get("Record"),
                  print(previousCounter),
                  lastUpdate = DateTime.tryParse(
                      (val.docs[0].get("Record_Time")).toDate().toString()),

                  print(lastUpdate),
                  //lastRecordId = val.docs[0].get("Pump_Record_Id"),
                  //print("last record iddddd$lastRecordId"),
                }
              else
                {
                  print("elseeeee"),
                }
            });
    //setState(() {});
  }

  void getContainerOldVolume() async {
    await db
        .collection('Stations')
        .doc(station)
        .collection('Container')
        .where('Container_Id', isEqualTo: containerID)
        .get()
        .then((val) => {
              if (val.docs.length > 0)
                {
                  oldVolume = val.docs[0].get("Volume"),
                  print('volumeeeeeeeeee $oldVolume'),
                }
              else
                {
                  print("elseeeee"),
                }
            });
  }

  //     .snapshots();
  // qs.then((value) => previousCounter = value.docs.last.data()['Record']);
  NumberFormat numberFormat = new NumberFormat('###,000');
  NumberSymbols numberFormatSymbols;

  @override
  Widget build(BuildContext context) {
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

    // final Map<String, Object> received_data =
    //     ModalRoute.of(context).settings.arguments;
    // pump_id = received_data["pump_id"];
    // pump_name = received_data["pump_name"];

    //if (mounted) {
    //getContainerInfo(pump_id);
    //}

    var dts;
    int _rowPerPage = PaginatedDataTable.defaultRowsPerPage;

    getPumpRecord();
    getLastRecordId();

    print("previous $previousCounter");

    print("builddd $containerID");
    print("builddd $containerName");
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        elevation: 0,
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
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              containerName != null ? 'Pump ($containerName)' : 'Pump',
              style: TextStyle(
                color: Colors.amber,
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Card(
            elevation: 12,
            child: ExpansionTile(
              title: Text("Pump Info",
                  style: TextStyle(fontSize: 29, color: Colors.blue[900])),
              trailing: Icon(Icons.arrow_drop_down,
                  size: 20, color: Colors.blue.shade900),
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 12,
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Text('Pump Name',
                              style: TextStyle(
                                  fontSize: 25, color: Colors.blue.shade800)),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(widget.pumpName != null ? '$pumpName' : 'Pump',
                          style: TextStyle(
                              fontSize: 22, color: Colors.indigo[300])),
                      SizedBox(
                        height: 18,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Text('Container Name',
                              style: TextStyle(
                                  fontSize: 25, color: Colors.blue.shade800)),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                          containerName != null
                              ? 'Container $containerName'
                              : 'Container',
                          style: TextStyle(
                              fontSize: 22, color: Colors.indigo[300])),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Card(
            elevation: 10,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  Text("New Counter",
                      style:
                          TextStyle(fontSize: 21, color: Colors.blue.shade800)),
                  SizedBox(height: 10),
                  Column(
                    children: <Widget>[
                      TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            ThousandsFormatter(),
                          ],
                          controller: msgController,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorR),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorR, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                            labelText: previousCounter != null
                                ? numberFormat
                                    .format(previousCounter)
                                    .toString()
                                : '',
                            fillColor: Colors.white,
                            labelStyle: TextStyle(color: Colors.black45),
                          ),
                          onChanged: (value) {
                            String g = value.replaceAll(RegExp(','), '');
                            //setState(() {
                            newCounter = int.parse(g);
                            //});
                          }),
                      Text(
                        recordError == 1
                            ? 'Enter value positive value greater than $previousCounter and less than current container volume $oldVolume'
                            : '',
                        style: TextStyle(color: colorR),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text('Previous Counter',
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF083369))),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                              previousCounter != null
                                  ? numberFormat
                                      .format(previousCounter)
                                      .toString()
                                  : '',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF083369))),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text('Last Update',
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF083369))),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                          lastUpdate != null
                              ? formatter.format(lastUpdate)
                              : '',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF083369))),
                    ),
                  ),
                  Divider(
                    color: Colors.black45,
                    thickness: 3,
                  ),
                  ButtonTheme(
                    height: 50.0,
                    minWidth: 130,
                    child: RaisedButton(
                      color: Colors.indigo[800],
                      elevation: 12,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.library_add_check_outlined,
                              size: 22, color: Colors.white),
                          SizedBox(
                            width: 14,
                          ),
                          Text('Save',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25)),
                        ],
                      ),
                      onPressed: () {
                        DateTime d = DateTime.now();
                        Timestamp myTimeStamp = Timestamp.fromDate(d);

                        if (newCounter == null) {
                          setState(() {
                            recordError = 1;
                            colorR = Colors.red;
                          });
                        } else {
                          print(
                              "new counterrr $newCounter previouss $previousCounter oldd volume $oldVolume");
                          if (newCounter - previousCounter > oldVolume) {
                            setState(() {
                              recordError = 1;
                              colorR = Colors.red;
                            });
                          }
                          if (newCounter < 0 || newCounter < previousCounter) {
                            setState(() {
                              recordError = 1;
                              colorR = Colors.red;
                            });
                          } else {
                            db
                                .collection('Stations')
                                .doc(station)
                                .collection('Pump_Record')
                                .where('Pump_Id', isEqualTo: pumpID)
                                .orderBy('Pump_Record_Id', descending: true)
                                .get()
                                .then((val) => {
                                      if (val.docs.length > 0)
                                        {
                                          previousCounter =
                                              val.docs[0].get("Record"),
                                          lastUpdate = DateTime.tryParse(
                                              (val.docs[0].get("Record_Time"))
                                                  .toDate()
                                                  .toString()),
                                        }
                                      else
                                        {
                                          print("elseeeee"),
                                        }
                                    });

                            if (newCounter != null &&
                                newCounter > previousCounter &&
                                newCounter - previousCounter < oldVolume) {
                              setState(() {
                                recordError = 0;
                                colorR = Colors.blueAccent;
                              });

                              print('newwwwwwww counterrrrrrr $newCounter');
                              print(
                                  'previoussssss counterrrrrrrr $previousCounter');
                              distractedContVolume =
                                  newCounter - previousCounter;
                              print(
                                  'distracteddddddddddddd $distractedContVolume');
                              int docId = lastRecordId + 1;
                              db
                                  .collection("Stations")
                                  .doc(station)
                                  .collection("Pump_Record")
                                  .doc(docId.toString())
                                  .set({
                                'Container_Id': containerID,
                                'Pump_Id': pumpID,
                                'Pump_Record_Id': docId,
                                'Record': newCounter,
                                'Record_Time': myTimeStamp,
                                'X_Id': myTimeStamp
                              }).then((value) {
                                db
                                    .collection('Stations')
                                    .doc(station)
                                    .collection('Container')
                                    .where('Container_Id',
                                        isEqualTo: containerID)
                                    .get()
                                    .then((val) => {
                                          if (val.docs.length > 0)
                                            {
                                              //setState(() {
                                              oldVolume =
                                                  val.docs[0].get("Volume"),
                                              //}),
                                              print(
                                                  'volumeeeeeeeeee $oldVolume'),
                                            }
                                          else
                                            {
                                              print("elseeeee"),
                                            }
                                        });
                                int newV = oldVolume - distractedContVolume;
                                print('newwwwwwwwVVVVVVVVVVVv$newV');
                                print(
                                    'plddddddddddddddddddVolumeeeeeeeeeee$oldVolume');
                                db
                                    .collection('Stations')
                                    .doc(station)
                                    .collection('Container')
                                    .doc(containerID.toString())
                                    .update({"Volume": newV}).then((value) {
                                  setState(() {
                                    //previousCounter = newCounter;
                                    //lastUpdate = DateTime.tryParse(
                                    //(myTimeStamp).toDate().toString());
                                    //previousCounter = newCounter;
                                    //lastUpdate = DateTime.now();
                                    //  distractedContVolume = 0;
                                    db
                                        .collection('Stations')
                                        .doc(station)
                                        .collection('Pump_Record')
                                        .where('Pump_Id', isEqualTo: pumpID)
                                        .orderBy('Pump_Record_Id',
                                            descending: true)
                                        .get()
                                        .then((val) => {
                                              if (val.docs.length > 0)
                                                {
                                                  previousCounter =
                                                      val.docs[0].get("Record"),
                                                  lastUpdate = DateTime.tryParse(
                                                      (val.docs[0].get(
                                                              "Record_Time"))
                                                          .toDate()
                                                          .toString()),
                                                }
                                              else
                                                {
                                                  print("elseeeee"),
                                                }
                                            });
                                    // db
                                    //     .collection('Stations')
                                    //     .doc(station)
                                    //     .collection('Container')
                                    //     .where('Container_Id',
                                    //         isEqualTo: containerID)
                                    //     .get()
                                    //     .then((val) => {
                                    //           if (val.docs.length > 0)
                                    //             {
                                    //               oldVolume =
                                    //                   val.docs[0].get("Volume"),
                                    //               print(
                                    //                   'volumeeeeeeeeee $oldVolume'),
                                    //             }
                                    //           else
                                    //             {
                                    //               print("elseeeee"),
                                    //             }
                                    //         });
                                    // setState(() {
                                    //   counterBeforeDelete = 0;
                                    //   counterToDelete = 0;
                                    //   volumeToBeAdded = 0;
                                    // });

                                    newCounter = null;
                                  });
                                  msgController.clear();
                                }).catchError((onError) {});
                              });
                            }
                          }
                        }
                        //setState(() {});
                      },
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Card(
            elevation: 12,
            child: ExpansionTile(
              title: Text("Previous Record",
                  style: TextStyle(fontSize: 29, color: Colors.blue.shade900)),
              trailing: Icon(Icons.arrow_drop_down,
                  size: 20, color: Colors.blue.shade900),
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 25),
                      TextFormField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: "Search Here",
                            fillColor: Colors.white,
                            labelStyle: TextStyle(
                              color: Colors.blue.shade100,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorT),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorR, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                          ),
                          onChanged: (String s) {}),
                      SizedBox(height: 40),
                      StreamBuilder(
                          stream: db
                              .collection('Stations')
                              .doc(station)
                              .collection('Pump_Record')
                              .where('Pump_Id', isEqualTo: pumpID)
                              .orderBy('Pump_Record_Id', descending: true)
                              .limit(10)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Text('ddddddddd');
                            } else {
                              return Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text('Date'),
                                      Text('Counter'),
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.indigo,
                                    thickness: 4,
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      itemCount: snapshot.data.docs.length,
                                      itemBuilder: (context, index) {
                                        int length = snapshot.data.docs.length;
                                        DocumentSnapshot documentSnapshot =
                                            snapshot.data.docs[index];
                                        // if (index == 1) {
                                        //   //setState(() {
                                        //   counterBeforeDelete =
                                        //       documentSnapshot['Record'];
                                        //   //  });
                                        // }
                                        return Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Text((documentSnapshot[
                                                                'Record_Time']
                                                            .toDate()
                                                            .toString()) !=
                                                        null
                                                    ? formatter.format(
                                                        DateTime.tryParse(
                                                            (documentSnapshot[
                                                                    'Record_Time']
                                                                .toDate()
                                                                .toString())))
                                                    : ''),
                                                Text(numberFormat
                                                    .format(documentSnapshot[
                                                        'Record'])
                                                    .toString()),
                                                GestureDetector(
                                                  child: index == 0
                                                      ? IconButton(
                                                          icon: const Icon(
                                                              Icons.delete),
                                                          color: Colors.red,
                                                          onPressed: () {
                                                            print(
                                                                "Deleteeeeeeeeeeeeeeeee");
                                                            int docID =
                                                                documentSnapshot[
                                                                    'Pump_Record_Id'];
                                                            String docId = docID
                                                                .toString();

                                                            //setState(() {
                                                            showDialog<String>(
                                                              context: context,
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  AlertDialog(
                                                                title: const Text(
                                                                    'DELETE !!!',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .red)),
                                                                content: const Text(
                                                                    'Are you sure you want to delete ???'),
                                                                actions: <
                                                                    Widget>[
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context,
                                                                          'Cancel');
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                      'Cancel',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.red),
                                                                    ),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      DocumentSnapshot
                                                                          documentSnapshot1 =
                                                                          snapshot
                                                                              .data
                                                                              .docs[1];
                                                                      counterBeforeDelete =
                                                                          documentSnapshot1[
                                                                              'Record'];
                                                                      counterToDelete =
                                                                          documentSnapshot[
                                                                              'Record'];

                                                                      volumeToBeAdded =
                                                                          counterToDelete -
                                                                              counterBeforeDelete;

                                                                      // setState(() {

                                                                      //});
                                                                      db
                                                                          .collection(
                                                                              'Stations')
                                                                          .doc(
                                                                              station)
                                                                          .collection(
                                                                              'Container')
                                                                          .where(
                                                                              'Container_Id',
                                                                              isEqualTo:
                                                                                  containerID)
                                                                          .get()
                                                                          .then((val) =>
                                                                              {
                                                                                if (val.docs.length > 0)
                                                                                  {
                                                                                    // setState(() {
                                                                                    oldVol = val.docs[0].get("Volume"),
                                                                                    newVol = oldVol + volumeToBeAdded,
                                                                                    //}),
                                                                                    print('oldddddddvollll $oldVol'),
                                                                                  }
                                                                                else
                                                                                  {
                                                                                    print("elseeeee"),
                                                                                  }
                                                                              });
                                                                      //});
                                                                      print(
                                                                          'previoussssssss $counterBeforeDelete');
                                                                      print(
                                                                          'deleteeeeeeeee $counterToDelete');

                                                                      //setState(() {

                                                                      print(
                                                                          'olddddd vollllll $oldVol');

                                                                      print(
                                                                          'newwwwwwww vollllll $newVol');
                                                                      //  });
                                                                      print(
                                                                          'volumeeeeee $volumeToBeAdded');

                                                                      db
                                                                          .collection(
                                                                              'Stations')
                                                                          .doc(
                                                                              station)
                                                                          .collection(
                                                                              'Pump_Record')
                                                                          .doc(
                                                                              docId)
                                                                          .delete()
                                                                          .then(
                                                                              (value) {
                                                                        db
                                                                            .collection(
                                                                                'Stations')
                                                                            .doc(
                                                                                station)
                                                                            .collection(
                                                                                'Container')
                                                                            .doc(containerID
                                                                                .toString())
                                                                            .update({
                                                                          "Volume":
                                                                              newVol
                                                                        }).then((value) {
                                                                          db
                                                                              .collection('Stations')
                                                                              .doc(station)
                                                                              .collection('Pump_Record')
                                                                              .where('Pump_Id', isEqualTo: pumpID)
                                                                              .orderBy('Pump_Record_Id', descending: true)
                                                                              .get()
                                                                              .then((val) => {
                                                                                    if (val.docs.length > 0)
                                                                                      {
                                                                                        setState(() {
                                                                                          previousCounter = val.docs[0].get("Record");

                                                                                          lastUpdate = DateTime.tryParse((val.docs[0].get("Record_Time")).toDate().toString());
                                                                                        }),
                                                                                        print(previousCounter),
                                                                                        print(lastUpdate),
                                                                                      }
                                                                                    else
                                                                                      {
                                                                                        print("elseeeee"),
                                                                                      },
                                                                                  });
                                                                        });
                                                                        db
                                                                            .collection(
                                                                                'Stations')
                                                                            .doc(
                                                                                station)
                                                                            .collection(
                                                                                'Pump_Record')
                                                                            .orderBy('Pump_Record_Id',
                                                                                descending: true)
                                                                            .get()
                                                                            .then((val) => {
                                                                                  if (val.docs.length > 0)
                                                                                    {
                                                                                      setState(() {
                                                                                        lastRecordId = val.docs[0].get("Pump_Record_Id");
                                                                                        print("last record iddddd$lastRecordId");
                                                                                      }),
                                                                                    }
                                                                                  else
                                                                                    {
                                                                                      print("elseeeee"),
                                                                                    }
                                                                                });
                                                                        db
                                                                            .collection(
                                                                                'Stations')
                                                                            .doc(
                                                                                station)
                                                                            .collection(
                                                                                'Container')
                                                                            .where('Container_Id',
                                                                                isEqualTo: containerID)
                                                                            .get()
                                                                            .then((val) => {
                                                                                  if (val.docs.length > 0)
                                                                                    {
                                                                                      //setState(() {
                                                                                      oldVolume = val.docs[0].get("Volume"),
                                                                                      //}),
                                                                                      print('volumeeeeeeeeee $oldVolume'),
                                                                                    }
                                                                                  else
                                                                                    {
                                                                                      print("elseeeee"),
                                                                                    }
                                                                                });

                                                                        Navigator.pop(
                                                                            context,
                                                                            'OK');
                                                                      }).catchError(
                                                                              (onError) {
                                                                        //alert error
                                                                        print(
                                                                            'error');
                                                                      });
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                      'OK',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.green),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        )
                                                      : IconButton(
                                                          icon: const Icon(
                                                              Icons.delete),
                                                          color: Colors.white,
                                                          onPressed: () {},
                                                        ),
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              color: Colors.blueAccent,
                                              thickness: 2,
                                            )
                                          ],
                                        );
                                      }),
                                ],
                              );
                            }
                          }),
                      SizedBox(height: 20),
                      Divider(
                        color: Colors.black,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}