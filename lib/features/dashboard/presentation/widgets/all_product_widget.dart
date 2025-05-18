import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/data/product_api_sevice.dart';
import 'package:order_management_system/features/dashboard/domain/cart_quantity_provider.dart';
import 'package:order_management_system/features/dashboard/domain/product_provider.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/home_screens/all_product_screen.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/widget_product_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:developer' as logger;
import 'package:order_management_system/localization/l10n.dart';

class AllProductWidget extends StatelessWidget {
  AllProductWidget({super.key});

  final productApiService = ProductApiSevice();

  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.current.allProducts,
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
                          builder: (context) => AllProductScreen()));
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
          Consumer<ProductProvider>(
              builder: (context, productProvider, children) {
            return productProvider.isWidgetProductLoading == true
                ? Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: CircularProgressIndicator(
                      color: CommonColor.primaryColor,
                    ))
                : productProvider.widgetProduct.isEmpty
                    ? Center(
                        child: Text(
                          "No products availiable",
                          style: TextStyle(
                              color: CommonColor.mediumGreyColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.75, crossAxisCount: 2),
                        itemCount: productProvider.widgetProduct.length > 10
                            ? 10
                            : productProvider.widgetProduct.length,
                        // itemCount: 3,
                        itemBuilder: (context, index) {
                          final product = productProvider.widgetProduct[index];
                          // productApiService
                          //     .getImageByFilename(product.imageUrl);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            WidgetProductDetailScreen(
                                                sku: product.sku.toString())));
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
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8)),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8),
                                          ),
                                          // child: CachedNetworkImage(
                                          //   //1:2 is best to load faster and smooth scrolling
                                          //   maxHeightDiskCache: 100,
                                          //   maxWidthDiskCache: 100,
                                          //   memCacheHeight: 200,
                                          //   memCacheWidth: 200,

                                          //   imageUrl: product.imageUrl,
                                          //   fit: BoxFit.cover,
                                          //   placeholder: (context, url) =>
                                          //       Shimmer.fromColors(
                                          //     baseColor: Colors.grey[300]!,
                                          //     highlightColor: Colors.grey[100]!,
                                          //     child: Container(
                                          //         color: Colors.grey[200]),
                                          //   ),
                                          //   errorWidget:
                                          //       (context, url, error) =>
                                          //           Icon(Icons.broken_image),
                                          // ),
                                          child: FutureBuilder(
                                              future: productApiService
                                                  .getThumbnailByFilename(
                                                      product.imageUrl),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  return Image.memory(
                                                    snapshot.data!,
                                                    fit: BoxFit.cover,
                                                    // cacheHeight: 120,
                                                    // cacheWidth: 120,
                                                  );
                                                } else if (snapshot
                                                        .connectionState ==
                                                    ConnectionState.waiting) {
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
                                    ),
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
                                              maxLines: 2,
                                              productProvider
                                                  .widgetProduct[index].name,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              productProvider
                                                  .widgetProduct[index]
                                                  .categoryName,
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
                                    const SizedBox(height: 7),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Rs.${productProvider.widgetProduct[index].price}",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: CommonColor.primaryColor,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          InkWell(
                                            onTap: () {
                                              Provider.of<CartQuantityProvider>(
                                                      context,
                                                      listen: false)
                                                  .addToCartFromWidgetProducts(
                                                      product.sku.toString(),
                                                      context);
                                              logger.log(
                                                  "tapped product id: ${product.sku}");
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  Future.delayed(
                                                      const Duration(
                                                          seconds: 1), () {
                                                    if (context.mounted) {
                                                      Navigator.pop(context);
                                                    }
                                                  });
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
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
          })
        ],
      ),
    );
  }
}
