import 'package:intl/intl.dart';

class OrderHistoryModel {
  final String orderNo;
  final String price;
  final DateFormat date;
  final String quantity;
  final String status;
  OrderHistoryModel({required this.orderNo, required this.price, required this.date, required this.quantity, required this.status});


}