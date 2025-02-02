// import 'package:flutter/material.dart';
// import 'package:icons_plus/icons_plus.dart';
// import 'package:intl/intl.dart';
// import 'package:logger/logger.dart';
// import 'package:order_management_system/common/common_color.dart';
// import 'package:order_management_system/features/dashboard/domain/cart_quantity_provider.dart';

// import 'package:order_management_system/features/order%20history/domain/order_history_provider.dart';
// import 'package:provider/provider.dart';

// class OrderHistoryScreen extends StatelessWidget {
//   const OrderHistoryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(
//         title: RichText(
//           text: TextSpan(
//             children: [
//               TextSpan(
//                 text: "Ord",
//                 style: TextStyle(
//                   fontSize: 22,
//                   color: CommonColor.primaryColor,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               TextSpan(
//                 text: "ers",
//                 style: TextStyle(
//                   fontSize: 22,
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         actions: [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 15),
//             child: IconButton(
//               onPressed: () {
//                 final orderHistoryProvider =
//                     Provider.of<OrderHistoryProvider>(context, listen: false);
//                 orderHistoryProvider.deleteOrders();
//                 final Logger logger = Logger();
//                 logger.i(orderHistoryProvider.orders.length);
//               },
//               icon: Icon(
//                 MingCute.delete_2_fill,
//                 size: 20,
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20),
//         child: Consumer<OrderHistoryProvider>(
//           builder: (context, provider, child) {
//             // Check if orders are null or empty
//             if (provider.orders.isEmpty) {
//               return Center(
//                 child: Text(
//                   "No orders till now!",
//                   style: TextStyle(fontSize: 20),
//                 ),
//               );
//             }

//             return ListView(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Order History",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           "Sort",
//                           style: TextStyle(
//                             color: CommonColor.mediumGreyColor,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Icon(
//                           Icons.arrow_drop_down_outlined,
//                           color: CommonColor.mediumGreyColor,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: screenHeight * 0.02),
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics:
//                       NeverScrollableScrollPhysics(), // Prevent inner ListView from scrolling
//                   itemCount: provider.orders.length,
//                   itemBuilder: (context, orderindex) {
//                     final order = provider.orders[orderindex];

//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Display formatted date
//                         Text(
//                           DateFormat('yyyy-MM-dd')
//                               .format(order["date"] as DateTime),
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         Container(
//                           height: 200,
//                           color: Colors.red,
//                           child: ListView.builder(
//                             shrinkWrap: true,
//                             itemCount: 1,
//                             itemBuilder: (context, itemIndex) {
//                               return TextButton(
//                                   onPressed: () {
//                                     final Logger logger = Logger();
//                                     logger.i("status: ${order["status"]}");
//                                     logger.i(
//                                         "Items length: ${order["items"].length}");
//                                     logger.i(order["items"].isEmpty
//                                         ? "No Product"
//                                         : order["items"][0].productName);
//                                     final cartQuantityProvider =
//                                         Provider.of<CartQuantityProvider>(
//                                             context,
//                                             listen: false);
//                                     final orderHistoryProvider =
//                                         Provider.of<OrderHistoryProvider>(
//                                             context,
//                                             listen: false);
//                                     logger.i(
//                                         "cart items: ${cartQuantityProvider.cartItems}");
//                                     logger.i(
//                                         "orders: ${orderHistoryProvider.orders}");
//                                         logger.i("OrderHistoryScreen orders: ${provider.orders}");

//                                   },
//                                   child: Text("Display"));
//                             },
//                           ),
//                         ),
//                         // Text("${order["items"][0]["productName"]}"),
//                         SizedBox(height: 10),
//                         // Display items in the order

//                         Divider(
//                             color: Colors.grey), // Add a divider between orders
//                       ],
//                     );
//                   },
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/domain/cart_quantity_provider.dart';

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
            // Check if orders are null or empty
            if (provider.orders.isEmpty) {
              return Center(
                child: Text(
                  "No orders till now!",
                  style: TextStyle(fontSize: 20),
                ),
              );
            }

            return ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order History",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Sort",
                          style: TextStyle(
                            color: CommonColor.mediumGreyColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down_outlined,
                          color: CommonColor.mediumGreyColor,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                ListView.builder(
                  shrinkWrap: true,
                  physics:
                      NeverScrollableScrollPhysics(), // Prevent inner ListView from scrolling
                  itemCount: provider.orders.length,
                  itemBuilder: (context, orderindex) {
                    final order = provider.orders[orderindex];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Display formatted date
                        Text(
                          DateFormat('yyyy-MM-dd')
                              .format(order["date"] as DateTime),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Container(
                          height: 200,
                          color: Colors.red,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 1,
                            itemBuilder: (context, itemIndex) {
                              return TextButton(
                                  onPressed: () {
                                    final Logger logger = Logger();
                                    logger.i("status: ${order["status"]}");
                                    logger.i(
                                        "Items length: ${order["items"].length}");
                                    logger.i(order["items"].isEmpty
                                        ? "No Product"
                                        : order["items"][0].productName);
                                    final cartQuantityProvider =
                                        Provider.of<CartQuantityProvider>(
                                            context,
                                            listen: false);
                                    final orderHistoryProvider =
                                        Provider.of<OrderHistoryProvider>(
                                            context,
                                            listen: false);
                                    logger.i(
                                        "cart items: ${cartQuantityProvider.cartItems}");
                                    logger.i(
                                        "orders: ${orderHistoryProvider.orders}");
                                    logger.i(
                                        "OrderHistoryScreen orders: ${provider.orders}");
                                  },
                                  child: Text("Display"));
                            },
                          ),
                        ),
                        // Text("${order["items"][0]["productName"]}"),
                        SizedBox(height: 10),
                        // Display items in the order

                        Divider(
                            color: Colors.grey), // Add a divider between orders
                      ],
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
