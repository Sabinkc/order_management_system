import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:order_management_system/features/dashboard/data/cart_model.dart';

class OrderHistoryProvider with ChangeNotifier {
  List<Map<String, dynamic>> orders = [];

  void addOrder(List<CartModel> items) {
    orders.add({
      'date': DateTime.now(),
      'items': items,
      'status': 'Pending',
      'orderId': "0123456",
    });
    final Logger logger = Logger();
    logger.i("Item added");
    logger.i("Orders after addition: $orders");

    notifyListeners();
  }

  void deleteOrders() {
    orders.clear();
    notifyListeners();
  }

  void updateOrderStatus(int index, String status) {
    if (index >= 0 && index < orders.length) {
      orders[index]['status'] = status;
      notifyListeners();
    }
  }
}
