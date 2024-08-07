import 'package:flutter/material.dart';
import 'package:galaxy/model/theme_model.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeModel themeModel = ThemeModel(isdark: true);

  changeTheme() {
    themeModel.isdark = !themeModel.isdark;
    notifyListeners();
  }
}
