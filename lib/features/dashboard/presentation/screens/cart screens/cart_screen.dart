import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/domain/cart_quantity_provider.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/confirm_order_widget.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/invoice_widget_dashboard.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/orders_widget_dashboard.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: CommonColor.scaffoldbackgroundColor,
      appBar: AppBar(
        backgroundColor: CommonColor.primaryColor,
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "Cart",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child:
            Consumer<CartQuantityProvider>(builder: (context, provider, child) {
          return provider.cartItems.isEmpty
              ? SizedBox(
                  height: screenHeight * 0.65,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 50, right: 50, bottom: 0, top: 20),
                    child: Center(
                      child: SizedBox(
                          height: screenHeight * 0.5,
                          // color: Colors.red,
                          child: Column(spacing: 15, children: [
                            Image.asset(
                              "assets/images/empty_cart.png",
                              height: screenHeight * 0.3,
                              fit: BoxFit.contain,
                            ),
                            Text(
                              "No products in the cart!",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: CommonColor.darkGreyColor),
                            ),
                          ])),
                    ),
                  ))
              : Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                  ),
                  child: Column(
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
                        height: screenWidth * 0.009,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          color: CommonColor.commonGreyColor,
                          thickness: 2,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      OrdersWidgetDashboard(),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          color: CommonColor.commonGreyColor,
                          thickness: 2,
                        ),
                      ),

                      SizedBox(
                        height: screenHeight * 0.009,
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
                        height: screenHeight * 0.009,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          color: CommonColor.commonGreyColor,
                          thickness: 2,
                        ),
                      ),

                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Spacer(),
                      ConfirmOrderWidget(),
                      Spacer(),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      // Divider(),
                    ],
                  ),
                );
        }),
      ),
    );
  }
}
