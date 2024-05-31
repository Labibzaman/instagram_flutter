import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram/models/user_model.dart';
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

        UserModel userModel = UserModel(
          uid: cred.user!.uid,
          photoURl: photoUrl,
          email: email,
          userName: userName,
          password: password,
          bio: bio,
        );

        _fireStore
            .collection('users')
            .doc(cred.user!.uid)
            .set(userModel.toJson());
        message = 'success';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == "invalid-email") {
        message = "This email is not valid";
      } else if (err.code == "week password") {
        message = "password is week";
      }
    } catch (err) {
      return message = err.toString();
    }

    return message;
  }

  Future<String> logIn(String email, dynamic password) async {
    String message = 'Some error Occured';

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        message = "Success";
      } else {
        message = "Enter all the filed";
      }
    } catch (error) {
      message = error.toString();
    }
    return message;
  }
}
