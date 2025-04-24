//Search screen without pagination

// import 'dart:async';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:icons_plus/icons_plus.dart';
// import 'package:keyboard_dismisser/keyboard_dismisser.dart';
// import 'package:order_management_system/common/common_color.dart';
// import 'package:order_management_system/features/dashboard/data/product_api_sevice.dart';
// import 'package:order_management_system/features/dashboard/domain/cart_quantity_provider.dart';
// import 'package:order_management_system/features/dashboard/domain/product_provider.dart';
// import 'package:order_management_system/features/dashboard/domain/tab_bar_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:shimmer/shimmer.dart';
// import 'dart:developer' as logger;

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   // final ScrollController scrollController = ScrollController();
//   final TextEditingController searchController = SearchController();
//   Timer? debounce;

//   @override
//   void initState() {
//     super.initState();
//     // scrollController.addListener(onScroll);

//     // Focus on the search field when screen loads
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       // Fetch product categories after the screen is built
//       Future.delayed(Duration.zero, () async {
//         if (!mounted) return;
//         final TabBarProvider tabBarProvider =
//             Provider.of(context, listen: false);
//         tabBarProvider.clearSelectedIndex();
//         tabBarProvider.clearSearchKeyword();
//         tabBarProvider.resetCategoryId();
//         final productProvider =
//             Provider.of<ProductProvider>(context, listen: false);
//         await productProvider.getAllProductCategories();
//         productProvider.resetCategoryProducts();
//         await productProvider.getCategoryProducts(0, "",
//             reset: true); // Fetch products for category ID 1 initially
//       });
//     });
//   }

//   // int pageSize = 20;
//   // void onScroll() {
//   //   if (scrollController.position.pixels ==
//   //       scrollController.position.maxScrollExtent) {
//   //     final tabBarProvider =
//   //         Provider.of<TabBarProvider>(context, listen: false);
//   //     Provider.of<ProductProvider>(context, listen: false).getCategoryProducts(
//   //         tabBarProvider.currentCategoryId, searchController.text.trim());
//   //   }
//   // }

//   // void onScroll() {
//   //   final productProvider =
//   //       Provider.of<ProductProvider>(context, listen: false);
//   //   if (scrollController.position.pixels ==
//   //           scrollController.position.maxScrollExtent &&
//   //       productProvider.hasMoreCategoryProducts &&
//   //       !productProvider.isCategoryProductLoading) {
//   //     productProvider.getAllProduct("");
//   //   }
//   // }

