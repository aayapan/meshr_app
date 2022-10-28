import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  late bool idExist;
// CHECKING IF THE USER EXIST
  Future<bool> checkIfDocExists(String docId) async {
    try {
      // Get reference to Firestore collection
      var collectionRef = FirebaseFirestore.instance.collection('users');

      var doc = await collectionRef.doc(docId).get();
      return doc.exists;
    } catch (e) {
      rethrow;
    }
  }

// ADDING USER DETAILS TO FIRESTORE DATABASE
  Future addUserDetails() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({
          'email': FirebaseAuth.instance.currentUser?.email,
          'settingStatus': false,
          'settingValue': null
        })
        .then((_) => print('Added'))
        .catchError((error) => print('Add failed: $error'));
  }
// GOOGLE LOGIN (FIREBASE AUTH)
  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      await FirebaseAuth.instance.signInWithCredential(credential);

      final currentUserID = FirebaseAuth.instance.currentUser?.uid;
      idExist = await checkIfDocExists(currentUserID!);
      if (idExist) {
        print("GOOGLE ID EXIST!!");
      } else {
        addUserDetails();
      }
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }
// LOGOUT GOOGLE ACCOUNT
  Future logout() async {
    try {
      print("test logout");
      await googleSignIn.disconnect();
    } catch (e) {
      print(e.toString());
    }

    // FirebaseAuth.instance.signOut();
    print("Sign out");
  }
}
