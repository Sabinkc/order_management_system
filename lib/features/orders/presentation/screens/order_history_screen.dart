//Without pagination

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:intl/intl.dart';
// import 'package:keyboard_dismisser/keyboard_dismisser.dart';
// import 'package:order_management_system/common/common_color.dart';
// import 'package:order_management_system/common/simple_ui_provider.dart';
// import 'package:order_management_system/features/orders/domain/order_screen_provider.dart';
// import 'package:order_management_system/features/orders/presentation/screens/search_order_screen.dart';
// import 'package:provider/provider.dart';

// // import 'dart:developer' as logger;
// class OrderHistoryScreen extends StatefulWidget {
//   const OrderHistoryScreen({super.key});

//   @override
//   State<OrderHistoryScreen> createState() => _InvoiceHistoryScreenState();
// }

// class _InvoiceHistoryScreenState extends State<OrderHistoryScreen> {
//   final ScrollController scrollController = ScrollController();
//   // final TextEditingController searchController = TextEditingController();

//   @override
//   void initState() {
//     // scrollController.addListener(onScroll);
//     Future.delayed(Duration.zero, () async {
//       if (!mounted) return;
//       final orderProvider =
//           Provider.of<OrderScreenProvider>(context, listen: false);
//       final simpleUiProvider =
//           Provider.of<SimpleUiProvider>(context, listen: false);
//       orderProvider.clearFilters();
//       orderProvider.clearSearchKeyword();
//       simpleUiProvider.clearDateRange();
//       simpleUiProvider.clearFilter();
//       orderProvider.resetAllOrders();
//       await orderProvider.getOrderByStatusAndDate(
//           simpleUiProvider.selectedStatus,
//           simpleUiProvider.selectedStartDate,
//           simpleUiProvider.selectedEndDate);
//     });

//     super.initState();
//   }

//   @override
//   void dispose() {
//     scrollController.dispose();
//     // searchController.dispose();
//     super.dispose();
//   }

//   // void onScroll() {
//   //   if (scrollController.position.pixels ==
//   //       scrollController.position.maxScrollExtent) {
//   //     Provider.of<OrderScreenProvider>(context, listen: false).getAllOrder();
//   //   }
//   // }

//   // void onScroll() {
//   //   final orderProvider =
//   //       Provider.of<OrderScreenProvider>(context, listen: false);
//   //   final simpleUiProvider =
//   //       Provider.of<SimpleUiProvider>(context, listen: false);
//   //   if (scrollController.position.pixels ==
//   //           scrollController.position.maxScrollExtent &&
//   //       orderProvider.orderBySandDHasMore &&
//   //       !orderProvider.isOrderBySandDLoading) {
//   //     orderProvider.getOrderByStatusAndDate(simpleUiProvider.selectedStatus,
//   //         simpleUiProvider.selectedStartDate, simpleUiProvider.selectedEndDate);
//   //   }
//   // }

//   int pageSize = 20;

//   @override
//   Widget build(BuildContext context) {
//     // final Logger logger = Logger();

//     return Consumer<OrderScreenProvider>(
//       builder: (context, orderScreenProvider, child) {
//         return KeyboardDismisser(
//           child: Scaffold(
//             backgroundColor: CommonColor.scaffoldbackgroundColor,
//             appBar: AppBar(
//               backgroundColor: CommonColor.primaryColor,
//               title: RichText(
//                 text: const TextSpan(
//                   children: [
//                     TextSpan(
//                       text: "My Orders",
//                       style: TextStyle(
//                         fontSize: 22,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               leading: IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: Icon(
//                     Icons.arrow_back_ios,
//                     color: Colors.white,
//                     size: 20,
//                   )),
//               centerTitle: true,
//               automaticallyImplyLeading: false,
//             ),
//             body: RefreshIndicator(
//               backgroundColor: Colors.white,
//               elevation: 0,
//               edgeOffset: 2,
//               color: CommonColor.primaryColor,
//               onRefresh: () async {
//                 final orderProvider =
//                     Provider.of<OrderScreenProvider>(context, listen: false);
//                 final simpleUiProvider =
//                     Provider.of<SimpleUiProvider>(context, listen: false);

