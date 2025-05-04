import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/constants.dart';
import 'package:order_management_system/features/dashboard/data/product_api_sevice.dart';
import 'package:order_management_system/features/dashboard/domain/cart_quantity_provider.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as logger;

import 'package:shimmer/shimmer.dart';

class CheckoutOrderWidgetDashboard extends StatelessWidget {
  CheckoutOrderWidgetDashboard({super.key});

  final productApiService = ProductApiSevice();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: screenHeight * 0.45,
        child:
            Consumer<CartQuantityProvider>(builder: (context, provider, child) {
          return ListView.builder(
              itemCount: provider.cartItems.length,
              itemBuilder: (context, index) {
                final item = provider.cartItems[index];
                logger.log(
                    "imageUrl: ${Constants.imageStorageBaseUrl}/${item.imagePath}");
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 110,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 0.2),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            spacing: 15,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                height: 130,
                                width: 90,
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
                                          .getImageByFilename(item.imagePath),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Image.memory(
                                            snapshot.data!,
                                            fit: BoxFit.cover,
                                            cacheHeight: 150,
                                            cacheWidth: 150,
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
                              SizedBox(
                                width: 0,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 18),
                                child: SizedBox(
                                  width: 170,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        item.productName,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Rs.",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: CommonColor.primaryColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            item.price.toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: CommonColor.primaryColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          Expanded(
                                            child: Text(
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              item.category,
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  color: CommonColor
                                                      .mediumGreyColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 0,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Qty: ",
                                            style: TextStyle(
                                                fontSize: 11,
                                                color:
                                                    CommonColor.mediumGreyColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Center(
                                            child: Text(
                                              item.quantity.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color:
                                                      CommonColor.primaryColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              });
        }),
      ),
    );
  }
}
