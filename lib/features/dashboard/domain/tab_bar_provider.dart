
import 'package:flutter/material.dart';
import 'dart:developer' as logger;

class TabBarProvider with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void selectTab(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void clearSelectedIndex() {
    _selectedIndex = 0;
    notifyListeners();
    logger.log("selected index: $_selectedIndex");
  }

  String _searchKeyword = "";
  String get searchKeyword => _searchKeyword;
  final TextEditingController searchController = TextEditingController();

  void updateSearchKeyword(String keyword) {
    _searchKeyword = keyword;
    notifyListeners();
  }

  void clearSearchKeyword(){
    _searchKeyword="";
     notifyListeners();
    logger.log("search keyword after clearing: $_searchKeyword");
    searchController.clear();
    notifyListeners();
  }
}
