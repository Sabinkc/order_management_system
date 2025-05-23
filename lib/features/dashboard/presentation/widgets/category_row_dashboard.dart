import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/data/product_api_sevice.dart';
import 'package:order_management_system/features/dashboard/domain/product_provider.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/home_screens/all_categories_screen.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/category_detail_screen.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as logger;
import 'package:order_management_system/localization/l10n.dart';
import 'package:shimmer/shimmer.dart';

class CategoryRowDashboard extends StatelessWidget {
  CategoryRowDashboard({super.key});

  final productApiSevice = ProductApiSevice();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.current.categories,
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
                          builder: (context) => AllCategoriesScreen()));
                },
                child: Text(
                  S.current.seeAll,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: CommonColor.primaryColor),
                ),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Consumer<ProductProvider>(builder: (context, productProvider, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                height: 110,
                child: productProvider.isCategoryWithoutallLoading == true
                    ? Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(
                            color: CommonColor.primaryColor,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount:
                            productProvider.productCategoryWithoutAll.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          // logger.log(
                          //     "${productProvider.productCategoryWithoutAll[index].categoryImage}");
                          return Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Column(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        logger.log(
                                            "tapped index id: ${productProvider.productCategoryWithoutAll[index].id}");
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CategoryDetailScreen(
                                                      category: productProvider
                                                              .productCategoryWithoutAll[
                                                          index],
                                                      index: productProvider
                                                          .productCategoryWithoutAll[
                                                              index]
                                                          .id,
                                                    )));
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(5),
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
                                              // BoxShadow(
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
                                          // child: ClipRRect(
                                          //   borderRadius: BorderRadius.circular(50),
                                          //   child: Image.network(""),
                                          // ),

                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: FutureBuilder(
                                                future: productApiSevice
                                                    .getCategoryImage(
                                                        productProvider
                                                            .productCategoryWithoutAll[
                                                                index]
                                                            .categoryImage),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    return Image.memory(
                                                      snapshot.data!,
                                                      fit: BoxFit.cover,
                                                      // cacheHeight: 120,
                                                      // cacheWidth: 120,
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
                                      )),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    productProvider
                                        .productCategoryWithoutAll[index].name,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: CommonColor.darkGreyColor,
                                        fontWeight: FontWeight.w600),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ));
                        }),
              ),
            );
          })
        ],
      ),
    );
  }
}
