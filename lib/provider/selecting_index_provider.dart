import 'package:flutter/material.dart';

class SelectIndex with ChangeNotifier {
  int currentIndex = 0;
  void OnselectingIndex(val) {
    currentIndex = val;
    notifyListeners();
  }
}
