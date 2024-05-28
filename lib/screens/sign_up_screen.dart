import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/resources/auth_methods.dart';
import 'package:instagram/screens/login_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/utils/image_picker.dart';
import '../utils/colors.dart';
import '../widgets/text_input_fileds.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailTeController = TextEditingController();
  final passTeController = TextEditingController();
  final usernameTeController = TextEditingController();
  final bioTeController = TextEditingController();

  Uint8List? _imageFile;

  @override
  void dispose() {
    super.dispose();
    emailTeController.dispose();
    passTeController.dispose();
    usernameTeController.dispose();
    bioTeController.dispose();
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _imageFile = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              Hero(
                tag: "instalogo",
                child: SvgPicture.asset(
                  "assets/ic_instagram.svg",
                  color: primaryColor,
                  height: 64,
                ),
              ),
              const SizedBox(height: 12),
              Stack(
                children: [
                  _imageFile != null
                      ? Stack(
                          children: [
                            CircleAvatar(
                                radius: 48,
                                backgroundImage: MemoryImage(_imageFile!)),
                            Positioned(
                              bottom: -10,
                              right: -8,
                              child: IconButton(
                                onPressed: selectImage,
                                icon: const Icon(
                                  Icons.camera_alt_outlined,
                                  size: 26,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Stack(
                          children: [
                            const CircleAvatar(
                              radius: 48,
                              child: Icon(
                                CupertinoIcons.person,
                                size: 45,
                              ),
                            ),
                            Positioned(
                              bottom: -10,
                              right: -8,
                              child: IconButton(
                                onPressed: selectImage,
                                icon: const Icon(
                                  Icons.camera_alt_outlined,
                                  size: 26,
                                ),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
              const SizedBox(
                height: 22,
              ),
              MyTextFiled(
                controller: usernameTeController,
                hintText: 'User name',
                obscure: false,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 22,
              ),
              MyTextFiled(
                controller: emailTeController,
                hintText: 'email',
                obscure: false,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 22,
              ),
              MyTextFiled(
                controller: passTeController,
                hintText: 'password',
                obscure: true,
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(
                height: 22,
              ),
              MyTextFiled(
                controller: bioTeController,
                hintText: 'bio',
                obscure: false,
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(
                height: 22,
              ),
              InkWell(
                onTap: () {
                  AuthMethods().signUp(
                    email: emailTeController.text.trim(),
                    userName: usernameTeController.text.trim(),
                    password: passTeController.text.trim(),
                    bio: bioTeController.text.trim(),
                    file: _imageFile!,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      color: Colors.blue),
                  child: const Text('Sign up'),
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text("Already have an account !"),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text(
                        "Log in",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
