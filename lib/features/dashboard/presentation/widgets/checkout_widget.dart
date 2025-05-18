import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/simple_ui_provider.dart';
import 'package:order_management_system/common/utils.dart';
import 'package:order_management_system/features/dashboard/data/cart_model.dart';
import 'package:order_management_system/features/dashboard/domain/cart_quantity_provider.dart';
import 'package:order_management_system/features/dashboard/domain/product_provider.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/landing_screen.dart';
import 'package:order_management_system/features/my%20order/domain/order_history_provider.dart';
import 'package:order_management_system/features/orders/domain/order_screen_provider.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as logger;
import 'package:order_management_system/localization/l10n.dart';

class CheckoutWidget extends StatelessWidget {
  final int shipppingLocationId;
  const CheckoutWidget({super.key, required this.shipppingLocationId});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.current.totalPrice,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              Consumer<CartQuantityProvider>(
                builder: (context, provider, child) {
                  return RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: "Rs.",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: CommonColor.primaryColor),
                    ),
                    TextSpan(
                      text: provider.getTotalPrice().toString(),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: CommonColor.primaryColor),
                    ),
                  ]));
                },
              ),
            ],
          ),
          SizedBox(
            width: screenWidth * 0.40,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  backgroundColor: CommonColor.primaryColor,
                ),
                onPressed: () {
                  // showDialogAndCheckout(context);
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: screenHeight * 0.5,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Choose payment method",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: CommonColor.mediumGreyColor,
                                        )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20),
                                  decoration: BoxDecoration(
                                      color: CommonColor.commonGreyColor,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: CommonColor.mediumGreyColor,
                                          width: 0.5)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        spacing: 15,
                                        children: [
                                          Icon(
                                            EvaIcons.credit_card_outline,
                                            color: CommonColor.darkGreyColor,
                                          ),
                                          Text(
                                            "Cash on Delivery",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      Icon(
                                        Icons.check_circle,
                                        color: CommonColor.primaryColor,
                                        size: 28,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.green[50],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    spacing: 15,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        BoxIcons.bx_info_circle,
                                        color: CommonColor.darkGreyColor,
                                      ),
                                      Expanded(
                                          child: Text(
                                              "We only accept cash on delivery at the moment."))
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        backgroundColor:
                                            CommonColor.primaryColor,
                                      ),
                                      onPressed: () {
                                        showDialogAndCheckout(context);
                                      },
                                      child: Text("Continue",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold))),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: Text(
                  S.current.checkout,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          )
        ],
      ),
    );
  }

