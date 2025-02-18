import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

class SimpleUiProvider extends ChangeNotifier {
  //provider to filter by date
  String selectedDate = "all";
  final Logger logger = Logger();

  void switchSelectedDate(String value) {
    selectedDate = value;
    logger.i("Selected data: $selectedDate");
    notifyListeners();
  }

//provider to filter by status
  String selectedStatus = "all_status";
  void switchSelectedStatus(String value) {
    selectedStatus = value;
    logger.i("selected status: $selectedStatus");
    notifyListeners();
  }
}
