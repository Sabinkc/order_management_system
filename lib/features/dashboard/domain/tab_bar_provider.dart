// import 'package:flutter/material.dart';

// class TabBarProvider with ChangeNotifier {
//   int _selectedIndex = 0;

//   int get selectedIndex => _selectedIndex;

//   void selectTab(int index) {
//     _selectedIndex = index;
//     notifyListeners();
//   }

//   String _searchKeyword = "";
//   String get searchKeyword => _searchKeyword;
//   final TextEditingController searchController = TextEditingController();

//   void updateSearchKeyword(String keyword) {
//     _searchKeyword = keyword;
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';

class TabBarProvider with ChangeNotifier {
  int _selectedIndex = 2;

  int get selectedIndex => _selectedIndex;

  void selectTab(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  String _searchKeyword = "";
  String get searchKeyword => _searchKeyword;
  final TextEditingController searchController = TextEditingController();

  void updateSearchKeyword(String keyword) {
    _searchKeyword = keyword;
    notifyListeners();
  }
}
