import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/domain/cart_quantity_provider.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/checkout_widget.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/invoice_widget_dashboard.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/orders_widget_dashboard.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/search_widget_dashboard.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/top_container_dashboard.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: PreferredSize(
        //     preferredSize: Size.fromHeight(kToolbarHeight),
        //     child: AppbarDashboard()),

        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenWidth * 0.05,
                ),
                TopContainerDashboard(),
                SizedBox(
                  height: screenWidth * 0.05,
                ),
                Consumer<CartQuantityProvider>(
                    builder: (context, provider, child) {
                  return provider.cartItems.isEmpty
                      ? SizedBox(
                          height: screenHeight * 0.67,
                          child: Center(
                            child: Text(
                              "No products in the cart!",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: CommonColor.darkGreyColor),
                            ),
                          ))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  "Orders",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )),
                            SizedBox(
                              height: screenWidth * 0.002,
                            ),
                            Divider(),
                            OrdersWidgetDashboard(),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  "Invoice Details:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )),
                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                            InvoiceWidgetDashboard(),
                            SizedBox(
                              height: screenHeight * 0.005,
                            ),
                            Divider(),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            CheckoutWidget(),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            Divider(),
                          ],
                        );
                }),
                SizedBox(
                  height: screenHeight * 0.013,
                ),
                SearchWidgetDashboard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
