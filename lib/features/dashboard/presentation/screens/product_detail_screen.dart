import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/data/product_api_sevice.dart';
import 'package:order_management_system/features/dashboard/domain/cart_quantity_provider.dart';
import 'package:order_management_system/features/dashboard/domain/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailScreen extends StatefulWidget {
  final String sku;
  const ProductDetailScreen({super.key, required this.sku});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final PageController smoothController = PageController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if (!mounted) {
        return;
      }
      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      productProvider.getProductDetail(widget.sku);
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
                      child: FutureBuilder<Uint8List>(
                        future: productApiSevice.getImageByFilename(
                            productProvider.productDetail.imageUrl),
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
                              child: Image.memory(
                                snapshot.data!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.broken_image),
                              ),
                            );
                          } else {
                            return Icon(Icons.broken_image);
                          }
                        },
                      ),
                      // child: Image.asset(
                      //   "assets/images/tshirt.jpeg",
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SmoothPageIndicator(
                          effect: JumpingDotEffect(
                            dotColor: Colors.green[200]!,
                            activeDotColor: CommonColor.primaryColor,
                            dotHeight: 10,
                            dotWidth: 10,
                          ),
                          controller: smoothController,
                          count: 3),
                    ),
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
                                Text(productProvider.productDetail.name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                Text(
                                  productProvider.productDetail.categoryName,
                                  style: TextStyle(
                                      color: CommonColor.darkGreyColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Rs.${productProvider.productDetail.price}",
                                  style: TextStyle(
                                      color: CommonColor.primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Description",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
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
                                Provider.of<CartQuantityProvider>(context,
                                        listen: false)
                                    .addToCart(
                                        productProvider.productDetail.sku
                                            .toString(),
                                        context);
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
