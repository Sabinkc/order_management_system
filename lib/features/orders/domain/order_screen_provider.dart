// import 'package:flutter/material.dart';
// import 'dart:developer' as logger;
// import 'package:order_management_system/features/dashboard/data/product_api_sevice.dart';
// import 'package:order_management_system/features/dashboard/data/product_model.dart';

// class OrderScreenProvider extends ChangeNotifier {
//   final ProductApiSevice productApiSevice = ProductApiSevice();
//   bool isInvoiceDetailPage = false;

//   void switchInvoiceDetailPage() {
//     isInvoiceDetailPage = !isInvoiceDetailPage;
//     notifyListeners();

//     logger.log("isInvocieDetailPage: $isInvoiceDetailPage");
//   }

//   String orderKey = "";

//   selectInvoiceKey(String oKey) {
//     orderKey = oKey;
//     notifyListeners();
//   }

//   InvoiceModel invoiceDetail = InvoiceModel(
//       orderNo: "",
//       totalAmount: "",
//       date: "",
//       totalQuantity: 0,
//       status: "",
//       products: []);
//   bool isFetchOrderByLoading = false;

//   Future fetchOrderByorderKey(String orderKey) async {
//     isFetchOrderByLoading = true;
//     notifyListeners();
//     InvoiceModel response = await productApiSevice.getOrderByKey(orderKey);
//     invoiceDetail = response;
//     isFetchOrderByLoading = false;
//     notifyListeners();
//   }

//   bool isGetAllOrderLoading = false; // Loading state
//   List<InvoiceModel> allOrders = []; // Stores all orders from the API
//   int allOrderPage = 1;
//   bool allOrderHasMore = true;

//   // Filter-related properties
//   String _selectedFilter = "all_status"; // Default filter
//   DateTime? _startDate;
//   DateTime? _endDate;

//   final ProductApiSevice _service = ProductApiSevice(); // Your API service
//   // Fetch all orders from the API
//   // In your OrderScreenProvider
//   Future<void> getAllOrder() async {
//     if (isGetAllOrderLoading || !allOrderHasMore) return;

//     isGetAllOrderLoading = true;
//     notifyListeners();

//     try {
//       final response = await _service.getAllMyOrders(allOrderPage);
//       if (response.isEmpty) {
//         allOrderHasMore = false;
//       } else {
//         allOrders.addAll(response);
//         allOrderPage++;
//       }
//     } catch (e) {
//       // Handle error
//     } finally {
//       isGetAllOrderLoading = false;
//       notifyListeners();
//     }
//   }

//   void resetAllOrders() {
//     allOrderPage = 1;
//     allOrderHasMore = true;
//     allOrders.clear();
//     isGetAllOrderLoading = false;
//     notifyListeners();
//   }

//   final TextEditingController searchController = TextEditingController();

//   String _searchKeyword = ""; // Store the search keyword

//   // Getter for search keyword
//   String get searchKeyword => _searchKeyword;

//   // Method to update the search keyword
//   void updateSearchKeyword(String keyword) {
//     _searchKeyword = keyword;
//     logger.log(_searchKeyword);
//     notifyListeners();
//   }

//   void clearSearchKeyword() {
//     _searchKeyword = "";
//     notifyListeners();
//     // logger.log("search keyword after clearing: $_searchKeyword");
//     searchController.clear();
//     notifyListeners();
//   }

//   // Getter for filtered orders
//   List<InvoiceModel> get filteredOrders {
//     logger.log("Selected filter: $_selectedFilter");

//     // First, filter by status if a specific status is selected
//     List<InvoiceModel> statusFilteredOrders = allOrders;

//     if (_selectedFilter != 'all_status') {
//       statusFilteredOrders = allOrders.where((order) {
//         return order.status.toLowerCase() == _selectedFilter.toLowerCase();
//       }).toList();
//     }

//     // Then, filter by date range if start and end dates are provided
//     if (_startDate != null && _endDate != null) {
//       statusFilteredOrders = statusFilteredOrders.where((order) {
//         final orderDate = DateTime.parse(order.date); // Parse the date string
//         return orderDate.isAfter(_startDate!.subtract(Duration(days: 1))) &&
//             orderDate.isBefore(_endDate!.add(Duration(days: 1)));
//       }).toList();
//     }

