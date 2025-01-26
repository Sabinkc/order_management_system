import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:order_management_system/features/dashboard/domain/cart_quantity_provider.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/appbar_dashboard.dart';
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
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: AppbarDashboard()),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopContainerDashboard(),
              SizedBox(
                height: screenWidth * 0.05,
              ),
              Consumer<CartQuantityProvider>(
                  builder: (context, provider, child) {
                return provider.cartItems.isEmpty
                    ? SizedBox(
                        height: screenHeight * 0.69,
                        child: Center(
                          child: Text("No products in the cart"),
                        ))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "Orders",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              )),
                          SizedBox(
                            height: screenWidth * 0.02,
                          ),
                          Divider(),
                          OrdersWidgetDashboard(),
                          SizedBox(
                            height: 10,
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
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              )),
                          SizedBox(
                            height: screenHeight * 0.015,
                          ),
                          InvoiceWidgetDashboard(),
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          Divider(),
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          CheckoutWidget(),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          Divider(),
                        ],
                      );
              }),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              SearchWidgetDashboard(),
            ],
          ),
        ),
      ),
    );
  }
}
