import 'package:flutter/material.dart';

class LoginTextfieldProvider extends ChangeNotifier {
  bool isObscure = false;

  void switchObscure() {
    if (isObscure == false) {
      isObscure = true;
    } else {
      isObscure = false;
    }
    notifyListeners();
    
  }
}
