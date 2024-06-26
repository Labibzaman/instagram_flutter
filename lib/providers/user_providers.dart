import 'package:flutter/material.dart';
import 'package:instagram/models/user_model.dart';
import 'package:instagram/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  UserModel? _userModel;

  final AuthMethods _authMethods = AuthMethods();

  UserModel? get getUser => _userModel;

  Future<void> refreshUser() async {
    UserModel userModel = await _authMethods.getUserDetails();
    _userModel = userModel;
    notifyListeners();
  }
}
