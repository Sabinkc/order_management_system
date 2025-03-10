import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/order/domain/order_screen_provider.dart';
import 'package:order_management_system/features/my%20order/domain/switch_order_screen_provider.dart';
import 'package:order_management_system/features/my%20order/presentation/widgets/order_history_invoice_widget.dart';
import 'package:order_management_system/features/my%20order/presentation/widgets/order_history_top_card.dart';
import 'package:order_management_system/features/my%20order/presentation/widgets/order_history_trackorder_widget.dart';
import 'package:provider/provider.dart';

class MyOrderHistoryScreen extends StatefulWidget {
  const MyOrderHistoryScreen({super.key});

  @override
  State<MyOrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<MyOrderHistoryScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if (!mounted) return;
      final orderProvider =
          Provider.of<OrderScreenProvider>(context, listen: false);
      orderProvider.getAllOrder();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<OrderScreenProvider>(
          builder: (context, orderProvider, child) {
            if (orderProvider.isGetAllOrderLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: CommonColor.primaryColor,
                ),
              );
            }
            if (orderProvider.allOrders.isEmpty) {
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
