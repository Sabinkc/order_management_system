import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/utils.dart';
import 'package:order_management_system/features/dashboard/domain/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:order_management_system/localization/l10n.dart';

class InvoiceDetailScreen extends StatefulWidget {
  final String invoiceNo;
  const InvoiceDetailScreen({super.key, required this.invoiceNo});

  @override
  State<InvoiceDetailScreen> createState() => _InvoiceDetailScreenState();
}

class _InvoiceDetailScreenState extends State<InvoiceDetailScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if (!mounted) {
        return;
      }
      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      productProvider.fetchInvoiceByNo(widget.invoiceNo);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: CommonColor.scaffoldbackgroundColor,
        appBar: AppBar(
          backgroundColor: CommonColor.primaryColor,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              )),
          title: RichText(
              text: TextSpan(children: [
            TextSpan(
              text: S.current.invoiceDetails,
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ])),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Consumer<ProductProvider>(
            builder: (context, productProvider, child) {
          final invoice = productProvider.invoiceDetail;
          return productProvider.isFetchInvoiceByNoLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                  color: CommonColor.primaryColor,
                ))
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.green[50],
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8)),
                              border:
                                  Border.all(color: Colors.grey, width: 0.2)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Invoice No",
                                        style: TextStyle(
                                            color: CommonColor.darkGreyColor,
                                            fontSize: 18),
                                      ),
                                      Row(
                                        spacing: 4,
                                        children: [
                                          Text(
                                            invoice.invoiceNo,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Clipboard.setData(ClipboardData(
                                                  text: invoice.invoiceNo));
                                              Utilities.showCommonSnackBar(
                                                  context,
                                                  "Invoice no copied to clipboard");
                                            },
                                            child: Icon(
                                              Icons.copy_outlined,
                                              size: 16,
                                              color: CommonColor.primaryColor,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.brown[100]!),
                                        borderRadius: BorderRadius.circular(15),
                                        color: invoice.paidStatus == "true"
                                            ? Colors.green[100]
                                            : Colors.yellow[100]),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.access_alarm_outlined,
                                              size: 18,
                                              color: Colors.brown[400],
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              invoice.paidStatus == "false"
                                                  ? "Unpaid"
                                                  : "Paid",
                                              style: TextStyle(
                                                  color: Colors.brown,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Issue Date",
                                        style: TextStyle(
                                            color: CommonColor.darkGreyColor,
                                            fontSize: 18),
                                      ),
                                      Text(
                                        invoice.date.substring(0, 10),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      )
                                    ],
                                  ),
                                  // Column(
                                  //   crossAxisAlignment: CrossAxisAlignment.end,
                                  //   children: [
                                  //     Text(
                                  //       "Due Date",
                                  //       style: TextStyle(
                                  //           color: CommonColor.darkGreyColor,
                                  //           fontSize: 18),
                                  //     ),
                                  //     Text(
                                  //       invoice.date.substring(0, 10),
                                  //       style: TextStyle(
                                  //           fontWeight: FontWeight.bold,
                                  //           fontSize: 18),
                                  //     )
                                  //   ],
                                  // )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey, width: 0.2),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8))

                              // border: Border.symmetric(
                              //     vertical:
                              //         BorderSide(color: Colors.grey, width: 0.2)),
                              ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Billed To",
                                      style: TextStyle(
                                          color: CommonColor.mediumGreyColor,
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
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      invoice.receiverEmail,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      "${invoice.receiverCity}, ${invoice.receiverArea}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Container(
                        //   padding: EdgeInsets.symmetric(
                        //       horizontal: 20, vertical: 10),
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.only(
                        //           bottomLeft: Radius.circular(8),
                        //           bottomRight: Radius.circular(8)),
                        //       border:
                        //           Border.all(color: Colors.grey, width: 0.2)),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Expanded(
                        //         child: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Text(
                        //               "Billed From",
                        //               style: TextStyle(
                        //                   color: CommonColor.mediumGreyColor,
                        //                   fontWeight: FontWeight.bold),
                        //             ),
                        //             SizedBox(
                        //               height: 5,
                        //             ),
                        //             Text(
                        //               "John Doe",
                        //               maxLines: 2,
                        //               overflow: TextOverflow.ellipsis,
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.bold,
                        //                   fontSize: 16),
                        //             ),
                        //             Text(
                        //               "9812345678",
                        //               maxLines: 2,
                        //               overflow: TextOverflow.ellipsis,
                        //               style: TextStyle(fontSize: 16),
                        //             ),
                        //             Text(
                        //               "johndoe@gmail.com",
                        //               maxLines: 2,
                        //               overflow: TextOverflow.ellipsis,
                        //               style: TextStyle(fontSize: 16),
                        //             ),
                        //             Text(
                        //               "City, Street",
                        //               maxLines: 2,
                        //               overflow: TextOverflow.ellipsis,
                        //               style: TextStyle(fontSize: 16),
                        //             )
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          height: 10,
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
                        Container(
                          decoration: BoxDecoration(
                              color: CommonColor.commonGreyColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8)),
                              border:
                                  Border.all(color: Colors.grey, width: 0.2)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  "Item",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Qty",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Price",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Amount",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Divider(
                        //   color: CommonColor.commonGreyColor,
                        //   thickness: 2,
                        //   // height: screenHeight * 0.05,
                        // ),
                        // SizedBox(
                        //   height: screenHeight * 0.01,
                        // ),
                        Expanded(
                          // height: 200,
                          child: Container(
                            // padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey, width: 0.2),
                              color: Colors.white,
                            ),
                            child: ListView.builder(
                                itemCount: invoice.products.length,
                                itemBuilder: (context, index) {
                                  final invoiceProduct = invoice.products;
                                  return Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 7),
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10, right: 5),
                                                    child: Text(
                                                      invoiceProduct[index]
                                                          .name,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5, right: 5),
                                                    child: Text(
                                                      invoiceProduct[index]
                                                          .quantity
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 10),
                                                    child: Text(
                                                      invoiceProduct[index]
                                                          .price
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 10),
                                                    child: Text(
                                                      "${invoiceProduct[index].price * invoiceProduct[index].quantity}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Divider(
                                              color: Colors.grey,
                                              thickness: 0.2,
                                              height: 0,
                                              // height: screenHeight * 0.05,
                                            ),
                                          ],
                                        ),
                                      ));
                                }),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              color: CommonColor.commonGreyColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8)),
                              border:
                                  Border.all(color: Colors.grey, width: 0.2)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Rs.${invoice.totalAmount}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        )
                      ]),
                );
        }));
  }
}
