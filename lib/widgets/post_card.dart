import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram/models/user_model.dart';
import 'package:instagram/providers/user_providers.dart';
import 'package:instagram/resources/firebase_methods.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../screens/comment_screen.dart';

class PostCard extends StatefulWidget {
  PostCard({super.key, required this.snap});

  final snap;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  bool isAnimating = false;
  int commentLength = 0;

  @override
  Widget build(BuildContext context) {
    UserModel? userModel = Provider.of<UserProvider>(context).getUser;

    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ).copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    "${widget.snap['profImage']}",
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.snap['username']}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                              child: ListView(
                                  shrinkWrap: true,
                                  children: const ['Delete', 'Share']
                                      .map(
                                        (e) => InkWell(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 16),
                                            child: Text(e),
                                          ),
                                        ),
                                      )
                                      .toList()));
                        });
                  },
                  icon: const Icon(Icons.more_vert_sharp),
                ),
              ],
            ),
          ),
          GestureDetector(
            onDoubleTap: () async {
              await FirebaseMethods().likePostMethod(
                  widget.snap['postId'], userModel!.uid, widget.snap['likes']);

              setState(() {
                isAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: double.infinity,
                    child: Image.network("${widget.snap['postURL']}")),
                AnimatedOpacity(
                  opacity: isAnimating ? 1 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: LikeAnimation(
                    isAnimating: isAnimating,
                    duration: const Duration(milliseconds: 400),
                    child: const Icon(
                      Icons.favorite,
                      size: 80,
                    ),
                    onEnd: () {
                      setState(() {
                        isAnimating = false;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              LikeAnimation(
                isAnimating: widget.snap['likes'].contains(userModel?.uid),
                child: IconButton(
                    onPressed: () {},
                    icon: widget.snap['likes'].contains(userModel?.uid)
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.redAccent,
                          )
                        : const Icon(Icons.favorite_outline)),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CommentScreen(
                      snap: widget.snap['postId'],
                    );
                  }));
                },
                icon: const Icon(Icons.comment_bank),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.send),
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(Icons.bookmark_border)),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.w800),
                  child: Text(
                    "${widget.snap['likes'].length}",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${widget.snap['username']}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: " ${widget.snap['description']}",
                          style: const TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                ),
                StreamBuilder(
                  stream: firebaseFirestore
                      .collection('posts')
                      .doc(widget.snap['postId'])
                      .collection('comments')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return const Center(child: Text('Something went wrong'));
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('Be the first to comment'));
                    }
                    commentLength = snapshot.data!.docs.length;
                    return Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      width: double.infinity,
                      child: Text(
                        'View all $commentLength comments',
                        style: const TextStyle(color: secondaryColor),
                      ),
                    );
                  },
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  width: double.infinity,
                  child: Text(
                    DateFormat.yMMMd()
                        .format(widget.snap['datePublished'].toDate()),
                    style: const TextStyle(color: secondaryColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
