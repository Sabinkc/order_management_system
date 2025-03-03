// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:intl/intl.dart';
// import 'package:keyboard_dismisser/keyboard_dismisser.dart';
// import 'package:logger/logger.dart';
// import 'package:order_management_system/common/common_color.dart';
// import 'package:order_management_system/common/simple_ui_provider.dart';
// import 'package:order_management_system/features/invoice/domain/invoice_screen_provider.dart';
// import 'package:order_management_system/features/invoice/domain/search_provider.dart';
// import 'package:order_management_system/features/order%20history/domain/order_history_provider.dart';
// import 'package:provider/provider.dart';

// class InvoiceHistoryScreen extends StatelessWidget {
//   const InvoiceHistoryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController searchController = TextEditingController();
//     final Random random = Random();
//     final Logger logger = Logger();

//     List<String> generateRandomStatuses(int count) {
//       List<String> statuses = ['Paid', 'Pending', 'Refunded', 'Cancelled'];

//       return List.generate(count, (index) {
//         return statuses[random.nextInt(statuses.length)];
//       });
//     }

//     // Function to generate random numbers between 000000 and 100000
//     List<String> generateRandomNumbers(int count) {
//       return List.generate(count, (index) {
//         int number =
//             random.nextInt(100001); // Generates a number between 0 and 100000
//         return number.toString().padLeft(
//             6, '0'); // Pads the number with leading zeros to ensure 6 digits
//       });
//     }

//     final OrderHistoryProvider orderHistoryProvider =
//         Provider.of<OrderHistoryProvider>(context, listen: false);
//     List orderNoList =
//         generateRandomNumbers(orderHistoryProvider.filteredOrders.length);

//     List randomStatusList =
//         generateRandomStatuses(orderHistoryProvider.filteredOrders.length);

//     logger.i("randomStatusList: $randomStatusList");

