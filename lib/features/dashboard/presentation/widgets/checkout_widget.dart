import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';

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
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: "Rs.",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: CommonColor.primaryColor),
                          ),
                          TextSpan(
                            text: "1699",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: CommonColor.primaryColor),
                          ),
                        ])),
                      ],
                    ),
                    SizedBox(
                      width: screenWidth * 0.35,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            backgroundColor: Color(0xFF100045),
                          ),
                          onPressed: () {},
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
}