import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/simple_ui_provider.dart';
import 'package:order_management_system/features/dashboard/domain/product_provider.dart';
import 'package:order_management_system/features/invoice/presentation/screens/invoice_detail_screen.dart';
import 'package:order_management_system/features/invoice/presentation/screens/search_invoice_screen.dart';
import 'package:provider/provider.dart';
import 'package:order_management_system/localization/l10n.dart';
import 'package:order_management_system/localization/l10n.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(onScroll);
    Future.delayed(Duration.zero, () async {
      if (!mounted) {
        return;
      }
      final simpleUiProvider =
          Provider.of<SimpleUiProvider>(context, listen: false);
      simpleUiProvider.clearInvoiceDateRange();
      simpleUiProvider.clearInvoiceFilter();
      if (!mounted) {
        return;
      }
      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      await productProvider.getAllInvoice(
          true,
          simpleUiProvider.selectedInvoiceStatus,
          simpleUiProvider.selectedInvoiceStartDate,
          simpleUiProvider.selectedInvoiceEndDate);
    });
    super.initState();
  }

  void onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      final simpleUiProvider =
          Provider.of<SimpleUiProvider>(context, listen: false);
      productProvider.getAllInvoice(
          false,
          simpleUiProvider.selectedInvoiceStatus,
          simpleUiProvider.selectedInvoiceStartDate,
          simpleUiProvider.selectedInvoiceEndDate);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return KeyboardDismisser(
      child: Scaffold(
          backgroundColor: CommonColor.scaffoldbackgroundColor,
          appBar: AppBar(
            backgroundColor: CommonColor.primaryColor,
            title: RichText(
              text:  TextSpan(
                children: [
                  TextSpan(
                    text: S.current.invoices,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: RefreshIndicator(
            backgroundColor: Colors.white,
            elevation: 0,
            edgeOffset: 2,
            color: CommonColor.primaryColor,
            onRefresh: () async {
              final productProvider =
                  Provider.of<ProductProvider>(context, listen: false);
              final simpleUiProvider =
                  Provider.of<SimpleUiProvider>(context, listen: false);
              // simpleUiProvider.clearInvoiceDateRange();
              // simpleUiProvider.clearInvoiceFilter();

              productProvider.resetAllInvoice();
              await productProvider.getAllInvoice(
                  true,
                  simpleUiProvider.selectedInvoiceStatus,
                  simpleUiProvider.selectedInvoiceStartDate,
                  simpleUiProvider.selectedInvoiceEndDate);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Consumer<ProductProvider>(
                  builder: (context, productProvider, child) {
                if (productProvider.isGetAllInvoiceLoading == true &&
                    productProvider.invoices.isEmpty) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: CommonColor.primaryColor,
                  ));
                } else {
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
                                        SearchInvoiceScreen()));
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
                              // border: Border.all(
                              //     color: CommonColor.mediumGreyColor),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      "Search invoice no....",
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
                            final simpleUiProvider =
                                Provider.of<SimpleUiProvider>(context,
                                    listen: false);
                            simpleUiProvider.clearInvoiceDateRange();
                            simpleUiProvider.clearInvoiceFilter();
                            final productProvider =
                                Provider.of<ProductProvider>(context,
                                    listen: false);
                            productProvider.resetAllInvoice();
                            await productProvider.getAllInvoice(
                                true, "", "", "");
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Text(
                              S.current.resetFilter,
                              style: TextStyle(
                                  color: CommonColor.primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      Divider(
                        color: CommonColor.commonGreyColor,
                        thickness: 2,
                      ),
                      // Divider(
                      //   color: Colors.grey,
                      //   thickness: 0.3,
                      // ),
                      productProvider.invoices.isEmpty
                          ? Center(
                              child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: SizedBox(
                                height: screenHeight * 0.6,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      MingCute.shopping_bag_2_line,
                                      color: CommonColor.darkGreyColor,
                                      weight: 0.5,
                                      size: 100,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "No invoices found!",
                                      style: TextStyle(
                                          color: CommonColor.darkGreyColor,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                          : Expanded(
                              child: ListView.builder(
                                  controller: scrollController,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  itemCount:
                                      productProvider.invoices.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index <
                                        productProvider.invoices.length) {
                                      final invoice =
                                          productProvider.invoices[index];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        InvoiceDetailScreen(
                                                            invoiceNo: invoice
                                                                .invoiceNo)));
                                          },
                                          child: Container(
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 15),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  width: 0.1,
                                                  color: CommonColor
                                                      .mediumGreyColor),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              spacing: 5,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Invoice No: ${invoice.invoiceNo}",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Rs.${invoice.totalAmount}",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      invoice.receiverName,
                                                      style: TextStyle(
                                                          color: CommonColor
                                                              .darkGreyColor,
                                                          fontSize: 15),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets
                                                          .symmetric(
                                                              horizontal: 8,
                                                              vertical: 3),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                      .brown[
                                                                  100]!),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15),
                                                          color: invoice
                                                                      .paidStatus ==
                                                                  "true"
                                                              ? Colors
                                                                  .green[100]
                                                              : Colors.yellow[
                                                                  100]),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .access_alarm_outlined,
                                                            size: 18,
                                                            color: Colors
                                                                .brown[400],
                                                          ),
                                                          SizedBox(
                                                            width: 3,
                                                          ),
                                                          Text(
                                                            invoice.paidStatus ==
                                                                    "false"
                                                                ? "Unpaid"
                                                                : "Paid",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .brown,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .shopping_bag_outlined,
                                                          size: 15,
                                                          color: CommonColor
                                                              .mediumGreyColor,
                                                        ),
                                                        SizedBox(
                                                          width: 3,
                                                        ),
                                                        Text(
                                                          invoice.date
                                                              .substring(
                                                                  0, 10),
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            color: CommonColor
                                                                .mediumGreyColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          MingCute
                                                              .shopping_bag_3_line,
                                                          size: 15,
                                                          color: CommonColor
                                                              .mediumGreyColor,
                                                        ),
                                                        SizedBox(
                                                          width: 3,
                                                        ),
                                                        Text(
                                                          "${invoice.totalQuantity} items",
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            color: CommonColor
                                                                .mediumGreyColor,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        child: Center(
                                          child: productProvider
                                                      .allInvoiceHasMore &&
                                                  productProvider
                                                          .invoices.length >=
                                                      20
                                              ? CircularProgressIndicator(
                                                  color: CommonColor
                                                      .primaryColor,
                                                )
                                              // : Text(
                                              //     "No more invoices to fetch",
                                              //     style: TextStyle(
                                              //         color: CommonColor
                                              //             .darkGreyColor,
                                              //         fontSize: 16),
                                              //   ),
                                              : SizedBox.shrink(),
                                        ),
                                      );
                                      // return CircularProgressIndicator();
                                    }
                                  }),
                            ),
                    ],
                  );
                }
              }),
            ),
          )),
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
                              .setSelectedInvoiceStartDate(formattedDate);
                        }
                      },
                      child: Text(
                        simpleUiProvider.selectedInvoiceStartDate != ""
                            ? simpleUiProvider.selectedInvoiceStartDate
                                .split(' ')[0]
                            : "Start Date",
                        style: TextStyle(
                          color: simpleUiProvider.selectedInvoiceStartDate != ""
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
                          simpleUiProvider
                              .setSelectedInvoiceEndDate(formattedDate);
                        }
                      },
                      child: Text(
                        simpleUiProvider.selectedInvoiceEndDate != ""
                            ? simpleUiProvider.selectedInvoiceEndDate
                                .split(' ')[0]
                            : "End Date",
                        style: TextStyle(
                          color: simpleUiProvider.selectedInvoiceEndDate != ""
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    simpleUiProvider.clearInvoiceFilter();
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
                      value: simpleUiProvider.selectedInvoiceStatus,
                      items: [
                        DropdownMenuItem(value: "", child: Text("All")),
                        DropdownMenuItem(value: "paid", child: Text("Paid")),
                        DropdownMenuItem(
                            value: "un_paid", child: Text("Unpaid")),
                      ],
                      onChanged: (value) {
                        simpleUiProvider.switchSelectedInvoiceStatus(value!);
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
                        final productProvider = Provider.of<ProductProvider>(
                            context,
                            listen: false);
                        productProvider.resetAllInvoice();
                        productProvider.getAllInvoice(
                            true,
                            simpleUiProvider.selectedInvoiceStatus == "paid"
                                ? "1"
                                : simpleUiProvider.selectedInvoiceStatus ==
                                        "un_paid"
                                    ? "0"
                                    : "",
                            simpleUiProvider.selectedInvoiceStartDate,
                            simpleUiProvider.selectedInvoiceEndDate);
                        Navigator.pop(context);
                      },
                      child: const Text("Apply"),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
