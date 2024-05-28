import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  //signup
  Future<String> signUp({
    required String email,
    required dynamic userName,
    required dynamic password,
    required String bio,
    required Uint8List file,
  }) async {
    String message = 'Some error occurred';

    try {
      if (email.isNotEmpty ||
          userName.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String photoUrl =
            await StorageMethods().uploadToCloud('profilePics', file!, false);

        _fireStore.collection('users').doc(cred.user!.uid).set({
          "uid": cred.user!.uid,
          "email": email,
          "username": userName,
          "password": password,
          "bio": bio,
          "profilePic": photoUrl
        });
        message = 'success';
      }
    } catch (err) {
      return message = err.toString();
    }

    return message;
  }
}
