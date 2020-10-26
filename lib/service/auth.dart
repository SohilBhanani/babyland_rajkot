import 'package:babylandrajkot/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  var uid;
  final FirebaseAuth _auth = FirebaseAuth.instance;
//  final GoogleSignIn googleSignIn = GoogleSignIn();

  // create user obj based on firebase user
  AppUser _userFromFirebaseUser(User user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }
  AppUser getUser(){
    User user;
    return user !=null ? AppUser(uid:user.uid):null;
  }

  Future<String> getCurrentUser() async {
    final User user = await _auth.currentUser;
    uid = user.uid;
    // Similarly we can get email as well
    //final uemail = user.email;
    return uid.toString();
    //print(uemail);
  }

  // auth change user stream
  Stream<AppUser> get user {
    return _auth.authStateChanges()
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

//  //sign in with google
//
//  Future<String> signInWithGoogle() async {
//    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
//    final GoogleSignInAuthentication googleSignInAuthentication =
//    await googleSignInAccount.authentication;
//
//    final AuthCredential credential = GoogleAuthProvider.getCredential(
//      accessToken: googleSignInAuthentication.accessToken,
//      idToken: googleSignInAuthentication.idToken,
//    );
//
//    final AuthResult authResult = await _auth.signInWithCredential(credential);
//    final FirebaseUser user = authResult.user;
//
//    assert(!user.isAnonymous);
//    assert(await user.getIdToken() != null);
//
//    final FirebaseUser currentUser = await _auth.currentUser();
//    assert(user.uid == currentUser.uid);
//
//    return 'signInWithGoogle succeeded: $user';
//  }


  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return error;
    }
  }

  // sign in with google
  //TODO: Sign In with google

  // register with email and password
  Future registerWithEmailAndPassword(
      String name, String email,String contact, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'userid': user.uid,
        'email': email,
        'name': name,
        'contact': contact,
        'address':''
      });
      UserCredential r = await _auth.signInWithEmailAndPassword(email:email, password: password);
      User u = r.user;
      return u;
    } catch (error) {
      print(error.toString());
      return error;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
