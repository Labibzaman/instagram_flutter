import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore= FirebaseFirestore.instance;


  Future<String> uploadToCloud(String childName, Uint8List file, bool isPost) async {
    Reference ref =
        firebaseStorage.ref().child(childName).child(auth.currentUser!.uid);

    if(isPost){
      String id = const Uuid().v1();
      ref =ref.child(id);
    }

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot taskSnapshot = await uploadTask;

    String picDownUrl = await taskSnapshot.ref.getDownloadURL();
    return picDownUrl;
  }




}
