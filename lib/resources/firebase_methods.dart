import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram/models/post_model.dart';
import 'package:instagram/resources/storage_methods.dart';

class FirebaseMethods {

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  StorageMethods storageMethods = StorageMethods();

  Future<String> postMethod(
    String uid,
    String description,
    String userName,
    String profImage,
    Uint8List file,
  ) async {
    String ref = 'post created';
    try {
      String postURl = await storageMethods.uploadToCloud('posts', file, true);


      PostModel postModel = PostModel(
        uid: uid,
        postUrl: postURl,
        description: description,
        userName: userName,
        likes: [],
        datePublished: DateTime.now(),
        profImage: profImage,
      );

      firebaseFirestore.collection('posts').doc(uid).set(postModel.toJson());
      ref = 'Success';
    } catch (err) {
      ref = err.toString();
    }
    return ref;
  }
}
