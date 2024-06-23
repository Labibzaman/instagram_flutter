import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram/models/post_model.dart';
import 'package:instagram/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirebaseMethods {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  StorageMethods storageMethods = StorageMethods();
  bool isLoading = false;

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
      ref = 'success';
    } catch (err) {
      ref = err.toString();
    }
    return ref;
  }

  Future<void> likePostMethod(String postID, String uid, List likes) async {
    try {
      String message = 'intit';
      if (likes.contains(uid)) {
        await firebaseFirestore.collection('posts').doc(postID).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await firebaseFirestore.collection('posts').doc(postID).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      message = 'success';
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> commentMethod(
      String postId, String profilePic, String text,String name) async {
    String commentId = const Uuid().v1();

   await firebaseFirestore.collection('posts').doc(postId).collection('comments').doc(commentId).set({
      'CommentID': commentId,
      'name':name,
      'profilePic':profilePic,
      'text':text,
      'datePublished':DateTime.now(),
      'postId':postId
    });
  }
}