//                 orderProvider.clearFilters();
//                 orderProvider.clearSearchKeyword();
//                 simpleUiProvider.clearDateRange();
//                 simpleUiProvider.clearFilter();
//                 orderProvider.resetAllOrders();
//                 await orderProvider.getOrderByStatusAndDate(
//                     simpleUiProvider.selectedStatus,
//                     simpleUiProvider.selectedStartDate,
//                     simpleUiProvider.selectedEndDate);
//               },
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Consumer<OrderScreenProvider>(
//                   builder: (context, orderProvider, child) {
//                     if (orderProvider.isOrderBySandDLoading &&
//                         orderProvider.ordersBySandD.isEmpty) {
//                       return Center(
//                           child: CircularProgressIndicator(
//                         color: CommonColor.primaryColor,
//                       ));
//                     }
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(top: 10, bottom: 10),
//                           child: InkWell(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           SearchOrderScreen()));
//                             },
//                             child: Container(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: 7,
//                               ),
//                               height: 45,
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8),
//                                 color: Colors.white,
//                               ),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Icon(
//                                         Icons.search,
//                                         size: 25,
//                                         color: CommonColor.primaryColor,
//                                       ),
//                                       SizedBox(
//                                         width: 15,
//                                       ),
//                                       Text(
//                                         "Search order no....",
//                                         style: TextStyle(
//                                             color: CommonColor.darkGreyColor,
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 16),
//                                       )
//                                     ],
//                                   ),
//                                   Theme(
//                                     data: ThemeData(
//                                         popupMenuTheme: PopupMenuThemeData(
//                                       color: Colors.white,
//                                     )),
//                                     child: PopupMenuButton(
//                                       child: Padding(
//                                         padding:
//                                             const EdgeInsets.only(right: 5.0),
//                                         child: SvgPicture.asset(
//                                           "assets/icons/filter.svg",
//                                           fit: BoxFit.contain,
//                                         ),
//                                       ),
//                                       itemBuilder: (context) {
//                                         return [
//                                           PopupMenuItem(
//                                             padding: const EdgeInsets.only(
//                                               left: 15,
//                                               right: 15,
//                                               top: 0,
//                                               bottom: 0,
//                                             ),
//                                             onTap: () {
//                                               showFilterDialog(context);
//                                             },
//                                             child: const Center(
//                                                 child: Text("Search filters")),
//                                           ),
//                                         ];
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),

//                         InkWell(
//                             onTap: () async {
//                               final orderProvider =
//                                   Provider.of<OrderScreenProvider>(context,
//                                       listen: false);
//                               final simpleUiProvider =
//                                   Provider.of<SimpleUiProvider>(context,
//                                       listen: false);
//                               orderProvider.clearFilters();
//                               orderProvider.clearSearchKeyword();
//                               simpleUiProvider.clearDateRange();
//                               simpleUiProvider.clearFilter();
//                               orderProvider.resetAllOrders();
//                               await orderProvider.getOrderByStatusAndDate(
//                                   simpleUiProvider.selectedStatus,
//                                   simpleUiProvider.selectedStartDate,
//                                   simpleUiProvider.selectedEndDate);
//                             },
//                             child: Padding(
//                               padding: EdgeInsets.only(right: 8),
//                               child: Text(
//                                 "Reset filter",
//                                 style: TextStyle(
//                                     color: CommonColor.primaryColor,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             )),
//                         Divider(
//                           color: CommonColor.commonGreyColor,
//                           thickness: 2,
//                         ),
//                         Expanded(
//                           child: Consumer<OrderScreenProvider>(
//                             builder: (context, searchProvider, child) {
//                               if (orderProvider.ordersBySandD.isEmpty) {
//                                 return Center(
//                                   child: Text(
//                                     "No orders found!",
//                                     style: TextStyle(
//                                       color: CommonColor.darkGreyColor,
//                                       fontSize: 20,
//                                     ),
//                                   ),
//                                 );
//                               }
//                               //filtered list displayed in listview
//                               return ListView.builder(
//                                 controller: scrollController,
//                                 physics: AlwaysScrollableScrollPhysics(),
//                                 itemCount: orderProvider.ordersBySandD.length,
//                                 // itemCount: orderProvider.ordersBySandD.length +
//                                 //     (orderProvider.orderBySandDHasMore &&
//                                 //             orderProvider
//                                 //                     .ordersBySandD.length >=
//                                 //                 pageSize
//                                 //         ? 1
//                                 //         : 0),
//                                 itemBuilder: (context, index) {
//                                   // if (index < orderProvider.orderKey.length) {
//                                   final order =
//                                       orderProvider.ordersBySandD[index];

