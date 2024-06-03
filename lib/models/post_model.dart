import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String description;
  final String userName;
  final String uid;
  final String profImage;
  final String postUrl;
  final String postId;
  final likes;
  final datePublished;

  PostModel({
    required this.uid,
    required this.postId,
    required this.postUrl,
    required this.description,
    required this.userName,
    required this.likes,
    required this.datePublished,
    required this.profImage,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "description": description,
        "username": userName,
        "likes": likes,
        "profImage": profImage,
        "datePublished": datePublished,
      };

  static PostModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    log('Snapshot data: $snapshot'); // Add logging here

    return PostModel(
      uid: snapshot['uid'] ?? '',
      userName: snapshot['username'] ?? '',
      description: snapshot['description'] ?? '',
      likes: snapshot['likes'] ?? '',
      datePublished: snapshot['datePublished'] ?? '',
      profImage: snapshot['profImage'] ?? '',
      postUrl: snapshot['postUrl'] ?? '',
      postId: snapshot['postId'] ?? '',
    );
  }
}
