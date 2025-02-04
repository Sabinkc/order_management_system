

import 'package:flutter/material.dart';

import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/order%20history/domain/order_history_provider.dart';
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
            final order = provider.orders;
            final int lastOrderIndex = order.length - 1;
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: double.infinity,
                      height: screenHeight * 0.29,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: CommonColor.primaryColor,
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Order No: ${order[lastOrderIndex]["orderId"]}",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Status: ${order[lastOrderIndex]["status"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                            Text(
                              "${order[lastOrderIndex]["date"]}",
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Container(
                                      height: 90,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Image.asset(
                                        order[lastOrderIndex]["items"][0]
                                            .imagePath, // First item image
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 220,
                                        child: Text(
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          order[lastOrderIndex]["items"][0]
                                              .productName, // First item name
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${order[lastOrderIndex]["items"][0].category} | Qty: ${order[lastOrderIndex]["items"][0].quantity}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text: "Rs.",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                "${order[lastOrderIndex]["items"][0].price * order[lastOrderIndex]["items"][0].quantity}", // First item price
                                            style: TextStyle(
                                              fontSize: 21,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      backgroundColor: Colors.white,
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      "Track Order",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: CommonColor.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 150,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      backgroundColor: Colors.white,
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      "View Invoice",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: CommonColor.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      height: 240,
                      child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, orderIndex) {
                          final order = provider.orders[lastOrderIndex];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: order["items"].map<Widget>((item) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: Container(
                                            height: 90,
                                            width: 70,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[100],
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Image.asset(
                                              item.imagePath,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 220,
                                              child: Text(
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                "${item.productName}",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "${item.category} | Qty: ${item.quantity}",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: CommonColor
                                                      .mediumGreyColor),
                                            ),
                                            RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                text: "Rs.",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: CommonColor
                                                        .primaryColor),
                                              ),
                                              TextSpan(
                                                text:
                                                    "${item.price * item.quantity}",
                                                style: TextStyle(
                                                    fontSize: 21,
                                                    fontWeight: FontWeight.bold,
                                                    color: CommonColor
                                                        .primaryColor),
                                              ),
                                            ])),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Divider(),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Invoice Details:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      )),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      spacing: 15,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Amount:",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Rs.",
                                  style: TextStyle(
                                    color: CommonColor.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "${order[lastOrderIndex]["items"]?.fold(0.0, (sum, item) => sum + (item.price * item.quantity)) ?? 0.0}",
                                  style: TextStyle(
                                    color: CommonColor.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Quantity:",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "(${order[lastOrderIndex]["items"]?.fold(0, (sum, item) => sum + item.quantity) ?? 0})",
                                  style: TextStyle(
                                    color: CommonColor.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
