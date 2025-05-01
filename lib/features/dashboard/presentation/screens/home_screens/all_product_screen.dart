// import 'dart:async';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:icons_plus/icons_plus.dart';
// import 'package:keyboard_dismisser/keyboard_dismisser.dart';
// import 'package:order_management_system/common/common_color.dart';
// import 'package:order_management_system/features/dashboard/data/product_api_sevice.dart';
// import 'package:order_management_system/features/dashboard/domain/cart_quantity_provider.dart';
// import 'package:order_management_system/features/dashboard/domain/product_provider.dart';
// import 'package:order_management_system/features/dashboard/presentation/screens/all_product_detail_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:shimmer/shimmer.dart';
// import 'dart:developer' as logger;

// class AllProductScreen extends StatefulWidget {
//   const AllProductScreen({super.key});

//   @override
//   State<AllProductScreen> createState() => _AllProductScreenState();
// }

// class _AllProductScreenState extends State<AllProductScreen>
//     {

//   final ScrollController scrollController = ScrollController();
//   final SearchController searchController = SearchController();
//   Timer? debounce;

//   @override
//   void initState() {
//     scrollController.addListener(onScroll);
//     Future.delayed(Duration.zero, () async {
//       if (!mounted) {
//         return;
//       }
//       final productProvider =
//           Provider.of<ProductProvider>(context, listen: false);
//       // if (productProvider.product.isEmpty) {
//         productProvider.resetAllProducts();
//         await productProvider.getAllProduct("");
//       // }
//     });
//     super.initState();
//   }

//   int pageSize = 20;

//   void onScroll() {
//     final productProvider =
//         Provider.of<ProductProvider>(context, listen: false);
//     if (scrollController.position.pixels ==
//         scrollController.position.maxScrollExtent) {
//       productProvider.getAllProduct(searchController.text.trim());
//     }
//   }

