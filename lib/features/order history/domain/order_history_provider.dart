// import 'package:flutter/material.dart';
// import 'package:logger/logger.dart';
// import 'package:order_management_system/features/dashboard/data/cart_model.dart';

// class OrderHistoryProvider with ChangeNotifier {
//   List<Map<String, dynamic>> orders = [];

//   void addOrder(List<CartModel> items) {
//     orders.add({
//       'date': DateTime.now(),
//       'items': items,
//       'status': 'Pending',
//       'orderId': "0123456",
//     });
//     final Logger logger = Logger();
//     logger.i("Item added");
//     logger.i("Orders after addition: $orders");

//     notifyListeners();
//   }

//   void deleteOrders() {
//     orders.clear();
//     notifyListeners();
//   }

//   void updateOrderStatus(int index, String status) {
//     if (index >= 0 && index < orders.length) {
//       orders[index]['status'] = status;
//       notifyListeners();
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:order_management_system/features/dashboard/data/cart_model.dart';

class OrderHistoryProvider with ChangeNotifier {
  List<Map<String, dynamic>> orders = [];

  OrderHistoryProvider() {
    _invoiceOrders = List.from(orders); // Initialize _orders
  }

  void addOrder(List<CartModel> items) {
    orders.add({
      'date': DateTime.now(),
      'items': items,
      'status': 'Pending',
      'orderId': "0123456",
    });
    _invoiceOrders = List.from(orders); // Update _orders

    final Logger logger = Logger();
    logger.i("Item added");
    logger.i("Orders after addition: $orders");

    notifyListeners();
  }

  void deleteOrders() {
    orders.clear();
    _invoiceOrders.clear();
    notifyListeners();
  }

  void updateOrderStatus(int index, String status) {
    if (index >= 0 && index < orders.length) {
      orders[index]['status'] = status;
      _invoiceOrders = List.from(orders); // Update _orders
      notifyListeners();
    }
  }

  List<Map<String, dynamic>> _invoiceOrders = [];
  String _selectedFilter = "all"; // Default filter
  List<Map<String, dynamic>> get filteredOrders {
    if (_selectedFilter == "all") {
      return _invoiceOrders;
    } else {
      final now = DateTime.now();
      switch (_selectedFilter) {
         case "last_second":
          return _invoiceOrders.where((order) {
            final orderDate = order["date"] as DateTime;
            return orderDate.isAfter(now.subtract(Duration(seconds: 15)));
          }).toList();
        case "last_minute":
          return _invoiceOrders.where((order) {
            final orderDate = order["date"] as DateTime;
            return orderDate.isAfter(now.subtract(Duration(minutes: 1)));
          }).toList();
        case "last_hour":
          return _invoiceOrders.where((order) {
            final orderDate = order["date"] as DateTime;
            return orderDate.isAfter(now.subtract(Duration(hours: 1)));
          }).toList();
        case "last_week":
          return _invoiceOrders.where((order) {
            final orderDate = order["date"] as DateTime;
            return orderDate.isAfter(now.subtract(Duration(days: 7)));
          }).toList();
        case "last_month":
          return _invoiceOrders.where((order) {
            final orderDate = order["date"] as DateTime;
            return orderDate.isAfter(now.subtract(Duration(days: 30)));
          }).toList();
        case "last_year":
          return _invoiceOrders.where((order) {
            final orderDate = order["date"] as DateTime;
            return orderDate.isAfter(now.subtract(Duration(days: 365)));
          }).toList();
        default:
          return _invoiceOrders;
      }
    }
  }

  void setFilter(String filter) {
    _selectedFilter = filter;
    final Logger logger = Logger();
    logger.i("selected filter = $_selectedFilter");
    notifyListeners();
  }
}
