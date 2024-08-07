import 'package:flutter/material.dart';

class SliderProvider extends ChangeNotifier {
  int sliderindex = 0;
  void changeslide(int val) {
    sliderindex = val;
    notifyListeners();
  }
}