//     return Consumer<InvoiceScreenProvider>(
//       builder: (context, invoiceScreenProvider, child) {
//         return KeyboardDismisser(
//           child: Scaffold(
//             backgroundColor: Colors.white,
//             appBar: AppBar(
//               backgroundColor: Colors.white,
//               title: RichText(
//                 text: const TextSpan(
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
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Consumer<OrderHistoryProvider>(
//                 builder: (context, orderHistoryProvider, child) {
//                   if (orderHistoryProvider.orders.isEmpty) {
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
//                         padding: const EdgeInsets.only(top: 10, bottom: 10),
//                         child: TextFormField(
//                           controller: searchController,
//                           onChanged: (value) {
//                             // Update the search keyword in the SearchProvider
//                             Provider.of<SearchProvider>(context, listen: false)
//                                 .updateSearchKeyword(value);
//                           },
//                           decoration: InputDecoration(
//                             contentPadding: const EdgeInsets.symmetric(
//                               horizontal: 10,
//                             ),
//                             fillColor: Colors.grey[100],
//                             filled: true,
//                             hintText: "Search invoice no...",
//                             hintStyle: TextStyle(
//                                 color: CommonColor.darkGreyColor,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16),
//                             prefixIcon: Icon(
//                               Icons.search,
//                               size: 25,
//                               color: CommonColor.primaryColor,
//                             ),
//                             suffixIcon: Theme(
//                               data: ThemeData(
//                                   popupMenuTheme: PopupMenuThemeData(
//                                 color: Colors.white,
//                               )),
//                               child: PopupMenuButton(
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(right: 5.0),
//                                   child: SvgPicture.asset(
//                                     "assets/icons/filter.svg",
//                                     fit: BoxFit.contain,
//                                   ),
//                                 ),
//                                 itemBuilder: (context) {
//                                   return [
//                                     PopupMenuItem(
//                                       padding: const EdgeInsets.only(
//                                         left: 15,
//                                         right: 15,
//                                         top: 0,
//                                         bottom: 0,
//                                       ),
//                                       onTap: () {
//                                         showFilterDialog(context);
//                                       },
//                                       child: const Center(
//                                           child: Text("Search filters")),
//                                     ),
//                                   ];
//                                 },
//                               ),
//                             ),
//                             suffixIconConstraints: const BoxConstraints(
//                                 maxHeight: 30,
//                                 maxWidth: 30,
//                                 minHeight: 30,
//                                 minWidth: 30),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide(
//                                   color:
//                                       Colors.grey[100]!), // Transparent border
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide(
//                                   color: CommonColor.primaryColor,
//                                   width: 2), // Focused border color
//                             ),
//                             errorBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide(
//                                   color: Colors.red,
//                                   width: 2), // Error border color
//                             ),
//                             focusedErrorBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide(
//                                   color: Colors.red,
//                                   width: 2), // Focused error border color
//                             ),
//                             disabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide(
//                                   color: Colors
//                                       .grey[100]!), // Disabled border color
//                             ),
//                           ),
//                         ),
//                       ),
//                       const Divider(),
//                       Expanded(
//                         child: Consumer<SearchProvider>(
//                           builder: (context, searchProvider, child) {
//                             // searchKeyword
//                             String searchKeyword =
//                                 searchProvider.searchKeyword.toLowerCase();

//                             final SimpleUiProvider simpleUiProvider =
//                                 Provider.of<SimpleUiProvider>(context,
//                                     listen: false);
//                             //selected date category
//                             String selectedDateCategory =
//                                 simpleUiProvider.selectedDate;

//                             // returns the list that is gained from filtered orders based on datecategory matching with searched keyword as filtered list
//                             List filteredList = orderHistoryProvider
//                                 .filteredOrders
//                                 .where((invoice) {
//                               final orderNumber = orderNoList[
//                                       orderHistoryProvider.filteredOrders
//                                           .indexOf(invoice)]
//                                   .toLowerCase();
//                               final matchesSearchKeyword =
//                                   orderNumber.contains(searchKeyword);

//                               if (selectedDateCategory == "All") {
//                                 return matchesSearchKeyword;
//                               } else {
//                                 // Apply date filter logic here if needed
//                                 return matchesSearchKeyword;
//                               }
//                             }).toList();

//                             final Logger logger = Logger();
//                             logger.i("filtered List: $filteredList");

//                             if (filteredList.isEmpty) {
//                               return Center(
//                                 child: Text(
//                                   "No invoices found!",
//                                   style: TextStyle(
//                                       color: CommonColor.darkGreyColor,
//                                       fontSize: 20),
//                                 ),
//                               );
//                             }

// //filtered list displayed in listview
//                             return ListView.builder(
//                               itemCount: filteredList.length,
//                               itemBuilder: (context, filteredOrderIndex) {
//                                 final sortedOrders = List.from(filteredList)
//                                   ..sort((a, b) => (b["date"] as DateTime)
//                                       .compareTo(a["date"] as DateTime));

//                                 //assigns items individually from filtered list to orders that comes from filtering with date and matching with searchkeyword based on checkedout date(reverse filteredlist)
//                                 final order = sortedOrders[filteredOrderIndex];

// //individual items from filtered list as order(in reverse), filtered list displayed in list view
//                                 return Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 10),
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       Provider.of<InvoiceScreenProvider>(
//                                               context,
//                                               listen: false)
//                                           .switchInvoiceDetailPage();
//                                       Provider.of<InvoiceScreenProvider>(
//                                               context,
//                                               listen: false)
//                                           .selectInvoiceIndex(
//                                               filteredOrderIndex);
//                                     },
//                                     child: Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 15, vertical: 15),
//                                       decoration: BoxDecoration(
//                                         color: Colors.grey[100],
//                                         borderRadius: BorderRadius.circular(8),
//                                       ),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         spacing: 3,
//                                         children: [
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Text(
//                                                 "Order No: ${orderNoList[filteredOrderIndex]}",
//                                                 style: TextStyle(
//                                                     fontSize: 15,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: CommonColor
//                                                         .darkGreyColor),
//                                               ),
//                                               Text(
//                                                 "Rs.${order["items"]?.fold(0.0, (sum, item) => sum + (item.price * item.quantity)) ?? 0.0}",
//                                                 style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 15,
//                                                     color: CommonColor
//                                                         .primaryColor),
//                                               ),
//                                             ],
//                                           ),
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Text(
//                                                 DateFormat(
//                                                         'yyyy-MM-dd, hh:mm a')
//                                                     .format(order["date"]
//                                                         as DateTime),
//                                                 style: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 11,
//                                                   color: CommonColor
//                                                       .mediumGreyColor,
//                                                 ),
//                                               ),
//                                               Text(
//                                                 "Qty: ${order["items"]?.fold(0, (sum, item) => sum + item.quantity) ?? 0}",
//                                                 style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 11,
//                                                     color: CommonColor
//                                                         .mediumGreyColor),
//                                               ),
//                                             ],
//                                           ),
//                                           Row(
//                                             children: [
//                                               Text(
//                                                 "Status: ",
//                                                 style: TextStyle(
//                                                     color: CommonColor
//                                                         .darkGreyColor,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               ),
//                                               Text(
//                                                 "${order["status"]}",
//                                                 style: TextStyle(
//                                                     color: CommonColor
//                                                         .primaryColor,
//                                                     fontWeight:
//                                                         FontWeight.w600),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   //logical part
//   //function to show filter dialog
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
//                             simpleUiProvider.setSelectedStartDate(picked);
//                           }
//                         },
//                         child: Text(
//                           simpleUiProvider.selectedStartDate != null
//                               ? "${simpleUiProvider.selectedStartDate!.toLocal()}"
//                                   .split(' ')[0]
//                               : "Start Date",
//                           style: TextStyle(
//                             color: simpleUiProvider.selectedStartDate != null
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
//                             simpleUiProvider.setSelectedEndDate(picked);
//                           }
//                         },
//                         child: Text(
//                           simpleUiProvider.selectedEndDate != null
//                               ? "${simpleUiProvider.selectedEndDate!.toLocal()}"
//                                   .split(' ')[0]
//                               : "End Date",
//                           style: TextStyle(
//                             color: simpleUiProvider.selectedEndDate != null
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
//                           DropdownMenuItem(
//                               value: "all_status", child: Text("All")),
//                           DropdownMenuItem(value: "paid", child: Text("Paid")),
//                           DropdownMenuItem(
//                               value: "pending", child: Text("Pending")),
//                           DropdownMenuItem(
//                               value: "cancelled", child: Text("Cancelled")),
//                           DropdownMenuItem(
//                               value: "refunded", child: Text("Refunded")),
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
//                           Provider.of<OrderHistoryProvider>(context,
//                                   listen: false)
//                               .setFilter(
//                             simpleUiProvider.selectedStatus,
//                             startDate: simpleUiProvider.selectedStartDate,
//                             endDate: simpleUiProvider.selectedEndDate,
//                           );
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

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/simple_ui_provider.dart';
import 'package:order_management_system/features/dashboard/domain/product_provider.dart';
import 'package:order_management_system/features/invoice/domain/invoice_screen_provider.dart';
import 'package:order_management_system/features/invoice/domain/search_provider.dart';
import 'package:provider/provider.dart';
// import 'dart:developer' as logger;
class InvoiceHistoryScreen extends StatefulWidget {
  const InvoiceHistoryScreen({super.key});

  @override
  State<InvoiceHistoryScreen> createState() => _InvoiceHistoryScreenState();
}

class _InvoiceHistoryScreenState extends State<InvoiceHistoryScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if (!mounted) return;
      final proudctProvider =
          Provider.of<ProductProvider>(context, listen: false);
      proudctProvider.getAllOrder();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    // final Logger logger = Logger();

    return Consumer<InvoiceScreenProvider>(
      builder: (context, invoiceScreenProvider, child) {
        return KeyboardDismisser(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: RichText(
                text: const TextSpan(
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Consumer<ProductProvider>(
                builder: (context, productProvider, child) {
                  if (productProvider.isGetAllOrderLoading) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: CommonColor.primaryColor,
                    ));
                  }
                  if (productProvider.allOrders.isEmpty) {
                    return Center(
                      child: Text("No invoices till now"),
                    );
                  }

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: TextFormField(
                          controller: searchController,
                          onChanged: (value) {
                            // Update the search keyword in the SearchProvider
                            Provider.of<SearchProvider>(context, listen: false)
                                .updateSearchKeyword(value);
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            fillColor: Colors.grey[100],
                            filled: true,
                            hintText: "Search invoice no...",
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
                                  padding: const EdgeInsets.only(right: 5.0),
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
                            suffixIconConstraints: const BoxConstraints(
                                maxHeight: 30,
                                maxWidth: 30,
                                minHeight: 30,
                                minWidth: 30),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color:
                                      Colors.grey[100]!), // Transparent border
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
                        ),
                      ),
                      const Divider(),
                      Expanded(
                        child: Consumer<SearchProvider>(
                          builder: (context, searchProvider, child) {
//filtered list displayed in listview
                            return ListView.builder(
                              itemCount: productProvider.filteredOrders.length,
                              itemBuilder: (context, index) {
                                final order =
                                    productProvider.filteredOrders[index];

                                if (productProvider.filteredOrders.isEmpty) {
                                  return Center(
                                    child: Text(
                                      "No invoices found!",
                                      style: TextStyle(
                                        color: CommonColor.darkGreyColor,
                                        fontSize: 20,
                                      ),
                                    ),
                                  );
                                }
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: GestureDetector(
                                    onTap: () 
                                    {
                                       Provider.of<InvoiceScreenProvider>(
                                              context,
                                              listen: false)
                                          .switchInvoiceDetailPage();
                                      Provider.of<InvoiceScreenProvider>(
                                              context,
                                              listen: false)
                                          .selectInvoiceKey(
                                            order.orderNo);
                                            
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        spacing: 3,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Order No: ${order.orderNo}",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: CommonColor
                                                        .darkGreyColor),
                                              ),
                                              Text(
                                                "Rs.${order.totalAmount}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: CommonColor
                                                        .primaryColor),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                order.date,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 11,
                                                  color: CommonColor
                                                      .mediumGreyColor,
                                                ),
                                              ),
                                              Text(
                                                "Qty: ${order.totalQuantity}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
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
                            simpleUiProvider.setSelectedStartDate(picked);
                          }
                        },
                        child: Text(
                          simpleUiProvider.selectedStartDate != null
                              ? "${simpleUiProvider.selectedStartDate!.toLocal()}"
                                  .split(' ')[0]
                              : "Start Date",
                          style: TextStyle(
                            color: simpleUiProvider.selectedStartDate != null
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
                            simpleUiProvider.setSelectedEndDate(picked);
                          }
                        },
                        child: Text(
                          simpleUiProvider.selectedEndDate != null
                              ? "${simpleUiProvider.selectedEndDate!.toLocal()}"
                                  .split(' ')[0]
                              : "End Date",
                          style: TextStyle(
                            color: simpleUiProvider.selectedEndDate != null
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
                          DropdownMenuItem(
                              value: "all_status", child: Text("All")),
                          DropdownMenuItem(
                              value: "confirmed", child: Text("Confirmed")),
                          DropdownMenuItem(
                              value: "pending", child: Text("Pending")),
                          DropdownMenuItem(
                              value: "cancelled", child: Text("Cancelled")),
                          DropdownMenuItem(
                              value: "refunded", child: Text("Refunded")),
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
                          Provider.of<ProductProvider>(context, listen: false)
                              .setFilter(
                            simpleUiProvider.selectedStatus,
                            startDate: simpleUiProvider.selectedStartDate,
                            endDate: simpleUiProvider.selectedEndDate,
                          );
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
