import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/domain/cart_quantity_provider.dart';
import 'package:provider/provider.dart';

class CheckoutWidget extends StatelessWidget {
  const CheckoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                "Total Price:",
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
            width: screenWidth * 0.35,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  backgroundColor: CommonColor.primaryColor,
                ),
                onPressed: () {
                  showLogoutDialogAndCheckout(context);
                },
                child: Text(
                  "Check Out",
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

  showLogoutDialogAndCheckout(BuildContext context) {
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
                            child: Text(
                              "Checkout",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ],
                  )
                ],
              ));
        });
  }

  checkout(BuildContext context) {
    Provider.of<CartQuantityProvider>(context, listen: false).clearCart();
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 1), () {
            if (context.mounted) {
              Navigator.pop(context);
              Navigator.pop(context);
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
                  "Checkout completed!",
                  style:
                      TextStyle(color: CommonColor.darkGreyColor, fontSize: 14),
                ),
              ),
            ),
          );
        });
  }
}