//   @override
//   void dispose() {
//     // scrollController.dispose();
//     searchController.dispose();
//     debounce?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final productProvider = Provider.of<ProductProvider>(context);
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Consumer<TabBarProvider>(
//       builder: (context, tabBarProvider, _) {
//         return KeyboardDismisser(
//           child: DefaultTabController(
//             length: productProvider.productCategory.length,
//             initialIndex: 0,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: CommonColor.commonGreyColor,
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(25),
//                   topRight: Radius.circular(25),
//                 ),
//               ),
//               height: screenHeight * 0.8,
//               child: Column(
//                 children: [
//                   SizedBox(height: screenHeight * 0.01),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Icon(Icons.cancel, color: Colors.transparent),
//                         const Center(
//                           child: Text(
//                             "Product Catalog",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w800, fontSize: 20),
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           icon: Icon(
//                             Icons.close,
//                             color: CommonColor.primaryColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const Divider(),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 20, vertical: 10),
//                     child: TextFormField(
//                       controller: searchController,
//                       onChanged: (value) {
//                         if (debounce?.isActive ?? false) {
//                           debounce!.cancel();
//                         }
//                         debounce = Timer(Duration(seconds: 1), () {
//                           // logger.log(searchController.text.trim());
//                           productProvider.getCategoryProducts(
//                               reset: true,
//                               tabBarProvider.currentCategoryId,
//                               searchController.text.trim());
//                         });
//                       },
//                       onFieldSubmitted: (value) {
//                         // logger.log(searchController.text.trim());
//                         // productProvider.getCategoryProducts(
//                         //     reset: true,
//                         //     tabBarProvider.currentCategoryId,
//                         //     searchController.text.trim());
//                       },
//                       decoration: InputDecoration(
//                         contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 15),
//                         fillColor: Colors.white,
//                         filled: true,
//                         hintText: "What are you looking for?",
//                         hintStyle: TextStyle(
//                           color: CommonColor.darkGreyColor,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                         prefixIcon: Icon(
//                           Icons.search,
//                           size: 23,
//                           color: CommonColor.primaryColor,
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide(color: Colors.transparent),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide(
//                               color: CommonColor.primaryColor, width: 2),
//                         ),
//                       ),
//                     ),
//                   ),
//                   productProvider.isCategoryLoading
//                       ? Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 20),
//                           child: Shimmer.fromColors(
//                             baseColor: Colors.grey[200]!,
//                             highlightColor: Colors.white,
//                             child: Container(
//                               color: Colors.white,
//                               height: 40,
//                               width: double.infinity,
//                             ),
//                           ),
//                         )
//                       : TabBar(
//                           indicatorSize: TabBarIndicatorSize.tab,
//                           unselectedLabelColor: CommonColor.darkGreyColor,
//                           indicatorColor: CommonColor.primaryColor,
//                           labelColor: CommonColor.primaryColor,
//                           labelPadding:
//                               const EdgeInsets.symmetric(horizontal: 25),
//                           isScrollable: true,
//                           tabAlignment: TabAlignment.start,
//                           onTap: (index) {
//                             searchController.clear();
//                             productProvider.resetCategoryProducts();
//                             tabBarProvider.selectTab(index);
//                             final selectedCategory =
//                                 productProvider.productCategory[index];
//                             tabBarProvider
//                                 .updateCurrentCategoryId(selectedCategory.id);
//                             if (!context.mounted) {
//                               return;
//                             }

//                             if (selectedCategory.id == 0) {
//                               // If "All" category is selected, fetch all products
//                               productProvider.getCategoryProducts(0, "",
//                                   reset: true);
//                             } else {
//                               // Otherwise, fetch products for the selected category
//                               productProvider.getCategoryProducts(
//                                   selectedCategory.id, "",
//                                   reset: true);
//                             }
//                           },
//                           tabs: productProvider.productCategory
//                               .map(
//                                 (tab) => Tab(
//                                   child: Text(
//                                     tab.name,
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 17),
//                                   ),
//                                 ),
//                               )
//                               .toList(),
//                         ),
//                   const SizedBox(height: 20),
//                   Expanded(
//                     child: productProvider.isCategoryProductLoading &&
//                             productProvider.categoryProducts.isEmpty
//                         ? Center(
//                             child: CircularProgressIndicator(
//                               color: CommonColor.primaryColor,
//                             ),
//                           )
//                         : productProvider.categoryProducts.isEmpty
//                             ? Center(
//                                 child: Text(
//                                   "No products found",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.grey[600],
//                                   ),
//                                 ),
//                               )
//                             : Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 20),
//                                 child: GridView.builder(
//                                   // controller: scrollController,
//                                   itemCount:
//                                       productProvider.categoryProducts.length,
//                                   // itemCount: productProvider
//                                   //         .categoryProducts.length +
//                                   //     (productProvider
//                                   //                 .hasMoreCategoryProducts &&
//                                   //             productProvider.categoryProducts
//                                   //                     .length >=
//                                   //                 pageSize
//                                   //         ? 1
//                                   //         : 0),
//                                   gridDelegate:
//                                       const SliverGridDelegateWithFixedCrossAxisCount(
//                                     childAspectRatio: 0.75,
//                                     crossAxisCount: 2,
//                                     mainAxisSpacing: 10,
//                                     crossAxisSpacing: 10,
//                                   ),
//                                   itemBuilder: (context, index) {
//                                     // if (index <
//                                     //     productProvider
//                                     //         .categoryProducts.length) {
//                                     final product =
//                                         productProvider.categoryProducts[index];
//                                     final productApiService =
//                                         ProductApiSevice();
//                                     // logger.log(
//                                     //     "built image url: ${product.imageUrl}");
//                                     // logger.log("built prouct: ${product.name}");
//                                     return Consumer<CartQuantityProvider>(
//                                       builder: (context, provider, child) {
//                                         return Container(
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(8),
//                                             color: Colors.white,
//                                           ),
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Container(
//                                                 decoration: BoxDecoration(
//                                                   color:
//                                                       const Color(0XFFFAFAFA),
//                                                   borderRadius:
//                                                       const BorderRadius
//                                                           .vertical(
//                                                     top: Radius.circular(8),
//                                                   ),
//                                                 ),
//                                                 height: 130,
//                                                 width: double.infinity,
//                                                 child: FutureBuilder<Uint8List>(
//                                                   future: productApiService
//                                                       .getImageByFilename(
//                                                           product.imageUrl),
//                                                   builder: (context, snapshot) {
//                                                     if (snapshot
//                                                             .connectionState ==
//                                                         ConnectionState
//                                                             .waiting) {
//                                                       return Center(
//                                                           child: Shimmer
//                                                               .fromColors(
//                                                         baseColor:
//                                                             Colors.grey[300]!,
//                                                         highlightColor:
//                                                             Colors.grey[100]!,
//                                                         child: Container(
//                                                           color: Colors.red,
//                                                         ),
//                                                       ));
//                                                     } else if (snapshot
//                                                         .hasError) {
//                                                       return Icon(
//                                                           Icons.broken_image);
//                                                     } else if (snapshot
//                                                         .hasData) {
//                                                       return ClipRRect(
//                                                         borderRadius:
//                                                             BorderRadius.only(
//                                                                 topLeft: Radius
//                                                                     .circular(
//                                                                         8),
//                                                                 topRight: Radius
//                                                                     .circular(
//                                                                         8)),
//                                                         child: Image.memory(
//                                                           snapshot.data!,
//                                                           fit: BoxFit.cover,
//                                                           errorBuilder: (context,
//                                                                   error,
//                                                                   stackTrace) =>
//                                                               Icon(Icons
//                                                                   .broken_image),
//                                                         ),
//                                                       );
//                                                     } else {
//                                                       return Icon(
//                                                           Icons.broken_image);
//                                                     }
//                                                   },
//                                                 ),
//                                               ),
//                                               const SizedBox(height: 15),
//                                               Padding(
//                                                   padding: const EdgeInsets
//                                                       .symmetric(horizontal: 8),
//                                                   child: Row(
//                                                     children: [
//                                                       SizedBox(
//                                                         width: 100,
//                                                         child: Text(
//                                                           overflow: TextOverflow
//                                                               .ellipsis,
//                                                           maxLines: 2,
//                                                           product.name,
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
//                                                           product.categoryName,
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
//                                                   )),
//                                               const SizedBox(height: 7),
//                                               Padding(
//                                                 padding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 8),
//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                   children: [
//                                                     SizedBox(
//                                                       width: 100,
//                                                       child: Text(
//                                                         "Rs. ${product.price}",
//                                                         maxLines: 2,
//                                                         overflow: TextOverflow
//                                                             .ellipsis,
//                                                         style: TextStyle(
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                           color: CommonColor
//                                                               .primaryColor,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     InkWell(
//                                                       onTap: () {
//                                                         showDialog(
//                                                           context: context,
//                                                           builder: (context) {
//                                                             Future.delayed(
//                                                                 const Duration(
//                                                                     seconds: 1),
//                                                                 () {
//                                                               if (context
//                                                                   .mounted) {
//                                                                 Navigator.pop(
//                                                                     context);
//                                                               }
//                                                             });
//                                                             return AlertDialog(
//                                                               backgroundColor:
//                                                                   Colors.white,
//                                                               shape:
//                                                                   RoundedRectangleBorder(
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             15),
//                                                               ),
//                                                               title: Center(
//                                                                 child: Text(
//                                                                   "Item added to cart successfully!",
//                                                                   style: TextStyle(
//                                                                       color: CommonColor
//                                                                           .darkGreyColor,
//                                                                       fontSize:
//                                                                           14),
//                                                                 ),
//                                                               ),
//                                                             );
//                                                           },
//                                                         );
//                                                         Provider.of<CartQuantityProvider>(
//                                                                 context,
//                                                                 listen: false)
//                                                             .addToCart(
//                                                                 product.sku
//                                                                     .toString(),
//                                                                 context);
//                                                         logger.log(
//                                                             "tapped product sku: ${product.sku}");
//                                                       },
//                                                       child: Icon(
//                                                         MingCute
//                                                             .shopping_cart_1_line,
//                                                         color: Colors.black87,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         );
//                                       },
//                                     );
//                                     // } else {
//                                     //   return productProvider
//                                     //               .hasMoreCategoryProducts &&
//                                     //           productProvider.categoryProducts
//                                     //                   .length >=
//                                     //               pageSize
//                                     //       ? Center(
//                                     //           child: SizedBox(
//                                     //               height: 30,
//                                     //               width: 30,
//                                     //               child:
//                                     //                   CircularProgressIndicator(
//                                     //                 color: CommonColor
//                                     //                     .primaryColor,
//                                     //               )))
//                                     //       : Column(
//                                     //           mainAxisAlignment:
//                                     //               MainAxisAlignment.start,
//                                     //           children: [
//                                     //             SizedBox(
//                                     //               height: 10,
//                                     //             ),
//                                     //             Text(
//                                     //               "No more products!",
//                                     //               style: TextStyle(
//                                     //                   color: Colors.grey,
//                                     //                   fontSize: 16),
//                                     //             ),
//                                     //           ],
//                                     //         );
//                                     // }
//                                   },
//                                 ),
//                               ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

//Search screen with pagination
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/data/product_api_sevice.dart';
import 'package:order_management_system/features/dashboard/domain/cart_quantity_provider.dart';
import 'package:order_management_system/features/dashboard/domain/product_provider.dart';
import 'package:order_management_system/features/dashboard/domain/tab_bar_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:developer' as logger;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = SearchController();
  Timer? debounce;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(onScroll);

    // Focus on the search field when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fetch product categories after the screen is built
      Future.delayed(Duration.zero, () async {
        if (!mounted) return;
        final TabBarProvider tabBarProvider =
            Provider.of(context, listen: false);
        tabBarProvider.clearSelectedIndex();
        tabBarProvider.clearSearchKeyword();
        tabBarProvider.resetCategoryId();
        final productProvider =
            Provider.of<ProductProvider>(context, listen: false);
        await productProvider.getAllProductCategories();
        productProvider.resetCategoryProducts();
        await productProvider.getCategoryProducts(0, "",
            reset: true); // Fetch products for category ID 1 initially
      });
    });
  }

  int pageSize = 20;
  void onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      logger.log("end reached");
      final tabBarProvider =
          Provider.of<TabBarProvider>(context, listen: false);
      Provider.of<ProductProvider>(context, listen: false).getCategoryProducts(
          tabBarProvider.currentCategoryId, searchController.text.trim());
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
    final productProvider = Provider.of<ProductProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Consumer<TabBarProvider>(
      builder: (context, tabBarProvider, _) {
        return KeyboardDismisser(
          child: DefaultTabController(
            length: productProvider.productCategory.length,
            initialIndex: 0,
            child: Container(
              decoration: BoxDecoration(
                color: CommonColor.commonGreyColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              height: screenHeight * 0.8,
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.01),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.cancel, color: Colors.transparent),
                        const Center(
                          child: Text(
                            "Product Catalog",
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 20),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            color: CommonColor.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: TextFormField(
                      controller: searchController,
                      onChanged: (value) {
                        if (debounce?.isActive ?? false) {
                          debounce!.cancel();
                        }
                        debounce = Timer(Duration(seconds: 1), () {
                          // logger.log(searchController.text.trim());
                          productProvider.getCategoryProducts(
                              reset: true,
                              tabBarProvider.currentCategoryId,
                              searchController.text.trim());
                        });
                      },
                      onFieldSubmitted: (value) {
                        // logger.log(searchController.text.trim());
                        // productProvider.getCategoryProducts(
                        //     reset: true,
                        //     tabBarProvider.currentCategoryId,
                        //     searchController.text.trim());
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
                  ),
                  productProvider.isCategoryLoading
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[200]!,
                            highlightColor: Colors.white,
                            child: Container(
                              color: Colors.white,
                              height: 40,
                              width: double.infinity,
                            ),
                          ),
                        )
                      : TabBar(
                          indicatorSize: TabBarIndicatorSize.tab,
                          unselectedLabelColor: CommonColor.darkGreyColor,
                          indicatorColor: CommonColor.primaryColor,
                          labelColor: CommonColor.primaryColor,
                          labelPadding:
                              const EdgeInsets.symmetric(horizontal: 25),
                          isScrollable: true,
                          tabAlignment: TabAlignment.start,
                          onTap: (index) {
                            searchController.clear();
                            productProvider.resetCategoryProducts();
                            tabBarProvider.selectTab(index);
                            final selectedCategory =
                                productProvider.productCategory[index];
                            tabBarProvider
                                .updateCurrentCategoryId(selectedCategory.id);
                            if (!context.mounted) {
                              return;
                            }

                            if (selectedCategory.id == 0) {
                              // If "All" category is selected, fetch all products
                              productProvider.getCategoryProducts(0, "",
                                  reset: true);
                            } else {
                              // Otherwise, fetch products for the selected category
                              productProvider.getCategoryProducts(
                                  selectedCategory.id, "",
                                  reset: true);
                            }
                          },
                          tabs: productProvider.productCategory
                              .map(
                                (tab) => Tab(
                                  child: Text(
                                    tab.name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: productProvider.isCategoryProductLoading &&
                            productProvider.categoryProducts.isEmpty
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: GridView.builder(
                                  controller: scrollController,
                                  itemCount:
                                      productProvider.categoryProducts.length +
                                          1,
                                  // itemCount: productProvider
                                  //         .categoryProducts.length +
                                  //     (productProvider
                                  //                 .hasMoreCategoryProducts &&
                                  //             productProvider.categoryProducts
                                  //                     .length >=
                                  //                 pageSize
                                  //         ? 1
                                  //         : 0),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.75,
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                  ),
                                  itemBuilder: (context, index) {
                                    if (index <
                                        productProvider
                                            .categoryProducts.length) {
                                      final product = productProvider
                                          .categoryProducts[index];
                                      final productApiService =
                                          ProductApiSevice();
                                      // logger.log(
                                      //     "built image url: ${product.imageUrl}");
                                      // logger.log("built prouct: ${product.name}");
                                      return Consumer<CartQuantityProvider>(
                                        builder: (context, provider, child) {
                                          return Container(
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
                                                  child:
                                                      FutureBuilder<Uint8List>(
                                                    future: productApiService
                                                        .getImageByFilename(
                                                            product.imageUrl),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return Center(
                                                            child: Shimmer
                                                                .fromColors(
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
                                                      } else if (snapshot
                                                          .hasData) {
                                                        return ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          8),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          8)),
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
                                                  ),
                                                ),
                                                const SizedBox(height: 15),
                                                Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 100,
                                                          child: Text(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 2,
                                                            product.name,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            product
                                                                .categoryName,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: CommonColor
                                                                  .mediumGreyColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                                const SizedBox(height: 7),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
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
                                                      InkWell(
                                                        onTap: () {
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
                                    } else {
                                      return productProvider
                                                  .hasMoreCategoryProducts &&
                                              productProvider.categoryProducts
                                                      .length >=
                                                  pageSize
                                          ? Center(
                                              child: SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: CommonColor
                                                        .primaryColor,
                                                  )))
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "No more products!",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            );
                                    }
                                  },
                                ),
                              ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
