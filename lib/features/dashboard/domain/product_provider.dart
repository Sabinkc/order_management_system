// import 'package:flutter/material.dart';
// import 'package:order_management_system/features/dashboard/data/product_model.dart';

// class ProductProvider extends ChangeNotifier{

//   List<ProductCategory> _categories = [];
//   bool _isLoading = false;
//   String _errorMessage = '';

//   List<ProductCategory> get categories => _categories;
//   bool get isLoading => _isLoading;
//   String get errorMessage => _errorMessage;

//   Future<void> fetchProductCategories() async {
//     _isLoading = true;
//     _errorMessage = '';
//     notifyListeners();

//     try {
//       _categories = await ProductApiService.fetchProductCategories();
//     } catch (e) {
//       _errorMessage = e.toString().replaceFirst('Exception: ', '');
//     }

//     _isLoading = false;
//     notifyListeners();
//   }
// }

// class ProductApiService {
// }