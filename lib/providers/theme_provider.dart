import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode themeMode = ThemeMode.system;

  changeTheme(ThemeMode newTheme){
    if(themeMode == newTheme) return;
    themeMode = newTheme;
    notifyListeners();
  }

}