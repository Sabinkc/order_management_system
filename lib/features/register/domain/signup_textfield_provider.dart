import 'package:flutter/material.dart';

class SignupTextfieldProvider extends ChangeNotifier {
  bool isPasswordObscure = false;

  void switchPasswordObscure() {
    if (isPasswordObscure == false) {
      isPasswordObscure = true;
    } else {
      isPasswordObscure = false;
    }
    notifyListeners();
  }

  bool isConfirmObscure = false;
  void switchConfirmObscure() {
    if (isConfirmObscure == false) {
      isConfirmObscure = true;
    } else {
      isConfirmObscure = false;
    }
    notifyListeners();
  }
}
