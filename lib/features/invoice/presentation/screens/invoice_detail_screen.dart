// import 'package:flutter/material.dart';
// import 'package:order_management_system/common/common_color.dart';
// import 'package:order_management_system/common/constants.dart';
// import 'package:order_management_system/features/invoice/domain/invoice_screen_provider.dart';
// import 'package:order_management_system/features/order%20history/domain/order_history_provider.dart';
// import 'package:provider/provider.dart';
// import 'dart:developer' as logger;

// class InvoiceDetailScreen extends StatelessWidget {
//   final int index;
//   const InvoiceDetailScreen({super.key, required this.index});

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final orderHistoryProvider = Provider.of<OrderHistoryProvider>(context);
//     final orderIndex = orderHistoryProvider.orders.length - 1 - index;
//     return Consumer<InvoiceScreenProvider>(
//         builder: (context, invoiceScreenProvider, child) {
//       return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           leading: IconButton(
//               onPressed: () {
//                 Provider.of<InvoiceScreenProvider>(context, listen: false)
//                     .switchInvoiceDetailPage();
//               },
//               icon: Icon(
//                 Icons.arrow_back_ios,
//                 color: CommonColor.primaryColor,
//                 size: 20,
//               )),
//           title: RichText(
//               text: TextSpan(children: [
//             TextSpan(
//               text: "InvoiceDetails",
//               style: TextStyle(
//                   fontSize: 22,
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold),
//             ),
//           ])),
//           centerTitle: true,
//           automaticallyImplyLeading: false,
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               // Text(index.toString()),
//               SizedBox(
//                 height: screenHeight * 0.01,
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 child: Text(
//                   "Orders",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//               ),
//               SizedBox(
//                 height: screenHeight * 0.01,
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 child: SizedBox(
//                   height: 450,
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: 1,
//                     itemBuilder: (context, index) {
//                       final order = orderHistoryProvider.orders[orderIndex];

//                       logger.log("Order Index: $orderIndex");
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: order["items"].map<Widget>((item) {
//                               logger.log(
//                                   "${Constants.imageStorageBaseUrl}/${item.imagePath}");
//                               return Padding(
//                                 padding: EdgeInsets.symmetric(vertical: 10),
//                                 child: Row(
//                                   children: [
//                                     Padding(
//                                       padding:
//                                           EdgeInsets.symmetric(vertical: 5),
//                                       child: Container(
//                                         height: 90,
//                                         width: 70,
//                                         decoration: BoxDecoration(
//                                             color: Colors.grey[100],
//                                             borderRadius:
//                                                 BorderRadius.circular(8)),
//                                         child: ClipRRect(
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                           child: Image.network(
//                                             "${Constants.imageStorageBaseUrl}/${item.imagePath}",
//                                             fit: BoxFit.cover,
//                                             errorBuilder:
//                                                 (context, error, stackTrace) =>
//                                                     Icon(Icons.broken_image),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(width: 10),
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         SizedBox(
//                                           width: 220,
//                                           child: Text(
//                                             maxLines: 1,
//                                             overflow: TextOverflow.ellipsis,
//                                             "${item.productName}",
//                                             style: TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ),
//                                         Text(
//                                           "${item.category} | Qty: ${item.quantity}",
//                                           style: TextStyle(
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w600,
//                                               color:
//                                                   CommonColor.mediumGreyColor),
//                                         ),
//                                         RichText(
//                                             text: TextSpan(children: [
//                                           TextSpan(
//                                             text: "Rs.",
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 color:
//                                                     CommonColor.primaryColor),
//                                           ),
//                                           TextSpan(
//                                             text:
//                                                 "${item.price * item.quantity}",
//                                             style: TextStyle(
//                                                 fontSize: 21,
//                                                 fontWeight: FontWeight.bold,
//                                                 color:
//                                                     CommonColor.primaryColor),
//                                           ),
//                                         ])),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             }).toList(),
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 child: Divider(),
//               ),
//               // Spacer(),
//               Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20),
//                   child: Text(
//                     "Invoice Details:",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   )),
//               SizedBox(
//                 height: screenHeight * 0.02,
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   spacing: 15,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Total Amount:",
//                           style: TextStyle(
//                             color: Colors.grey,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 16,
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             Text(
//                               "Rs.",
//                               style: TextStyle(
//                                 color: CommonColor.primaryColor,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 12,
//                               ),
//                             ),
//                             Text(
//                               "${orderHistoryProvider.orders[orderIndex]["items"]?.fold(0.0, (sum, item) => sum + (item.price * item.quantity)) ?? 0.0}",
//                               style: TextStyle(
//                                 color: CommonColor.primaryColor,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Total Quantity:",
//                           style: TextStyle(
//                             color: Colors.grey,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 16,
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             Text(
//                               "(${orderHistoryProvider.orders[orderIndex]["items"]?.fold(0, (sum, item) => sum + item.quantity) ?? 0})",
//                               style: TextStyle(
//                                 color: CommonColor.primaryColor,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }


import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/constants.dart';
import 'package:order_management_system/features/dashboard/data/product_api_sevice.dart';
import 'package:order_management_system/features/invoice/domain/invoice_screen_provider.dart';
import 'package:order_management_system/features/order%20history/domain/order_history_provider.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as logger;

class InvoiceDetailScreen extends StatefulWidget {
  final String orderKey;
  const InvoiceDetailScreen({super.key, required this.orderKey});

  @override
  State<InvoiceDetailScreen> createState() => _InvoiceDetailScreenState();
}

class _InvoiceDetailScreenState extends State<InvoiceDetailScreen> {
  

  @override
  void initState() {
    
     Future.delayed(Duration.zero, () {
      if (!mounted) return;
     final invoiceScreenProvider = Provider.of<InvoiceScreenProvider>(context,listen: false);
    invoiceScreenProvider.fetchOrderByorderKey(widget.orderKey);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Consumer<InvoiceScreenProvider>(
        builder: (context, invoiceScreenProvider, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Provider.of<InvoiceScreenProvider>(context, listen: false)
                    .switchInvoiceDetailPage();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: CommonColor.primaryColor,
                size: 20,
              )),
          title: RichText(
              text: TextSpan(children: [
            TextSpan(
              text: "InvoiceDetails",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ])),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Consumer<InvoiceScreenProvider>(builder: (context, invoiceScreenProvider, child){
          return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Text(index.toString()),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Orders",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 450,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                    if (invoiceScreenProvider.isFetchOrderByLoading) {
      return Center(child: CircularProgressIndicator()); // Show loader while fetching
    }

    if (invoiceScreenProvider.invoiceDetail.products.isEmpty) {
      return Center(child: Text("No products available")); // Handle empty state
    }

    final order = invoiceScreenProvider.invoiceDetail;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: order.products.map<Widget>((item) {

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
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            item.imagePath,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Icon(Icons.broken_image),
                                          ),
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
                                            item.name,
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
                                              color:
                                                  CommonColor.mediumGreyColor),
                                        ),
                                        RichText(
                                            text: TextSpan(children: [
                                          TextSpan(
                                            text: "Rs.",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    CommonColor.primaryColor),
                                          ),
                                          TextSpan(
                                            text:
                                                "${item.price * item.quantity}",
                                            style: TextStyle(
                                                fontSize: 21,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    CommonColor.primaryColor),
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
              // Spacer(),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Invoice Details:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                              invoiceScreenProvider.invoiceDetail.totalAmount,
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
                            invoiceScreenProvider.invoiceDetail.totalQuantity.toString(),
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
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        );
        })
      );
    });
  }
}
