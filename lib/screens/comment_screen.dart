import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/resources/firebase_methods.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/snackbar.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../providers/user_providers.dart';
import '../widgets/comment_card.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key, required this.snap});

  final snap;

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController commentController = TextEditingController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    super.dispose();
    commentController.dispose();
  }

  bool isLoading = false;

  // Future commentMethod(String photo, String username) async {
  //   isLoading = true;
  //   setState(() {});
  //   await FirebaseMethods().commentMethod(
  //     widget.snap['postId'],
  //     photo,
  //     commentController.text,
  //     username,
  //   );
  //   isLoading = false;
  //   showSnackBar(context, 'success');
  //
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    final UserModel? userModel = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text('Comments'),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: firebaseFirestore
            .collection('posts')
            .doc(widget.snap)
            .collection('comments').orderBy('datePublished',descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              return  CommentCard(snap: snapshot.data?.docs[index]);
            },
          );
        },
      ),
      bottomNavigationBar: SafeArea(
          child: Container(
        height: kToolbarHeight,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                '${userModel?.photoURl}',
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 10),
                child: TextFormField(
                  controller: commentController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Comment as ${userModel?.userName}',
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                FirebaseMethods().commentMethod(
                    widget.snap,
                    userModel!.photoURl,
                    commentController.text,
                    userModel.userName);
                // commentMethod(userModel!.photoURl, userModel.userName);
                commentController.clear();
              },
              child: Container(
                padding: const EdgeInsets.only(left: 4, right: 15),
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : const Text(
                        'Post',
                        style: TextStyle(color: Colors.lightBlueAccent),
                      ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
