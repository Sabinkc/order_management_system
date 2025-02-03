import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/order%20history/domain/order_history_provider.dart';
import 'package:provider/provider.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Ord",
                style: TextStyle(
                  fontSize: 22,
                  color: CommonColor.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: "ers",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: IconButton(
              onPressed: () {
                final orderHistoryProvider =
                    Provider.of<OrderHistoryProvider>(context, listen: false);
                orderHistoryProvider.deleteOrders();
                final Logger logger = Logger();
                logger.i(orderHistoryProvider.orders.length);
              },
              icon: Icon(
                MingCute.delete_2_fill,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Consumer<OrderHistoryProvider>(
          builder: (context, provider, child) {
            if (provider.orders.isEmpty) {
              return Center(
                child: Text(
                  "No orders till now!",
                  style: TextStyle(fontSize: 20),
                ),
              );
            }

            return ListView.builder(
              itemCount: provider.orders.length,
              itemBuilder: (context, orderIndex) {
                final order = provider.orders[orderIndex];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('yyyy-MM-dd')
                          .format(order["date"] as DateTime),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "#ABC23RC",
                          style: TextStyle(
                              color: CommonColor.darkGreyColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Text(
                              "Details",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: CommonColor.mediumGreyColor,
                                color: CommonColor.mediumGreyColor,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right_rounded,
                              color: CommonColor.mediumGreyColor,
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: order["items"].map<Widget>((item) {
                        return Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Container(
                                height: 80,
                                width: 110,
                                color: Colors.grey[100],
                                child: Image.asset(
                                  item.imagePath,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    item.productName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: CommonColor.mediumGreyColor),
                                  ),
                                ),
                                Text(
                                  "Quantity: ${item.quantity} | Rs. ${item.price}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: CommonColor.mediumGreyColor),
                                )
                              ],
                            )
                          ],
                        );
                      }).toList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Text(
                            "Status: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 3, vertical: 1),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              border: Border.all(color: Colors.red),
                            ),
                            child: Text(
                              "Pending",
                              style: TextStyle(
                                  color: CommonColor.mediumGreyColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(color: Colors.grey),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
