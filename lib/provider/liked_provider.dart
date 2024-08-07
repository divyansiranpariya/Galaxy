import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteProvider extends ChangeNotifier {
  List<Map<String, dynamic>> allfav = [];
  FavouriteProvider() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? favData = prefs.getString('favorites');
    if (favData != null) {
      List<dynamic> decodedData = jsonDecode(favData);
      allfav =
          decodedData.map((item) => Map<String, dynamic>.from(item)).toList();
    }
    notifyListeners();
  }

  addData({required map}) {
    allfav.add(map);
    notifyListeners();
  }

  removeData({required map}) {
    allfav.remove(map);
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(allfav);
    await prefs.setString('favorites', encodedData);
  }
}
