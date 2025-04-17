import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

class SimpleUiProvider extends ChangeNotifier {
  final Logger logger = Logger();

//provider to filter by status
  String selectedStatus = "";
  void switchSelectedStatus(String value) {
    selectedStatus = value;
    logger.i("selected status: $selectedStatus");
    notifyListeners();
  }

//provider to filter invoice based on date
  String _selectedStartDate = "";
  String _selectedEndDate = "";

  String get selectedStartDate => _selectedStartDate;
  String get selectedEndDate => _selectedEndDate;

  void setSelectedStartDate(String date) {
    _selectedStartDate = date;
    notifyListeners();
  }

  void setSelectedEndDate(String date) {
    _selectedEndDate = date;
    notifyListeners();
  }

  void clearDateRange() {
    _selectedStartDate = "";
    _selectedEndDate = "";
    notifyListeners();
  }

  void clearFilter() {
    selectedStatus = "";
    _selectedStartDate = "";
    _selectedEndDate = "";
    notifyListeners();
  }
}
