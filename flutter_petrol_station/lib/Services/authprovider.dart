import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';



class AuthProvider {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signInWithEmail(String email, String password) async{
    try {

      UserCredential result = await _auth.signInWithEmailAndPassword(email: email,password: password);
      User user = result.user;
      if(user != null)
      { Fluttertoast.showToast(
          msg: "Login succefully :)",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 13.0
      );
      return true;}
      else   return false;
    } catch (e) {
      print(e.message);
      return false;
    }
  }


  Future<void> logOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("error logging out");
    }
  }

}