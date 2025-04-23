import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/domain/product_provider.dart';
import 'package:provider/provider.dart';

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
              text: "Invoice Details",
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
                        // Text("Receipt"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Prepared for",
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
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Date",
                                  style: TextStyle(
                                      color: CommonColor.mediumGreyColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 110,
                                  child: Text(
                                    invoice.date,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
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
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Products",
                                style: TextStyle(
                                    color: CommonColor.mediumGreyColor),
                              ),
                              Text(
                                "Amount",
                                style: TextStyle(
                                    color: CommonColor.mediumGreyColor),
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
                        Expanded(
                          // height: 200,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: ListView.builder(
                                itemCount: invoice.products.length,
                                itemBuilder: (context, index) {
                                  final invoiceProduct = invoice.products;
                                  return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${invoiceProduct[index].quantity} ${invoiceProduct[index].name}",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "${invoiceProduct[index].price}",
                                                style: TextStyle(
                                                    color: CommonColor
                                                        .mediumGreyColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                          Divider(
                                            color: CommonColor.commonGreyColor,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Invoice no",
                              style: TextStyle(
                                color: CommonColor.mediumGreyColor,
                              ),
                            ),
                            Text(
                              invoice.invoiceNo,
                              style:
                                  TextStyle(color: CommonColor.mediumGreyColor),
                            )
                          ],
                        ),
                        Divider(
                          color: CommonColor.commonGreyColor,
                          thickness: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Invoice status",
                              style: TextStyle(
                                color: CommonColor.mediumGreyColor,
                              ),
                            ),
                            Text(
                              invoice.paidStatus == "false" ? "Unpaid" : "Paid",
                              style:
                                  TextStyle(color: CommonColor.mediumGreyColor),
                            )
                          ],
                        ),
                        Divider(
                          color: CommonColor.commonGreyColor,
                          thickness: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Subtotal",
                              style: TextStyle(
                                color: CommonColor.mediumGreyColor,
                              ),
                            ),
                            Text(
                              "Rs.${invoice.totalAmount}",
                              style:
                                  TextStyle(color: CommonColor.mediumGreyColor),
                            )
                          ],
                        ),
                        Divider(
                          color: CommonColor.commonGreyColor,
                          thickness: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Discount",
                              style: TextStyle(
                                color: CommonColor.mediumGreyColor,
                              ),
                            ),
                            Text(
                              "Rs.0",
                              style:
                                  TextStyle(color: CommonColor.mediumGreyColor),
                            )
                          ],
                        ),
                        Divider(
                          color: CommonColor.commonGreyColor,
                          thickness: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(
                                color: CommonColor.mediumGreyColor,
                              ),
                            ),
                            Text(
                              "Rs.${invoice.totalAmount}",
                              style:
                                  TextStyle(color: CommonColor.mediumGreyColor),
                            )
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.005,
                        )
                      ]),
                );
        }));
  }
}
