import 'package:flutter/material.dart';
import 'package:order_management_system/features/orders/domain/order_screen_provider.dart';
import 'package:order_management_system/features/orders/presentation/screens/order_detail_screen.dart';
import 'package:order_management_system/features/orders/presentation/screens/order_history_screen.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderScreenProvider>(
        builder: (context, orderscreenProvider, child) {
      return orderscreenProvider.isInvoiceDetailPage == true
          ? OrderDetailScreen(
              orderKey: orderscreenProvider.orderKey,
            )
          : OrderHistoryScreen();
    });
  }
}