//loical part
  //function to show logoutdialog and checkout dialog
  showDialogAndCheckout(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              backgroundColor: Colors.white,
              alignment: Alignment.center,
              titlePadding: EdgeInsets.only(
                top: 12,
                bottom: 10,
              ),
              contentPadding: EdgeInsets.only(bottom: 12),
              title: Text(
                "Confirm to checkout?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Are you sure you want to checkout?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 13, color: CommonColor.darkGreyColor),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 15,
                    children: [
                      SizedBox(
                        width: 122,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: CommonColor.primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(8)),
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: CommonColor.primaryColor),
                            )),
                      ),
                      SizedBox(
                        width: 122,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              backgroundColor: CommonColor.primaryColor,
                            ),
                            onPressed: () {
                              checkout(context);
                            },
                            child: Consumer<CartQuantityProvider>(
                              builder: (context, cartProvider, child) {
                                return cartProvider.isCheckoutLoading == true
                                    //  || productProvider.isGetAllInvoiceLoading && orderProvider.isOrderBySandDLoading == true
                                    ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
                                        "Checkout",
                                        style: TextStyle(color: Colors.white),
                                      );
                              },
                            )),
                      ),
                    ],
                  )
                ],
              ));
        });
  }

  //function to checkout
  void checkout(BuildContext context) async {
    final cartQuantityProvider =
        Provider.of<CartQuantityProvider>(context, listen: false);
    final orderHistoryProvider =
        Provider.of<OrderHistoryProvider>(context, listen: false);
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);

    // Create a deep copy of the cart items
    final List<CartModel> cartItemsCopy =
        List.from(cartQuantityProvider.cartItems);

    orderHistoryProvider.addOrder(cartItemsCopy);

    List cartItems = cartQuantityProvider.cartItems;
    // logger.log("cartItmes: $cartItems");
    List<Map<String, dynamic>> orders = [];
    for (CartModel item in cartItems) {
      orders.add({
        "sku": item.sku,
        "quantity": item.quantity,
      });
    }

    logger.log("Orders to be passed: $orders");

    try {
      cartQuantityProvider.setCheckoutLoading(true);
      // Wait for the order creation to complete
      await productProvider.createOrder(shipppingLocationId, orders);
      if (!context.mounted) {
        return;
      }

//to update in my order screen
      final orderProvider =
          Provider.of<OrderScreenProvider>(context, listen: false);
      orderProvider.resetAllOrders();
      Provider.of<OrderScreenProvider>(context, listen: false);
      final simpleUiProvider =
          Provider.of<SimpleUiProvider>(context, listen: false);
      orderProvider.clearFilters();
      orderProvider.clearSearchKeyword();
      simpleUiProvider.clearDateRange();
      simpleUiProvider.clearFilter();
      simpleUiProvider.clearDateRange();
      simpleUiProvider.clearInvoiceDateRange();
      simpleUiProvider.clearInvoiceFilter();

      await Future.wait([
        orderProvider.getOrderByStatusAndDate("", "", ""),
        productProvider.getAllInvoice(true, "", "", ""),
      ]);

      cartQuantityProvider.clearCart();
      if (!context.mounted) return;

      // showDialog(
      //   context: context,
      //   barrierDismissible: false,

      //   builder: (context) {
      //     // Future.delayed(Duration(seconds: 1), () {
      //     //   if (context.mounted) {
      //     //     Navigator.pop(context); // Close the dialog
      //     //     Navigator.pop(context); // Go back to the previous screen
      //     //   }
      //     // });
      //     return AlertDialog(
      //       backgroundColor: Colors.white,
      //       shape:
      //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      //       content: SizedBox(
      //         height: 90,
      //         child: Center(
      //           child: Consumer<ProductProvider>(
      //             builder: (context, productProvider, child) {
      //               return productProvider.isCreateOrderLoading
      //                   ? Center(
      //                       child: CircularProgressIndicator(
      //                       color: CommonColor.primaryColor,
      //                     ))
      //                   : Column(
      //                       mainAxisAlignment: MainAxisAlignment.center,
      //                       spacing: 20,
      //                       children: [
      //                         Text(
      //                           "Checkout completed!",
      //                           style: TextStyle(
      //                               color: CommonColor.darkGreyColor,
      //                               fontWeight: FontWeight.bold,
      //                               fontSize: 14),
      //                         ),
      //                         InkWell(
      //                             onTap: () {

      //                             },
      //                             child: Container(
      //                               decoration: BoxDecoration(
      //                                   color: CommonColor.primaryColor,
      //                                   borderRadius: BorderRadius.circular(8)),
      //                               padding: EdgeInsets.symmetric(
      //                                   horizontal: 20, vertical: 10),
      //                               child: Text(
      //                                 "OK",
      //                                 style: TextStyle(
      //                                     color: Colors.white,
      //                                     fontWeight: FontWeight.bold),
      //                               ),
      //                             )),
      //                       ],
      //                     );
      //             },
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // );
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => LandingScreen(
                    selectedIndex: 2,
                  )),
          (route) => false);
      Utilities.showCommonSnackBar(
          context,
          durationMilliseconds: 2000,
          icon: Icons.shopping_bag_outlined,
          "Your order has been placed successfully!");
    } catch (e) {
      logger.log("Error during order creation: $e");

      // productProvider.isCategoryLoading = false;
      // Show an error dialog to the user
      showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 1), () {
            if (context.mounted) {
              Navigator.pop(context); // Close the dialog
            }
          });
          return AlertDialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: SizedBox(
              height: 90,
              child: Center(
                child: Text(
                  "$e",
                  style:
                      TextStyle(color: CommonColor.darkGreyColor, fontSize: 14),
                ),
              ),
            ),
          );
        },
      );
    } finally {
      cartQuantityProvider.setCheckoutLoading(false);
    }
  }
}
