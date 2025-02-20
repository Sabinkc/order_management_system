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

//provider to filter invoice based on date
   DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;

  DateTime? get selectedStartDate => _selectedStartDate;
  DateTime? get selectedEndDate => _selectedEndDate;

  void setSelectedStartDate(DateTime? date) {
    _selectedStartDate = date;
    notifyListeners();
  }

  void setSelectedEndDate(DateTime? date) {
    _selectedEndDate = date;
    notifyListeners();
  }

  void clearDateRange() {
    _selectedStartDate = null;
    _selectedEndDate = null;
    notifyListeners();
  }
}