//     if (_searchKeyword.isNotEmpty) {
//       statusFilteredOrders = statusFilteredOrders.where((order) {
//         return order.orderNo
//             .toLowerCase()
//             .contains(_searchKeyword.toLowerCase());
//       }).toList();
//     }
//     logger.log("filteredOrders: $statusFilteredOrders");
//     return statusFilteredOrders;
//   }

//   // Method to set filters
//   void setFilter(String filter, {DateTime? startDate, DateTime? endDate}) {
//     _selectedFilter = filter;
//     _startDate = startDate;
//     _endDate = endDate;

//     logger.log(
//         "Selected filter = $_selectedFilter, startDate = $_startDate, endDate = $_endDate");
//     notifyListeners();
//   }

//   // Clear filters
//   void clearFilters() {
//     _selectedFilter = "all_status";
//     _startDate = null;
//     _endDate = null;
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';
import 'dart:developer' as logger;
import 'package:order_management_system/features/dashboard/data/product_api_sevice.dart';
import 'package:order_management_system/features/dashboard/data/product_model.dart';

class OrderScreenProvider extends ChangeNotifier {
  final ProductApiSevice productApiSevice = ProductApiSevice();
  bool isInvoiceDetailPage = false;

  void switchInvoiceDetailPage() {
    isInvoiceDetailPage = !isInvoiceDetailPage;
    notifyListeners();

    logger.log("isInvocieDetailPage: $isInvoiceDetailPage");
  }

  String orderKey = "";

  selectInvoiceKey(String oKey) {
    orderKey = oKey;
    notifyListeners();
  }

  InvoiceModel invoiceDetail = InvoiceModel(
      orderNo: "",
      totalAmount: "",
      date: "",
      totalQuantity: 0,
      status: "",
      products: []);
  bool isFetchOrderByLoading = false;

  Future fetchOrderByorderKey(String orderKey) async {
    isFetchOrderByLoading = true;
    notifyListeners();
    InvoiceModel response = await productApiSevice.getOrderByKey(orderKey);
    invoiceDetail = response;
    isFetchOrderByLoading = false;
    notifyListeners();
  }

  // bool isGetAllOrderLoading = false; // Loading state
  // List<InvoiceModel> allOrders = []; // Stores all orders from the API
  // int allOrderPage = 1;
  // bool allOrderHasMore = true;

  // Filter-related properties
  String _selectedFilter = "all_status"; // Default filter
  String? _startDate;
  String? _endDate;

  final ProductApiSevice _service = ProductApiSevice(); // Your API service
  // Fetch all orders from the API
  // In your OrderScreenProvider
  // Future<void> getAllOrder() async {
  //   if (isGetAllOrderLoading || !allOrderHasMore) return;

  //   isGetAllOrderLoading = true;
  //   notifyListeners();

  //   try {
  //     final response = await _service.getAllMyOrders(allOrderPage);
  //     if (response.isEmpty) {
  //       allOrderHasMore = false;
  //     } else {
  //       allOrders.addAll(response);
  //       allOrderPage++;
  //     }
  //   } catch (e) {
  //     // Handle error
  //   } finally {
  //     isGetAllOrderLoading = false;
  //     notifyListeners();
  //   }
  // }

  // Future<void> getOrderByStatus(String status) async {
  //   if (isGetAllOrderLoading || !allOrderHasMore) return;

  //   isGetAllOrderLoading = true;
  //   notifyListeners();

  //   try {
  //     final response =
  //         await _service.getAllMyOrdersByStatus(allOrderPage, status);
  //     if (response.isEmpty) {
  //       allOrderHasMore = false;
  //     } else {
  //       allOrders.addAll(response);
  //       allOrderPage++;
  //     }
  //   } catch (e) {
  //     // Handle error
  //   } finally {
  //     isGetAllOrderLoading = false;
  //     notifyListeners();
  //   }
  // }

  // Future<void> getOrderByDate(String startDate, String endDate) async {
  //   if (isGetAllOrderLoading || !allOrderHasMore) return;