//   @override
//   void dispose() {
//     scrollController.dispose();
//     searchController.dispose();
//     debounce?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return KeyboardDismisser(
//       child: Scaffold(
//         backgroundColor: CommonColor.scaffoldbackgroundColor,
//         appBar: AppBar(
//           backgroundColor: CommonColor.primaryColor,
//           title: RichText(
//             text: const TextSpan(
//               children: [
//                 TextSpan(
//                   text: "All Products",
//                   style: TextStyle(
//                     fontSize: 22,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           leading: IconButton(
//               onPressed: () {
//                 // final productProvider =
//                 //     Provider.of<ProductProvider>(context, listen: false);
//                 // productProvider.resetAllProducts();
//                 // productProvider.getAllProduct("");
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
//         body: RefreshIndicator(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           edgeOffset: 2,
//           color: CommonColor.primaryColor,
//           onRefresh: () async {
//             final productProvider =
//                 Provider.of<ProductProvider>(context, listen: false);
//             productProvider.resetAllProducts();
//             await productProvider.getAllProduct("");
//           },
//           child: Padding(
//             padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//             child: Consumer<ProductProvider>(
//                 builder: (context, productProvider, children) {
//               return Column(
//                 children: [
//                   TextFormField(
//                     controller: searchController,
//                     onChanged: (value) {
//                       if (debounce?.isActive ?? false) {
//                         debounce!.cancel();
//                       }
//                       debounce = Timer(Duration(seconds: 1), () {
//                         // logger.log(searchController.text.trim());
//                         productProvider.resetAllProducts();
//                         productProvider
//                             .getAllProduct(searchController.text.trim());
//                       });
//                     },
//                     onFieldSubmitted: (value) {
//                       debounce?.cancel();
//                       logger.log(searchController.text.trim());
//                       productProvider.resetAllProducts();
//                       productProvider
//                           .getAllProduct(searchController.text.trim());
//                     },
//                     decoration: InputDecoration(
//                       contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 10, vertical: 15),
//                       fillColor: Colors.white,
//                       filled: true,
//                       hintText: "What are you looking for?",
//                       hintStyle: TextStyle(
//                         color: CommonColor.darkGreyColor,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                       prefixIcon: Icon(
//                         Icons.search,
//                         size: 23,
//                         color: CommonColor.primaryColor,
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: BorderSide(color: Colors.transparent),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: BorderSide(
//                             color: CommonColor.primaryColor, width: 2),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   productProvider.isProductLoading == true &&
//                           productProvider.product.isEmpty
//                       ? Padding(
//                           padding: EdgeInsets.only(top: 20),
//                           child: Center(
//                             child: CircularProgressIndicator(
//                               color: CommonColor.primaryColor,
//                             ),
//                           ))
//                       : productProvider.product.isEmpty
//                           ? Expanded(
//                               child: Center(
//                                   child: Text(
//                                 "No products found!",
//                                 style: TextStyle(
//                                     color: CommonColor.darkGreyColor,
//                                     fontSize: 20),
//                               )),
//                             )
//                           : Expanded(
//                               child: GridView.builder(
//                                   controller: scrollController,
//                                   physics: AlwaysScrollableScrollPhysics(),
//                                   gridDelegate:
//                                       SliverGridDelegateWithFixedCrossAxisCount(
//                                           childAspectRatio: 0.75,
//                                           crossAxisCount: 2),
//                                   itemCount: productProvider.product.length + 1,
//                                   itemBuilder: (context, index) {
//                                     if (index <
//                                         productProvider.product.length) {
//                                       final productApiService =
//                                           ProductApiSevice();
//                                       final product =
//                                           productProvider.product[index];
//                                       return Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: GestureDetector(
//                                           onTap: () {
//                                             Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         AllProductDetailScreen(
//                                                             sku: product.sku
//                                                                 .toString())));
//                                           },
//                                           child: Container(
//                                             width: 160,
//                                             height: 200,
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(8),
//                                               color: Colors.white,
//                                             ),
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Container(
//                                                   decoration: BoxDecoration(
//                                                     color:
//                                                         const Color(0XFFFAFAFA),
//                                                     borderRadius:
//                                                         const BorderRadius
//                                                             .vertical(
//                                                       top: Radius.circular(8),
//                                                     ),
//                                                   ),
//                                                   height: 130,
//                                                   width: double.infinity,
//                                                   child: ClipRRect(
//                                                       borderRadius:
//                                                           BorderRadius.only(
//                                                               topLeft: Radius
//                                                                   .circular(8),
//                                                               topRight: Radius
//                                                                   .circular(8)),
//                                                       // child: Image.network(
//                                                       //   productProvider.product[index].imageUrl,
//                                                       //   fit: BoxFit.cover,
//                                                       //   errorBuilder:
//                                                       //       (context, error, stackTrace) =>
//                                                       //           Icon(Icons.broken_image),
//                                                       // ),
//                                                       child: FutureBuilder<
//                                                           Uint8List>(
//                                                         future: productApiService
//                                                             .getImageByFilename(
//                                                                 product
//                                                                     .imageUrl),
//                                                         builder: (context,
//                                                             snapshot) {
//                                                           if (snapshot
//                                                                   .connectionState ==
//                                                               ConnectionState
//                                                                   .waiting) {
//                                                             return Center(
//                                                                 child: Shimmer
//                                                                     .fromColors(
//                                                               baseColor: Colors
//                                                                   .grey[300]!,
//                                                               highlightColor:
//                                                                   Colors.grey[
//                                                                       100]!,
//                                                               child: Container(
//                                                                 color:
//                                                                     Colors.red,
//                                                               ),
//                                                             ));
//                                                           } else if (snapshot
//                                                               .hasError) {
//                                                             return Icon(Icons
//                                                                 .broken_image);
//                                                           } else if (snapshot
//                                                               .hasData) {
//                                                             return ClipRRect(
//                                                               borderRadius: BorderRadius.only(
//                                                                   topLeft: Radius
//                                                                       .circular(
//                                                                           8),
//                                                                   topRight: Radius
//                                                                       .circular(
//                                                                           8)),
//                                                               child:
//                                                                   Image.memory(
//                                                                 snapshot.data!,
//                                                                 fit: BoxFit
//                                                                     .cover,
//                                                                 errorBuilder: (context,
//                                                                         error,
//                                                                         stackTrace) =>
//                                                                     Icon(Icons
//                                                                         .broken_image),
//                                                               ),
//                                                             );
//                                                           } else {
//                                                             return Icon(Icons
//                                                                 .broken_image);
//                                                           }
//                                                         },
//                                                       )),
//                                                 ),
//                                                 const SizedBox(height: 15),
//                                                 Padding(
//                                                   padding: const EdgeInsets
//                                                       .symmetric(horizontal: 8),
//                                                   child: Row(
//                                                     spacing: 10,
//                                                     children: [
//                                                       Expanded(
//                                                         child: Text(
//                                                           overflow: TextOverflow
//                                                               .ellipsis,
//                                                           maxLines: 2,
//                                                           productProvider
//                                                               .product[index]
//                                                               .name,
//                                                           textAlign:
//                                                               TextAlign.start,
//                                                           style: TextStyle(
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                             fontSize: 14,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       Expanded(
//                                                         child: Text(
//                                                           productProvider
//                                                               .product[index]
//                                                               .categoryName,
//                                                           overflow: TextOverflow
//                                                               .ellipsis,
//                                                           maxLines: 1,
//                                                           style: TextStyle(
//                                                             fontSize: 11,
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                             color: CommonColor
//                                                                 .mediumGreyColor,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 const SizedBox(height: 7),
//                                                 Padding(
//                                                   padding: const EdgeInsets
//                                                       .symmetric(horizontal: 8),
//                                                   child: Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceBetween,
//                                                     children: [
//                                                       Expanded(
//                                                         child: Text(
//                                                           "Rs.${productProvider.product[index].price}",
//                                                           maxLines: 2,
//                                                           overflow: TextOverflow
//                                                               .ellipsis,
//                                                           style: TextStyle(
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                             color: CommonColor
//                                                                 .primaryColor,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       const SizedBox(width: 8),
//                                                       InkWell(
//                                                         onTap: () {
//                                                           Provider.of<CartQuantityProvider>(
//                                                                   context,
//                                                                   listen: false)
//                                                               .addToCartFromAllProducts(
//                                                                   product.sku
//                                                                       .toString(),
//                                                                   context);
//                                                           logger.log(
//                                                               "tapped product id: ${product.sku}");
//                                                           showDialog(
//                                                             context: context,
//                                                             builder: (context) {
//                                                               Future.delayed(
//                                                                   const Duration(
//                                                                       seconds:
//                                                                           1),
//                                                                   () {
//                                                                 if (context
//                                                                     .mounted) {
//                                                                   Navigator.pop(
//                                                                       context);
//                                                                 }
//                                                               });
//                                                               return AlertDialog(
//                                                                 backgroundColor:
//                                                                     Colors
//                                                                         .white,
//                                                                 shape:
//                                                                     RoundedRectangleBorder(
//                                                                   borderRadius:
//                                                                       BorderRadius
//                                                                           .circular(
//                                                                               15),
//                                                                 ),
//                                                                 title: Center(
//                                                                   child: Text(
//                                                                     "Item added to cart successfully!",
//                                                                     style: TextStyle(
//                                                                         color: CommonColor
//                                                                             .darkGreyColor,
//                                                                         fontSize:
//                                                                             14),
//                                                                   ),
//                                                                 ),
//                                                               );
//                                                             },
//                                                           );
//                                                         },
//                                                         child: Icon(
//                                                           MingCute
//                                                               .shopping_cart_1_line,
//                                                           color: Colors.black87,
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       );
//                                     } else {
//                                       return productProvider
//                                                   .hasMoreAllProduct &&
//                                               productProvider.product.length >=
//                                                   pageSize
//                                           ? Center(
//                                               child: SizedBox(
//                                                   height: 30,
//                                                   width: 30,
//                                                   child:
//                                                       CircularProgressIndicator(
//                                                     color: CommonColor
//                                                         .primaryColor,
//                                                   )),
//                                             )
//                                           // : Column(
//                                           //     mainAxisAlignment: MainAxisAlignment.start,
//                                           //     children: [
//                                           //       SizedBox(
//                                           //         height: 10,
//                                           //       ),
//                                           //       Text(
//                                           //         "No more products!",
//                                           //         style: TextStyle(
//                                           //             color: Colors.grey, fontSize: 16),
//                                           //       ),
//                                           //     ],
//                                           //   );
//                                           : SizedBox.shrink();
//                                     }
//                                   }),
//                             ),
//                 ],
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/data/product_api_sevice.dart';
import 'package:order_management_system/features/dashboard/domain/cart_quantity_provider.dart';
import 'package:order_management_system/features/dashboard/domain/product_provider.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/all_product_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:developer' as logger;

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  final ScrollController scrollController = ScrollController();
  final SearchController searchController = SearchController();
  Timer? debounce;
  final productApiService = ProductApiSevice();

  @override
  void initState() {
    scrollController.addListener(onScroll);
    Future.delayed(Duration.zero, () async {
      if (!mounted) {
        return;
      }
      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      // if (productProvider.product.isEmpty) {
      productProvider.resetAllProducts();
      await productProvider.getAllProduct("");
      // }
    });
    super.initState();
  }

  int pageSize = 20;

  void onScroll() {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      productProvider.getAllProduct(searchController.text.trim());
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.dispose();
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: CommonColor.scaffoldbackgroundColor,
        appBar: AppBar(
          backgroundColor: CommonColor.primaryColor,
          title: RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: "All Products",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          leading: IconButton(
              onPressed: () {
                // final productProvider =
                //     Provider.of<ProductProvider>(context, listen: false);
                // productProvider.resetAllProducts();
                // productProvider.getAllProduct("");
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
        body: RefreshIndicator(
          backgroundColor: Colors.white,
          elevation: 0,
          edgeOffset: 2,
          color: CommonColor.primaryColor,
          onRefresh: () async {
            final productProvider =
                Provider.of<ProductProvider>(context, listen: false);
            productProvider.resetAllProducts();
            await productProvider.getAllProduct("");
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Consumer<ProductProvider>(
                builder: (context, productProvider, children) {
              return Column(
                children: [
                  TextFormField(
                    controller: searchController,
                    onChanged: (value) {
                      if (debounce?.isActive ?? false) {
                        debounce!.cancel();
                      }
                      debounce = Timer(Duration(seconds: 1), () {
                        // logger.log(searchController.text.trim());
                        productProvider.resetAllProducts();
                        productProvider
                            .getAllProduct(searchController.text.trim());
                      });
                    },
                    onFieldSubmitted: (value) {
                      debounce?.cancel();
                      logger.log(searchController.text.trim());
                      productProvider.resetAllProducts();
                      productProvider
                          .getAllProduct(searchController.text.trim());
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "What are you looking for?",
                      hintStyle: TextStyle(
                        color: CommonColor.darkGreyColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 23,
                        color: CommonColor.primaryColor,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: CommonColor.primaryColor, width: 2),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  productProvider.isProductLoading == true &&
                          productProvider.product.isEmpty
                      ? Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: CommonColor.primaryColor,
                            ),
                          ))
                      : productProvider.product.isEmpty
                          ? Expanded(
                              child: Center(
                                  child: Text(
                                "No products found!",
                                style: TextStyle(
                                    color: CommonColor.darkGreyColor,
                                    fontSize: 20),
                              )),
                            )
                          : Expanded(
                              child: GridView.builder(
                                  controller: scrollController,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 0.75,
                                          crossAxisCount: 2),
                                  itemCount: productProvider.product.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index <
                                        productProvider.product.length) {
                                      final product =
                                          productProvider.product[index];
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
                                                        AllProductDetailScreen(
                                                            sku: product.sku
                                                                .toString())));
                                          },
                                          child: Container(
                                            width: 160,
                                            height: 200,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Colors.white,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0XFFFAFAFA),
                                                    borderRadius:
                                                        const BorderRadius
                                                            .vertical(
                                                      top: Radius.circular(8),
                                                    ),
                                                  ),
                                                  height: 130,
                                                  width: double.infinity,
                                                  // child: ClipRRect(
                                                  //     borderRadius:
                                                  //         BorderRadius.only(
                                                  //             topLeft: Radius
                                                  //                 .circular(8),
                                                  //             topRight: Radius
                                                  //                 .circular(8)),
                                                  //     // child: Image.network(
                                                  //     //   productProvider.product[index].imageUrl,
                                                  //     //   fit: BoxFit.cover,
                                                  //     //   errorBuilder:
                                                  //     //       (context, error, stackTrace) =>
                                                  //     //           Icon(Icons.broken_image),
                                                  //     // ),
                                                  //     child: FutureBuilder<
                                                  //         Uint8List>(
                                                  //       future: productApiService
                                                  //           .getImageByFilename(
                                                  //               product
                                                  //                   .imageUrl),
                                                  //       builder: (context,
                                                  //           snapshot) {
                                                  //         if (snapshot
                                                  //                 .connectionState ==
                                                  //             ConnectionState
                                                  //                 .waiting) {
                                                  //           return Center(
                                                  //               child: Shimmer
                                                  //                   .fromColors(
                                                  //             baseColor: Colors
                                                  //                 .grey[300]!,
                                                  //             highlightColor:
                                                  //                 Colors.grey[
                                                  //                     100]!,
                                                  //             child: Container(
                                                  //               color:
                                                  //                   Colors.red,
                                                  //             ),
                                                  //           ));
                                                  //         } else if (snapshot
                                                  //             .hasError) {
                                                  //           return Icon(Icons
                                                  //               .broken_image);
                                                  //         } else if (snapshot
                                                  //             .hasData) {
                                                  //           return ClipRRect(
                                                  //             borderRadius: BorderRadius.only(
                                                  //                 topLeft: Radius
                                                  //                     .circular(
                                                  //                         8),
                                                  //                 topRight: Radius
                                                  //                     .circular(
                                                  //                         8)),
                                                  //             child:
                                                  //                 Image.memory(
                                                  //               snapshot.data!,
                                                  //               fit: BoxFit
                                                  //                   .cover,
                                                  //               errorBuilder: (context,
                                                  //                       error,
                                                  //                       stackTrace) =>
                                                  //                   Icon(Icons
                                                  //                       .broken_image),
                                                  //             ),
                                                  //           );
                                                  //         } else {
                                                  //           return Icon(Icons
                                                  //               .broken_image);
                                                  //         }
                                                  //       },
                                                  //     )),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(8),
                                                      topRight:
                                                          Radius.circular(8),
                                                    ),
                                                    child: CachedNetworkImage(
                                                      maxHeightDiskCache: 100,
                                                      maxWidthDiskCache: 100,
                                                      memCacheHeight: 200,
                                                      memCacheWidth: 200,
                                                      imageUrl:
                                                          product.imageUrl,
                                                      fit: BoxFit.cover,
                                                      placeholder: (context,
                                                              url) =>
                                                          Shimmer.fromColors(
                                                        baseColor:
                                                            Colors.grey[300]!,
                                                        highlightColor:
                                                            Colors.grey[100]!,
                                                        child: Container(
                                                            color: Colors
                                                                .grey[200]),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons
                                                              .broken_image),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 15),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  child: Row(
                                                    spacing: 10,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 2,
                                                          productProvider
                                                              .product[index]
                                                              .name,
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
                                                          productProvider
                                                              .product[index]
                                                              .categoryName,
                                                          overflow: TextOverflow
                                                              .ellipsis,
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
                                                  ),
                                                ),
                                                const SizedBox(height: 7),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          "Rs.${productProvider.product[index].price}",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: CommonColor
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      InkWell(
                                                        onTap: () {
                                                          Provider.of<CartQuantityProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .addToCartFromAllProducts(
                                                                  product.sku
                                                                      .toString(),
                                                                  context);
                                                          logger.log(
                                                              "tapped product id: ${product.sku}");
                                                          showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              Future.delayed(
                                                                  const Duration(
                                                                      seconds:
                                                                          1),
                                                                  () {
                                                                if (context
                                                                    .mounted) {
                                                                  Navigator.pop(
                                                                      context);
                                                                }
                                                              });
                                                              return AlertDialog(
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
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
                                                                        fontSize:
                                                                            14),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
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
                                          ),
                                        ),
                                      );
                                    } else {
                                      return productProvider
                                                  .hasMoreAllProduct &&
                                              productProvider.product.length >=
                                                  pageSize
                                          ? Center(
                                              child: SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: CommonColor
                                                        .primaryColor,
                                                  )),
                                            )
                                          // : Column(
                                          //     mainAxisAlignment: MainAxisAlignment.start,
                                          //     children: [
                                          //       SizedBox(
                                          //         height: 10,
                                          //       ),
                                          //       Text(
                                          //         "No more products!",
                                          //         style: TextStyle(
                                          //             color: Colors.grey, fontSize: 16),
                                          //       ),
                                          //     ],
                                          //   );
                                          : SizedBox.shrink();
                                    }
                                  }),
                            ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
