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
    String randomStatus =
        statuses[Random().nextInt(statuses.length)]; // Select a random status

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

    // First, filter by status if a specific status is selected
    List<Map<String, dynamic>> statusFilteredOrders = _invoiceOrders;
    if (_selectedFilter != 'all_status') {
      switch (_selectedFilter) {
        case "pending":
          statusFilteredOrders = _invoiceOrders
              .where((order) => order["status"] == "Pending")
              .toList();
          break;
        case "paid":
          statusFilteredOrders = _invoiceOrders
              .where((order) => order["status"] == "Paid")
              .toList();
          break;
        case "refunded":
          statusFilteredOrders = _invoiceOrders
              .where((order) => order["status"] == "Refunded")
              .toList();
          break;
        case "cancelled":
          statusFilteredOrders = _invoiceOrders
              .where((order) => order["status"] == "Cancelled")
              .toList();
          break;
        default:
          statusFilteredOrders = _invoiceOrders;
          break;
      }
    }

    // Then, filter by date range if start and end dates are provided
    if (_startDate != null && _endDate != null) {
      statusFilteredOrders = statusFilteredOrders.where((order) {
        final orderDate = order["date"] as DateTime;
        return orderDate.isAfter(_startDate!.subtract(Duration(days: 1))) &&
            orderDate.isBefore(_endDate!.add(Duration(days: 1)));
      }).toList();
    }

    return statusFilteredOrders;
  }

  void setFilter(String filter, {DateTime? startDate, DateTime? endDate}) {
    _selectedFilter = filter;
    _startDate = startDate;
    _endDate = endDate;

    logger.i(
        "selected filter = $_selectedFilter, startDate = $_startDate, endDate = $_endDate");
    notifyListeners();
  }
}
