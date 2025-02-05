import 'package:flutter/material.dart';

import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/order%20history/domain/order_history_provider.dart';
import 'package:order_management_system/features/order%20history/domain/switch_order_screen_provider.dart';
import 'package:order_management_system/features/order%20history/presentation/widgets/order_history_invoice_widget.dart';
import 'package:order_management_system/features/order%20history/presentation/widgets/order_history_top_card.dart';
import 'package:order_management_system/features/order%20history/presentation/widgets/order_history_trackorder_widget.dart';
import 'package:provider/provider.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<OrderHistoryProvider>(
          builder: (context, provider, child) {
            if (provider.orders.isEmpty) {
              return Center(
                child: Text(
                  "No orders till now!",
                  style:
                      TextStyle(color: CommonColor.darkGreyColor, fontSize: 20),
                ),
              );
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "My Orders",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  OrderHistoryTopCard(),
                  Consumer<SwitchOrderScreenProvider>(
                      builder: (context, provider, child) {
                    return provider.selectedIndex == 0
                        ? OrderHistoryTrackorderWidget()
                        : OrderHistoryInvoiceWidget();
                  })
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
