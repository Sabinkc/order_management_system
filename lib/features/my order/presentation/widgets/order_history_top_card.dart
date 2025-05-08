import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/data/product_api_sevice.dart';
import 'package:order_management_system/features/orders/domain/order_screen_provider.dart';
import 'package:order_management_system/features/my%20order/domain/switch_order_screen_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:developer' as logger;
import 'package:order_management_system/localization/l10n.dart';

class OrderHistoryTopCard extends StatelessWidget {
  OrderHistoryTopCard({super.key});

  final productApiService = ProductApiSevice();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final SwitchOrderScreenProvider switchOrderScreenProvider =
        Provider.of<SwitchOrderScreenProvider>(context);
    return Consumer<OrderScreenProvider>(
      builder: (context, orderProvider, child) {
        final order = orderProvider.ordersBySandD;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: double.infinity,
            height: screenHeight * 0.29,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: CommonColor.primaryColor,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order No: ${order[0].orderNo}",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Status: ${order[0].status}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Text(
                    order[0].date,
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: CommonColor.primaryColor,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 0),
                                color: Colors.black12,
                                blurRadius: 1)
                          ]
                          // border: Border.all(color: Colors.white),
                          ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 90,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  // child: Image.network(
                                  //   "${Constants.imageStorageBaseUrl}/${order[0].products[0].imagePath}", // First item image
                                  //   fit: BoxFit.cover,
                                  //   errorBuilder:
                                  //       (context, error, stackTrace) =>
                                  //           Icon(Icons.broken_image),
                                  // ),
                                  child: FutureBuilder(
                                      future:
                                          productApiService.getThumbnailByFilename(
                                              order[0].products[0].imagePath),
                                      builder: (context, snapshot) {
                                        logger.log(
                                            "top response: ${order[0].products[0].imagePath}");
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
                              SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 220,
                                    child: Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      order[0]
                                          .products[0]
                                          .name, // First item name
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${order[0].products[0].category} | Qty: ${order[0].products[0].quantity}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: "Rs.",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            "${order[0].products[0].price * order[0].products[0].quantity}", // First item price
                                        style: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(
                                color:
                                    switchOrderScreenProvider.selectedIndex == 0
                                        ? Colors.blue
                                        : Colors.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {
                            Provider.of<SwitchOrderScreenProvider>(context,
                                    listen: false)
                                .switchSelectedIndex(0);
                          },
                          child: Text(
                            S.current.trackOrder,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: CommonColor.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(
                                color:
                                    switchOrderScreenProvider.selectedIndex == 1
                                        ? Colors.blue
                                        : Colors.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {
                            Provider.of<SwitchOrderScreenProvider>(context,
                                    listen: false)
                                .switchSelectedIndex(1);
                          },
                          child: Text(
                            S.current.viewInvoice,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: CommonColor.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
