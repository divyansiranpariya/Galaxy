import 'package:flutter/material.dart';
import 'package:galaxy/model/theme_model.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeModel themeModel = ThemeModel(isdark: false);

  changeTheme() {
    themeModel.isdark = !themeModel.isdark;
    notifyListeners();
  }
}
