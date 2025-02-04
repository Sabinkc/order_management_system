import 'package:order_management_system/features/dashboard/data/cart_model.dart';

class OrderHistoryModel {
  final String date;
  final List<CartModel> items;
  final String status;
  final String orderId;

  OrderHistoryModel(
      {required this.date,
      required this.items,
      required this.status,
      required this.orderId});

  @override
  String toString() {
    return 'OrderHistoryModel(date: $date, items:$items, status: $status, orderId: $orderId)';
  }
}
