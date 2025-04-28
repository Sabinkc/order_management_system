import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/simple_ui_provider.dart';
import 'package:order_management_system/features/dashboard/data/product_api_sevice.dart';
import 'package:order_management_system/features/dashboard/domain/cart_quantity_provider.dart';
import 'package:order_management_system/features/dashboard/domain/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AllProductDetailScreen extends StatefulWidget {
  final String sku;
  const AllProductDetailScreen({super.key, required this.sku});

  @override
  State<AllProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<AllProductDetailScreen> {
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
      Provider.of<SimpleUiProvider>(context,listen: false).clearCarouselIndex();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: CommonColor.scaffoldbackgroundColor,
        appBar: AppBar(
          backgroundColor: CommonColor.primaryColor,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              )),
          title: RichText(
              text: TextSpan(children: [
            TextSpan(
              text: "Product Details",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
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
                      height: screenHeight * 0.35,
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
                              height: screenHeight * 0.35,
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
                              effect: JumpingDotEffect(
                                dotColor: Colors.green[200]!,
                                activeDotColor: CommonColor.primaryColor,
                                dotHeight: 10,
                                dotWidth: 10,
                              ),
                              controller: PageController(
                                  initialPage: simpleUiProvider.carouselIndex),
                              count:
                                  productProvider.productDetail.images.length);
                        })),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
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
                                          productProvider.productDetail.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18)),
                                    ),
                                    Row(
                                      spacing: 3,
                                      children: [
                                        productProvider.productDetail
                                                    .isAvailable ==
                                                true
                                            ? Text("Availiable",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16))
                                            : Text("Not Availiable",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16)),
                                        productProvider.productDetail
                                                    .isAvailable ==
                                                true
                                            ? Icon(
                                                Icons.check_circle_outline,
                                                color: Colors.blue,
                                                size: 17,
                                              )
                                            : Icon(
                                                Icons.cancel_outlined,
                                                color: Colors.red,
                                                size: 17,
                                              )
                                      ],
                                    )
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
                                        productProvider
                                            .productDetail.categoryName,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: CommonColor.darkGreyColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Stock: ",
                                          style: TextStyle(
                                              color: CommonColor.darkGreyColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        Text(
                                          productProvider
                                              .productDetail.stockQuantity
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
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "S-K-U: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Rs.${productProvider.productDetail.price}",
                                      style: TextStyle(
                                          color: CommonColor.primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 28),
                                    ),
                                  ],
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
                                Text(
                                  productProvider.productDetail.description,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: CommonColor.darkGreyColor,
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 14),
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
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: SizedBox(
                          height: screenHeight * 0.06,
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  backgroundColor: CommonColor.primaryColor),
                              onPressed: () {
                                Provider.of<CartQuantityProvider>(context,
                                        listen: false)
                                    .addToCartFromAllProducts(
                                        productProvider.productDetail.sku
                                            .toString(),
                                        context);
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    Future.delayed(const Duration(seconds: 1),
                                        () {
                                      if (context.mounted) {
                                        Navigator.pop(context);
                                      }
                                    });
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      title: Center(
                                        child: Text(
                                          "Item added to cart successfully!",
                                          style: TextStyle(
                                              color: CommonColor.darkGreyColor,
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
                );
        }));
  }
}
