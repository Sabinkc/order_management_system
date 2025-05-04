import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/data/product_api_sevice.dart';
import 'package:order_management_system/features/dashboard/domain/cart_quantity_provider.dart';
import 'package:order_management_system/features/dashboard/domain/product_provider.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/widget_category_product_detail_screen.dart';
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
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  Timer? debounce;
  final productApiService = ProductApiSevice();
  @override
  void initState() {
    scrollController.addListener(onScroll);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      productProvider.getWidgetCategoryProducts(widget.index, "", reset: true);
    });
  }

  void onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      productProvider.getWidgetCategoryProducts(
          widget.index, searchController.text.trim(),
          reset: false);
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
    // List subCategoryImages = [
    //   "assets/images/electronic_c.png",
    //   "assets/images/clothing_c.png",
    //   "assets/images/furniture_c.png",
    //   "assets/images/grocery_c.png",
    //   "assets/images/stationary_c.png",
    //   "assets/images/books_c.png",
    //   "assets/images/toys_c.png",
    //   "assets/images/sports_c.png",
    //   "assets/images/automobile_c.png"
    // ];
    List subCategoryName = [
      "Category A",
      "Category B",
      "Category C",
      "Category D",
      "Category E",
      "Category F",
      "Category G",
      "Category H",
      "Category I"
    ];
    return KeyboardDismisser(
      child: Scaffold(
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
                  // await productProvider.getAllProduct();
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
              searchController.clear();
              final productProvider =
                  Provider.of<ProductProvider>(context, listen: false);
              await productProvider.getWidgetCategoryProducts(widget.index, "",
                  reset: true);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 10),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text(
                  //         "Sub Categories",
                  //         style: TextStyle(
                  //           color: CommonColor.blackColor,
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.w600,
                  //         ),
                  //       ),
                  //       InkWell(
                  //         onTap: () {},
                  //         child: Text(
                  //           "See all",
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.w600,
                  //               color: CommonColor.primaryColor),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: TextFormField(
                      controller: searchController,
                      onChanged: (value) {
                        if (debounce?.isActive ?? false) {
                          debounce!.cancel();
                        }
                        debounce = Timer(Duration(seconds: 1), () {
                          productProvider.getWidgetCategoryProducts(
                              widget.index, searchController.text.trim(),
                              reset: true);
                          // logger.log(searchController.text.trim());
                        });
                      },
                      onFieldSubmitted: (value) {
                        debounce?.cancel();
                        logger.log(searchController.text.trim());
                        productProvider.getWidgetCategoryProducts(
                            widget.index, searchController.text.trim(),
                            reset: true);
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
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 115,
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
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 8),
                                      child: Container(
                                        // height: 90,
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(0, 0),
                                                blurRadius: 3,
                                                color: Colors.grey),
                                            // // BoxShadow(
                                            //     offset: Offset(-2, -2),
                                            //     blurRadius: 1,
                                            //     color: Colors.grey)
                                          ],
                                          border:
                                              Border.all(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.white,
                                        ),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Image.asset(
                                              "assets/images/profile.jpg",
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                    )),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  subCategoryName[index],
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
                  Divider(
                    color: Colors.grey[300],
                    thickness: 1,
                    height: 20,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: productProvider.isWidgetCategoryProductLoading &&
                            productProvider.widgetCategoryProducts.isEmpty
                        ? Center(
                            child: CircularProgressIndicator(
                              color: CommonColor.primaryColor,
                            ),
                          )
                        : productProvider.widgetCategoryProducts.isEmpty
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
                                    const EdgeInsets.symmetric(horizontal: 0),
                                child: GridView.builder(
                                  controller: scrollController,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  itemCount: productProvider
                                          .widgetCategoryProducts.length +
                                      1,
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
                                            .widgetCategoryProducts.length) {
                                      final product = productProvider
                                          .widgetCategoryProducts[index];

                                      logger.log(
                                          "built image url: ${product.imageUrl}");
                                      return Consumer<CartQuantityProvider>(
                                        builder: (context, provider, child) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          WidgetCategoryProductDetailScreen(
                                                              sku: product.sku
                                                                  .toString())));
                                            },
                                            child: Container(
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
                                                      color: const Color(
                                                          0XFFFAFAFA),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .vertical(
                                                        top: Radius.circular(8),
                                                      ),
                                                    ),
                                                    height: 130,
                                                    width: double.infinity,

                                                    // child: CachedNetworkImage(
                                                    //   maxHeightDiskCache: 100,
                                                    //   maxWidthDiskCache: 100,
                                                    //   memCacheHeight: 200,
                                                    //   memCacheWidth: 200,
                                                    //   imageUrl:
                                                    //       product.imageUrl,
                                                    //   fit: BoxFit.cover,
                                                    //   placeholder: (context,
                                                    //           url) =>
                                                    //       Shimmer.fromColors(
                                                    //     baseColor:
                                                    //         Colors.grey[300]!,
                                                    //     highlightColor:
                                                    //         Colors.grey[100]!,
                                                    //     child: Container(
                                                    //         color: Colors
                                                    //             .grey[200]),
                                                    //   ),
                                                    //   errorWidget: (context,
                                                    //           url, error) =>
                                                    //       Icon(Icons
                                                    //           .broken_image),
                                                    // ),
                                                    child: FutureBuilder(
                                                        future: productApiService
                                                            .getImageByFilename(
                                                                product
                                                                    .imageUrl),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            return Image.memory(
                                                              snapshot.data!,
                                                              fit: BoxFit.cover,
                                                              cacheHeight: 100,
                                                              cacheWidth: 100,
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
                                                            return Icon(Icons
                                                                .broken_image);
                                                          }
                                                        }),
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
                                                                  TextAlign
                                                                      .start,
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
                                                        .symmetric(
                                                        horizontal: 8),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            "Rs. ${product.price}",
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: CommonColor
                                                                  .primaryColor,
                                                            ),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            Provider.of<CartQuantityProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .addToCartFromWidgetCategoryProducts(
                                                                    product.sku
                                                                        .toString(),
                                                                    context);
                                                            logger.log(
                                                                "tapped product sku: ${product.sku}");
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
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
                                                                        BorderRadius.circular(
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
                                                            color:
                                                                Colors.black87,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    } else {
                                      return productProvider
                                                  .hasMoreWidgetCategoryProducts &&
                                              productProvider
                                                      .widgetCategoryProducts
                                                      .length >=
                                                  20
                                          ? Center(
                                              child: CircularProgressIndicator(
                                              color: CommonColor.primaryColor,
                                            ))
                                          // : Column(
                                          //     mainAxisAlignment:
                                          //         MainAxisAlignment.start,
                                          //     children: [
                                          //       SizedBox(
                                          //         height: 10,
                                          //       ),
                                          //       Text(
                                          //         "No more products!",
                                          //         style: TextStyle(
                                          //             color: CommonColor
                                          //                 .darkGreyColor,
                                          //             fontSize: 16),
                                          //       )
                                          //     ],
                                          //   );
                                          : SizedBox.shrink();
                                    }
                                  },
                                ),
                              ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
