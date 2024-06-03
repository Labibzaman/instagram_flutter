import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram/models/post_model.dart';
import 'package:instagram/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirebaseMethods {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  StorageMethods storageMethods = StorageMethods();
  bool isLoading= false;

  Future<String> postMethod(
    String uid,
    String description,
    String userName,
    String profImage,
    Uint8List file,
  ) async {
    String ref = 'post initialize';

    try {
      String postURl = await storageMethods.uploadToCloud('posts', file, true);

      String postID = const Uuid().v1();

      PostModel postModel = PostModel(
        uid: uid,
        postUrl: postURl,
        description: description,
        userName: userName,
        likes: [],
        datePublished: DateTime.now(),
        profImage: profImage,
        postId: postID,
      );

      firebaseFirestore.collection('posts').doc(postID).set(postModel.toJson());
      ref = 'Success';

    } catch (err) {
      ref = err.toString();
    }
    return ref;
  }
}
