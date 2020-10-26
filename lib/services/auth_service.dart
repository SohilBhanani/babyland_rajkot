import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FireUser {
  final String uid;
  final String email;

  const FireUser({this.uid, this.email});
}

class AuthService with ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;
  bool loading = false;
  String userId;

  FireUser _userFromFirebase(User user) {
    return user == null ? null : FireUser(uid: user.uid, email: user.email);
  }

  String getCurrentUser() {
    final User user = _firebaseAuth.currentUser;
    userId = user.uid;
    return userId;
  }

  Stream<FireUser> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future signIn(String email, String password) async {
    try {
      loading = true;
      notifyListeners();
      final authResult = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        loading = false;
        notifyListeners();
        return _userFromFirebase(value.user);
      });
    } catch (e) {
      print(e);
      loading = false;
      notifyListeners();
      return e;
      // loading = false;
      // return e;
    }
  }

  Future signUp(
      String name, String email, String contact, String password) async {
    try {
      loading = true;
      notifyListeners();
      final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user.uid)
          .set({
        'userid': authResult.user.uid,
        'email': email,
        'name': name,
        'contact': contact,
        'address': ''
      }).then((value) {
        loading = false;
        notifyListeners();
        return _userFromFirebase(authResult.user);
      });
    } catch (e) {
      loading = false;
      notifyListeners();
      return e;
    }
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
