import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_petrol_station/models/Container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudServices {
  final _firestore;
  final _auth;

  CloudServices(this._firestore, this._auth);

  get auth => _auth;

  get firestore => _firestore;

  User getCurrentUser() {
    User loggedInUser;
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        return loggedInUser;
      }
    } catch (e) {
      print(e);
    }
    return loggedInUser;
  }

  Future<String> getUserStation(User loggedInUser) async {
    await for (var d
        in _firestore.collection("Login").doc(loggedInUser.uid).snapshots()) {
      print(d.data()); //get all fields
      return d.get("station"); //get specific field
    }
    //setState(
    //  () {}); // hay bhotta ekher shi bl fct yalle btrajj3 shi future krml yn3amal rebuild
    // krml yontor l data yalle 3m trj3 mn l firestore bs n3aytla ll method
  }

  //get all documents of a collection
  //Future<List<Map<String, dynamic>>>
  Future<List<QuerySnapshot>> getAllStationInfo() async {
    List<Map<String, Object>> allData;
    List<QuerySnapshot> snapshots = new List();
    var containers = _firestore
        .collection('Stations')
        .doc('Petrol Station 1')
        .collection('Container');
    //QuerySnapshot querySnapshot = containers;
    //Loop over docs which are the rows of Container collection (all containers)
    await for (var container in containers.snapshots()) {
      for (var c in container.docs) {
        //print(c.data());
      }

      QuerySnapshot querySnapshot = await containers.get();
      snapshots.add(querySnapshot);
      // Get data from docs and convert map to List
      allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      //print(allData);
      // for (var i in allData) {
      //   print("jjjjjjjjj");
      //   //containers_list.add(i.)
      //   print(i.keys);
      //   print(i.values);
      // }
    }
    //QuerySnapshot querySnapshot = await containers.get();
    // Get data from docs and convert map to List
    //final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    //print(allData);
    //return allData;

    return snapshots;
  }

  Future<QuerySnapshot> getAllStationInfo1() async {
    var snapshots = await _firestore
        .collection('Stations')
        .doc('Petrol Station 1')
        .collection('Container')
        .get();
    return snapshots;
  }

  Future<Stream> get() async {
    return await _firestore
        .collection('Stations')
        .doc('Petrol Station 1')
        .collection('Container')
        .snapshots();
  }

  // void get() {
  //   _firestore.collection('Stations')
  //       .doc('Petrol Station 1')
  //       .collection('Container')
  //       .get()
  //       .addOnSuccessListener(new OnSuccessListener<DocumentSnapshot>() {
  //   @Override
  //   public void onSuccess(DocumentSnapshot documentSnapshot) {
  //   if(documentSnapshots.isEmpty()){
  //   Log.d("MyLogger", "Empty Document!");
  //   }else{
  //   // Get all fields to a list
  //   List<MyModel> types = documentSnapshots.toObjects(MyModel.class);
  //   }
  //   }
  //   });

  //}

  //Get one document from a collection
  void getOneStationInfo() async {
    var containers = _firestore
        .collection('Stations')
        .doc('Petrol Station 1')
        .collection('Container')
        .doc('1'); //specific row
    //loop over doc fields
    await for (var container in containers.snapshots()) {
      print(container.data());
    }
  }
}
