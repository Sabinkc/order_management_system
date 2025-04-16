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

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(onScroll);
    Future.delayed(Duration.zero, () async {
      if (!mounted) {
        return;
      }
      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      productProvider.resetAllProducts();
      await productProvider.getAllProduct();
    });
    super.initState();
  }

  void onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      Provider.of<ProductProvider>(context, listen: false).getAllProduct();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
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
          await productProvider.getAllProduct();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Consumer<ProductProvider>(
              builder: (context, productProvider, children) {
            return productProvider.isProductLoading == true &&
                    productProvider.product.isEmpty
                ? Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: CommonColor.primaryColor,
                      ),
                    ))
                : GridView.builder(
                    controller: scrollController,
                    // shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.75, crossAxisCount: 2),
                    itemCount: productProvider.product.length + 1,
                    itemBuilder: (context, index) {
                      if (index < productProvider.product.length) {
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
                                      borderRadius: const BorderRadius.vertical(
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
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(8),
                                                    topRight:
                                                        Radius.circular(8)),
                                                child: Image.memory(
                                                  snapshot.data!,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      Icon(Icons.broken_image),
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
                                                .addToCartFromAllProducts(
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
                      } else {
                        return productProvider.hasMoreAllProduct
                            ? Center(
                                child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: CircularProgressIndicator(
                                      color: CommonColor.primaryColor,
                                    )),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "No more products!",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 16),
                                  ),
                                ],
                              );
                      }
                    });
          }),
        ),
      ),
    );
  }
}
