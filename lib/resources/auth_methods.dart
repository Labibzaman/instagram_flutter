import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  //signup
  Future<String>signUp({
    required String email,
    required dynamic userName,
    required dynamic password,
    required String bio,
  }) async {
    String message = 'Some error occurred';

    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _fireStore.collection('users').doc(cred.user!.uid).set({
        "uid":cred.user!.uid,
        "email": email,
        "username": userName,
        "password": password,
        "bio": bio,
      });
      message = 'success';
    } catch (err) {
      return message = err.toString();
    }

    return message;
  }
}
