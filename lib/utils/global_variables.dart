import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/feed_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/search_screen.dart';
import '../screens/upload_screen.dart';

const webScreenSize = 600;

final homeScreenItems = [
  Center(child: FeedScreen()),
  const Center(child: SearchScreen()),
  const UploadScreen(),
  const Center(child: Text('favourite')),
  Center(
    child: ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
  ),
];
