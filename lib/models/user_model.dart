import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final dynamic userName;
  final dynamic uid;
  final dynamic photoURl;
  final dynamic password;
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

    return UserModel(
      uid: snapshot['uid'],
      photoURl: snapshot['profilePic'],
      email: snapshot['email'],
      userName: snapshot['userName'],
      password: snapshot['password'],
      bio: snapshot['bio'],
    );
  }
}