//                                   return Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 10),
//                                     child: GestureDetector(
//                                       onTap: () {
//                                         Provider.of<OrderScreenProvider>(
//                                                 context,
//                                                 listen: false)
//                                             .switchInvoiceDetailPage();
//                                         Provider.of<OrderScreenProvider>(
//                                                 context,
//                                                 listen: false)
//                                             .selectInvoiceKey(order.orderNo);
//                                       },
//                                       child: Container(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 15, vertical: 15),
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                         ),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           spacing: 3,
//                                           children: [
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Text(
//                                                   "Order No: ${order.orderNo}",
//                                                   style: TextStyle(
//                                                       fontSize: 15,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       color: CommonColor
//                                                           .darkGreyColor),
//                                                 ),
//                                                 Text(
//                                                   "Rs.${order.totalAmount}",
//                                                   style: TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       fontSize: 15,
//                                                       color: CommonColor
//                                                           .primaryColor),
//                                                 ),
//                                               ],
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Text(
//                                                   order.date,
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 11,
//                                                     color: CommonColor
//                                                         .mediumGreyColor,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   "Qty: ${order.totalQuantity}",
//                                                   style: TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       fontSize: 11,
//                                                       color: CommonColor
//                                                           .mediumGreyColor),
//                                                 ),
//                                               ],
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Text(
//                                                   "Status: ",
//                                                   style: TextStyle(
//                                                       color: CommonColor
//                                                           .darkGreyColor,
//                                                       fontWeight:
//                                                           FontWeight.bold),
//                                                 ),
//                                                 Text(
//                                                   order.status,
//                                                   style: TextStyle(
//                                                       color: CommonColor
//                                                           .primaryColor,
//                                                       fontWeight:
//                                                           FontWeight.w600),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                   // } else {
//                                   //   // Footer item (either loading indicator or "no more orders" message)
//                                   //   return Padding(
//                                   //     padding: const EdgeInsets.symmetric(
//                                   //         vertical: 20),
//                                   //     child: Center(
//                                   //       child: orderProvider
//                                   //                   .orderBySandDHasMore &&
//                                   //               orderProvider
//                                   //                       .ordersBySandD.length >=
//                                   //                   pageSize
//                                   //           ? CircularProgressIndicator(
//                                   //               color: CommonColor.primaryColor,
//                                   //             )
//                                   //           : orderProvider
//                                   //                   .ordersBySandD.isEmpty
//                                   //               ? Text(
//                                   //                   "No more orders to fetch")
//                                   //               : SizedBox.shrink(),
//                                   //     ),
//                                   //   );
//                                   // }
//                                 },
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   //logical part
//   void showFilterDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return Consumer<SimpleUiProvider>(
//           builder: (context, simpleUiProvider, child) {
//             return AlertDialog(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               contentPadding: const EdgeInsets.all(20),
//               backgroundColor: Colors.white,
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Search filter by:",
//                     style: TextStyle(
//                       color: CommonColor.darkGreyColor,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Row(
//                     children: [
//                       Text("Date:",
//                           style: TextStyle(color: CommonColor.darkGreyColor)),
//                       TextButton(
//                         onPressed: () async {
//                           DateTime? picked = await showDatePicker(
//                             context: context,
//                             initialDate: DateTime.now(),
//                             firstDate: DateTime(2000),
//                             lastDate: DateTime.now(),
//                           );
//                           if (picked != null) {
//                             String formattedDate =
//                                 DateFormat('yyyy-MM-dd').format(picked);
//                             simpleUiProvider
//                                 .setSelectedStartDate(formattedDate);
//                           }
//                         },
//                         child: Text(
//                           simpleUiProvider.selectedStartDate != ""
//                               ? simpleUiProvider.selectedStartDate.split(' ')[0]
//                               : "Start Date",
//                           style: TextStyle(
//                             color: simpleUiProvider.selectedStartDate != ""
//                                 ? Colors.black
//                                 : Colors.grey,
//                           ),
//                         ),
//                       ),
//                       Text("to",
//                           style: TextStyle(color: CommonColor.darkGreyColor)),
//                       TextButton(
//                         onPressed: () async {
//                           DateTime? picked = await showDatePicker(
//                             context: context,
//                             initialDate: DateTime.now(),
//                             firstDate: DateTime(2000),
//                             lastDate: DateTime.now(),
//                           );
//                           if (picked != null) {
//                             String formattedDate =
//                                 DateFormat('yyyy-MM-dd').format(picked);
//                             simpleUiProvider.setSelectedEndDate(formattedDate);
//                           }
//                         },
//                         child: Text(
//                           simpleUiProvider.selectedEndDate != ""
//                               ? simpleUiProvider.selectedEndDate.split(' ')[0]
//                               : "End Date",
//                           style: TextStyle(
//                             color: simpleUiProvider.selectedEndDate != ""
//                                 ? Colors.black
//                                 : Colors.grey,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       simpleUiProvider.clearDateRange();
//                     },
//                     child: Text(
//                       "Clear date range",
//                       style: TextStyle(
//                           // decoration: TextDecoration.underline,
//                           color: CommonColor.darkGreyColor,
//                           fontWeight: FontWeight.w600),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Divider(),
//                   Row(
//                     children: [
//                       Text("Status:",
//                           style: TextStyle(color: CommonColor.darkGreyColor)),
//                       const SizedBox(width: 10),
//                       DropdownButton(
//                         value: simpleUiProvider.selectedStatus,
//                         items: [
//                           DropdownMenuItem(value: "", child: Text("All")),
//                           DropdownMenuItem(
//                               value: "pending", child: Text("Pending")),
//                           DropdownMenuItem(
//                               value: "confirmed", child: Text("Confirmed")),
//                           DropdownMenuItem(
//                               value: "shipped", child: Text("Shipped")),
//                           DropdownMenuItem(
//                               value: "delivered", child: Text("Delivered")),
//                         ],
//                         onChanged: (value) {
//                           simpleUiProvider.switchSelectedStatus(value!);
//                         },
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                           onPressed: () => Navigator.pop(context),
//                           child: const Text("Cancel")),
//                       TextButton(
//                         onPressed: () {
//                           // Apply both filters
//                           Provider.of<OrderScreenProvider>(context,
//                                   listen: false)
//                               .setFilter(
//                             simpleUiProvider.selectedStatus,
//                             startDate: simpleUiProvider.selectedStartDate,
//                             endDate: simpleUiProvider.selectedEndDate,
//                           );

//                           final orderProvider =
//                               Provider.of<OrderScreenProvider>(context,
//                                   listen: false);
//                           orderProvider.resetAllOrders();

//                           orderProvider.getOrderByStatusAndDate(
//                               simpleUiProvider.selectedStatus,
//                               simpleUiProvider.selectedStartDate.toString(),
//                               simpleUiProvider.selectedEndDate.toString());

//                           Navigator.pop(context);
//                         },
//                         child: const Text("Apply"),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }

//With Pagination
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/simple_ui_provider.dart';
import 'package:order_management_system/features/orders/domain/order_screen_provider.dart';
import 'package:order_management_system/features/orders/presentation/screens/search_order_screen.dart';
import 'package:provider/provider.dart';

// import 'dart:developer' as logger;
class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _InvoiceHistoryScreenState();
}

class _InvoiceHistoryScreenState extends State<OrderHistoryScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(onScroll);
    Future.delayed(Duration.zero, () async {
      if (!mounted) return;
      final orderProvider =
          Provider.of<OrderScreenProvider>(context, listen: false);
      final simpleUiProvider =
          Provider.of<SimpleUiProvider>(context, listen: false);
      orderProvider.clearFilters();
      orderProvider.clearSearchKeyword();
      simpleUiProvider.clearDateRange();
      simpleUiProvider.clearFilter();
      orderProvider.resetAllOrders();
      await orderProvider.getOrderByStatusAndDate(
          simpleUiProvider.selectedStatus,
          simpleUiProvider.selectedStartDate,
          simpleUiProvider.selectedEndDate);
    });

    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      final simpleUiProvider =
          Provider.of<SimpleUiProvider>(context, listen: false);

      Provider.of<OrderScreenProvider>(context, listen: false)
          .getOrderByStatusAndDate(
              simpleUiProvider.selectedStatus,
              simpleUiProvider.selectedStartDate,
              simpleUiProvider.selectedEndDate);
    }
  }

  int pageSize = 20;

  @override
  Widget build(BuildContext context) {
    // final Logger logger = Logger();

    return Consumer<OrderScreenProvider>(
      builder: (context, orderScreenProvider, child) {
        return KeyboardDismisser(
          child: Scaffold(
            backgroundColor: CommonColor.scaffoldbackgroundColor,
            appBar: AppBar(
              backgroundColor: CommonColor.primaryColor,
              title: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "My Orders",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 20,
                  )),
              centerTitle: true,
              automaticallyImplyLeading: false,
            ),
            body: RefreshIndicator(
              backgroundColor: Colors.white,
              elevation: 0,
              edgeOffset: 2,
              color: CommonColor.primaryColor,
              onRefresh: () async {
                final orderProvider =
                    Provider.of<OrderScreenProvider>(context, listen: false);
                final simpleUiProvider =
                    Provider.of<SimpleUiProvider>(context, listen: false);

                orderProvider.clearFilters();
                orderProvider.clearSearchKeyword();
                simpleUiProvider.clearDateRange();
                simpleUiProvider.clearFilter();
                orderProvider.resetAllOrders();
                await orderProvider.getOrderByStatusAndDate(
                    simpleUiProvider.selectedStatus,
                    simpleUiProvider.selectedStartDate,
                    simpleUiProvider.selectedEndDate);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Consumer<OrderScreenProvider>(
                  builder: (context, orderProvider, child) {
                    if (orderProvider.isOrderBySandDLoading &&
                        orderProvider.ordersBySandD.isEmpty) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: CommonColor.primaryColor,
                      ));
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SearchOrderScreen()));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 7,
                              ),
                              height: 45,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.search,
                                        size: 25,
                                        color: CommonColor.primaryColor,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        "Search order no....",
                                        style: TextStyle(
                                            color: CommonColor.darkGreyColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                  Theme(
                                    data: ThemeData(
                                        popupMenuTheme: PopupMenuThemeData(
                                      color: Colors.white,
                                    )),
                                    child: PopupMenuButton(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5.0),
                                        child: SvgPicture.asset(
                                          "assets/icons/filter.svg",
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      itemBuilder: (context) {
                                        return [
                                          PopupMenuItem(
                                            padding: const EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 0,
                                              bottom: 0,
                                            ),
                                            onTap: () {
                                              showFilterDialog(context);
                                            },
                                            child: const Center(
                                                child: Text("Search filters")),
                                          ),
                                        ];
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                            onTap: () async {
                              final orderProvider =
                                  Provider.of<OrderScreenProvider>(context,
                                      listen: false);
                              final simpleUiProvider =
                                  Provider.of<SimpleUiProvider>(context,
                                      listen: false);
                              orderProvider.clearFilters();
                              orderProvider.clearSearchKeyword();
                              simpleUiProvider.clearDateRange();
                              simpleUiProvider.clearFilter();
                              orderProvider.resetAllOrders();
                              await orderProvider.getOrderByStatusAndDate(
                                  simpleUiProvider.selectedStatus,
                                  simpleUiProvider.selectedStartDate,
                                  simpleUiProvider.selectedEndDate);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Text(
                                "Reset filter",
                                style: TextStyle(
                                    color: CommonColor.primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                        Divider(
                          color: CommonColor.commonGreyColor,
                          thickness: 2,
                        ),
                        Expanded(
                          child: Consumer<OrderScreenProvider>(
                            builder: (context, searchProvider, child) {
                              if (orderProvider.ordersBySandD.isEmpty) {
                                return Center(
                                  child: Text(
                                    "No orders found!",
                                    style: TextStyle(
                                      color: CommonColor.darkGreyColor,
                                      fontSize: 20,
                                    ),
                                  ),
                                );
                              }
                              //filtered list displayed in listview
                              return ListView.builder(
                                controller: scrollController,
                                physics: AlwaysScrollableScrollPhysics(),
                                itemCount:
                                    orderProvider.ordersBySandD.length + 1,
                                itemBuilder: (context, index) {
                                  if (index <
                                      orderProvider.ordersBySandD.length) {
                                    final order =
                                        orderProvider.ordersBySandD[index];

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          Provider.of<OrderScreenProvider>(
                                                  context,
                                                  listen: false)
                                              .switchInvoiceDetailPage();
                                          Provider.of<OrderScreenProvider>(
                                                  context,
                                                  listen: false)
                                              .selectInvoiceKey(order.orderNo);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 15),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            spacing: 3,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Order No: ${order.orderNo}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: CommonColor
                                                            .darkGreyColor),
                                                  ),
                                                  Text(
                                                    "Rs.${order.totalAmount}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                        color: CommonColor
                                                            .primaryColor),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    order.date,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 11,
                                                      color: CommonColor
                                                          .mediumGreyColor,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Qty: ${order.totalQuantity}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 11,
                                                        color: CommonColor
                                                            .mediumGreyColor),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Status: ",
                                                    style: TextStyle(
                                                        color: CommonColor
                                                            .darkGreyColor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    order.status,
                                                    style: TextStyle(
                                                        color: CommonColor
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    // Footer item (either loading indicator or "no more orders" message)
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Center(
                                        child: orderProvider
                                                    .orderBySandDHasMore &&
                                                orderProvider
                                                        .ordersBySandD.length >=
                                                    pageSize
                                            ? CircularProgressIndicator(
                                                color: CommonColor.primaryColor,
                                              )
                                            : Text(
                                                "No more orders to fetch",
                                                style: TextStyle(
                                                    color: CommonColor
                                                        .darkGreyColor,
                                                    fontSize: 16),
                                              ),
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  //logical part
  void showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Consumer<SimpleUiProvider>(
          builder: (context, simpleUiProvider, child) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.all(20),
              backgroundColor: Colors.white,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Search filter by:",
                    style: TextStyle(
                      color: CommonColor.darkGreyColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text("Date:",
                          style: TextStyle(color: CommonColor.darkGreyColor)),
                      TextButton(
                        onPressed: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(picked);
                            simpleUiProvider
                                .setSelectedStartDate(formattedDate);
                          }
                        },
                        child: Text(
                          simpleUiProvider.selectedStartDate != ""
                              ? simpleUiProvider.selectedStartDate.split(' ')[0]
                              : "Start Date",
                          style: TextStyle(
                            color: simpleUiProvider.selectedStartDate != ""
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                      ),
                      Text("to",
                          style: TextStyle(color: CommonColor.darkGreyColor)),
                      TextButton(
                        onPressed: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(picked);
                            simpleUiProvider.setSelectedEndDate(formattedDate);
                          }
                        },
                        child: Text(
                          simpleUiProvider.selectedEndDate != ""
                              ? simpleUiProvider.selectedEndDate.split(' ')[0]
                              : "End Date",
                          style: TextStyle(
                            color: simpleUiProvider.selectedEndDate != ""
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      simpleUiProvider.clearDateRange();
                    },
                    child: Text(
                      "Clear date range",
                      style: TextStyle(
                          // decoration: TextDecoration.underline,
                          color: CommonColor.darkGreyColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(),
                  Row(
                    children: [
                      Text("Status:",
                          style: TextStyle(color: CommonColor.darkGreyColor)),
                      const SizedBox(width: 10),
                      DropdownButton(
                        value: simpleUiProvider.selectedStatus,
                        items: [
                          DropdownMenuItem(value: "", child: Text("All")),
                          DropdownMenuItem(
                              value: "pending", child: Text("Pending")),
                          DropdownMenuItem(
                              value: "confirmed", child: Text("Confirmed")),
                          DropdownMenuItem(
                              value: "shipped", child: Text("Shipped")),
                          DropdownMenuItem(
                              value: "delivered", child: Text("Delivered")),
                        ],
                        onChanged: (value) {
                          simpleUiProvider.switchSelectedStatus(value!);
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel")),
                      TextButton(
                        onPressed: () {
                          // Apply both filters
                          Provider.of<OrderScreenProvider>(context,
                                  listen: false)
                              .setFilter(
                            simpleUiProvider.selectedStatus,
                            startDate: simpleUiProvider.selectedStartDate,
                            endDate: simpleUiProvider.selectedEndDate,
                          );

                          final orderProvider =
                              Provider.of<OrderScreenProvider>(context,
                                  listen: false);
                          orderProvider.resetAllOrders();

                          orderProvider.getOrderByStatusAndDate(
                              simpleUiProvider.selectedStatus,
                              simpleUiProvider.selectedStartDate.toString(),
                              simpleUiProvider.selectedEndDate.toString());

                          Navigator.pop(context);
                        },
                        child: const Text("Apply"),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
