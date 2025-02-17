import 'package:flutter/cupertino.dart';

class SimpleUiProvider extends ChangeNotifier {
  String selectedDate = "all";

  void switchSelectedDate(String value) {
    selectedDate = value;
    notifyListeners();
  }
}
