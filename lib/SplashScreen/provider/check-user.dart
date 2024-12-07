import 'package:firebase_auth/firebase_auth.dart';
import 'package:fix_go/Auth/model/usermodel.dart';
import 'package:fix_go/backend/firebase_functions.dart';
import 'package:flutter/material.dart';

class CheckUser extends ChangeNotifier {
  UserModel? userModel;
  User? firebaseUser;

  CheckUser() {
    firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser != null) {
      initUser();
    }
  }

  Future<void> initUser() async {
    userModel = await FirebaseFunctions.readUserData();
    notifyListeners();
  }
}