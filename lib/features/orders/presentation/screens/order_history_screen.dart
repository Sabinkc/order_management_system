// import 'dart:async';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/simple_ui_provider.dart';
import 'package:order_management_system/features/orders/domain/order_screen_provider.dart';
import 'package:provider/provider.dart';

// import 'dart:developer' as logger;
class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _InvoiceHistoryScreenState();
}

class _InvoiceHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if (!mounted) return;
      final orderProvider =
          Provider.of<OrderScreenProvider>(context, listen: false);
      final simpleUiProvider =
          Provider.of<SimpleUiProvider>(context, listen: false);
      orderProvider.getAllOrder();
      orderProvider.clearFilters();
      orderProvider.clearSearchKeyword();
      simpleUiProvider.clearDateRange();
      simpleUiProvider.clearFilter();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final Logger logger = Logger();
    Timer? debounce;

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
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Consumer<OrderScreenProvider>(
                builder: (context, orderProvider, child) {
                  if (orderProvider.isGetAllOrderLoading) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: CommonColor.primaryColor,
                    ));
                  }
                  if (orderProvider.allOrders.isEmpty) {
                    return Center(
                      child: Text(
                        "No orders till now",
                        style: TextStyle(color: Colors.grey, fontSize: 25),
                      ),
                    );
                  }

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: TextFormField(
                          controller: orderProvider.searchController,
                          onChanged: (value) {
                            final trimmedValue = value.trim();
                            if (debounce?.isActive ?? false) debounce?.cancel();
                            debounce =
                                Timer(const Duration(milliseconds: 500), () {
                              if (trimmedValue.isNotEmpty) {
                                // Update the search keyword in the SearchProvider
                                Provider.of<OrderScreenProvider>(context,
                                        listen: false)
                                    .updateSearchKeyword(trimmedValue);
                              } else {
                                // Update the search keyword in the SearchProvider
                                Provider.of<OrderScreenProvider>(context,
                                        listen: false)
                                    .updateSearchKeyword("");
                              }
                            });
                          },
                          onFieldSubmitted: (value) {
                            final trimmedValue = value.trim();
                            if (trimmedValue.isNotEmpty) {
                              Provider.of<OrderScreenProvider>(context,
                                      listen: false)
                                  .updateSearchKeyword(trimmedValue);
                            } else {
                              Provider.of<OrderScreenProvider>(context,
                                      listen: false)
                                  .updateSearchKeyword("");
                            }
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Search order no...",
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
                      Divider(
                        color: CommonColor.commonGreyColor,
                        thickness: 2,
                      ),
                      Expanded(
                        child: Consumer<OrderScreenProvider>(
                          builder: (context, searchProvider, child) {
                            if (orderProvider.filteredOrders.isEmpty) {
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
//filtered list displayed in listview
                            return ListView.builder(
                              itemCount: orderProvider.filteredOrders.length,
                              itemBuilder: (context, index) {
                                final order =
                                    orderProvider.filteredOrders[index];

                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      Provider.of<OrderScreenProvider>(context,
                                              listen: false)
                                          .switchInvoiceDetailPage();
                                      Provider.of<OrderScreenProvider>(context,
                                              listen: false)
                                          .selectInvoiceKey(order.orderNo);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
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
