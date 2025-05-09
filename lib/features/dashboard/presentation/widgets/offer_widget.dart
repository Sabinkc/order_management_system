import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/data/product_api_sevice.dart';
import 'package:order_management_system/features/dashboard/domain/cart_quantity_provider.dart';
import 'package:order_management_system/features/dashboard/domain/product_provider.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/home_screens/all_offers_screen.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/offer_detail_screen.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as logger;
import 'package:order_management_system/localization/l10n.dart';
import 'package:shimmer/shimmer.dart';

class OfferWidget extends StatelessWidget {
  OfferWidget({super.key});

  final ProductApiSevice productApiSevice = ProductApiSevice();

  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          spacing: 5,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.current.offers,
                  style: TextStyle(
                    color: CommonColor.blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllOffersScreen()));
                  },
                  child: Text(
                    S.current.seeAll,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: CommonColor.primaryColor),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 3,
            ),
            SizedBox(
              height: 200,
              child: Center(child: Consumer<ProductProvider>(
                  builder: (context, productProvider, child) {
                // logger.log(
                //     "offer prodcut length: ${productProvider.offerProduct.length.toString()}");
                // if (productProvider.isOfferProductLoading == true &&
                //     productProvider.offerProduct.isEmpty) {
                //   return Center(
                //       child: CircularProgressIndicator(
                //     color: CommonColor.primaryColor,
                //   ));
                // } else if (productProvider.offerProduct.isEmpty) {
                //   return SizedBox.shrink();
                // } else {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: productProvider.offerProduct.length > 5
                          ? 5
                          : productProvider.offerProduct.length,
                      itemBuilder: (context, index) {
                        final offerProduct =
                            productProvider.offerProduct[index];
                        // double price = offerProduct.price;
                        // int parsedPrice = price.toInt();
                        // String discountPercent = offerProduct.discountPercent;

                        return Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OfferDetailScreen(
                                          sku: offerProduct.sku.toString())));
                            },
                            child: Container(
                              width: 160,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0XFFFAFAFA),
                                        borderRadius:
                                            const BorderRadius.vertical(
                                          top: Radius.circular(8),
                                        ),
                                      ),
                                      height: 130,
                                      width: double.infinity,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 0,
                                            top: 0,
                                            right: 0,
                                            bottom: 0,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                  topRight: Radius.circular(8)),
                                              child: FutureBuilder(
                                                  future: productApiSevice
                                                      .getThumbnailByFilename(
                                                          offerProduct
                                                              .imageUrl),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Image.memory(
                                                        snapshot.data!,
                                                        fit: BoxFit.cover,
                                                        cacheHeight: 150,
                                                        cacheWidth: 150,
                                                      );
                                                    } else if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return Shimmer.fromColors(
                                                          baseColor:
                                                              Colors.grey[100]!,
                                                          highlightColor:
                                                              Colors.white,
                                                          child: Container(
                                                            color: Colors.white,
                                                          ));
                                                    } else {
                                                      return Icon(
                                                          Icons.broken_image);
                                                    }
                                                  }),
                                            ),
                                          ),
                                          Positioned(
                                              left: 0,
                                              top: 0,
                                              child: Container(
                                                padding: EdgeInsets.all(3),
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomRight: Radius
                                                                .circular(8),
                                                            topLeft:
                                                                Radius.circular(
                                                                    8))),
                                                child: Center(
                                                  child: Text(
                                                    "${offerProduct.discountPercent}% Off",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ))
                                        ],
                                      )),
                                  const SizedBox(height: 15),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Row(
                                      spacing: 10,
                                      children: [
                                        SizedBox(
                                          width: 70,
                                          child: Text(
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            offerProduct.name,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            offerProduct.categoryName,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  CommonColor.mediumGreyColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 120,
                                          child: Row(children: [
                                            Text(
                                              offerProduct.price.toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 12,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    CommonColor.darkGreyColor,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              child: Text(
                                                offerProduct.price.toString(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: CommonColor
                                                        .primaryColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ]),
                                        ),
                                        // const SizedBox(width: 8),
                                        InkWell(
                                          onTap: () {
                                            Provider.of<CartQuantityProvider>(
                                                    context,
                                                    listen: false)
                                                .addToCartFromOfferProducts(
                                                    offerProduct.sku.toString(),
                                                    context);
                                            logger.log(
                                                "tapped product id: ${offerProduct.sku}");
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                Future.delayed(
                                                    const Duration(seconds: 1),
                                                    () {
                                                  if (context.mounted) {
                                                    Navigator.pop(context);
                                                  }
                                                });
                                                return AlertDialog(
                                                  backgroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  title: Center(
                                                    child: Text(
                                                      "Item added to cart successfully!",
                                                      style: TextStyle(
                                                          color: CommonColor
                                                              .darkGreyColor,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Icon(
                                            MingCute.shopping_cart_1_line,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                // }
              })),
            )
          ],
        ));
  }
}
