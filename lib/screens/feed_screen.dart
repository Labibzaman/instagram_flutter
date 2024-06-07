import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/utils/colors.dart';

import '../widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 1),
          child: Container(
            height: 40,
            child: SvgPicture.asset(
              'assets/ic_instagram.svg',
              color: primaryColor,

            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_outline_rounded,size: 30,color: Colors.white,),
          ),
          IconButton(
            onPressed: () {},
            icon: Container(
              height: 26,
              child: Image.asset(
                'lib/icons/messenger.png',
                color: Colors.white,
              ),
            ),
          ),

        ],
      ),
      body: const PostCard(),
    );
  }
}