  //   isGetAllOrderLoading = true;
  //   notifyListeners();

  //   try {
  //     final response =
  //         await _service.getAllMyOrdersByDate(allOrderPage, startDate, endDate);
  //     if (response.isEmpty) {
  //       allOrderHasMore = false;
  //     } else {
  //       allOrders.addAll(response);
  //       allOrderPage++;
  //     }
  //   } catch (e) {
  //     // Handle error
  //   } finally {
  //     isGetAllOrderLoading = false;
  //     notifyListeners();
  //   }
  // }

  //   void resetAllOrders() {
  //   allOrderPage = 1;
  //   allOrderHasMore = true;
  //   allOrders.clear();
  //   isGetAllOrderLoading = false;
  //   notifyListeners();
  // }
  bool isOrderBySandDLoading = false; // Loading state
  List<InvoiceModel> ordersBySandD = []; // Stores all orders from the API
  bool orderBySandDHasMore = true;

  int orderBySandDPage = 1;
  Future<void> getOrderByStatusAndDate(
      String status, String startDate, String endDate) async {
    if (isOrderBySandDLoading || !orderBySandDHasMore) return;

    isOrderBySandDLoading = true;
    notifyListeners();

    try {
      logger.log(
          "page:$orderBySandDPage, status: $status, startDate: $startDate, endDate: $endDate");
      final response = await _service.getAllMyOrdersByStatusAndDate(
          orderBySandDPage, status, startDate, endDate);
      if (response.isEmpty) {
        orderBySandDHasMore = false;
      } else {
        ordersBySandD.addAll(response);
        orderBySandDPage++;
        logger.log("ordersbysandd: $ordersBySandD");
        notifyListeners();
      }
    } catch (e) {
      logger.log("$e");
    } finally {
      isOrderBySandDLoading = false;
      notifyListeners();
    }
  }

  void resetAllOrders() {
    orderBySandDPage = 1;
    orderBySandDHasMore = true;
    ordersBySandD.clear();
    isOrderBySandDLoading = false;
    notifyListeners();
  }

  final TextEditingController searchController = TextEditingController();

  String _searchKeyword = ""; // Store the search keyword

  // Getter for search keyword
  String get searchKeyword => _searchKeyword;

  // Method to update the search keyword
  void updateSearchKeyword(String keyword) {
    _searchKeyword = keyword;
    logger.log(_searchKeyword);
    notifyListeners();
  }

  void clearSearchKeyword() {
    _searchKeyword = "";
    notifyListeners();
    // logger.log("search keyword after clearing: $_searchKeyword");
    searchController.clear();
    notifyListeners();
  }

  // // Getter for filtered orders
  // List<InvoiceModel> get filteredOrders {
  //   logger.log("Selected filter: $_selectedFilter");

  //   // First, filter by status if a specific status is selected
  //   List<InvoiceModel> statusFilteredOrders = allOrders;

  //   if (_selectedFilter != 'all_status') {
  //     statusFilteredOrders = allOrders.where((order) {
  //       return order.status.toLowerCase() == _selectedFilter.toLowerCase();
  //     }).toList();
  //   }

  //   // Then, filter by date range if start and end dates are provided
  //   if (_startDate != null && _endDate != null) {
  //     statusFilteredOrders = statusFilteredOrders.where((order) {
  //       final orderDate = DateTime.parse(order.date); // Parse the date string
  //       return orderDate.isAfter(_startDate!.subtract(Duration(days: 1))) &&
  //           orderDate.isBefore(_endDate!.add(Duration(days: 1)));
  //     }).toList();
  //   }

  //   if (_searchKeyword.isNotEmpty) {
  //     statusFilteredOrders = statusFilteredOrders.where((order) {
  //       return order.orderNo
  //           .toLowerCase()
  //           .contains(_searchKeyword.toLowerCase());
  //     }).toList();
  //   }
  //   logger.log("filteredOrders: $statusFilteredOrders");
  //   return statusFilteredOrders;
  // }

  // Method to set filters
  void setFilter(String filter, {String? startDate, String? endDate}) {
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
