import 'package:flutter/material.dart';
import '../core/remote/network/firestore_manager.dart';
import '../model/user.dart';
class UserProvider  extends ChangeNotifier{

  MyUser? user;

  setUserValue()async{
    user = await FirestoreManager.getUser();
    notifyListeners();
  }
}