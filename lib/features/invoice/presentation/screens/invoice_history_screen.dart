// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:intl/intl.dart';
// import 'package:keyboard_dismisser/keyboard_dismisser.dart';
// import 'package:order_management_system/common/common_color.dart';
// import 'package:order_management_system/common/simple_ui_provider.dart';
// import 'package:order_management_system/features/invoice/domain/invoice_screen_provider.dart';
// import 'package:order_management_system/features/order%20history/domain/order_history_provider.dart';
// import 'package:provider/provider.dart';

// class InvoiceHistoryScreen extends StatelessWidget {
//   const InvoiceHistoryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController searchController = SearchController();
//     final Random random = Random();

//     // Function to generate random numbers between 000000 and 100000
//     List<String> generateRandomNumbers(int count) {
//       return List.generate(count, (index) {
//         int number =
//             random.nextInt(100001); // Generates a number between 0 and 100000
//         return number.toString().padLeft(
//             6, '0'); // Pads the number with leading zeros to ensure 6 digits
//       });
//     }

//     // final Logger logger = Logger();
//     String filterValue = "All";
//     // final screenHeight = MediaQuery.of(context).size.height;
//     // final screenWidth = MediaQuery.of(context).size.width;
//     return Consumer<InvoiceScreenProvider>(
//         builder: (context, invoiceScreenProvider, child) {
//       return KeyboardDismisser(
//         child: Scaffold(
//             backgroundColor: Colors.white,
//             appBar: AppBar(
//               backgroundColor: Colors.white,
//               title: RichText(
//                 text: TextSpan(
//                   children: [
//                     TextSpan(
//                       text: "My Invoices",
//                       style: TextStyle(
//                         fontSize: 22,
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               centerTitle: true,
//               automaticallyImplyLeading: false,
//             ),
//             body: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Consumer<OrderHistoryProvider>(
//                 builder: (context, provider, child) {
//                   if (provider.orders.isEmpty) {
//                     return Center(
//                       child: Text(
//                         "No invoices till now!",
//                         style: TextStyle(
//                             color: CommonColor.darkGreyColor, fontSize: 20),
//                       ),
//                     );
//                   }

//                   return Column(
//                     children: [
//                       Padding(
//                           padding: EdgeInsets.only(top: 10, bottom: 10),
//                           child: TextFormField(
//                             controller: searchController,
//                             onChanged: (value) {},
//                             decoration: InputDecoration(
//                               // contentPadding: EdgeInsets.symmetric(
//                               //     horizontal: 10, vertical: 15),
//                               contentPadding: EdgeInsets.symmetric(
//                                 horizontal: 10,
//                               ),
//                               fillColor: Colors.grey[100],
//                               filled: true,
//                               hintText: "Search.....",
//                               hintStyle: TextStyle(
//                                   color: CommonColor.darkGreyColor,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16),
//                               prefixIcon: Icon(
//                                 Icons.search,
//                                 size: 25,
//                                 color: CommonColor.primaryColor,
//                               ),

