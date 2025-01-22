import 'package:flutter/material.dart';

class CheckboxProvider extends ChangeNotifier {
  bool isSelected = false;
  void switchSelection() {
    if (isSelected == false) {
      isSelected = true;
    } else {
      isSelected = false;
    }
    notifyListeners();
    
  }
}
