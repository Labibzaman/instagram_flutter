import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram/responsive/mobile_screen.dart';
import 'package:instagram/responsive/responsive_layout_screen.dart';
import 'package:instagram/responsive/web_Screen.dart';
import 'package:instagram/screens/login_screen.dart';
import 'package:instagram/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyDZTBbFdgSGxruQEmEcPMoN_rBNa0Gs6xY",
      appId: "1:250215316087:web:063c86319b1188fb68a472",
      messagingSenderId: "250215316087",
      projectId: "instagram-17cdb",
      storageBucket: "instagram-17cdb.appspot.com",
    ));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram',
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      // home: const ResponsiveLayout(
      //   webScreenLayout: WebScreen(),
      //   mobileScreenLayout: MobileScreen(),
      // ),
      home: const LoginScreen(),
    );
  }
}
