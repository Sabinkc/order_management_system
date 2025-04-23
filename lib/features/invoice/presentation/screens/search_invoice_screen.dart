import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/domain/product_provider.dart';
import 'package:provider/provider.dart';

class SearchInvoiceScreen extends StatefulWidget {
  const SearchInvoiceScreen({super.key});

  @override
  State<SearchInvoiceScreen> createState() => _SearchOrderScreenState();
}

class _SearchOrderScreenState extends State<SearchInvoiceScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if (!mounted) {
        return;
      }
      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      productProvider.clearSearchedInvoice();
    });
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
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
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "Search Invoices",
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
          body: Consumer<ProductProvider>(
              builder: (context, productProvider, children) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: TextFormField(
                      controller: searchController,
                      onFieldSubmitted: (value) {
                        productProvider
                            .fetchInvoiceByNo(searchController.text.trim());
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Search invoice no...",
                        hintStyle: TextStyle(
                            color: CommonColor.darkGreyColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        prefixIcon: InkWell(
                          onTap: () {
                            productProvider
                                .fetchInvoiceByNo(searchController.text.trim());
                          },
                          child: Icon(
                            Icons.search,
                            size: 25,
                            color: CommonColor.primaryColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: Colors.grey[100]!), // Transparent border
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
                              color:
                                  Colors.grey[100]!), // Disabled border color
                        ),
                      ),
                    ),
                  ),
                  // InkWell(
                  //     onTap: () async {},
                  //     child: Padding(
                  //       padding: EdgeInsets.only(right: 8),
                  //       child: Text(
                  //         "Clear search",
                  //         style: TextStyle(
                  //             color: CommonColor.primaryColor,
                  //             fontWeight: FontWeight.bold),
                  //       ),
                  //     )),
                  Divider(
                    color: CommonColor.commonGreyColor,
                    thickness: 2,
                  ),
                  productProvider.isFetchInvoiceByNoLoading == true
                      ? Center(
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              color: CommonColor.primaryColor,
                            ),
                          ),
                        )
                      : productProvider.searchedInvoice.isEmpty
                          ? Center(
                              child: Text(
                                "No invoice matching with the orderKey!",
                                style: TextStyle(
                                    color: CommonColor.mediumGreyColor,
                                    fontSize: 16),
                              ),
                            )
                          : Builder(builder: (context) {
                              final invoice =
                                  productProvider.searchedInvoice[0];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Prepared for",
                                              style: TextStyle(
                                                  color: CommonColor
                                                      .mediumGreyColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              invoice.receiverName,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              invoice.receiverPhone,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              invoice.receiverEmail,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              "${invoice.receiverCity}, ${invoice.receiverArea}",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Date",
                                            style: TextStyle(
                                                color:
                                                    CommonColor.mediumGreyColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "2025-02-01",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Divider(
                                    color: CommonColor.commonGreyColor,
                                    thickness: 2,
                                    height: screenHeight * 0.05,
                                  ),

                                  Text(
                                    "Invoice Summary",
                                    style: TextStyle(
                                        color: CommonColor.primaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.01,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Products",
                                          style: TextStyle(
                                              color:
                                                  CommonColor.mediumGreyColor),
                                        ),
                                        Text(
                                          "Amount",
                                          style: TextStyle(
                                              color:
                                                  CommonColor.mediumGreyColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.01,
                                  ),
                                  // Divider(
                                  //   color: CommonColor.commonGreyColor,
                                  //   thickness: 2,
                                  //   // height: screenHeight * 0.05,
                                  // ),
                                  // SizedBox(
                                  //   height: screenHeight * 0.01,
                                  // ),
                                  SizedBox(
                                    height: screenHeight * 0.25,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: ListView.builder(
                                          itemCount: invoice.products.length,
                                          itemBuilder: (context, index) {
                                            final invoiceProduct =
                                                invoice.products;
                                            return Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "${invoiceProduct[index].quantity} ${invoiceProduct[index].name}",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          "${invoiceProduct[index].price}",
                                                          style: TextStyle(
                                                              color: CommonColor
                                                                  .mediumGreyColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ],
                                                    ),
                                                    Divider(
                                                      color: CommonColor
                                                          .commonGreyColor,
                                                      thickness: 2,
                                                      // height: screenHeight * 0.05,
                                                    ),
                                                  ],
                                                ));
                                          }),
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Invoice no",
                                        style: TextStyle(
                                          color: CommonColor.mediumGreyColor,
                                        ),
                                      ),
                                      Text(
                                        invoice.invoiceNo,
                                        style: TextStyle(
                                            color: CommonColor.mediumGreyColor),
                                      )
                                    ],
                                  ),
                                  Divider(
                                    color: CommonColor.commonGreyColor,
                                    thickness: 2,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Invoice status",
                                        style: TextStyle(
                                          color: CommonColor.mediumGreyColor,
                                        ),
                                      ),
                                      Text(
                                        invoice.paidStatus=="false"?"Unpaid":"Paid",
                                        style: TextStyle(
                                            color: CommonColor.mediumGreyColor),
                                      )
                                    ],
                                  ),
                                  Divider(
                                    color: CommonColor.commonGreyColor,
                                    thickness: 2,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Subtotal",
                                        style: TextStyle(
                                          color: CommonColor.mediumGreyColor,
                                        ),
                                      ),
                                      Text(
                                        "Rs.${invoice.totalAmount}",
                                        style: TextStyle(
                                            color: CommonColor.mediumGreyColor),
                                      )
                                    ],
                                  ),
                                  Divider(
                                    color: CommonColor.commonGreyColor,
                                    thickness: 2,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Discount",
                                        style: TextStyle(
                                          color: CommonColor.mediumGreyColor,
                                        ),
                                      ),
                                      Text(
                                        "Rs.0",
                                        style: TextStyle(
                                            color: CommonColor.mediumGreyColor),
                                      )
                                    ],
                                  ),
                                  Divider(
                                    color: CommonColor.commonGreyColor,
                                    thickness: 2,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total",
                                        style: TextStyle(
                                          color: CommonColor.mediumGreyColor,
                                        ),
                                      ),
                                      Text(
                                        "Rs.${invoice.totalAmount}",
                                        style: TextStyle(
                                            color: CommonColor.mediumGreyColor),
                                      )
                                    ],
                                  ),
                                ],
                              );
                            }),
                ],
              ),
            );
          })),
    );
  }
}
