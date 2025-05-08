import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/domain/cart_quantity_provider.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/checkout_order_widget_dashboard.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/checkout_widget.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/invoice_widget_dashboard.dart';
import 'package:provider/provider.dart';
import 'package:order_management_system/localization/l10n.dart';

class CheckOutScreen extends StatelessWidget {
  final int shippingLocationid;
  const CheckOutScreen({super.key, required this.shippingLocationid});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: CommonColor.scaffoldbackgroundColor,
      appBar: AppBar(
        backgroundColor: CommonColor.primaryColor,
        title: RichText(
            text: TextSpan(children: [
          TextSpan(
            text: S.current.checkout,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          
        ])),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
        actions: [
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Center(
        child:
            Consumer<CartQuantityProvider>(builder: (context, provider, child) {
          return Padding(
            padding: EdgeInsets.only(
              top: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      S.current.orders,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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

                CheckoutOrderWidgetDashboard(),
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
                      S.current.invoiceDetails,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                Spacer(
                  flex: 2,
                ),
                CheckoutWidget(
                  shipppingLocationId: shippingLocationid,
                ),
       

                SizedBox(
                  height: screenHeight * 0.02,
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
