import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteProvider extends ChangeNotifier {
  List<Map<dynamic, dynamic>> allfav = [];
  // FavouriteProvider() {
  //   _loadFavorites();
  // }

  // Future<void> _loadFavorites() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final String? favData = prefs.getString('favorites');
  //   if (favData != null) {
  //     List<dynamic> decodedData = jsonDecode(favData);
  //     allfav =
  //         decodedData.map((item) => Map<String, dynamic>.from(item)).toList();
  //   }
  //   notifyListeners();
  // }
  bool isliked = false;
  addData({required map}) async {
    allfav.add(map);
    isliked = !isliked;

    notifyListeners();
  }

  removeData({required map}) async {
    allfav.remove(map);

    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(allfav);
    await prefs.setString('favorites', encodedData);
  }
}
