import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../providers/user_providers.dart';
import '../utils/colors.dart';
import '../utils/image_picker.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  Uint8List? _file;

  Future<void> refreshUserData() async {
    Provider.of<UserProvider>(context).refreshUser();
  }

  _selectImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select image'),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(16),
              onPressed: () async {
                Navigator.pop(context);
                Uint8List file = await pickImage(ImageSource.gallery);
                setState(() {
                  _file = file;
                });
              },
              child: const Text('Choose from gallery'),
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(16),
              onPressed: () async {
                Navigator.pop(context);
                Uint8List file = await pickImage(ImageSource.camera);
                setState(() {
                  _file = file;
                });
              },
              child: const Text('Take a picture'),
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(16),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final UserModel? userModel = userProvider.getUser;

    if (userModel == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return _file == null
        ? Center(
            child: IconButton(
              onPressed: () => _selectImage(context),
              icon: const Icon(Icons.upload),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_back,
                ),
              ),
              title: const Text('POST TO'),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'POST',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                        backgroundImage: NetworkImage(userModel.photoURl),
                        ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Write a caption..',
                          border: InputBorder.none,
                        ),
                        maxLines: 4,
                      ),
                    ),
                    SizedBox(
                      height: 45.0,
                      width: 45.0,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                            image: _file != null
                                ? DecorationImage(
                                    fit: BoxFit.fill,
                                    alignment: FractionalOffset.topCenter,
                                    image: MemoryImage(_file!),
                                  )
                                : null,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(),
              ],
            ),
          );
  }
}
