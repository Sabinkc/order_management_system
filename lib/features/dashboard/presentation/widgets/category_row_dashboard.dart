import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/domain/product_provider.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/all_categories_screen.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/category_detail_screen.dart';
import 'package:provider/provider.dart';

class CategoryRowDashboard extends StatelessWidget {
  const CategoryRowDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Categories",
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
                  "See all",
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
                          return Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Column(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CategoryDetailScreen(
                                                      category: productProvider
                                                          .productCategoryWithoutAll[
                                                              index]
                                                          .name,
                                                    )));
                                      },
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
                                            border:
                                                Border.all(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(8),
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
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.asset(
                                                "assets/images/food.png",
                                                fit: BoxFit.cover,
                                              )),
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
