import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/simple_ui_provider.dart';
import 'package:order_management_system/features/invoice/domain/invoice_screen_provider.dart';
import 'package:order_management_system/features/order%20history/domain/order_history_provider.dart';
import 'package:provider/provider.dart';

class InvoiceHistoryScreen extends StatelessWidget {
  const InvoiceHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                          child: TextFormField(
                            onChanged: (value) {},
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
                              child: GestureDetector(
                                onTap: () {
                                  Provider.of<InvoiceScreenProvider>(context,
                                          listen: false)
                                      .switchInvoiceDetailPage();
                                  Provider.of<InvoiceScreenProvider>(context,
                                          listen: false)
                                      .selectInvoiceIndex(orderIndex);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
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
                                            "Order No: 01234567",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    CommonColor.darkGreyColor),
                                          ),
                                          Text(
                                            "Rs.${order["items"]?.fold(0.0, (sum, item) => sum + (item.price * item.quantity)) ?? 0.0}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color:
                                                    CommonColor.primaryColor),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            DateFormat('yyyy-MM-dd, hh:mm a')
                                                .format(
                                                    order["date"] as DateTime),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11,
                                              color:
                                                  CommonColor.mediumGreyColor,
                                            ),
                                          ),
                                          Text(
                                            "Qty: ${order["items"]?.fold(0, (sum, item) => sum + item.quantity) ?? 0}",
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
                                                color:
                                                    CommonColor.darkGreyColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "Pending",
                                            style: TextStyle(
                                                color: CommonColor.primaryColor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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
            )),
      );
    });
  }
}
