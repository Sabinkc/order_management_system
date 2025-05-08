import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/data/product_api_sevice.dart';
import 'package:order_management_system/features/orders/domain/order_screen_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:order_management_system/localization/l10n.dart';

class OrderHistoryInvoiceWidget extends StatelessWidget {
   OrderHistoryInvoiceWidget({super.key});
final productApiService = ProductApiSevice();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Consumer<OrderScreenProvider>(
      builder: (context, orderProvider, child) {
        final order = orderProvider.ordersBySandD;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: CommonColor.commonGreyColor,
                thickness: 2,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: screenHeight * 0.28,
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, orderIndex) {
                    final firstOrder = orderProvider.ordersBySandD[0];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: firstOrder.products.map<Widget>((item) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 0.2),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 90,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        // child: Image.network(
                                        //   "${Constants.imageStorageBaseUrl}/${item.imagePath}",
                                        //   fit: BoxFit.cover,
                                        //   errorBuilder:
                                        //       (context, error, stackTrace) =>
                                        //           Icon(Icons.broken_image),
                                        // ),
                                          child: FutureBuilder(
                                      future: productApiService
                                          .getThumbnailByFilename(item.imagePath),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Image.memory(
                                            snapshot.data!,
                                            fit: BoxFit.cover,
                                            cacheHeight: 120,
                                            cacheWidth: 120,
                                          );
                                        } else if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Shimmer.fromColors(
                                              baseColor: Colors.grey[100]!,
                                              highlightColor: Colors.white,
                                              child: Container(
                                                color: Colors.white,
                                              ));
                                        } else {
                                          return Icon(Icons.broken_image);
                                        }
                                      }),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 220,
                                          child: Text(
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            item.name,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "${item.category} | Qty: ${item.quantity}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  CommonColor.mediumGreyColor),
                                        ),
                                        RichText(
                                            text: TextSpan(children: [
                                          TextSpan(
                                            text: "Rs.",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    CommonColor.primaryColor),
                                          ),
                                          TextSpan(
                                            text:
                                                "${item.price * item.quantity}",
                                            style: TextStyle(
                                                fontSize: 21,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    CommonColor.primaryColor),
                                          ),
                                        ])),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  color: CommonColor.commonGreyColor,
                  thickness: 2,
                ),
              ),
            ),
            // Spacer(),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  S.current.invoiceDetails,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )),
            SizedBox(
              height: screenHeight * 0.015,
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
                            "${order[0].products.fold(0.0, (sum, item) => sum + (item.price * item.quantity))}",
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
                            "(${order[0].products.fold(0, (sum, item) => sum + item.quantity)})",
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
                  // Spacer(),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
