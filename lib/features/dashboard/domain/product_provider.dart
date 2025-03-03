// import 'package:flutter/material.dart';
// import 'package:order_management_system/features/dashboard/data/product_api_sevice.dart';
// import 'package:order_management_system/features/dashboard/domain/tab_bar_provider.dart';
// import 'dart:developer' as logger;

// import 'package:provider/provider.dart';

// class ProductProvider extends ChangeNotifier {
//   //provider to get all categories
//   final _service = ProductApiSevice();
//   bool isCategoryLoading = false;
//   List productCategory = [];

//   Future<void> getAllProductCategories() async {
//     isCategoryLoading = true;
//     notifyListeners();
//     final response = await _service.getProductCategories();
//     productCategory = response;
//     isCategoryLoading = false;
//     notifyListeners();
//   }

// //provider to fetch all products
//   bool isProductLoading = false;
//   List product = [];

//   Future<void> getAllProduct() async {
//     isProductLoading = true;
//     notifyListeners();
//     final response = await _service.getAllProducts();
//     product = response;
//     logger.log("product in provider: $product");
//     isProductLoading = false;
//     notifyListeners();
//   }

// //provider to get product category wise
//   bool isCategoryProductLoading = false;
//   List categoryProducts = [];

//   Future<void> getCategoryProducts(int c) async {
//     isCategoryProductLoading = true;
//     notifyListeners();
//     final response = await _service.getProductsByCategory(c);
//     categoryProducts = response;
//     filteredCategoryProducts = List.from(categoryProducts);
//     isCategoryProductLoading = false;
//     notifyListeners();
//   }

// //provider to search products
//   List filteredCategoryProducts = [];

//   // Search for products based on a keyword
//   void searchProducts(BuildContext context) {
//     final tabBarProvider = Provider.of<TabBarProvider>(context, listen: false);
//     final query = tabBarProvider.searchKeyword;
//     // logger.log("search keyword: $query");

//     if (query.isEmpty) {
//       // If the search query is empty, show all products
//       filteredCategoryProducts = List.from(categoryProducts);
//     } else {
//       // Filter products based on the search keyword
//       filteredCategoryProducts = categoryProducts
//           .where((product) =>
//               product.name.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     }
//     notifyListeners();
//   }

//   //provider to create orders
//   bool isCreateOrderLoading = false;
//   Future<Map<String, dynamic>> createOrder(
//       List<Map<String, dynamic>> orders) async {
//     isCreateOrderLoading = true;
//     notifyListeners();
//     final response = await _service.createOrders(orders);
//     isCreateOrderLoading = false;
//     notifyListeners();
//     return response;
//   }

//   //provider to get all orders
//   bool isGetAllOrderLoading = false;
//   List allOrders = [];
//   Future getAllOrder() async{
//     isGetAllOrderLoading = true;
//     notifyListeners();
//    final response = await _service.getAllMyOrders();
//    allOrders = response;
//    logger.log("allorders: $allOrders");
//     isGetAllOrderLoading = false;
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';
import 'package:order_management_system/features/dashboard/data/product_api_sevice.dart';
import 'package:order_management_system/features/dashboard/data/product_model.dart';
import 'package:order_management_system/features/dashboard/domain/tab_bar_provider.dart';
import 'dart:developer' as logger;

import 'package:provider/provider.dart';

class ProductProvider extends ChangeNotifier {
  //provider to get all categories
  final _service = ProductApiSevice();
  bool isCategoryLoading = false;
  List productCategory = [];

  Future<void> getAllProductCategories() async {
    isCategoryLoading = true;
    notifyListeners();
    final response = await _service.getProductCategories();
    productCategory = response;
    isCategoryLoading = false;
    notifyListeners();
  }

//provider to fetch all products
  bool isProductLoading = false;
  List product = [];

  Future<void> getAllProduct() async {
    isProductLoading = true;
    notifyListeners();
    final response = await _service.getAllProducts();
    product = response;
    logger.log("product in provider: $product");
    isProductLoading = false;
    notifyListeners();
  }

//provider to get product category wise
  bool isCategoryProductLoading = false;
  List categoryProducts = [];

  Future<void> getCategoryProducts(int c) async {
    isCategoryProductLoading = true;
    notifyListeners();
    final response = await _service.getProductsByCategory(c);
    categoryProducts = response;
    filteredCategoryProducts = List.from(categoryProducts);
    isCategoryProductLoading = false;
    notifyListeners();
  }

//provider to search products
  List filteredCategoryProducts = [];

  // Search for products based on a keyword
  void searchProducts(BuildContext context) {
    final tabBarProvider = Provider.of<TabBarProvider>(context, listen: false);
    final query = tabBarProvider.searchKeyword;
    // logger.log("search keyword: $query");

    if (query.isEmpty) {
      // If the search query is empty, show all products
      filteredCategoryProducts = List.from(categoryProducts);
    } else {
      // Filter products based on the search keyword
      filteredCategoryProducts = categoryProducts
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  //provider to create orders
  bool isCreateOrderLoading = false;
  Future<Map<String, dynamic>> createOrder(
      List<Map<String, dynamic>> orders) async {
    isCreateOrderLoading = true;
    notifyListeners();
    final response = await _service.createOrders(orders);
    isCreateOrderLoading = false;
    notifyListeners();
    return response;
  }


  bool isGetAllOrderLoading = false; // Loading state
  List<InvoiceModel> allOrders = []; // Stores all orders from the API

  // Filter-related properties
  String _selectedFilter = "all_status"; // Default filter
  DateTime? _startDate;
  DateTime? _endDate;

  // final Service _service = Service(); // Your API service

  // Fetch all orders from the API
  Future<void> getAllOrder() async {
    isGetAllOrderLoading = true;
    notifyListeners();
    final response = await _service.getAllMyOrders();
    allOrders = response;
    logger.log("All orders: $allOrders");
    isGetAllOrderLoading = false;
    notifyListeners();
  }

  // Getter for filtered orders
  List<InvoiceModel> get filteredOrders {
    logger.log("Selected filter: $_selectedFilter");

    // First, filter by status if a specific status is selected
    List<InvoiceModel> statusFilteredOrders = allOrders;

    if (_selectedFilter != 'all_status') {
      statusFilteredOrders = allOrders.where((order) {
        return order.status.toLowerCase() == _selectedFilter.toLowerCase();
      }).toList();
    }

    // Then, filter by date range if start and end dates are provided
    if (_startDate != null && _endDate != null) {
      statusFilteredOrders = statusFilteredOrders.where((order) {
        final orderDate = DateTime.parse(order.date); // Parse the date string
        return orderDate.isAfter(_startDate!.subtract(Duration(days: 1))) &&
            orderDate.isBefore(_endDate!.add(Duration(days: 1)));
      }).toList();
    }
    logger.log("filteredOrders: $statusFilteredOrders");
    return statusFilteredOrders;
  }

  // Method to set filters
  void setFilter(String filter, {DateTime? startDate, DateTime? endDate}) {
    _selectedFilter = filter;
    _startDate = startDate;
    _endDate = endDate;

    logger.log(
        "Selected filter = $_selectedFilter, startDate = $_startDate, endDate = $_endDate");
    notifyListeners();
  }

  // Clear filters
  void clearFilters() {
    _selectedFilter = "all_status";
    _startDate = null;
    _endDate = null;
    notifyListeners();
  }
}
