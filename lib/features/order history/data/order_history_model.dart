import 'package:order_management_system/features/dashboard/data/cart_model.dart';

class OrderHistoryModel {
  final String date;
  final List<CartModel> items;
  final String status;

  OrderHistoryModel(
      {required this.date, required this.items, required this.status});

  @override
  String toString() {
    return 'OrderHistoryModel(date: $date, items:$items, status: $status)';
  }
}
