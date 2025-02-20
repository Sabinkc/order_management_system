// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:logger/logger.dart';
// import 'package:order_management_system/features/dashboard/data/cart_model.dart';

// class OrderHistoryProvider with ChangeNotifier {
//   final Logger logger = Logger();
//   List<Map<String, dynamic>> orders = [];

//   OrderHistoryProvider() {
//     _invoiceOrders = List.from(orders); // Initialize _orders
//   }

// void addOrder(List<CartModel> items) {
//   List<String> statuses = ['Paid', 'Pending', 'Refunded', 'Cancelled'];
//   String randomStatus = statuses[Random().nextInt(statuses.length)]; // Select a random status

//   orders.add({
//     'date': DateTime.now(),
//     'items': items,
//     'status': randomStatus, // Assign random status
//     'orderId': "0123456",
//   });

//   _invoiceOrders = List.from(orders); // Update _orders

//   logger.i("Item added with status: $randomStatus");
//   logger.i("Orders after addition: $orders");

//   notifyListeners();
// }

//   void deleteOrders() {
//     orders.clear();
//     _invoiceOrders.clear();
//     notifyListeners();
//   }

//   void updateOrderStatus(int index, String status) {
//     if (index >= 0 && index < orders.length) {
//       orders[index]['status'] = status;
//       _invoiceOrders = List.from(orders); // Update _orders
//       notifyListeners();
//     }
//   }

//   List<Map<String, dynamic>> _invoiceOrders = [];
//   String _selectedFilter = "all"; // Default filter
//   List<Map<String, dynamic>> get filteredOrders {
//     logger.i("selected filter: $_selectedFilter");
//     logger.i("invoice_orders:$_invoiceOrders");
//     if (_selectedFilter == "all" || _selectedFilter == 'all_status') {
//       return _invoiceOrders;
//     } else {
//       final now = DateTime.now();
//       switch (_selectedFilter) {
//         case "last_second":
//           return _invoiceOrders.where((order) {
//             final orderDate = order["date"] as DateTime;
//             return orderDate.isAfter(now.subtract(Duration(seconds: 15)));
//           }).toList();
//         case "last_minute":
//           return _invoiceOrders.where((order) {
//             final orderDate = order["date"] as DateTime;
//             return orderDate.isAfter(now.subtract(Duration(minutes: 1)));
//           }).toList();
//         case "last_hour":
//           return _invoiceOrders.where((order) {
//             final orderDate = order["date"] as DateTime;
//             return orderDate.isAfter(now.subtract(Duration(hours: 1)));
//           }).toList();
//         case "last_week":
//           return _invoiceOrders.where((order) {
//             final orderDate = order["date"] as DateTime;
//             return orderDate.isAfter(now.subtract(Duration(days: 7)));
//           }).toList();
//         case "last_month":
//           return _invoiceOrders.where((order) {
//             final orderDate = order["date"] as DateTime;
//             return orderDate.isAfter(now.subtract(Duration(days: 30)));
//           }).toList();
//         case "last_year":
//           return _invoiceOrders.where((order) {
//             final orderDate = order["date"] as DateTime;
//             return orderDate.isAfter(now.subtract(Duration(days: 365)));
//           }).toList();
//         case "pending":
//           return _invoiceOrders.where((order) => order["status"] == "Pending").toList();
//         case "paid":
//           return _invoiceOrders
//               .where((order) => order["status"] == "Paid")
//               .toList();
//         case "refunded":
//           return _invoiceOrders
//               .where((order) => order["status"] == "Refunded")
//               .toList();
//         case "cancelled":
//           return _invoiceOrders
//               .where((order) => order["status"] == "Cancelled")
//               .toList();
//         default:
//           return _invoiceOrders;
//       }
//     }
//   }

//   void setFilter(String filter) {
//     _selectedFilter = filter;
//     final Logger logger = Logger();
//     logger.i("selected filter = $_selectedFilter");
//     notifyListeners();
//   }
// }

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:order_management_system/features/dashboard/data/cart_model.dart';

class OrderHistoryProvider with ChangeNotifier {
  final Logger logger = Logger();
  List<Map<String, dynamic>> orders = [];

  OrderHistoryProvider() {
    _invoiceOrders = List.from(orders); // Initialize _orders
  }

void addOrder(List<CartModel> items) {
  List<String> statuses = ['Paid', 'Pending', 'Refunded', 'Cancelled'];
  String randomStatus = statuses[Random().nextInt(statuses.length)]; // Select a random status

  orders.add({
    'date': DateTime.now(),
    'items': items,
    'status': randomStatus, // Assign random status
    'orderId': "0123456",
  });

  _invoiceOrders = List.from(orders); // Update _orders

  logger.i("Item added with status: $randomStatus");
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
  String _selectedFilter = "all_status"; // Default filter
  DateTime? _startDate;
  DateTime? _endDate;

  List<Map<String, dynamic>> get filteredOrders {
    logger.i("selected filter: $_selectedFilter");
    logger.i("invoice_orders: $_invoiceOrders");
    if (_selectedFilter == 'all_status') {
      return _invoiceOrders;
    } else {
      switch (_selectedFilter) {
        case "pending":
          return _invoiceOrders.where((order) => order["status"] == "Pending").toList();
        case "paid":
          return _invoiceOrders.where((order) => order["status"] == "Paid").toList();
        case "refunded":
          return _invoiceOrders.where((order) => order["status"] == "Refunded").toList();
        case "cancelled":
          return _invoiceOrders.where((order) => order["status"] == "Cancelled").toList();
        case "date_range":
          if (_startDate != null && _endDate != null) {
            return _invoiceOrders.where((order) {
              final orderDate = order["date"] as DateTime;
              return orderDate.isAfter(_startDate!.subtract(Duration(days: 1))) && 
                     orderDate.isBefore(_endDate!.add(Duration(days: 1)));
            }).toList();
          }
          return _invoiceOrders;
        default:
          return _invoiceOrders;
      }
    }
  }

  void setFilter(String filter, {DateTime? startDate, DateTime? endDate}) {
    _selectedFilter = filter;
    _startDate = startDate;
    _endDate = endDate;

    // Reset date range if filter is not "date_range"
    if (filter != "date_range") {
      _startDate = null;
      _endDate = null;
    }

    logger.i("selected filter = $_selectedFilter, startDate = $_startDate, endDate = $_endDate");
    notifyListeners();
  }

}
