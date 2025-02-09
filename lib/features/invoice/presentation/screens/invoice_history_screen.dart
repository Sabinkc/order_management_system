import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/invoice/domain/invoice_screen_provider.dart';
import 'package:order_management_system/features/order%20history/domain/order_history_provider.dart';
import 'package:provider/provider.dart';

class InvoiceHistoryScreen extends StatelessWidget {
  const InvoiceHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Consumer<InvoiceScreenProvider>(
        builder: (context, invoiceScreenProvider, child) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Inv",
                    style: TextStyle(
                      fontSize: 22,
                      color: CommonColor.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "oice",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: IconButton(
                  onPressed: () {
                    final orderHistoryProvider =
                        Provider.of<OrderHistoryProvider>(context,
                            listen: false);
                    orderHistoryProvider.deleteOrders();
                    final Logger logger = Logger();
                    logger.i(orderHistoryProvider.orders.length);
                  },
                  icon: Icon(
                    MingCute.delete_2_fill,
                    size: 20,
                    color: CommonColor.darkGreyColor,
                  ),
                ),
              ),
            ],
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Consumer<OrderHistoryProvider>(
              builder: (context, provider, child) {
                if (provider.orders.isEmpty) {
                  return Center(
                    child: Text(
                      "No invoices till now!",
                      style: TextStyle(
                          color: CommonColor.darkGreyColor, fontSize: 20),
                    ),
                  );
                }

                return Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: screenWidth * 0.75,
                              child: TextFormField(
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Search for your invoice..",
                                  hintStyle: TextStyle(
                                      color: CommonColor.darkGreyColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    size: 23,
                                    color: CommonColor.primaryColor,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: CommonColor
                                            .primaryColor), // Transparent border
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: CommonColor.primaryColor,
                                        width: 2), // Focused border color
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 2), // Error border color
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 2), // Focused error border color
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: Colors
                                            .grey), // Disabled border color
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: CommonColor.primaryColor),
                                  borderRadius: BorderRadius.circular(10)),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.sort,
                                    color: CommonColor.mediumGreyColor,
                                  )),
                            )
                          ],
                        )),
                    Expanded(
                      child: ListView.builder(
                        itemCount: provider.orders.length,
                        itemBuilder: (context, orderIndex) {
                          // Sort orders in descending order (latest first)
                          final sortedOrders = List.from(provider.orders)
                            ..sort((a, b) => (b["date"] as DateTime)
                                .compareTo(a["date"] as DateTime));

                          final order = sortedOrders[orderIndex];

                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: CommonColor.mediumGreyColor),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        DateFormat('yyyy-MM-dd')
                                            .format(order["date"] as DateTime),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Provider.of<InvoiceScreenProvider>(
                                                  context,
                                                  listen: false)
                                              .switchInvoiceDetailPage();
                                          Provider.of<InvoiceScreenProvider>(
                                                  context,
                                                  listen: false)
                                              .selectInvoiceIndex(orderIndex);
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              "Details",
                                              style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor:
                                                    CommonColor.mediumGreyColor,
                                                color:
                                                    CommonColor.mediumGreyColor,
                                              ),
                                            ),
                                            Icon(
                                              Icons
                                                  .keyboard_arrow_right_rounded,
                                              color:
                                                  CommonColor.mediumGreyColor,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  // Column(
                                  //   crossAxisAlignment: CrossAxisAlignment.start,
                                  //   children: order["items"].map<Widget>((item) {
                                  //     return Row(
                                  //       children: [
                                  //         Padding(
                                  //           padding:
                                  //               EdgeInsets.symmetric(vertical: 5),
                                  //           child: Container(
                                  //             height: 80,
                                  //             width: 110,
                                  //             color: Colors.grey[100],
                                  //             child: Image.asset(
                                  //               item.imagePath,
                                  //               fit: BoxFit.contain,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         SizedBox(width: 10),
                                  //         Column(
                                  //           crossAxisAlignment:
                                  //               CrossAxisAlignment.start,
                                  //           children: [
                                  //             SizedBox(
                                  //               width: 200,
                                  //               child: Text(
                                  //                 maxLines: 1,
                                  //                 overflow: TextOverflow.ellipsis,
                                  //                 item.productName,
                                  //                 style: TextStyle(
                                  //                     fontWeight: FontWeight.bold,
                                  //                     color: CommonColor
                                  //                         .mediumGreyColor),
                                  //               ),
                                  //             ),
                                  //             Text(
                                  //               "Quantity: ${item.quantity} | Rs. ${item.price * item.quantity}",
                                  //               style: TextStyle(
                                  //                   fontWeight: FontWeight.w500,
                                  //                   color: CommonColor
                                  //                       .mediumGreyColor),
                                  //             )
                                  //           ],
                                  //         )
                                  //       ],
                                  //     );
                                  //   }).toList(),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                              "Status: ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 3),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                border: Border.all(
                                                    color: Colors.red),
                                              ),
                                              child: Text(
                                                "Paid",
                                                style: TextStyle(
                                                    color: CommonColor
                                                        .mediumGreyColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ));
    });
  }
}
