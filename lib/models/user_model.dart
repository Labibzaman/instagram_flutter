import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String userName;
  final String uid;
  final String photoURl;
  final String password;
  final String bio;

  UserModel({
    required this.uid,
    required this.photoURl,
    required this.email,
    required this.userName,
    required this.password,
    required this.bio,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "username": userName,
        "password": password,
        "bio": bio,
        "profilePic": photoURl
      };

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    log('Snapshot data: $snapshot'); // Add logging here

    return UserModel(
      uid: snapshot['uid'] ?? '',
      photoURl: snapshot['profilePic'] ?? '',
      email: snapshot['email'] ?? '',
      userName: snapshot['username'] ?? '',
      password: snapshot['password'] ?? '', // Assuming password can be of any type
      bio: snapshot['bio'] ?? '',
    );
  }
}
