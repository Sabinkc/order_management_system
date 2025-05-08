import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/data/product_api_sevice.dart';
import 'package:order_management_system/features/orders/domain/order_screen_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
// import 'dart:developer' as logger;
import 'package:order_management_system/localization/l10n.dart';

class OrderDetailScreen extends StatefulWidget {
  final String orderKey;
  const OrderDetailScreen({super.key, required this.orderKey});

  @override
  State<OrderDetailScreen> createState() => _InvoiceDetailScreenState();
}

class _InvoiceDetailScreenState extends State<OrderDetailScreen> {
  final productApiService = ProductApiSevice();
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if (!mounted) return;
      final orderScreenProvider =
          Provider.of<OrderScreenProvider>(context, listen: false);
      orderScreenProvider.fetchOrderByorderKey(widget.orderKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Consumer<OrderScreenProvider>(
        builder: (context, orderScreenProvider, child) {
      return Scaffold(
          backgroundColor: CommonColor.scaffoldbackgroundColor,
          appBar: AppBar(
            backgroundColor: CommonColor.primaryColor,
            leading: IconButton(
                onPressed: () {
                  // Provider.of<OrderScreenProvider>(context, listen: false)
                  //     .switchInvoiceDetailPage();
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
                text: S.current.orderDetails,
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ])),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: Consumer<OrderScreenProvider>(
              builder: (context, orderScreenProvider, child) {
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
                      S.current.orders,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.005,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Divider(
                      color: CommonColor.commonGreyColor,
                      thickness: 2,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      height: screenHeight * 0.6,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          if (orderScreenProvider.isFetchOrderByLoading) {
                            return Center(
                                child: CircularProgressIndicator(
                              color: CommonColor.primaryColor,
                            )); // Show loader while fetching
                          }

                          if (orderScreenProvider
                              .invoiceDetail.products.isEmpty) {
                            return Center(
                                child: Text(
                                    "No products available")); // Handle empty state
                          }

                          final order = orderScreenProvider.invoiceDetail;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: order.products.map<Widget>((item) {
                                  return Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey, width: 0.2),
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 90,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[100],
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                // child: Image.network(
                                                //   "${Constants.imageStorageBaseUrl}/${item.imagePath}",
                                                //   fit: BoxFit.cover,
                                                //   errorBuilder: (context, error,
                                                //           stackTrace) =>
                                                //       Icon(Icons.broken_image),
                                                // ),
                                                child: FutureBuilder(
                                                    future: productApiService
                                                        .getThumbnailByFilename(
                                                            item.imagePath),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        return Image.memory(
                                                          snapshot.data!,
                                                          fit: BoxFit.cover,
                                                          cacheHeight: 120,
                                                          cacheWidth: 120,
                                                        );
                                                      } else if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return Shimmer
                                                            .fromColors(
                                                                baseColor:
                                                                    Colors.grey[
                                                                        100]!,
                                                                highlightColor:
                                                                    Colors
                                                                        .white,
                                                                child:
                                                                    Container(
                                                                  color: Colors
                                                                      .white,
                                                                ));
                                                      } else {
                                                        return Icon(
                                                            Icons.broken_image);
                                                      }
                                                    }),
                                              ),
                                            ),
                                            SizedBox(width: 15),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 220,
                                                  child: Text(
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    item.name,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  "${item.category} | Qty: ${item.quantity}",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: CommonColor
                                                          .mediumGreyColor),
                                                ),
                                                RichText(
                                                    text: TextSpan(children: [
                                                  TextSpan(
                                                    text: "Rs.",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: CommonColor
                                                            .primaryColor),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        "${item.price * item.quantity}",
                                                    style: TextStyle(
                                                        fontSize: 21,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: CommonColor
                                                            .primaryColor),
                                                  ),
                                                ])),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ));
                                }).toList(),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Divider(
                      color: CommonColor.commonGreyColor,
                      thickness: 2,
                    ),
                  ),
                  // Spacer(),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        S.current.orderDetails,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
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
                          S.current.totalAmount,
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
                                  orderScreenProvider.invoiceDetail.totalAmount,
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
                              S.current.totalQuantity,
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  orderScreenProvider
                                      .invoiceDetail.totalQuantity
                                      .toString(),
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
          }));
    });
  }
}
