import 'package:flutter/material.dart';

import '../screens/feed_screen.dart';
import '../screens/upload_screen.dart';

const webScreenSize = 600;

final homeScreenItems = [
   Center(child: FeedScreen()),
  const Center(child: Text('search')),
  const UploadScreen(),
  const Center(child: Text('favourite')),
  const Center(child: Text('profile')),
];