//                               suffixIcon: Theme(
//                                 data: ThemeData(
//                                     popupMenuTheme: PopupMenuThemeData(
//                                   color: Colors.white,
//                                 )),
//                                 child: PopupMenuButton(
//                                     child: Padding(
//                                       padding:
//                                           const EdgeInsets.only(right: 5.0),
//                                       child: SvgPicture.asset(
//                                         "assets/icons/filter.svg",
//                                         fit: BoxFit.contain,
//                                       ),
//                                     ),
//                                     itemBuilder: (context) {
//                                       return [
//                                         PopupMenuItem(
//                                             padding: EdgeInsets.only(
//                                               left: 15,
//                                               right: 15,
//                                               top: 0,
//                                               bottom: 0,
//                                             ),
//                                             onTap: () {
//                                               showDialog(
//                                                   context: context,
//                                                   builder: (context) {
//                                                     return Consumer<
//                                                             SimpleUiProvider>(
//                                                         builder: (context,
//                                                             simpleUiProvider,
//                                                             child) {
//                                                       return AlertDialog(
//                                                         shape:
//                                                             RoundedRectangleBorder(
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             8)),
//                                                         contentPadding:
//                                                             EdgeInsets.only(
//                                                           top: 20,
//                                                           bottom: 10,
//                                                           left: 20,
//                                                           right: 20,
//                                                         ),
//                                                         backgroundColor:
//                                                             Colors.white,
//                                                         content: Column(
//                                                           mainAxisSize:
//                                                               MainAxisSize.min,
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .center,
//                                                           children: [
//                                                             Text(
//                                                               "Search filter by date",
//                                                               style: TextStyle(
//                                                                   color: CommonColor
//                                                                       .darkGreyColor,
//                                                                   fontSize: 18,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w600),
//                                                             ),
//                                                             SizedBox(
//                                                               height: 5,
//                                                             ),
//                                                             Row(
//                                                               mainAxisAlignment:
//                                                                   MainAxisAlignment
//                                                                       .center,
//                                                               spacing: 10,
//                                                               children: [
//                                                                 Text(
//                                                                   "Date:",
//                                                                   style: TextStyle(
//                                                                       color: CommonColor
//                                                                           .darkGreyColor,
//                                                                       fontSize:
//                                                                           16,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w600),
//                                                                 ),
//                                                                 DropdownButton(
//                                                                     value: simpleUiProvider
//                                                                         .selectedDate,
//                                                                     items: [
//                                                                       DropdownMenuItem(
//                                                                           value:
//                                                                               "all",
//                                                                           child:
//                                                                               Text("All")),
//                                                                       DropdownMenuItem(
//                                                                           value:
//                                                                               "last_second",
//                                                                           child:
//                                                                               Text("Last 15 seconds")),
//                                                                       DropdownMenuItem(
//                                                                           value:
//                                                                               "last_minute",
//                                                                           child:
//                                                                               Text("Last minute")),
//                                                                       DropdownMenuItem(
//                                                                           value:
//                                                                               "last_week",
//                                                                           child:
//                                                                               Text("Last week")),
//                                                                       DropdownMenuItem(
//                                                                           value:
//                                                                               "last_month",
//                                                                           child:
//                                                                               Text("Last month")),
//                                                                       DropdownMenuItem(
//                                                                           value:
//                                                                               "last_year",
//                                                                           child:
//                                                                               Text("Last year")),
//                                                                     ],
//                                                                     onChanged:
//                                                                         (value) {
//                                                                       simpleUiProvider
//                                                                           .switchSelectedDate(
//                                                                               value!);
//                                                                       filterValue =
//                                                                           value;
//                                                                       debugPrint(
//                                                                           value);
//                                                                       debugPrint(
//                                                                           simpleUiProvider
//                                                                               .selectedDate);
//                                                                     })
//                                                               ],
//                                                             ),
//                                                             Row(
//                                                               spacing: 15,
//                                                               mainAxisAlignment:
//                                                                   MainAxisAlignment
//                                                                       .end,
//                                                               children: [
//                                                                 TextButton(
//                                                                     onPressed:
//                                                                         () {
//                                                                       Navigator.pop(
//                                                                           context);
//                                                                     },
//                                                                     child: Text(
//                                                                         "Cancel")),
//                                                                 TextButton(
//                                                                     onPressed:
//                                                                         () {
//                                                                       Provider.of<OrderHistoryProvider>(
//                                                                               context,
//                                                                               listen:
//                                                                                   false)
//                                                                           .setFilter(
//                                                                               filterValue);

