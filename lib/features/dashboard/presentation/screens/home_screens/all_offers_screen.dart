import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/data/product_api_sevice.dart';
import 'package:order_management_system/features/dashboard/domain/cart_quantity_provider.dart';
import 'package:order_management_system/features/dashboard/domain/product_provider.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/offer_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class AllOffersScreen extends StatefulWidget {
  const AllOffersScreen({super.key});

  @override
  State<AllOffersScreen> createState() => _AllOffersScreenState();
}

class _AllOffersScreenState extends State<AllOffersScreen> {
  final productApiService = ProductApiSevice();
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    scrollController.addListener(onScroll);
    Future.delayed(Duration.zero, () async {
      if (!mounted) {
        return;
      }
      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      productProvider.resetOfferProducts();
      await productProvider.getOfferProduct("");
    });
    super.initState();
  }

  int pageSize = 20;
  void onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      productProvider.getOfferProduct("");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColor.scaffoldbackgroundColor,
      appBar: AppBar(
        backgroundColor: CommonColor.primaryColor,
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "All Offers",
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
          productProvider.resetOfferProducts();
          await productProvider.getOfferProduct("");
        },
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Consumer<ProductProvider>(
                builder: (context, productProvider, child) {
              if (productProvider.isOfferProductLoading == true &&
                  productProvider.offerProduct.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(
                    color: CommonColor.primaryColor,
                  ),
                );
              } else if (productProvider.offerProduct.isEmpty) {
                return Center(
                  child: Text("No offers to display"),
                );
              } else {
                return GridView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.80,
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 10),
                    scrollDirection: Axis.vertical,
                    itemCount: productProvider.offerProduct.length + 1,
                    itemBuilder: (context, index) {
                      if (index < productProvider.offerProduct.length) {
                        final offerProduct =
                            productProvider.offerProduct[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OfferDetailScreen(
                                        sku: offerProduct.sku.toString())));
                          },
                          child: Container(
                            width: 170,
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
                                      borderRadius: const BorderRadius.vertical(
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
                                                future: productApiService
                                                    .getImageByFilename(
                                                        offerProduct.imageUrl),
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
                                        Positioned(
                                            left: 0,
                                            top: 0,
                                            child: Container(
                                              padding: EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  8),
                                                          topLeft:
                                                              Radius.circular(
                                                                  8))),
                                              child: Center(
                                                child: Text(
                                                  offerProduct.discountPercent
                                                      .toString(),
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
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    spacing: 10,
                                    children: [
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        offerProduct.name.toString(),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          offerProduct.categoryName.toString(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: CommonColor.mediumGreyColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
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
                                              color: CommonColor.darkGreyColor,
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
                                                  color:
                                                      CommonColor.primaryColor,
                                                  fontWeight: FontWeight.bold),
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
                                                      BorderRadius.circular(15),
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
                        );
                      } else {
                        return productProvider.hasMoreOfferProduct &&
                                productProvider.offerProduct.length >= pageSize
                            ? Center(
                                child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: CircularProgressIndicator(
                                      color: CommonColor.primaryColor,
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
                    });
              }
            })),
      ),
    );
  }
}
