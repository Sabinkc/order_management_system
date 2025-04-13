

import 'package:flutter/material.dart';
// import 'package:logger/logger.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/domain/cart_quantity_provider.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/cart%20screens/confirm_order_address_screen.dart';
import 'package:provider/provider.dart';


class ConfirmOrderWidget extends StatelessWidget {
  const ConfirmOrderWidget({super.key});

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
            crossAxisAlignment: CrossAxisAlignment.start,
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
            width: screenWidth * 0.40,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  backgroundColor: CommonColor.primaryColor,
                ),
                onPressed: () {
                  
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ConfirmOrderAddressScreen()));
                },
                child: Text(
                  "Confirm Order",
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

}
