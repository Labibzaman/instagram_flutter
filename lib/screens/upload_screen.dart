import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/resources/firebase_methods.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../providers/user_providers.dart';
import '../utils/colors.dart';
import '../utils/image_picker.dart';
import '../utils/snackbar.dart'; // Ensure you have this import for showSnackBar

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  Uint8List? _file;
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;

  Future<void> refreshUserData() async {
    await Provider.of<UserProvider>(context, listen: false).refreshUser();
  }

  Future<String> postMethod(
    String uid,
    String username,
    String profImage,
  ) async {
    setState(() {
      isLoading = true;
    });

    try {
      String response = await FirebaseMethods().postMethod(
        uid,
        descriptionController.text,
        username,
        profImage,
        _file!,
      );

      print('Response from postMethod: $response');
      if (response == 'success') {
        if (mounted) {
          showSnackBar(context, 'Post uploaded successfully');
          clearImage();
        }
      } else {
        if (mounted) {
          showSnackBar(context, 'Failed to upload post');
        }
      }
      return response;
    } catch (e) {
      if (mounted) {
        showSnackBar(context, 'Error: $e');
      }
      return 'failed';
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void clearImage (){
    _file=null;
  }

  Future<void> _selectImage(BuildContext context) async {
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
                  onPressed: () {
                    postMethod(
                        userModel.uid, userModel.userName, userModel.photoURl);
                  },
                  child: const Text(
                    'POST',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                isLoading
                    ? const LinearProgressIndicator(
                        backgroundColor: Colors.blue,
                      )
                    : const SizedBox(height: 10),
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
                        controller: descriptionController,
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
