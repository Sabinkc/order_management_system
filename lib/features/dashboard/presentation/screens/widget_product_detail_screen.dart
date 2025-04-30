import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/simple_ui_provider.dart';
import 'package:order_management_system/features/dashboard/data/product_api_sevice.dart';
import 'package:order_management_system/features/dashboard/domain/cart_quantity_provider.dart';
import 'package:order_management_system/features/dashboard/domain/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WidgetProductDetailScreen extends StatefulWidget {
  final String sku;
  const WidgetProductDetailScreen({super.key, required this.sku});

  @override
  State<WidgetProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<WidgetProductDetailScreen> {
  final PageController smoothController = PageController();
  final CarouselSliderController carouselSliderController =
      CarouselSliderController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if (!mounted) {
        return;
      }
      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      productProvider.getProductDetail(widget.sku);
      Provider.of<SimpleUiProvider>(context, listen: false)
          .clearCarouselIndex();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: CommonColor.scaffoldbackgroundColor,
        appBar: AppBar(
          backgroundColor: CommonColor.scaffoldbackgroundColor,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 24,
              )),
          title: RichText(
              text: TextSpan(children: [
            TextSpan(
              text: "Product Details",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 22,
                color: Colors.black,
              ),
            ),
          ])),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Consumer<ProductProvider>(
            builder: (context, productProvider, child) {
          final ProductApiSevice productApiSevice = ProductApiSevice();
          return productProvider.isProductDetailLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: CommonColor.primaryColor,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.40,
                      width: double.infinity,
                      child: CarouselSlider(
                          carouselController: carouselSliderController,
                          items: List.generate(
                              productProvider.productDetail.images.length,
                              (index) {
                            return FutureBuilder<Uint8List>(
                              future: productApiSevice.getImageByFilename(
                                  productProvider.productDetail.images[index]),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      color: Colors.red,
                                    ),
                                  ));
                                } else if (snapshot.hasError) {
                                  return Icon(Icons.broken_image);
                                } else if (snapshot.hasData) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8)),
                                    child: SizedBox.expand(
                                      child: Image.memory(
                                        snapshot.data!,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Icon(Icons.broken_image),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Icon(Icons.broken_image);
                                }
                              },
                            );
                          }),
                          options: CarouselOptions(
                              height: screenHeight * 0.40,
                              autoPlay: false,
                              enableInfiniteScroll: false,
                              viewportFraction: 1,
                              onPageChanged: (index, reason) {
                                Provider.of<SimpleUiProvider>(context,
                                        listen: false)
                                    .updateCarouselIndex(index);
                              })),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Consumer<SimpleUiProvider>(
                            builder: (context, simpleUiProvider, child) {
                          return SmoothPageIndicator(
                              effect: ExpandingDotsEffect(
                                dotColor: Colors.grey,
                                activeDotColor: Colors.black,
                                dotHeight: 10,
                                dotWidth: 10,
                              ),
                              controller: PageController(
                                  initialPage: simpleUiProvider.carouselIndex),
                              count:
                                  productProvider.productDetail.images.length);
                        })),
                    SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  spacing: 10,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Category: ${productProvider.productDetail.categoryName}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                          productProvider.productDetail.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18)),
                                    ),
                                    // Row(
                                    //   children: [
                                    //     Text(
                                    //       "Stock: ",
                                    //       style: TextStyle(
                                    //           color: CommonColor.darkGreyColor,
                                    //           fontWeight: FontWeight.bold,
                                    //           fontSize: 14),
                                    //     ),
                                    //     Text(
                                    //       productProvider
                                    //           .productDetail.stockQuantity
                                    //           .toString(),
                                    //       style: TextStyle(
                                    //           color: CommonColor.darkGreyColor,
                                    //           fontWeight: FontWeight.bold,
                                    //           fontSize: 14),
                                    //     ),
                                    //     SizedBox(
                                    //       width: 5,
                                    //     )
                                    //   ],
                                    // )
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  spacing: 3,
                                  children: [
                                    productProvider.productDetail.isAvailable ==
                                            true
                                        ? Text("Availiable",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16))
                                        : Text("Not Availiable",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                    productProvider.productDetail.isAvailable ==
                                            true
                                        ? Icon(
                                            Icons.check_circle,
                                            color: Colors.blue,
                                            size: 17,
                                          )
                                        : Icon(
                                            Icons.cancel,
                                            color: Colors.red,
                                            size: 17,
                                          )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  spacing: 3,
                                  children: [
                                    Icon(
                                      color: CommonColor.primaryColor,
                                      Icons.inventory_2_outlined,
                                      size: 18,
                                    ),
                                    Text(
                                      "S-K-U:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      productProvider.productDetail.sku
                                          .toString(),
                                      style: TextStyle(
                                          color: CommonColor.darkGreyColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),

                                SizedBox(
                                  height: 10,
                                ),
                                Text("Description",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                SizedBox(
                                  height: 5,
                                ),
                                ExpandableText(
                                  productProvider.productDetail.description,
                                  expandText: "Show more!",
                                  collapseText: "Show less!",
                                  style: TextStyle(
                                      color: CommonColor.darkGreyColor,
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                  maxLines: 5,
                                  linkColor: Colors.blue,
                                  textAlign: TextAlign.justify,
                                  animation: true,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                // Expanded(child: SizedBox()),

                                SizedBox(
                                  height: 20,
                                ),
                              ]),
                        ),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        spacing: 20,
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Rs.",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Expanded(
                                  child: Text(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    "${productProvider.productDetail.price}",
                                    // "1000000000000",
                                    style: TextStyle(
                                        color: CommonColor.primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 26),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: SizedBox(
                                height: screenHeight * 0.055,

                                // width: double.infinity,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 50),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        backgroundColor:
                                            CommonColor.primaryColor),
                                    onPressed: () {
                                      Provider.of<CartQuantityProvider>(context,
                                              listen: false)
                                          .addToCartFromWidgetProducts(
                                              productProvider.productDetail.sku
                                                  .toString(),
                                              context);
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          Future.delayed(
                                              const Duration(seconds: 1), () {
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
                                    child: Text(
                                      "Add To Cart",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ))),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
        }));
  }
}