//                                                                       Navigator.pop(
//                                                                           context);
//                                                                     },
//                                                                     child: Text(
//                                                                         "Apply")),
//                                                               ],
//                                                             )
//                                                           ],
//                                                         ),
//                                                       );
//                                                     });
//                                                   });
//                                             },
//                                             child: Center(
//                                                 child: Text("Search filters"))),
//                                       ];
//                                     }),
//                               ),
//                               suffixIconConstraints: BoxConstraints(
//                                   maxHeight: 30,
//                                   maxWidth: 30,
//                                   minHeight: 30,
//                                   minWidth: 30),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                                 borderSide: BorderSide(
//                                     color: Colors
//                                         .grey[100]!), // Transparent border
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                                 borderSide: BorderSide(
//                                     color: CommonColor.primaryColor,
//                                     width: 2), // Focused border color
//                               ),
//                               errorBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                                 borderSide: BorderSide(
//                                     color: Colors.red,
//                                     width: 2), // Error border color
//                               ),
//                               focusedErrorBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                                 borderSide: BorderSide(
//                                     color: Colors.red,
//                                     width: 2), // Focused error border color
//                               ),
//                               disabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                                 borderSide: BorderSide(
//                                     color: Colors
//                                         .grey[100]!), // Disabled border color
//                               ),
//                             ),
//                           )),
//                       Divider(),
//                       Expanded(
//                         child: provider.filteredOrders.isEmpty
//                             ? Center(
//                                 child: Text(
//                                     "No invoices found in the selected filter date!"),
//                               )
//                             : ListView.builder(
//                                 itemCount: provider.filteredOrders.length,
//                                 itemBuilder: (context, filteredOrderIndex) {
//                                   // Sort orders in descending order (latest first)
//                                   final sortedOrders =
//                                       List.from(provider.filteredOrders)
//                                         ..sort((a, b) => (b["date"] as DateTime)
//                                             .compareTo(a["date"] as DateTime));
//                                   final order =
//                                       sortedOrders[filteredOrderIndex];
//                                   String orderNo = generateRandomNumbers(
//                                       provider.filteredOrders
//                                           .length)[filteredOrderIndex];
//                                   return Padding(
//                                     padding: EdgeInsets.symmetric(vertical: 10),
//                                     child: GestureDetector(
//                                       onTap: () {
//                                         Provider.of<InvoiceScreenProvider>(
//                                                 context,
//                                                 listen: false)
//                                             .switchInvoiceDetailPage();
//                                         Provider.of<InvoiceScreenProvider>(
//                                                 context,
//                                                 listen: false)
//                                             .selectInvoiceIndex(
//                                                 filteredOrderIndex);
//                                       },
//                                       child: Container(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 15, vertical: 15),
//                                         decoration: BoxDecoration(
//                                           color: Colors.grey[100],
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
//                                                   "Order No: $orderNo",
//                                                   style: TextStyle(
//                                                       fontSize: 15,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       color: CommonColor
//                                                           .darkGreyColor),
//                                                 ),
//                                                 Text(
//                                                   "Rs.${order["items"]?.fold(0.0, (sum, item) => sum + (item.price * item.quantity)) ?? 0.0}",
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
//                                                   DateFormat(
//                                                           'yyyy-MM-dd, hh:mm a')
//                                                       .format(order["date"]
//                                                           as DateTime),
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 11,
//                                                     color: CommonColor
//                                                         .mediumGreyColor,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   "Qty: ${order["items"]?.fold(0, (sum, item) => sum + item.quantity) ?? 0}",
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
//                                                   "Pending",
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
//                                 },
//                               ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             )),
//       );
//     });
//   }
// }

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/simple_ui_provider.dart';
import 'package:order_management_system/features/invoice/domain/invoice_screen_provider.dart';
import 'package:order_management_system/features/invoice/domain/search_provider.dart';
import 'package:order_management_system/features/order%20history/domain/order_history_provider.dart';
import 'package:provider/provider.dart';

class InvoiceHistoryScreen extends StatelessWidget {
  const InvoiceHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = SearchController();
    final Random random = Random();

    // Function to generate random numbers between 000000 and 100000
    List<String> generateRandomNumbers(int count) {
      return List.generate(count, (index) {
        int number =
            random.nextInt(100001); // Generates a number between 0 and 100000
        return number.toString().padLeft(
            6, '0'); // Pads the number with leading zeros to ensure 6 digits
      });
    }

    final OrderHistoryProvider orderHistoryProvider =
        Provider.of<OrderHistoryProvider>(context, listen: false);
    List orderNoList =
        generateRandomNumbers(orderHistoryProvider.filteredOrders.length);

    // final Logger logger = Logger();
    String filterValue = "All";
    // final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;
    return Consumer<InvoiceScreenProvider>(
        builder: (context, invoiceScreenProvider, child) {
      return KeyboardDismisser(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "My Invoices",
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
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Consumer<OrderHistoryProvider>(
                builder: (context, orderHistoryProvider, child) {
                  if (orderHistoryProvider.orders.isEmpty) {
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
                          child: TextFormField(
                            controller: searchController,
                            onChanged: (value) {
                              // Update the search keyword in the SearchProvider
                              Provider.of<SearchProvider>(context,
                                      listen: false)
                                  .updateSearchKeyword(value);
                            },
                            decoration: InputDecoration(
                              // contentPadding: EdgeInsets.symmetric(
                              //     horizontal: 10, vertical: 15),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              fillColor: Colors.grey[100],
                              filled: true,
                              hintText: "Search.....",
                              hintStyle: TextStyle(
                                  color: CommonColor.darkGreyColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                              prefixIcon: Icon(
                                Icons.search,
                                size: 25,
                                color: CommonColor.primaryColor,
                              ),

                              suffixIcon: Theme(
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
                                            padding: EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 0,
                                              bottom: 0,
                                            ),
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Consumer<
                                                            SimpleUiProvider>(
                                                        builder: (context,
                                                            simpleUiProvider,
                                                            child) {
                                                      return AlertDialog(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                          top: 20,
                                                          bottom: 10,
                                                          left: 20,
                                                          right: 20,
                                                        ),
                                                        backgroundColor:
                                                            Colors.white,
                                                        content: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "Search filter by date",
                                                              style: TextStyle(
                                                                  color: CommonColor
                                                                      .darkGreyColor,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              spacing: 10,
                                                              children: [
                                                                Text(
                                                                  "Date:",
                                                                  style: TextStyle(
                                                                      color: CommonColor
                                                                          .darkGreyColor,
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                                DropdownButton(
                                                                    value: simpleUiProvider
                                                                        .selectedDate,
                                                                    items: [
                                                                      DropdownMenuItem(
                                                                          value:
                                                                              "all",
                                                                          child:
                                                                              Text("All")),
                                                                      DropdownMenuItem(
                                                                          value:
                                                                              "last_second",
                                                                          child:
                                                                              Text("Last 15 seconds")),
                                                                      DropdownMenuItem(
                                                                          value:
                                                                              "last_minute",
                                                                          child:
                                                                              Text("Last minute")),
                                                                      DropdownMenuItem(
                                                                          value:
                                                                              "last_week",
                                                                          child:
                                                                              Text("Last week")),
                                                                      DropdownMenuItem(
                                                                          value:
                                                                              "last_month",
                                                                          child:
                                                                              Text("Last month")),
                                                                      DropdownMenuItem(
                                                                          value:
                                                                              "last_year",
                                                                          child:
                                                                              Text("Last year")),
                                                                    ],
                                                                    onChanged:
                                                                        (value) {
                                                                      simpleUiProvider
                                                                          .switchSelectedDate(
                                                                              value!);
                                                                      filterValue =
                                                                          value;
                                                                      debugPrint(
                                                                          value);
                                                                      debugPrint(
                                                                          simpleUiProvider
                                                                              .selectedDate);
                                                                    })
                                                              ],
                                                            ),
                                                            Row(
                                                              spacing: 15,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                        "Cancel")),
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Provider.of<OrderHistoryProvider>(
                                                                              context,
                                                                              listen:
                                                                                  false)
                                                                          .setFilter(
                                                                              filterValue);

                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                        "Apply")),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    });
                                                  });
                                            },
                                            child: Center(
                                                child: Text("Search filters"))),
                                      ];
                                    }),
                              ),
                              suffixIconConstraints: BoxConstraints(
                                  maxHeight: 30,
                                  maxWidth: 30,
                                  minHeight: 30,
                                  minWidth: 30),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Colors
                                        .grey[100]!), // Transparent border
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
                                        .grey[100]!), // Disabled border color
                              ),
                            ),
                          )),
                      Divider(),
                      Expanded(
                          child: orderHistoryProvider.filteredOrders.isEmpty
                              ? Center(
                                  child: Text(
                                      "No invoices found in the selected filter date!"),
                                )
                              : // Inside your widget
                              ListView.builder(
                                  itemCount: orderHistoryProvider
                                      .filteredOrders.length,
                                  itemBuilder: (context, filteredOrderIndex) {
                                    // Sort orders in descending order (latest first)
                                    final sortedOrders = List.from(
                                        orderHistoryProvider.filteredOrders)
                                      ..sort((a, b) => (b["date"] as DateTime)
                                          .compareTo(a["date"] as DateTime));
                                    final order =
                                        sortedOrders[filteredOrderIndex];

                                    // Listen to the search provider for the updated search keyword
                                    String searchKeyword = Provider.of<
                                            SearchProvider>(context)
                                        .searchKeyword
                                        .toLowerCase(); // Get the search keyword

                                    final SimpleUiProvider simpleUiProvider =
                                        Provider.of<SimpleUiProvider>(context,
                                            listen: false);
                                    String selectedDateCategory =
                                        simpleUiProvider.selectedDate;

                                    // Filtering the orders based on the selected date and search keyword
                                    List filteredList = selectedDateCategory ==
                                            "All"
                                        ? orderHistoryProvider.filteredOrders
                                            .where((invoice) {
                                            return orderNoList[
                                                    filteredOrderIndex]
                                                .toLowerCase()
                                                .contains(
                                                    searchKeyword); // Compare order number with search keyword
                                          }).toList()
                                        : orderHistoryProvider.filteredOrders
                                            .where((invoice) {
                                            return orderNoList[
                                                    filteredOrderIndex]
                                                .toLowerCase()
                                                .contains(
                                                    searchKeyword); // Filter based on order number and selected date
                                          }).toList();

                                    // Only show filtered orders
                                    if (filteredList.isEmpty) {
                                      return Container(); // If no orders match, return an empty container
                                    }

                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          Provider.of<InvoiceScreenProvider>(
                                                  context,
                                                  listen: false)
                                              .switchInvoiceDetailPage();
                                          Provider.of<InvoiceScreenProvider>(
                                                  context,
                                                  listen: false)
                                              .selectInvoiceIndex(
                                                  filteredOrderIndex);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 15),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[100],
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
                                                    "Order No: ${orderNoList[filteredOrderIndex]}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: CommonColor
                                                            .darkGreyColor),
                                                  ),
                                                  Text(
                                                    "Rs.${order["items"]?.fold(0.0, (sum, item) => sum + (item.price * item.quantity)) ?? 0.0}",
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
                                                    DateFormat(
                                                            'yyyy-MM-dd, hh:mm a')
                                                        .format(order["date"]
                                                            as DateTime),
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 11,
                                                      color: CommonColor
                                                          .mediumGreyColor,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Qty: ${order["items"]?.fold(0, (sum, item) => sum + item.quantity) ?? 0}",
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
                                                    "Pending",
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
                                  },
                                )),
                    ],
                  );
                },
              ),
            )),
      );
    });
  }
}
