// import 'package:flutter/material.dart';
// import 'package:icons_plus/icons_plus.dart';
// import 'package:order_management_system/common/common_color.dart';
// import 'package:order_management_system/features/dashboard/data/category_data.dart';
// import 'package:order_management_system/features/dashboard/domain/product_provider.dart';
// import 'package:provider/provider.dart';

// class CategoryDetailScreen extends StatelessWidget {
//   final String category;
//   final int index;
//   const CategoryDetailScreen(
//       {super.key, required this.category, required this.index});

//   @override
//   Widget build(BuildContext context) {
//     List categoryImages = [
//       "assets/images/electronic_c.png",
//       "assets/images/clothing_c.png",
//       "assets/images/furniture_c.png",
//       "assets/images/grocery_c.png",
//       "assets/images/stationary_c.png",
//       "assets/images/books_c.png",
//       "assets/images/toys_c.png",
//       "assets/images/sports_c.png",
//       "assets/images/automobile_c.png"
//     ];
//     return Scaffold(
//         backgroundColor: Colors.grey[100],
//         appBar: AppBar(
//           backgroundColor: CommonColor.primaryColor,
//           title: RichText(
//             text: TextSpan(
//               children: [
//                 TextSpan(
//                   text: category,
//                   style: TextStyle(
//                     fontSize: 22,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             // Text(
//             //   "Filter",
//             //   style: TextStyle(color: Colors.white),
//             // ),
//             Padding(
//               padding: EdgeInsets.only(right: 25),
//               child: Icon(
//                 Icons.filter_list,
//                 color: Colors.white,
//               ),
//             )
//           ],
//           leading: IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: Icon(
//                 Icons.arrow_back_ios,
//                 color: Colors.white,
//                 size: 20,
//               )),
//           centerTitle: true,
//           automaticallyImplyLeading: false,
//         ),
//         body: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 110,
//                 child: IntrinsicHeight(
//                   child: ListView.builder(
//                       itemCount: 5,
//                       scrollDirection: Axis.horizontal,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                             padding: const EdgeInsets.only(right: 5),
//                             child: Column(
//                               children: [
//                                 GestureDetector(
//                                     onTap: () {},
//                                     child: Padding(
//                                       padding: EdgeInsets.all(5),
//                                       child: Container(
//                                         // height: 90,
//                                         height: 70,
//                                         width: 80,
//                                         decoration: BoxDecoration(
//                                           boxShadow: [
//                                             BoxShadow(
//                                                 offset: Offset(0, 0),
//                                                 blurRadius: 3,
//                                                 color: Colors.grey),
//                                             // BoxShadow(
//                                             //     offset: Offset(-2, -2),
//                                             //     blurRadius: 1,
//                                             //     color: Colors.grey)
//                                           ],
//                                           border:
//                                               Border.all(color: Colors.white),
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                           color: Colors.white,
//                                         ),
//                                         // child: Center(
//                                         //     child: Text(
//                                         //   productProvider
//                                         //       .productCategoryWithoutAll[index].name,
//                                         //   style: TextStyle(
//                                         //       fontSize: 12,
//                                         //       color: CommonColor.darkGreyColor,
//                                         //       fontWeight: FontWeight.w600),
//                                         //   overflow: TextOverflow.ellipsis,
//                                         // )),
//                                         child: ClipRRect(
//                                             borderRadius:
//                                                 BorderRadius.circular(8),
//                                             child: Image.asset(
//                                               categoryImages[index],
//                                               fit: BoxFit.cover,
//                                             )),
//                                       ),
//                                     )),
//                                 SizedBox(
//                                   height: 4,
//                                 ),
//                                 Text(
//                                   "Sub Cat..",
//                                   maxLines: 1,
//                                   style: TextStyle(
//                                       fontSize: 12,
//                                       color: CommonColor.darkGreyColor,
//                                       fontWeight: FontWeight.w600),
//                                   overflow: TextOverflow.ellipsis,
//                                 )
//                               ],
//                             ));
//                       }),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Expanded(
//                 child: GridView.builder(
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         childAspectRatio: 0.75, crossAxisCount: 2),
//                     itemCount: 5,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: GestureDetector(
//                           onTap: () {},
//                           child: Container(
//                             width: 160,
//                             height: 200,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8),
//                               color: Colors.white,
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   decoration: BoxDecoration(
//                                     color: const Color(0XFFFAFAFA),
//                                     borderRadius: const BorderRadius.vertical(
//                                       top: Radius.circular(8),
//                                     ),
//                                   ),
//                                   height: 130,
//                                   width: double.infinity,
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(8),
//                                         topRight: Radius.circular(8)),
//                                     child: Image.asset(
//                                       "assets/images/book.jpeg",
//                                       fit: BoxFit.cover,
//                                       errorBuilder:
//                                           (context, error, stackTrace) =>
//                                               Icon(Icons.broken_image),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 15),
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(horizontal: 8),
//                                   child: Row(
//                                     spacing: 10,
//                                     children: [
//                                       Text(
//                                         overflow: TextOverflow.ellipsis,
//                                         maxLines: 2,
//                                         "Book",
//                                         textAlign: TextAlign.start,
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                       Expanded(
//                                         child: Text(
//                                           "Stationary",
//                                           overflow: TextOverflow.ellipsis,
//                                           maxLines: 1,
//                                           style: TextStyle(
//                                             fontSize: 11,
//                                             fontWeight: FontWeight.bold,
//                                             color: CommonColor.mediumGreyColor,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 const SizedBox(height: 7),
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(horizontal: 8),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       SizedBox(
//                                         width: 100,
//                                         child: Text(
//                                           "Rs.500",
//                                           maxLines: 2,
//                                           overflow: TextOverflow.ellipsis,
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             color: CommonColor.primaryColor,
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(width: 8),
//                                       Icon(
//                                         MingCute.shopping_cart_1_line,
//                                         color: Colors.black87,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//               )
//             ],
//           ),
//         ));
//   }
// }

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/data/product_api_sevice.dart';
import 'package:order_management_system/features/dashboard/domain/cart_quantity_provider.dart';
import 'package:order_management_system/features/dashboard/domain/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:developer' as logger;

class CategoryDetailScreen extends StatefulWidget {
  final String category;
  final int index;
  const CategoryDetailScreen(
      {super.key, required this.category, required this.index});

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      if (!mounted) return;

      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      // await productProvider.getAllProductCategories();
      // await productProvider.getAllProduct();
      await productProvider.getCategoryProducts(
          widget.index); // Fetch products for category ID 1 initially
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    List categoryImages = [
      "assets/images/electronic_c.png",
      "assets/images/clothing_c.png",
      "assets/images/furniture_c.png",
      "assets/images/grocery_c.png",
      "assets/images/stationary_c.png",
      "assets/images/books_c.png",
      "assets/images/toys_c.png",
      "assets/images/sports_c.png",
      "assets/images/automobile_c.png"
    ];
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: CommonColor.primaryColor,
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.category,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            // Text(
            //   "Filter",
            //   style: TextStyle(color: Colors.white),
            // ),
            Padding(
              padding: EdgeInsets.only(right: 25),
              child: Icon(
                Icons.filter_list,
                color: Colors.white,
              ),
            )
          ],
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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              SizedBox(
                height: 110,
                child: IntrinsicHeight(
                  child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Container(
                                    // height: 90,
                                    height: 70,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0, 0),
                                            blurRadius: 3,
                                            color: Colors.grey),
                                        // BoxShadow(
                                        //     offset: Offset(-2, -2),
                                        //     blurRadius: 1,
                                        //     color: Colors.grey)
                                      ],
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
                                    ),
                                    // child: Center(
                                    //     child: Text(
                                    //   productProvider
                                    //       .productCategoryWithoutAll[index].name,
                                    //   style: TextStyle(
                                    //       fontSize: 12,
                                    //       color: CommonColor.darkGreyColor,
                                    //       fontWeight: FontWeight.w600),
                                    //   overflow: TextOverflow.ellipsis,
                                    // )),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          categoryImages[index],
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                )),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "Sub Cat..",
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: CommonColor.darkGreyColor,
                                  fontWeight: FontWeight.w600),
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        );
                      }),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: productProvider.isCategoryProductLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: CommonColor.primaryColor,
                        ),
                      )
                    : productProvider.categoryProducts.isEmpty
                        ? Center(
                            child: Text(
                              "No products found",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            child: GridView.builder(
                              itemCount:
                                  productProvider.categoryProducts.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 0.75,
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                              ),
                              itemBuilder: (context, index) {
                                final product =
                                    productProvider.categoryProducts[index];
                                final productApiService = ProductApiSevice();
                                // logger.log(
                                //     "built image url: ${product.imageUrl}");
                                return Consumer<CartQuantityProvider>(
                                  builder: (context, provider, child) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                              child: FutureBuilder<Uint8List>(
                                                future: productApiService
                                                    .getImageByFilename(
                                                        product.imageUrl),
                                                builder: (context, snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return Center(
                                                        child:
                                                            Shimmer.fromColors(
                                                      baseColor:
                                                          Colors.grey[300]!,
                                                      highlightColor:
                                                          Colors.grey[100]!,
                                                      child: Container(
                                                        color: Colors.red,
                                                      ),
                                                    ));
                                                  } else if (snapshot
                                                      .hasError) {
                                                    return Icon(
                                                        Icons.broken_image);
                                                  } else if (snapshot.hasData) {
                                                    return ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(8),
                                                              topRight: Radius
                                                                  .circular(8)),
                                                      child: Image.memory(
                                                        snapshot.data!,
                                                        fit: BoxFit.cover,
                                                        errorBuilder: (context,
                                                                error,
                                                                stackTrace) =>
                                                            Icon(Icons
                                                                .broken_image),
                                                      ),
                                                    );
                                                  } else {
                                                    return Icon(
                                                        Icons.broken_image);
                                                  }
                                                },
                                              )),
                                          const SizedBox(height: 15),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 100,
                                                    child: Text(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      product.name,
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      product.categoryName,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: CommonColor
                                                            .mediumGreyColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          const SizedBox(height: 7),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 100,
                                                  child: Text(
                                                    "Rs. ${product.price}",
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: CommonColor
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        Future.delayed(
                                                            const Duration(
                                                                seconds: 1),
                                                            () {
                                                          if (context.mounted) {
                                                            Navigator.pop(
                                                                context);
                                                          }
                                                        });
                                                        return AlertDialog(
                                                          backgroundColor:
                                                              Colors.white,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
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
                                                            product.sku
                                                                .toString(),
                                                            context);
                                                    logger.log(
                                                        "tapped product sku: ${product.sku}");
                                                  },
                                                  child: Icon(
                                                    MingCute
                                                        .shopping_cart_1_line,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
              ),
            ],
          ),
        ));
  }
}
