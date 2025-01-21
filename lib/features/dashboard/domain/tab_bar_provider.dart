import 'package:flutter/material.dart';

class TabBarProvider with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void selectTab(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}

// import 'package:flutter/material.dart';

// class TabBarProvider extends ChangeNotifier {
//   int _selectedIndex = 0;
//   String _searchText = "";

//   List<Map<String, dynamic>> _filteredProducts = [];
//   List<Map<String, dynamic>> _products = [
//     // Add your product list here
//   ];

//   int get selectedIndex => _selectedIndex;
//   String get searchText => _searchText;
//   List<Map<String, dynamic>> get filteredProducts =>
//       _filteredProducts.isEmpty && _searchText.isEmpty
//           ? _products
//           : _filteredProducts;

//   void selectTab(int index) {
//     _selectedIndex = index;
//     filterProducts(); // Apply category filtering when tab changes
//     notifyListeners();
//   }

//   void updateSearchText(String text) {
//     _searchText = text;
//     filterProducts(); // Apply search filtering
//     notifyListeners();
//   }

//   void filterProducts() {
//     _filteredProducts = _products.where((product) {
//       final categoryMatch = _selectedIndex == 0 ||
//           product["category"]
//               .toLowerCase()
//               .contains(_getSelectedCategory().toLowerCase());
//       final nameMatch = product["name"]
//           .toLowerCase()
//           .contains(_searchText.toLowerCase());
//       return categoryMatch && nameMatch;
//     }).toList();
//   }

//   String _getSelectedCategory() {
//     switch (_selectedIndex) {
//       case 1:
//         return "phone";
//       case 2:
//         return "laptop";
//       case 3:
//         return "camera";
//       default:
//         return "all";
//     }
//   }
// }
