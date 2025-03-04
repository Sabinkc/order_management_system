import 'package:flutter/material.dart';
// import 'dart:developer' as logger;

class LocationProvider extends ChangeNotifier {
//provider to switch address category
  String addressCategory = "home";
  switchAdressCategory(String category) {
    addressCategory = category;
    // logger.log(addressCategory);
    notifyListeners();
  }
}
