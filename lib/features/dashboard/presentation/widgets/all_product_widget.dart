import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/data/product_api_sevice.dart';
import 'package:order_management_system/features/dashboard/domain/cart_quantity_provider.dart';
import 'package:order_management_system/features/dashboard/domain/product_provider.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/home_screens/all_product_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:developer' as logger;

class AllProductWidget extends StatelessWidget {
  const AllProductWidget({super.key});

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
                "All Products",
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
                  "See all",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: CommonColor.primaryColor),
                ),
              )
            ],
          ),
          Consumer<ProductProvider>(
              builder: (context, productProvider, children) {
            return productProvider.isCategoryProductLoading == true
                ? Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: CircularProgressIndicator(
                      color: CommonColor.primaryColor,
                    ))
                : productProvider.product.isEmpty
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
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          final productApiService = ProductApiSevice();
                          final product = productProvider.product[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {},
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
                                          // child: Image.network(
                                          //   productProvider.product[index].imageUrl,
                                          //   fit: BoxFit.cover,
                                          //   errorBuilder:
                                          //       (context, error, stackTrace) =>
                                          //           Icon(Icons.broken_image),
                                          // ),
                                          child: FutureBuilder<Uint8List>(
                                            future: productApiService
                                                .getImageByFilename(
                                                    product.imageUrl),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return Center(
                                                    child: Shimmer.fromColors(
                                                  baseColor: Colors.grey[300]!,
                                                  highlightColor:
                                                      Colors.grey[100]!,
                                                  child: Container(
                                                    color: Colors.red,
                                                  ),
                                                ));
                                              } else if (snapshot.hasError) {
                                                return Icon(Icons.broken_image);
                                              } else if (snapshot.hasData) {
                                                return ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft: Radius
                                                              .circular(8),
                                                          topRight:
                                                              Radius.circular(
                                                                  8)),
                                                  child: Image.memory(
                                                    snapshot.data!,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        Icon(
                                                            Icons.broken_image),
                                                  ),
                                                );
                                              } else {
                                                return Icon(Icons.broken_image);
                                              }
                                            },
                                          )),
                                    ),
                                    const SizedBox(height: 15),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Row(
                                        spacing: 10,
                                        children: [
                                          Text(
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            productProvider.product[index].name,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              productProvider
                                                  .product[index].categoryName,
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
                                          SizedBox(
                                            width: 100,
                                            child: Text(
                                              "Rs.${productProvider.product[index].price}",
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
                                              Provider.of<CartQuantityProvider>(
                                                      context,
                                                      listen: false)
                                                  .addToCart(
                                                      product.sku.toString(),
                                                      context);
                                              logger.log(
                                                  "tapped product id: ${product.sku}");
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
